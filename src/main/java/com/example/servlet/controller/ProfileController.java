package com.example.servlet.controller;

import com.example.servlet.dao.UserDAO;
import com.example.servlet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProfileController extends HttpServlet {
    private UserDAO userDAO;
    private static final String UPLOAD_DIR = "C:\\Users\\Admin\\Desktop\\SWP391_HealthyFood\\src\\main\\webapp\\img\\avar";
    private static final String RELATIVE_PATH = "img/avar";

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            user = userDAO.findByEmail(user.getEmail());
            if (user != null) {
                session.setAttribute("user", user);
            } 
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading user data: " + e.getMessage());
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
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

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("birthDate");

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required and cannot be empty");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // Handle file upload
        String imagePath = user.getImage();
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fullPath = UPLOAD_DIR + File.separator + fileName;
            filePart.write(fullPath);
            imagePath = RELATIVE_PATH + "/" + fileName;
        }

        // Update user object
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(gender);
        user.setBirthDate(birthDateStr != null && !birthDateStr.isEmpty() ? Date.valueOf(birthDateStr) : null);
        user.setImage(imagePath);

        try {
            userDAO.updateUser(user);
            session.setAttribute("user", user);
            response.sendRedirect("profile?success=Profile updated successfully");
        } catch (SQLException e) {
            request.setAttribute("error", "Update failed: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}