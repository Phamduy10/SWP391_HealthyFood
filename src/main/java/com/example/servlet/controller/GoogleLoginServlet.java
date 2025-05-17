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
    private static final String CLIENT_ID = "543378430539-glm8gq8ag8cmt52ef2qmom1t6d2qncdb.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/Home";
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
            String tokenParams = "code=" + code + "&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&redirect_uri=" + REDIRECT_URI + "&grant_type=authorization_code";
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
                user.setFullName(userInfo.name);
                user.setEmail(userInfo.email);
                try {
                    userDAO.registerUser(user);
                } catch (SQLException ex) {
                    Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    user = userDAO.findByEmail(userInfo.email); // Lấy lại user để có ID
                }catch (SQLException ex) {
                    Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            req.getSession().setAttribute("user", user);
            resp.sendRedirect("home.jsp");
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