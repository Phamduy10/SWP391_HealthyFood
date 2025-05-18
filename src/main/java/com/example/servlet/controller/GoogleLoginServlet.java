package com.example.servlet.controller;

import com.example.servlet.dao.UserDAO;
import com.example.servlet.model.User;
import com.google.gson.Gson;
import io.github.cdimascio.dotenv.Dotenv;
import org.apache.http.client.fluent.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.http.HttpResponse;
import org.apache.http.entity.ContentType;
import org.apache.http.util.EntityUtils;

public class GoogleLoginServlet extends HttpServlet {

    String clientId = "";
    String clientSecret = "";
    private static final String REDIRECT_URI = "http://localhost:8080/GoogleLoginServlet";
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        if (code != null) {
            // Xử lý mã code như hiện tại
            String tokenUrl = "https://oauth2.googleapis.com/token";
            String tokenParams = "code=" + URLEncoder.encode(code, "UTF-8")
                    + "&client_id=" + clientId
                    + "&client_secret=" + clientSecret
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                    + "&grant_type=authorization_code";
            System.out.println("Token URL: " + tokenUrl);
            System.out.println("Token Params: " + tokenParams);
            HttpResponse response = Request.Post(tokenUrl)
                    .bodyString(tokenParams, ContentType.APPLICATION_FORM_URLENCODED)
                    .execute().returnResponse();
            if (response.getStatusLine().getStatusCode() != 200) {
                throw new ServletException("Token request failed: " + response.getStatusLine());
            }

            String tokenResponse = response.getEntity() != null ? EntityUtils.toString(response.getEntity()) : "";
            Gson gson = new Gson();

            if (tokenResponse == null || tokenResponse.isEmpty()) {
                throw new ServletException("Failed to get token response from Google");
            }
            TokenResponse token = gson.fromJson(tokenResponse, TokenResponse.class);
            if (token == null || token.access_token == null) {
                throw new ServletException("Invalid token response from Google");
            }
            String userInfoJson = Request.Get("https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + token.access_token)
                    .execute().returnContent().asString();

            UserInfo userInfo = gson.fromJson(userInfoJson, UserInfo.class);
            User user = null;
            try {
                user = userDAO.findByEmail(userInfo.email);
            } catch (SQLException ex) {
                Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, "Error in doGet", ex);
            }
            if (user == null) {
                user = new User();
                user.setUsername(userInfo.email);
                user.setName(userInfo.name);
                user.setEmail(userInfo.email);
                user.setRole("USER_OAUTH");
                try {
                    userDAO.registerUser(user);
                } catch (SQLException ex) {
                    Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    user = userDAO.findByEmail(userInfo.email);
                } catch (SQLException ex) {
                    Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            req.getSession().setAttribute("user", user);
            resp.sendRedirect("profile");
        } else {
            // Chuyển hướng đến Google OAuth
            String authUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                    + "?client_id=" + clientId
                    + "&redirect_uri=" + REDIRECT_URI
                    + "&response_type=code"
                    + "&scope=email%20profile";
            resp.sendRedirect(authUrl);
        }
    }

    private static class TokenResponse {

        String access_token;
    }

    private static class UserInfo {

        String email;
        String name;
    }
}
