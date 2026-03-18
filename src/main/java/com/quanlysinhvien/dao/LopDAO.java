package com.quanlysinhvien.dao;

import com.quanlysinhvien.model.Lop;
import com.quanlysinhvien.model.Khoa;
import com.quanlysinhvien.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LopDAO {

    public List<Lop> getAll() throws SQLException {
        String sql = """
            SELECT l.*, k.TenKhoa,
                   (SELECT COUNT(*) FROM SinhVien sv WHERE sv.MaLop = l.MaLop) AS SoSinhVien
            FROM Lop l JOIN Khoa k ON l.MaKhoa = k.MaKhoa
            ORDER BY l.MaLop
            """;
        List<Lop> list = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Lop lop = new Lop();
                lop.setMaLop(rs.getString("MaLop"));
                lop.setTenLop(rs.getString("TenLop"));
                lop.setMaKhoa(rs.getString("MaKhoa"));
                lop.setTenKhoa(rs.getString("TenKhoa"));
                lop.setSoSinhVien(rs.getInt("SoSinhVien"));
                list.add(lop);
            }
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    public Lop findById(String maLop) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT l.*, k.TenKhoa FROM Lop l JOIN Khoa k ON l.MaKhoa=k.MaKhoa WHERE l.MaLop=?")) {
            ps.setString(1, maLop);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Lop lop = new Lop();
                lop.setMaLop(rs.getString("MaLop"));
                lop.setTenLop(rs.getString("TenLop"));
                lop.setMaKhoa(rs.getString("MaKhoa"));
                lop.setTenKhoa(rs.getString("TenKhoa"));
                return lop;
            }
            return null;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean insert(Lop lop) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO Lop(MaLop, TenLop, MaKhoa) VALUES(?,?,?)")) {
            ps.setString(1, lop.getMaLop());
            ps.setString(2, lop.getTenLop());
            ps.setString(3, lop.getMaKhoa());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean update(Lop lop) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "UPDATE Lop SET TenLop=?, MaKhoa=? WHERE MaLop=?")) {
            ps.setString(1, lop.getTenLop());
            ps.setString(2, lop.getMaKhoa());
            ps.setString(3, lop.getMaLop());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean delete(String maLop) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM Lop WHERE MaLop=?")) {
            ps.setString(1, maLop);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    public boolean hasSinhVien(String maLop) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT 1 FROM SinhVien WHERE MaLop=?")) {
            ps.setString(1, maLop);
            return ps.executeQuery().next();
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}
