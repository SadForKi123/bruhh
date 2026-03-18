package com.quanlysinhvien.dao;

import com.quanlysinhvien.model.NguoiDung;
import com.quanlysinhvien.util.DBConnection;
import com.quanlysinhvien.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungDAO {

    // ── Đăng nhập ────────────────────────────────────────────────────────────
    public NguoiDung login(String tenDangNhap, String matKhauRaw) throws SQLException {
        String sql = "SELECT * FROM NguoiDung WHERE TenDangNhap = ? AND TrangThai = 1";
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenDangNhap.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String hashed = rs.getString("MatKhau");
                if (PasswordUtil.verify(matKhauRaw, hashed)) {
                    return map(rs);
                }
            }
            return null;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Đăng ký ──────────────────────────────────────────────────────────────
    public boolean register(NguoiDung nd) throws SQLException {
        String sql = """
            INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, VaiTro)
            VALUES (?, ?, ?, ?, 'USER')
            """;
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nd.getTenDangNhap().trim().toLowerCase());
            ps.setString(2, PasswordUtil.hash(nd.getMatKhau()));
            ps.setString(3, nd.getHoTen().trim());
            ps.setString(4, nd.getEmail().trim().toLowerCase());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Kiểm tra tên đăng nhập tồn tại ───────────────────────────────────────
    public boolean existsTenDangNhap(String tenDangNhap) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT 1 FROM NguoiDung WHERE TenDangNhap = ?")) {
            ps.setString(1, tenDangNhap.trim().toLowerCase());
            return ps.executeQuery().next();
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Kiểm tra email tồn tại ────────────────────────────────────────────────
    public boolean existsEmail(String email) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT 1 FROM NguoiDung WHERE Email = ?")) {
            ps.setString(1, email.trim().toLowerCase());
            return ps.executeQuery().next();
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Lấy tất cả người dùng (admin) ────────────────────────────────────────
    public List<NguoiDung> getAll() throws SQLException {
        Connection conn = DBConnection.getConnection();
        List<NguoiDung> list = new ArrayList<>();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM NguoiDung ORDER BY NgayTao DESC")) {
            while (rs.next()) list.add(map(rs));
        } finally {
            DBConnection.closeConnection(conn);
        }
        return list;
    }

    // ── Đổi mật khẩu ────────────────────────────────────────────────────────
    public boolean doiMatKhau(int maND, String matKhauMoi) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "UPDATE NguoiDung SET MatKhau = ? WHERE MaND = ?")) {
            ps.setString(1, PasswordUtil.hash(matKhauMoi));
            ps.setInt(2, maND);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Khoá / mở tài khoản ──────────────────────────────────────────────────
    public boolean doiTrangThai(int maND, boolean trangThai) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "UPDATE NguoiDung SET TrangThai = ? WHERE MaND = ?")) {
            ps.setBoolean(1, trangThai);
            ps.setInt(2, maND);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Xoá người dùng ───────────────────────────────────────────────────────
    public boolean delete(int maND) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM NguoiDung WHERE MaND = ? AND VaiTro != 'ADMIN'")) {
            ps.setInt(1, maND);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Tìm theo ID ──────────────────────────────────────────────────────────
    public NguoiDung findById(int maND) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM NguoiDung WHERE MaND = ?")) {
            ps.setInt(1, maND);
            ResultSet rs = ps.executeQuery();
            return rs.next() ? map(rs) : null;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Map ResultSet → NguoiDung ────────────────────────────────────────────
    private NguoiDung map(ResultSet rs) throws SQLException {
        NguoiDung nd = new NguoiDung();
        nd.setMaND(rs.getInt("MaND"));
        nd.setTenDangNhap(rs.getString("TenDangNhap"));
        nd.setMatKhau(rs.getString("MatKhau"));
        nd.setHoTen(rs.getString("HoTen"));
        nd.setEmail(rs.getString("Email"));
        nd.setVaiTro(rs.getString("VaiTro"));
        nd.setTrangThai(rs.getBoolean("TrangThai"));
        Timestamp ts = rs.getTimestamp("NgayTao");
        if (ts != null) nd.setNgayTao(ts.toLocalDateTime());
        return nd;
    }
}
