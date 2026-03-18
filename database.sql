-- ==============================================
-- HỆ THỐNG QUẢN LÝ SINH VIÊN - SQL Server Script
-- ==============================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'QuanLySinhVien')
BEGIN
    CREATE DATABASE QuanLySinhVien;
END
GO

USE QuanLySinhVien;
GO

-- Tạo bảng Khoa
IF OBJECT_ID('Khoa', 'U') IS NULL
CREATE TABLE Khoa (
    MaKhoa   VARCHAR(10)  PRIMARY KEY,
    TenKhoa  NVARCHAR(100) NOT NULL
);
GO

-- Tạo bảng Lop
IF OBJECT_ID('Lop', 'U') IS NULL
CREATE TABLE Lop (
    MaLop   VARCHAR(10)  PRIMARY KEY,
    TenLop  NVARCHAR(100) NOT NULL,
    MaKhoa  VARCHAR(10)  NOT NULL,
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);
GO

-- Tạo bảng SinhVien
IF OBJECT_ID('SinhVien', 'U') IS NULL
CREATE TABLE SinhVien (
    MSV       VARCHAR(15)  PRIMARY KEY,
    HoVaTen   NVARCHAR(100) NOT NULL,
    NgaySinh  DATE         NOT NULL,
    GioiTinh  NVARCHAR(10) NOT NULL,
    DiaChi    NVARCHAR(200),
    Email     VARCHAR(100),
    SoDT      VARCHAR(15),
    MaLop     VARCHAR(10)  NOT NULL,
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop)
);
GO

-- ========================
-- DỮ LIỆU MẪU
-- ========================

-- Khoa
INSERT INTO Khoa (MaKhoa, TenKhoa) VALUES
('CNTT', N'Công nghệ thông tin'),
('KT',   N'Kinh tế'),
('XD',   N'Xây dựng'),
('DT',   N'Điện tử viễn thông');
GO

-- Lớp
INSERT INTO Lop (MaLop, TenLop, MaKhoa) VALUES
('CNTT01', N'CNTT K01', 'CNTT'),
('CNTT02', N'CNTT K02', 'CNTT'),
('KT01',   N'Kế toán K01', 'KT'),
('KT02',   N'Tài chính K02', 'KT'),
('XD01',   N'Xây dựng K01', 'XD'),
('DT01',   N'Điện tử K01', 'DT');
GO

-- Sinh viên
INSERT INTO SinhVien (MSV, HoVaTen, NgaySinh, GioiTinh, DiaChi, Email, SoDT, MaLop) VALUES
('SV001', N'Nguyễn Văn An',    '2003-05-15', N'Nam',  N'Hà Nội',     'an.nv@email.com',   '0901234561', 'CNTT01'),
('SV002', N'Trần Thị Bình',    '2003-08-22', N'Nữ',   N'Hà Nội',     'binh.tt@email.com', '0901234562', 'CNTT01'),
('SV003', N'Lê Văn Cường',     '2002-12-10', N'Nam',  N'Nam Định',   'cuong.lv@email.com','0901234563', 'CNTT02'),
('SV004', N'Phạm Thị Dung',    '2003-03-18', N'Nữ',   N'Hải Phòng',  'dung.pt@email.com', '0901234564', 'KT01'),
('SV005', N'Hoàng Văn Em',     '2002-07-25', N'Nam',  N'Hà Nam',     'em.hv@email.com',   '0901234565', 'KT02'),
('SV006', N'Vũ Thị Phương',    '2003-01-30', N'Nữ',   N'Thái Bình',  'phuong.vt@email.com','0901234566','CNTT02'),
('SV007', N'Đặng Văn Giang',   '2002-09-14', N'Nam',  N'Hưng Yên',   'giang.dv@email.com','0901234567', 'XD01'),
('SV008', N'Bùi Thị Hoa',      '2003-11-05', N'Nữ',   N'Hà Nội',     'hoa.bt@email.com',  '0901234568', 'DT01'),
('SV009', N'Ngô Văn Inh',      '2002-06-20', N'Nam',  N'Hải Dương',  'inh.nv@email.com',  '0901234569', 'CNTT01'),
('SV010', N'Đinh Thị Kim',     '2003-04-12', N'Nữ',   N'Vĩnh Phúc',  'kim.dt@email.com',  '0901234570', 'KT01');
GO

PRINT N'Tạo database và dữ liệu mẫu thành công!';
GO
