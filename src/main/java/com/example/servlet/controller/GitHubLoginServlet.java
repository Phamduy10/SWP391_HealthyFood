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
import org.apache.http.entity.ContentType;

public class GitHubLoginServlet extends HttpServlet {

    String clientId = "Ov23li5L7N0QU8WL62FR";
    String clientSecret = "33c9275b6191b3c448dd3e5ba5e274ddef8e29ab";
    private static final String REDIRECT_URI = "http://localhost:8080/GitHubLoginServlet";
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        if (code != null) {
            // Lấy token từ GitHub
            String tokenUrl = "https://github.com/login/oauth/access_token";
            String tokenParams = "code=" + code + "&client_id=" + clientId + "&client_secret=" + clientSecret + "&redirect_uri=" + REDIRECT_URI;
            System.out.println("Token URL: " + tokenUrl);
            System.out.println("Token Params: " + tokenParams);

            String tokenResponse = Request.Post(tokenUrl)
                    .setHeader("Accept", "application/json")
                    .bodyString(tokenParams, ContentType.APPLICATION_FORM_URLENCODED)
                    .execute().returnContent().asString();

            if (tokenResponse == null || tokenResponse.isEmpty()) {
                throw new ServletException("Failed to get token response from GitHub");
            }

            Gson gson = new Gson();
            System.out.println("Token Response: " + tokenResponse);
            TokenResponse token = gson.fromJson(tokenResponse, TokenResponse.class);
            if (token == null || token.access_token == null) {
                throw new ServletException("Invalid token response from GitHub");
            }

            // Lấy thông tin người dùng từ GitHub
            String userInfoJson = Request.Get("https://api.github.com/user")
                    .setHeader("Authorization", "Bearer " + token.access_token)
                    .execute().returnContent().asString();

            UserInfo userInfo = gson.fromJson(userInfoJson, UserInfo.class);
            User user = null;
            try {
                user = userDAO.findByEmail(userInfo.email);
            } catch (SQLException ex) {
                Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, "Error finding user", ex);
            }

            if (user == null) {
                user = new User();
                user.setUsername(userInfo.login);
                user.setName(userInfo.name);
                user.setEmail(userInfo.email);
                user.setRole("USER_OAUTH");
                try {
                    userDAO.registerUser(user);
                    user = userDAO.findByEmail(userInfo.email);
                } catch (SQLException ex) {
                    Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, "Error registering user", ex);
                }
            }

            req.getSession().setAttribute("user", user);
            resp.sendRedirect("profile");
        } else {
            // Chuyển hướng đến GitHub OAuth
            String authUrl = "https://github.com/login/oauth/authorize"
                    + "?client_id=" + clientId
                    + "&redirect_uri=" + REDIRECT_URI
                    + "&scope=user:email";
            resp.sendRedirect(authUrl);
        }
    }

    private static class UserInfo {

        String email;
        String name;
        String login; // GitHub username
    }

    private static class TokenResponse {

        String access_token;

    }

    private static class EmailInfo {

        String email;
        boolean primary;
        boolean verified;
    }
}
