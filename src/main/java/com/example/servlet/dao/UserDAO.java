package com.example.servlet.dao;

import com.example.servlet.model.User;
import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    public void registerUser(User user) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "INSERT INTO Users (username, pass, name, email, phone, gender, birthDate, role, status, image, create_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPass());
            stmt.setString(3, user.getName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getGender());
            stmt.setDate(7, user.getBirthDate());
            stmt.setString(8, user.getRole());
            stmt.setString(9, user.getStatus());
            stmt.setString(10, user.getImage());
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public User loginUser(String username, String password) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT * FROM Users WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("pass");
                // Kiểm tra mật khẩu bằng BCrypt123 = >abc   abc 
                // register 123 => abc (DB)
                // userName:admin
                if (BCrypt.checkpw(password, hashedPassword)) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            hashedPassword, // Lưu ý: Có thể không cần lưu mật khẩu
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("gender"),
                            rs.getDate("birthDate"),
                            rs.getString("role"),
                            rs.getString("status"),
                            rs.getString("image"),
                            rs.getTimestamp("create_at")
                    );
                }
            }
            return null;
        } finally {
            dbConnect.closeConnection();
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT email FROM Users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public void updatePassword(String email, String newPass) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "UPDATE Users SET pass = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPass);
            stmt.setString(2, email);
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public void updateUser(User user) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "UPDATE Users SET name = ?, email = ?, phone = ?, gender = ?, birthDate = ?, role = ?, status = ?, image = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getGender());
            stmt.setDate(5, user.getBirthDate());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getStatus());
            stmt.setString(8, user.getImage());
            stmt.setInt(9, user.getId());
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public User findByEmail(String email) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT * FROM Users WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("pass"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("gender"),
                        rs.getDate("birthDate"),
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getTimestamp("create_at")
                );
            }
            return null;
        } finally {
            dbConnect.closeConnection();
        }
    }
}
