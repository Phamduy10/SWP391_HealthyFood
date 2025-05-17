package com.example.servlet.dao;



import com.example.servlet.model.User;
import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

public class UserDAO {
    public void registerUser(User user) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "INSERT INTO Users (username, password, fullName, email, phone, gender, birthDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getGender());
            stmt.setDate(7, user.getBirthDate());
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public User loginUser(String username, String password) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("fullName"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("gender"),
                    rs.getDate("birthDate")
                );
            }
            return null;
        } finally {
            dbConnect.closeConnection();
        }
    }

    public void updateUser(User user) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "UPDATE Users SET fullName = ?, email = ?, phone = ?, gender = ?, birthDate = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getGender());
            stmt.setDate(5, user.getBirthDate());
            stmt.setInt(6, user.getId());
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }
}