<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="currentPage" value="sinhvien"/>
<%@ include file="/WEB-INF/header.jsp" %>

<%-- Thông báo --%>
<c:if test="${param.success == 'added'}">
    <div class="alert alert-success">✔ Thêm sinh viên thành công!</div>
</c:if>
<c:if test="${param.success == 'updated'}">
    <div class="alert alert-success">✔ Cập nhật sinh viên thành công!</div>
</c:if>
<c:if test="${param.success == 'deleted'}">
    <div class="alert alert-success">✔ Xoá sinh viên thành công!</div>
</c:if>
<c:if test="${not empty param.error}">
    <div class="alert alert-danger">✖ Có lỗi xảy ra: ${param.error}</div>
</c:if>

<%-- Search bar --%>
<div class="search-bar">
    <label>TÌM KIẾM</label>
    <form method="get" action="${pageContext.request.contextPath}/sinhvien"
          style="display:flex;gap:8px;flex-wrap:wrap;align-items:center;flex:1">
        <input type="hidden" name="action" value="search">
        <input type="text" name="tenSV" placeholder="Tìm kiếm tên..."
               value="${searchTen}" style="min-width:160px">

        <select name="gioiTinh">
            <option value="">Tìm kiếm giới tính</option>
            <option value="Nam"  ${searchGioiTinh == 'Nam'  ? 'selected' : ''}>Nam</option>
            <option value="Nữ"   ${searchGioiTinh == 'Nữ'  ? 'selected' : ''}>Nữ</option>
        </select>

        <select name="maLop">
            <option value="">Tìm kiếm lớp</option>
            <c:forEach var="l" items="${lopList}">
                <option value="${l.maLop}" ${searchLop == l.maLop ? 'selected' : ''}>${l.tenLop}</option>
            </c:forEach>
        </select>

        <span class="total-badge">TỔNG: ${total}</span>

        <button type="submit" class="btn btn-primary">🔍 LỌC</button>
        <a href="${pageContext.request.contextPath}/sinhvien" class="btn btn-secondary">↺ RESET</a>
        <a href="${pageContext.request.contextPath}/sinhvien?action=add" class="btn btn-success">➕ THÊM MỚI</a>
    </form>
</div>

<%-- Table --%>
<div class="card" style="padding:0">
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>MSV</th>
                    <th>Họ và tên</th>
                    <th>Ngày sinh</th>
                    <th>Giới tính</th>
                    <th>Lớp</th>
                    <th>Khoa</th>
                    <th>Email</th>
                    <th>Số ĐT</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty sinhvienList}">
                        <tr>
                            <td colspan="9" style="text-align:center;padding:30px;color:#999">
                                Không có dữ liệu sinh viên
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="sv" items="${sinhvienList}">
                            <tr>
                                <td><strong>${sv.msv}</strong></td>
                                <td>${sv.hoVaTen}</td>
                                <td>
                                    <c:if test="${not empty sv.ngaySinh}">
                                        ${sv.ngaySinh.dayOfMonth}/${sv.ngaySinh.monthValue}/${sv.ngaySinh.year}
                                    </c:if>
                                </td>
                                <td>
                                    <span style="color:${sv.gioiTinh == 'Nam' ? '#2c6fad' : '#e91e8c'};font-weight:600">
                                        ${sv.gioiTinh}
                                    </span>
                                </td>
                                <td>${sv.tenLop}</td>
                                <td>${sv.tenKhoa}</td>
                                <td>${sv.email}</td>
                                <td>${sv.soDT}</td>
                                <td style="white-space:nowrap">
                                    <a href="${pageContext.request.contextPath}/sinhvien?action=edit&msv=${sv.msv}"
                                       class="icon-btn edit" title="Sửa">✏️</a>
                                    <button class="icon-btn del" title="Xoá"
                                        onclick="confirmDelete('${sv.msv}','${sv.hoVaTen}')">🗑️</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<%-- Delete confirm modal --%>
<div id="modalOverlay" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:999;justify-content:center;align-items:center">
    <div style="background:white;border-radius:8px;padding:28px;min-width:320px;text-align:center;box-shadow:0 4px 20px rgba(0,0,0,.3)">
        <div style="font-size:48px;margin-bottom:12px">⚠️</div>
        <h3 style="margin-bottom:8px">Xác nhận xoá</h3>
        <p id="modalMsg" style="color:#666;margin-bottom:20px"></p>
        <div style="display:flex;gap:10px;justify-content:center">
            <button class="btn btn-danger" id="confirmBtn">Xoá</button>
            <button class="btn btn-secondary" onclick="closeModal()">Huỷ</button>
        </div>
    </div>
</div>

<script>
function confirmDelete(msv, ten) {
    document.getElementById('modalMsg').textContent = 'Bạn có chắc muốn xoá sinh viên "' + ten + '" (MSV: ' + msv + ')?';
    document.getElementById('confirmBtn').onclick = function() {
        window.location = '${pageContext.request.contextPath}/sinhvien?action=delete&msv=' + msv;
    };
    document.getElementById('modalOverlay').style.display = 'flex';
}
function closeModal() {
    document.getElementById('modalOverlay').style.display = 'none';
}
</script>

<%@ include file="/WEB-INF/footer.jsp" %>
