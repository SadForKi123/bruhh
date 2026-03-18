package com.quanlysinhvien.model;

import java.time.LocalDate;

public class SinhVien {
    private String msv;
    private String hoVaTen;
    private LocalDate ngaySinh;
    private String gioiTinh;
    private String diaChi;
    private String email;
    private String soDT;
    private String maLop;
    private String tenLop;
    private String maKhoa;
    private String tenKhoa;

    public SinhVien() {}

    public SinhVien(String msv, String hoVaTen, LocalDate ngaySinh,
                    String gioiTinh, String diaChi, String email,
                    String soDT, String maLop) {
        this.msv = msv;
        this.hoVaTen = hoVaTen;
        this.ngaySinh = ngaySinh;
        this.gioiTinh = gioiTinh;
        this.diaChi = diaChi;
        this.email = email;
        this.soDT = soDT;
        this.maLop = maLop;
    }

    // Getters & Setters
    public String getMsv() { return msv; }
    public void setMsv(String msv) { this.msv = msv; }

    public String getHoVaTen() { return hoVaTen; }
    public void setHoVaTen(String hoVaTen) { this.hoVaTen = hoVaTen; }

    public LocalDate getNgaySinh() { return ngaySinh; }
    public void setNgaySinh(LocalDate ngaySinh) { this.ngaySinh = ngaySinh; }

    public String getGioiTinh() { return gioiTinh; }
    public void setGioiTinh(String gioiTinh) { this.gioiTinh = gioiTinh; }

    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSoDT() { return soDT; }
    public void setSoDT(String soDT) { this.soDT = soDT; }

    public String getMaLop() { return maLop; }
    public void setMaLop(String maLop) { this.maLop = maLop; }

    public String getTenLop() { return tenLop; }
    public void setTenLop(String tenLop) { this.tenLop = tenLop; }

    public String getMaKhoa() { return maKhoa; }
    public void setMaKhoa(String maKhoa) { this.maKhoa = maKhoa; }

    public String getTenKhoa() { return tenKhoa; }
    public void setTenKhoa(String tenKhoa) { this.tenKhoa = tenKhoa; }
}
