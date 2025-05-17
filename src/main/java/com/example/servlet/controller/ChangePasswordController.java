package com.example.servlet.controller;

import com.example.servlet.dao.UserDAO;
import com.example.servlet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/changePassword")
public class ChangePasswordController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Validate old password
            User loggedInUser = userDAO.loginUser(user.getUsername(), oldPassword);
            if (loggedInUser == null) {
                request.setAttribute("error", "Incorrect old password");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Check if new passwords match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Update password
            userDAO.updatePassword(user.getEmail(), newPassword);
            user.setPass(newPassword);
            session.setAttribute("user", user);
            response.sendRedirect("profile.jsp?success=Password changed successfully");

        } catch (SQLException e) {
            request.setAttribute("error", "Password change failed: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}