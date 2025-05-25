/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.Blogs;
import com.example.servlet.utils.DBConnect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class NutritionistDAO {

    Connection conn;
    PreparedStatement ps;
    CallableStatement cs = null;
    ResultSet rs;

    public List<Blogs> getBlogsByFilter(String keyword, int typeBMI, boolean sortNewestFirst) {
    List<Blogs> lstBlog = new ArrayList<>();
    DBConnect db = new DBConnect();

    try {
        StringBuilder sql = new StringBuilder(
            "SELECT b.blogID, b.AuthorID, a.name AS authorName, b.typeBMI, b.title, " +
            "b.image, b.content, b.status, b.create_at, b.update_at " +
            "FROM Blogs b JOIN Accounts a ON b.AuthorID = a.id WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (typeBMI != -1) {
            sql.append("AND b.typeBMI = ? ");
            params.add(typeBMI);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (b.title LIKE ? OR a.name LIKE ?) ");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }

        sql.append("ORDER BY b.update_at ").append(sortNewestFirst ? "DESC" : "ASC");

        conn = db.getConnection();
        ps = conn.prepareStatement(sql.toString());

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        rs = ps.executeQuery();
        while (rs.next()) {
            Blogs blog = new Blogs(
                rs.getInt("blogID"),
                rs.getInt("AuthorID"),
                rs.getString("authorName"),
                rs.getInt("typeBMI"),
                rs.getString("title"),
                rs.getString("image"),
                rs.getString("content"),
                rs.getString("status"),
                rs.getTimestamp("create_at"),
                rs.getTimestamp("update_at")
            );
            lstBlog.add(blog);
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    return lstBlog;
}

    public void insertBlog(Blogs blog) {
        DBConnect db = new DBConnect();
        try {
            conn = db.getConnection();
            conn.setAutoCommit(true);

            String sql = "{call InsertBlog(?, ?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);

            cs.setInt(1, blog.getAuthorID());
            cs.setInt(2, blog.getBmiId());
            cs.setString(3, blog.getTitle());
            cs.setString(4, blog.getImageUlr());
            cs.setString(5, blog.getContent());
            cs.setString(6, blog.getStatus());

            boolean hasResultSet = cs.execute();

            if (hasResultSet) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    System.out.println("Rows inserted: " + rs.getInt("RowsInserted"));
                }
            } else {
                System.out.println("Procedure executed, no result set.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void updateBlog(Blogs blog) {
        DBConnect db = new DBConnect();
        try {
            conn = db.getConnection();
            conn.setAutoCommit(true);

            String sql = "{call UpdateBlog(?, ?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);

            cs.setInt(1, blog.getbID());         // blogID là tham số đầu tiên
            cs.setInt(2, blog.getBmiId());
            cs.setString(3, blog.getTitle());
            cs.setString(4, blog.getImageUlr());
            cs.setString(5, blog.getContent());
            cs.setString(6, blog.getStatus());

            boolean hasResultSet = cs.execute();

            if (hasResultSet) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    System.out.println("Rows affected: " + rs.getInt("RowsAffected"));
                }
            } else {
                System.out.println("Procedure executed, no result set.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (cs != null) {
                    cs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
    
    public void deleteBlogByID(int blogID) {
    DBConnect db = new DBConnect();
    try {
        String sql = "DELETE FROM Blogs WHERE blogID = ?";

        conn = db.getConnection();
        ps = conn.prepareStatement(sql);
        ps.setInt(1, blogID);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            System.out.println("Xóa blog thành công. Số dòng bị ảnh hưởng: " + rowsAffected);
        } else {
            System.out.println("Không tìm thấy blog để xóa.");
        }

    } catch (Exception ex) {
        Logger.getLogger(NutritionistDAO.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        try {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


    
    
}
