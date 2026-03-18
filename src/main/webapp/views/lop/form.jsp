<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="lop"/>
<c:set var="isEdit" value="${not empty lop}"/>
<%@ include file="/WEB-INF/header.jsp" %>

<div class="card" style="max-width:500px">
    <div class="card-header">${isEdit ? '✏️ Chỉnh sửa lớp' : '➕ Thêm lớp mới'}</div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">✖ ${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/lop">
        <input type="hidden" name="action" value="${isEdit ? 'update' : 'insert'}">

        <div class="form-group">
            <label>Mã lớp <span style="color:red">*</span></label>
            <input type="text" name="maLop" required
                   value="${isEdit ? lop.maLop : ''}"
                   ${isEdit ? 'readonly style=background:#f5f5f5' : ''}
                   placeholder="VD: CNTT03" maxlength="10">
        </div>
        <div class="form-group">
            <label>Tên lớp <span style="color:red">*</span></label>
            <input type="text" name="tenLop" required
                   value="${isEdit ? lop.tenLop : ''}"
                   placeholder="VD: CNTT K03" maxlength="100">
        </div>
        <div class="form-group">
            <label>Khoa <span style="color:red">*</span></label>
            <select name="maKhoa" required>
                <option value="">-- Chọn khoa --</option>
                <c:forEach var="k" items="${khoaList}">
                    <option value="${k.maKhoa}" ${(isEdit && lop.maKhoa == k.maKhoa) ? 'selected' : ''}>
                        ${k.tenKhoa}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">${isEdit ? '💾 Cập nhật' : '➕ Thêm'}</button>
            <a href="${pageContext.request.contextPath}/lop" class="btn btn-secondary">↩ Quay lại</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/footer.jsp" %>
