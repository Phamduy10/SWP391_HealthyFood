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

public class GitHubLoginServlet extends HttpServlet {
    private static final String CLIENT_ID = "Ov23liuSOh1flCRd73X2";
    private static final String CLIENT_SECRET = "ebbd4aa82148f0de7b08642f4f6bd5cc23a7cacd";
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
            String tokenUrl = "https://github.com/login/oauth/access_token";
            String tokenParams = "client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&code=" + code + "&redirect_uri=" + REDIRECT_URI;
            String tokenResponse = Request.Post(tokenUrl).bodyString(tokenParams, null).execute().returnContent().asString();

            String accessToken = tokenResponse.split("&")[0].split("=")[1];
            String userInfoJson = Request.Get("https://api.github.com/user")
                    .addHeader("Authorization", "Bearer " + accessToken)
                    .execute().returnContent().asString();

            Gson gson = new Gson();
            UserInfo userInfo = gson.fromJson(userInfoJson, UserInfo.class);
            User user = null;
            try {
                user = userDAO.findByEmail(userInfo.email);
            } catch (SQLException ex) {
                Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (user == null) {
                user = new User();
                user.setUsername(userInfo.email);
                user.setName(userInfo.name);
                user.setEmail(userInfo.email);
                try {
                    userDAO.registerUser(user);
                } catch (SQLException ex) {
                    Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    user = userDAO.findByEmail(userInfo.email); // Lấy lại user để có ID
                } catch (SQLException ex) {
                    Logger.getLogger(GitHubLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            req.getSession().setAttribute("user", user);
            resp.sendRedirect("home.jsp");
        }
    }

    private static class UserInfo {
        String email;
        String name;
    }
}