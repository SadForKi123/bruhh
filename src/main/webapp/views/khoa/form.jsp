<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="khoa"/>
<c:set var="isEdit" value="${not empty khoa}"/>
<%@ include file="/WEB-INF/header.jsp" %>

<div class="card" style="max-width:420px">
    <div class="card-header">${isEdit ? '✏️ Chỉnh sửa khoa' : '➕ Thêm khoa mới'}</div>

    <form method="post" action="${pageContext.request.contextPath}/khoa">
        <input type="hidden" name="action" value="${isEdit ? 'update' : 'insert'}">

        <div class="form-group">
            <label>Mã khoa <span style="color:red">*</span></label>
            <input type="text" name="maKhoa" required
                   value="${isEdit ? khoa.maKhoa : ''}"
                   ${isEdit ? 'readonly style=background:#f5f5f5' : ''}
                   placeholder="VD: CNTT" maxlength="10">
        </div>
        <div class="form-group">
            <label>Tên khoa <span style="color:red">*</span></label>
            <input type="text" name="tenKhoa" required
                   value="${isEdit ? khoa.tenKhoa : ''}"
                   placeholder="VD: Công nghệ thông tin" maxlength="100">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">${isEdit ? '💾 Cập nhật' : '➕ Thêm'}</button>
            <a href="${pageContext.request.contextPath}/khoa" class="btn btn-secondary">↩ Quay lại</a>
        </div>
    </form>
</div>

<%@ include file="/WEB-INF/footer.jsp" %>
