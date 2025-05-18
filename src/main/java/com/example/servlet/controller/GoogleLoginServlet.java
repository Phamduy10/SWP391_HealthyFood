package com.example.servlet.controller;

import com.example.servlet.dao.UserDAO;
import com.example.servlet.model.User;
import com.google.gson.Gson;
import org.apache.http.client.fluent.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class GoogleLoginServlet extends HttpServlet {
    
    String clientId = System.getenv("GOOGLE_CLIENT_ID");
    String clientSecret = System.getenv("GOOGLE_CLIENT_SECRET");
    private static final String REDIRECT_URI = "https://abc123.ngrok.io/GoogleLoginServlet";
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        if (code != null) {
            String tokenUrl = "https://oauth2.googleapis.com/token";
            String tokenParams = "code=" + code + "&client_id=" + clientId + "&client_secret=" + clientSecret + "&redirect_uri=" + REDIRECT_URI + "&grant_type=authorization_code";
            String tokenResponse = Request.Post(tokenUrl).bodyString(tokenParams, null).execute().returnContent().asString();

            Gson gson = new Gson();
            TokenResponse token = gson.fromJson(tokenResponse, TokenResponse.class);
            String userInfoJson = Request.Get("https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + token.access_token)
                    .execute().returnContent().asString();

            UserInfo userInfo = gson.fromJson(userInfoJson, UserInfo.class);
            User user = null;
            try {
                user = userDAO.findByEmail(userInfo.email);
            } catch (SQLException ex) {
                Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (user == null) {
                user = new User();
                user.setUsername(userInfo.email);
                user.setName(userInfo.name);
                user.setEmail(userInfo.email);
                try {
                    userDAO.registerUser(user);
                } catch (SQLException ex) {
                    Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    user = userDAO.findByEmail(userInfo.email); // Lấy lại user để có ID
                } catch (SQLException ex) {
                    Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            req.getSession().setAttribute("user", user);
            resp.sendRedirect("profile");
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
