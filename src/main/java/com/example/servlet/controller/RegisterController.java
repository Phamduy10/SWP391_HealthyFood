package com.example.servlet.controller;

<<<<<<< HEAD
=======


>>>>>>> origin/Duy
import com.example.servlet.dao.AccountDAO;
import com.example.servlet.model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
<<<<<<< HEAD

=======
   
>>>>>>> origin/Duy
    private AccountDAO userDAO;

    @Override
    public void init() {
        userDAO = new AccountDAO();
    }

    @Override
<<<<<<< HEAD
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
=======
>>>>>>> origin/Duy
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
<<<<<<< HEAD
        String confirmPassword = request.getParameter("confirmPassword");
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        
=======
>>>>>>> origin/Duy
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("birthDate");

<<<<<<< HEAD
        //check email existed
        try {
            if (userDAO.checkEmailExists(email)) {
                request.setAttribute("error", "This email existed!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
=======
        
        //check email existed
        try {
            if(userDAO.checkEmailExists(email)){
                    request.setAttribute("error", "This email existed!" );
            request.getRequestDispatcher("register.jsp").forward(request, response);     
>>>>>>> origin/Duy
            }
        } catch (SQLException ex) {
        }
        Account user = new Account();
        user.setUsername(username);
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        user.setPass(hashedPassword);
        user.setName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setGender(gender);
        user.setRole("USER");
        user.setBirthDate(birthDateStr != null && !birthDateStr.isEmpty() ? Date.valueOf(birthDateStr) : null);

        try {
            userDAO.registerUser(user);
            response.sendRedirect("login.jsp?success=Registration successful");
        } catch (SQLException e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/Duy
