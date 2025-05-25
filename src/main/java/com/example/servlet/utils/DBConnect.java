package com.example.servlet.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
    private Connection c;
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SWP391_PROJECT_FOODSHOP;encrypt=true;trustServerCertificate=true;useUnicode=true;";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "123";

    public DBConnect() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            c = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("JDBC Driver not found", e);
        } catch (SQLException e) {
            throw new RuntimeException("Database connection failed: " + e.getMessage(), e);
        }
    }

    public Connection getConnection() {
        return c;
    }

    public void closeConnection() {
        try {
            if (c != null && !c.isClosed()) {
                c.close();
                System.out.println("Connection closed successfully.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing connection: " + e.getMessage());
        }
    }
}