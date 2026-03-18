<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="dashboard"/>
<%@ include file="/WEB-INF/header.jsp" %>

<c:if test="${not empty param.success}">
    <div class="alert alert-success">✔ Thao tác thành công!</div>
</c:if>

<div class="card-header" style="font-size:30px; margin-bottom:20px;">📊 Tổng quan hệ thống</div>

<div class="stats-grid">
    <div class="stat-card">
        <div class="num">${totalSV}</div>
        <div class="lbl" style="font-size:30px;">👤 Tổng sinh viên</div>
    </div>
    <div class="stat-card" style="border-top-color:#28a745">
        <div class="num" style="color:#28a745">${totalLop}</div>
        <div class="lbl" style="font-size:30px;">🏫 Tổng lớp học</div>
    </div>
    <div class="stat-card" style="border-top-color:#fd7e14">
        <div class="num" style="color:#fd7e14">${totalKhoa}</div>
        <div class="lbl" style="font-size:30px;">🏛️ Tổng khoa</div>
    </div>
</div>

<div class="card">
    <div class="card-header">📋 Thống kê sinh viên theo khoa</div>
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Mã khoa</th>
                    <th>Tên khoa</th>
                    <th>Số sinh viên</th>
                    <th>Tỉ lệ</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="k" items="${khoaList}">
                    <tr>
                        <td><strong>${k.maKhoa}</strong></td>
                        <td>${k.tenKhoa}</td>
                        <td>
                            <span style="background:#2c6fad;color:white;padding:2px 10px;border-radius:12px;font-size:12px">
                                ${k.soSinhVien}
                            </span>
                        </td>
                        <td>
                            <c:if test="${totalSV > 0}">
                                <div style="background:#e8eef5;border-radius:4px;height:14px;width:200px;overflow:hidden">
                                    <div style="background:#2c6fad;height:100%;width:${k.soSinhVien * 100 / totalSV}%"></div>
                                </div>
                                <small>${String.format('%.1f', k.soSinhVien * 100.0 / totalSV)}%</small>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<div style="display:flex; gap:12px; flex-wrap:wrap;">
    <a href="${pageContext.request.contextPath}/sinhvien?action=add" class="btn btn-primary">➕ Thêm sinh viên mới</a>
    <a href="${pageContext.request.contextPath}/sinhvien" class="btn btn-secondary">📋 Xem danh sách sinh viên</a>
    <a href="${pageContext.request.contextPath}/lop?action=add" class="btn btn-success">➕ Thêm lớp mới</a>
</div>

<%@ include file="/WEB-INF/footer.jsp" %>
