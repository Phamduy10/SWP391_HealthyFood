package com.example.servlet.controller;

import com.example.servlet.dao.AccountDAO;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ForgotPasswordController extends HttpServlet {

    static final ConcurrentHashMap<String, String> verificationCodes = new ConcurrentHashMap<>();
    private final AccountDAO userDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        // Kiểm tra email tồn tại
        boolean emailExists = false;
        try {
            emailExists = userDAO.checkEmailExists(email);
        } catch (SQLException ex) {
            Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (!emailExists) {
            req.setAttribute("error", "Email không tồn tại!");
            req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
            return;
        }

        String code = generateVerificationCode();
        verificationCodes.put(email, code);

        try {
            sendEmail(req.getServletContext(), email, "Mã Xác Nhận Đặt Lại Mật Khẩu",
                    "Mã xác nhận của bạn là: " + code);
            req.setAttribute("success", "Mã xác nhận đã được gửi!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi gửi email: " + e.getMessage());
            req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
        }
    }

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    private void sendEmail(ServletContext context, String to, String subject, String content)
            throws MessagingException, IOException {
        Properties props = new Properties();
        props.load(context.getResourceAsStream("/WEB-INF/application.properties"));
        
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(props.getProperty("mail.username"),
                        props.getProperty("mail.password"));
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(props.getProperty("mail.username")));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(content);

        Transport.send(message);
    }
}
