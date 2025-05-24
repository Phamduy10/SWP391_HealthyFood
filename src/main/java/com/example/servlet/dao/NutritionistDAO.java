/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;
import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Admin
 */
public class NutritionistDAO {
    public void getAllBlogs () throws SQLException{
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        String sql = "INSERT INTO Users (username, pass, name, email, phone, gender, birthDate, role, status, image, create_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }
    
}
