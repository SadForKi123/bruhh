package com.quanlysinhvien.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:sqlserver://192.168.1.32:1433"
                    + ";databaseName=QuanLySinhVien"
                    + ";encrypt=true"
                    + ";trustServerCertificate=true"
                    + ";loginTimeout=30";

    private static final String USERNAME = "qlsv";
    private static final String PASSWORD = "qlsv123";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Không tìm thấy JDBC Driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
}
