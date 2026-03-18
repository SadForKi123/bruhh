package com.quanlysinhvien.model;

import java.time.LocalDateTime;

public class NguoiDung {
    private int maND;
    private String tenDangNhap;
    private String matKhau;
    private String hoTen;
    private String email;
    private String vaiTro;   // ADMIN / USER
    private boolean trangThai;
    private LocalDateTime ngayTao;

    public NguoiDung() {}

    // Getters & Setters
    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }

    public String getTenDangNhap() { return tenDangNhap; }
    public void setTenDangNhap(String tenDangNhap) { this.tenDangNhap = tenDangNhap; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }

    public LocalDateTime getNgayTao() { return ngayTao; }
    public void setNgayTao(LocalDateTime ngayTao) { this.ngayTao = ngayTao; }

    public boolean isAdmin() { return "ADMIN".equalsIgnoreCase(vaiTro); }
}
