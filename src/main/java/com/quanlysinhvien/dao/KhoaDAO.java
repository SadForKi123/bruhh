package com.quanlysinhvien.dao;

import com.quanlysinhvien.model.Khoa;
import com.quanlysinhvien.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KhoaDAO {

    public List<Khoa> getAll() throws SQLException {
        String sql = """
            SELECT k.*,
                   (SELECT COUNT(*) FROM SinhVien sv JOIN Lop l ON sv.MaLop=l.MaLop WHERE l.MaKhoa=k.MaKhoa) AS SoSinhVien
            FROM Khoa k ORDER BY k.MaKhoa
            """;
        List<Khoa> list = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Khoa k = new Khoa();
                k.setMaKhoa(rs.getString("MaKhoa"));
                k.setTenKhoa(rs.getString("TenKhoa"));
                k.setSoSinhVien(rs.getInt("SoSinhVien"));
                list.add(k);
            }
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    public Khoa findById(String maKhoa) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement("SELECT * FROM Khoa WHERE MaKhoa=?")) {
            ps.setString(1, maKhoa);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Khoa(rs.getString("MaKhoa"), rs.getString("TenKhoa"));
            }
            return null;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean insert(Khoa k) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO Khoa(MaKhoa,TenKhoa) VALUES(?,?)")) {
            ps.setString(1, k.getMaKhoa());
            ps.setString(2, k.getTenKhoa());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean update(Khoa k) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "UPDATE Khoa SET TenKhoa=? WHERE MaKhoa=?")) {
            ps.setString(1, k.getTenKhoa());
            ps.setString(2, k.getMaKhoa());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean delete(String maKhoa) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM Khoa WHERE MaKhoa=?")) {
            ps.setString(1, maKhoa);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}
