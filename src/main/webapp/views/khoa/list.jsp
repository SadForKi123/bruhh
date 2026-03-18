<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="khoa"/>
<%@ include file="/WEB-INF/header.jsp" %>

<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px">
    <div class="card-header" style="margin:0">🏛️ Danh sách khoa</div>
    <a href="${pageContext.request.contextPath}/khoa?action=add" class="btn btn-success">➕ Thêm khoa mới</a>
</div>

<div class="card" style="padding:0">
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Mã khoa</th>
                    <th>Tên khoa</th>
                    <th>Số sinh viên</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="k" items="${khoaList}" varStatus="st">
                    <tr>
                        <td>${st.index + 1}</td>
                        <td><strong>${k.maKhoa}</strong></td>
                        <td>${k.tenKhoa}</td>
                        <td>
                            <span style="background:#fd7e14;color:white;padding:2px 10px;border-radius:12px;font-size:12px">
                                ${k.soSinhVien}
                            </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/khoa?action=edit&maKhoa=${k.maKhoa}"
                               class="icon-btn edit">✏️</a>
                            <button class="icon-btn del"
                                onclick="confirmDel('${k.maKhoa}','${k.tenKhoa}')">🗑️</button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty khoaList}">
                    <tr><td colspan="5" style="text-align:center;padding:30px;color:#999">Chưa có khoa nào</td></tr>
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
function confirmDel(maKhoa, tenKhoa) {
    document.getElementById('modalMsg').textContent = 'Xoá khoa "' + tenKhoa + '"? (Sẽ xoá toàn bộ lớp thuộc khoa này!)';
    document.getElementById('confirmBtn').onclick = function() {
        window.location = '${pageContext.request.contextPath}/khoa?action=delete&maKhoa=' + maKhoa;
    };
    document.getElementById('modalOverlay').style.display = 'flex';
}
function closeModal() { document.getElementById('modalOverlay').style.display = 'none'; }
</script>

<%@ include file="/WEB-INF/footer.jsp" %>
