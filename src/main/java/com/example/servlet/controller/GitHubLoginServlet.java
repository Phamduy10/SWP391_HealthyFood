package com.example.servlet.controller;

import com.example.servlet.dao.UserDAO;
import com.example.servlet.model.User;
import com.google.gson.Gson;
//import jakarta.security.auth.message.callback.SecretKeyCallback.Request;
import org.apache.http.client.fluent.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.http.client.fluent.Request;


public class GitHubLoginServlet extends HttpServlet {
    private static final String CLIENT_ID = "Ov23li5L7N0QU8WL62FR";
    private static final String CLIENT_SECRET = "33c9275b6191b3c448dd3e5ba5e274ddef8e29ab";
    private static final String REDIRECT_URI = "https://abc123.ngrok.io/GitHubLoginServlet";
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.INFO, "Received code: " + code);

        if (code == null || code.isEmpty()) {
            req.setAttribute("error", "GitHub authentication code not provided");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            return;
        }

        try {
            // Exchange code for access token
            String tokenUrl = "https://github.com/login/oauth/access_token";
            String tokenParams = "client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&code=" + code + "&redirect_uri=" + REDIRECT_URI;
            String tokenResponse = Request.Post(tokenUrl)
                    .bodyString(tokenParams, null)
                    .addHeader("Accept", "application/json")
                    .execute()
                    .returnContent()
                    .asString();
            Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.INFO, "Token response: " + tokenResponse);

            Gson gson = new Gson();
            TokenResponse tokenData = gson.fromJson(tokenResponse, TokenResponse.class);
            if (tokenData.access_token == null) {
                req.setAttribute("error", "Failed to obtain GitHub access token");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                return;
            }

            // Fetch user info
            String userInfoJson = Request.Get("https://api.github.com/user")
                    .addHeader("Authorization", "Bearer " + tokenData.access_token)
                    .execute()
                    .returnContent()
                    .asString();
            Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.INFO, "User info: " + userInfoJson);

            UserInfo userInfo = gson.fromJson(userInfoJson, UserInfo.class);

            // Fetch email if not provided in user info
            String email = userInfo.email;
            if (email == null || email.isEmpty()) {
                String emailsJson = Request.Get("https://api.github.com/user/emails")
                        .addHeader("Authorization", "Bearer " + tokenData.access_token)
                        .execute()
                        .returnContent()
                        .asString();
                Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.INFO, "Emails: " + emailsJson);
                EmailInfo[] emails = gson.fromJson(emailsJson, EmailInfo[].class);
                for (EmailInfo e : emails) {
                    if (e.primary && e.verified) {
                        email = e.email;
                        break;
                    }
                }
            }

            if (email == null || email.isEmpty()) {
                email = userInfo.login + "@github.placeholder"; // Fallback if no email
                Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.WARNING, "No email found, using placeholder: " + email);
            }

            User user = null;
            try {
                user = userDAO.findByEmail(email);
                Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.INFO, "Found user: " + (user != null ? user.getEmail() : "null"));
            } catch (SQLException ex) {
                Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, "Error finding user by email: " + email, ex);
            }

            if (user == null) {
                user = new User();
                user.setUsername(userInfo.login != null ? userInfo.login : email);
                user.setName(userInfo.name);
                user.setEmail(email);
                user.setRole("USER"); // Default role
                try {
                    userDAO.registerUser(user);
                    Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.INFO, "Registered new user: " + email);
                    user = userDAO.findByEmail(email); // Retrieve user with ID
                } catch (SQLException ex) {
                    Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, "Error registering user: " + email, ex);
                    req.setAttribute("error", "Failed to register user: " + ex.getMessage());
                    req.getRequestDispatcher("login.jsp").forward(req, resp);
                    return;
                }
            }

            if (user != null) {
                req.getSession().setAttribute("user", user);
                Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.INFO, "User set in session: " + user.getEmail());
                resp.sendRedirect("profile"); // Redirect to profile
            } else {
                req.setAttribute("error", "Failed to authenticate user");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (Exception ex) {
            Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, "Unexpected error during GitHub login", ex);
            req.setAttribute("error", "Authentication error: " + ex.getMessage());
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    private static class UserInfo {
        String email;
        String name;
        String login; // GitHub username
    }

    private static class TokenResponse {
        String access_token;
        String token_type;
        String scope;
    }

    private static class EmailInfo {
        String email;
        boolean primary;
        boolean verified;
    }
}