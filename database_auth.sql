-- ===========================
-- THÊM VÀO database.sql (chạy sau script cũ)
-- ===========================

USE QuanLySinhVien;
GO

IF OBJECT_ID('NguoiDung', 'U') IS NULL
CREATE TABLE NguoiDung (
    MaND        INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap VARCHAR(50)   NOT NULL UNIQUE,
    MatKhau     VARCHAR(256)  NOT NULL,  -- SHA-256 hash
    HoTen       NVARCHAR(100) NOT NULL,
    Email       VARCHAR(100)  NOT NULL UNIQUE,
    VaiTro      VARCHAR(20)   NOT NULL DEFAULT 'USER',  -- ADMIN / USER
    TrangThai   BIT           NOT NULL DEFAULT 1,       -- 1=active, 0=locked
    NgayTao     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- Tài khoản admin mặc định: admin / Admin@123
-- SHA-256 của "Admin@123"
INSERT INTO NguoiDung (TenDangNhap, MatKhau, HoTen, Email, VaiTro)
VALUES (
    'admin',
    'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', -- Admin@123
    N'Quản trị viên',
    'admin@qlsv.edu.vn',
    'ADMIN'
);
GO

PRINT N'Tạo bảng NguoiDung thành công!';
GO
