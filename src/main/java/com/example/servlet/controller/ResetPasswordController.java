package com.example.servlet.controller;

import com.example.servlet.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.concurrent.ConcurrentHashMap;
import org.mindrot.jbcrypt.BCrypt;

public class ResetPasswordController extends HttpServlet {

    private static final ConcurrentHashMap<String, String> verificationCodes = ForgotPasswordController.verificationCodes;
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String code = req.getParameter("code");
        String newPassword = req.getParameter("newPassword");
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        String storedCode = verificationCodes.get(email);
        if (storedCode == null || !storedCode.equals(code)) {
            req.setAttribute("error", "Mã xác nhận không hợp lệ!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetPassword.jsp").forward(req, resp);
            return;
        }

        try {
            userDAO.updatePassword(email, hashedPassword);
            verificationCodes.remove(email);
            req.setAttribute("success", "Đặt lại mật khẩu thành công!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Lỗi cập nhật mật khẩu!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetPassword.jsp").forward(req, resp);
        }
    }
}
