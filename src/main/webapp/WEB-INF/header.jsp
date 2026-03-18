<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hệ Thống Quản Lý Sinh Viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .header { display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:8px; }
        .header-title { font-size:18px; font-weight:bold; letter-spacing:.5px; }
        .user-info { display:flex; align-items:center; gap:10px; font-size:13px; }
        .user-info .name { color:#cde; }
        .user-info .role-badge {
            background:rgba(255,255,255,.2);
            color:#fff;
            padding:2px 8px;
            border-radius:10px;
            font-size:11px;
            font-weight:600;
        }
        .user-info .role-badge.admin { background:#ffc107; color:#333; }
        .btn-logout { background:rgba(255,255,255,.15); color:#fff; border:1px solid rgba(255,255,255,.3);
                      padding:5px 12px; border-radius:4px; text-decoration:none; font-size:12px;
                      transition:background .2s; cursor:pointer; }
        .btn-logout:hover { background:rgba(255,255,255,.25); color:#fff; }
        .sidebar a.sidebar-logout { color:#f8a0a0; }
        .sidebar a.sidebar-logout:hover { background:rgba(220,53,69,.2); color:#fff; }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="header">
        <div class="header-title">🎓 HỆ THỐNG QUẢN LÝ SINH VIÊN</div>
        <c:if test="${not empty sessionScope.nguoidung}">
            <div class="user-info">
                <span class="name">👤 ${sessionScope.nguoidung.hoTen}</span>
                <span class="role-badge ${sessionScope.nguoidung.admin ? 'admin' : ''}">
                    ${sessionScope.nguoidung.vaiTro}
                </span>
                <a href="${pageContext.request.contextPath}/doimatkhau" class="btn-logout">🔑 Đổi MK</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">🚪 Đăng xuất</a>
            </div>
        </c:if>
    </div>
    <div class="body-container">
        <nav class="sidebar">
            <a href="${pageContext.request.contextPath}/dashboard"
               class="${currentPage == 'dashboard' ? 'active' : ''}">📊 Dashboard</a>
            <a href="${pageContext.request.contextPath}/sinhvien"
               class="${currentPage == 'sinhvien' ? 'active' : ''}">👤 Quản lý sinh viên</a>
            <a href="${pageContext.request.contextPath}/lop"
               class="${currentPage == 'lop' ? 'active' : ''}">🏫 Quản lý lớp</a>
            <a href="${pageContext.request.contextPath}/khoa"
               class="${currentPage == 'khoa' ? 'active' : ''}">🏛️ Quản lý khoa</a>
            <a href="${pageContext.request.contextPath}/logout"
               class="sidebar-logout" style="margin-top:auto">🚪 Đăng xuất</a>
        </nav>
        <div class="main-content">
