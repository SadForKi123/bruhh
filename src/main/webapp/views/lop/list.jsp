<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="lop"/>
<%@ include file="/WEB-INF/header.jsp" %>

<c:if test="${not empty param.success}">
    <div class="alert alert-success">✔ Thao tác thành công!</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">✖ ${error}</div>
</c:if>

<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px">
    <div class="card-header" style="margin:0">🏫 Danh sách lớp học</div>
    <a href="${pageContext.request.contextPath}/lop?action=add" class="btn btn-success">➕ Thêm lớp mới</a>
</div>

<div class="card" style="padding:0">
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Mã lớp</th>
                    <th>Tên lớp</th>
                    <th>Khoa</th>
                    <th>Số sinh viên</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="l" items="${lopList}" varStatus="st">
                    <tr>
                        <td>${st.index + 1}</td>
                        <td><strong>${l.maLop}</strong></td>
                        <td>${l.tenLop}</td>
                        <td>${l.tenKhoa}</td>
                        <td>
                            <span style="background:#2c6fad;color:white;padding:2px 10px;border-radius:12px;font-size:12px">
                                ${l.soSinhVien}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/lop?action=edit&maLop=${l.maLop}"
                               class="icon-btn edit" title="Sửa">✏️</a>
                            <button class="icon-btn del" title="Xoá"
                                onclick="confirmDeleteLop('${l.maLop}','${l.tenLop}',${l.soSinhVien})">🗑️</button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty lopList}">
                    <tr><td colspan="6" style="text-align:center;padding:30px;color:#999">Chưa có lớp nào</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

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
function confirmDeleteLop(maLop, tenLop, soSV) {
    if (soSV > 0) {
        alert('Không thể xoá lớp "' + tenLop + '" vì còn ' + soSV + ' sinh viên!');
        return;
    }
    document.getElementById('modalMsg').textContent = 'Bạn có chắc muốn xoá lớp "' + tenLop + '"?';
    document.getElementById('confirmBtn').onclick = function() {
        window.location = '${pageContext.request.contextPath}/lop?action=delete&maLop=' + maLop;
    };
    document.getElementById('modalOverlay').style.display = 'flex';
}
function closeModal() { document.getElementById('modalOverlay').style.display = 'none'; }
</script>

<%@ include file="/WEB-INF/footer.jsp" %>
