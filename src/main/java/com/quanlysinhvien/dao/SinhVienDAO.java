package com.quanlysinhvien.dao;

import com.quanlysinhvien.model.SinhVien;
import com.quanlysinhvien.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class SinhVienDAO {

    // ── Lấy toàn bộ sinh viên (kèm tên lớp, tên khoa) ──────────────────────
    public List<SinhVien> getAll() throws SQLException {
        String sql = """
            SELECT sv.*, l.TenLop, l.MaKhoa, k.TenKhoa
            FROM SinhVien sv
            JOIN Lop  l ON sv.MaLop  = l.MaLop
            JOIN Khoa k ON l.MaKhoa  = k.MaKhoa
            ORDER BY sv.MSV
            """;
        return executeQuery(sql);
    }

    // ── Tìm kiếm + lọc ──────────────────────────────────────────────────────
    public List<SinhVien> search(String tenSV, String gioiTinh, String maLop) throws SQLException {
        StringBuilder sb = new StringBuilder("""
            SELECT sv.*, l.TenLop, l.MaKhoa, k.TenKhoa
            FROM SinhVien sv
            JOIN Lop  l ON sv.MaLop  = l.MaLop
            JOIN Khoa k ON l.MaKhoa  = k.MaKhoa
            WHERE 1=1
            """);

        List<Object> params = new ArrayList<>();

        if (tenSV != null && !tenSV.trim().isEmpty()) {
            sb.append(" AND sv.HoVaTen LIKE ?");
            params.add("%" + tenSV.trim() + "%");
        }
        if (gioiTinh != null && !gioiTinh.isEmpty()) {
            sb.append(" AND sv.GioiTinh = ?");
            params.add(gioiTinh);
        }
        if (maLop != null && !maLop.isEmpty()) {
            sb.append(" AND sv.MaLop = ?");
            params.add(maLop);
        }
        sb.append(" ORDER BY sv.MSV");

        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sb.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            return mapResultSet(ps.executeQuery());
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Tìm theo MSV ────────────────────────────────────────────────────────
    public SinhVien findById(String msv) throws SQLException {
        String sql = """
            SELECT sv.*, l.TenLop, l.MaKhoa, k.TenKhoa
            FROM SinhVien sv
            JOIN Lop  l ON sv.MaLop = l.MaLop
            JOIN Khoa k ON l.MaKhoa = k.MaKhoa
            WHERE sv.MSV = ?
            """;
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, msv);
            List<SinhVien> list = mapResultSet(ps.executeQuery());
            return list.isEmpty() ? null : list.get(0);
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Thêm mới ────────────────────────────────────────────────────────────
    public boolean insert(SinhVien sv) throws SQLException {
        String sql = """
            INSERT INTO SinhVien (MSV, HoVaTen, NgaySinh, GioiTinh, DiaChi, Email, SoDT, MaLop)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """;
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sv.getMsv());
            ps.setString(2, sv.getHoVaTen());
            ps.setDate(3, Date.valueOf(sv.getNgaySinh()));
            ps.setString(4, sv.getGioiTinh());
            ps.setString(5, sv.getDiaChi());
            ps.setString(6, sv.getEmail());
            ps.setString(7, sv.getSoDT());
            ps.setString(8, sv.getMaLop());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Cập nhật ─────────────────────────────────────────────────────────────
    public boolean update(SinhVien sv) throws SQLException {
        String sql = """
            UPDATE SinhVien
            SET HoVaTen=?, NgaySinh=?, GioiTinh=?, DiaChi=?, Email=?, SoDT=?, MaLop=?
            WHERE MSV=?
            """;
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sv.getHoVaTen());
            ps.setDate(2, Date.valueOf(sv.getNgaySinh()));
            ps.setString(3, sv.getGioiTinh());
            ps.setString(4, sv.getDiaChi());
            ps.setString(5, sv.getEmail());
            ps.setString(6, sv.getSoDT());
            ps.setString(7, sv.getMaLop());
            ps.setString(8, sv.getMsv());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Xóa ──────────────────────────────────────────────────────────────────
    public boolean delete(String msv) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM SinhVien WHERE MSV=?")) {
            ps.setString(1, msv);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Kiểm tra MSV đã tồn tại chưa ─────────────────────────────────────────
    public boolean existsMsv(String msv) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (PreparedStatement ps = conn.prepareStatement("SELECT 1 FROM SinhVien WHERE MSV=?")) {
            ps.setString(1, msv);
            return ps.executeQuery().next();
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Đếm tổng ─────────────────────────────────────────────────────────────
    public int countAll() throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM SinhVien")) {
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // ── Helper ───────────────────────────────────────────────────────────────
    private List<SinhVien> executeQuery(String sql) throws SQLException {
        Connection conn = DBConnection.getConnection();
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            return mapResultSet(rs);
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    private List<SinhVien> mapResultSet(ResultSet rs) throws SQLException {
        List<SinhVien> list = new ArrayList<>();
        while (rs.next()) {
            SinhVien sv = new SinhVien();
            sv.setMsv(rs.getString("MSV"));
            sv.setHoVaTen(rs.getString("HoVaTen"));
            Date d = rs.getDate("NgaySinh");
            if (d != null) sv.setNgaySinh(d.toLocalDate());
            sv.setGioiTinh(rs.getString("GioiTinh"));
            sv.setDiaChi(rs.getString("DiaChi"));
            sv.setEmail(rs.getString("Email"));
            sv.setSoDT(rs.getString("SoDT"));
            sv.setMaLop(rs.getString("MaLop"));
            sv.setTenLop(rs.getString("TenLop"));
            sv.setMaKhoa(rs.getString("MaKhoa"));
            sv.setTenKhoa(rs.getString("TenKhoa"));
            list.add(sv);
        }
        return list;
    }
}
