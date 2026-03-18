<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value="sinhvien"/>
<c:set var="isEdit" value="${not empty sinhvien}"/>
<%@ include file="/WEB-INF/header.jsp" %>

<div class="card">
    <div class="card-header">
        ${isEdit ? '✏️ Chỉnh sửa sinh viên' : '➕ Thêm sinh viên mới'}
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">✖ ${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/sinhvien"
          onsubmit="return validateForm()">
        <input type="hidden" name="action" value="${isEdit ? 'update' : 'insert'}">

        <div class="form-row">
            <div class="form-group">
                <label>Mã sinh viên <span style="color:red">*</span></label>
                <input type="text" name="msv" id="msv" required
                       value="${isEdit ? sinhvien.msv : ''}"
                       ${isEdit ? 'readonly style=background:#f5f5f5' : ''}
                       placeholder="VD: SV011" maxlength="15">
            </div>
            <div class="form-group">
                <label>Họ và tên <span style="color:red">*</span></label>
                <input type="text" name="hoVaTen" required
                       value="${sinhvien.hoVaTen}"
                       placeholder="VD: Nguyễn Văn An" maxlength="100">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Ngày sinh <span style="color:red">*</span></label>
                <input type="date" name="ngaySinh" required
                       value="${sinhvien.ngaySinh}"
                       max="${java.time.LocalDate.now()}">
            </div>
            <div class="form-group">
                <label>Giới tính <span style="color:red">*</span></label>
                <select name="gioiTinh" required>
                    <option value="">-- Chọn giới tính --</option>
                    <option value="Nam"  ${sinhvien.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                    <option value="Nữ"   ${sinhvien.gioiTinh == 'Nữ'  ? 'selected' : ''}>Nữ</option>
                    <option value="Khác" ${sinhvien.gioiTinh == 'Khác' ? 'selected' : ''}>Khác</option>
                </select>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Lớp <span style="color:red">*</span></label>
                <select name="maLop" required>
                    <option value="">-- Chọn lớp --</option>
                    <c:forEach var="l" items="${lopList}">
                        <option value="${l.maLop}"
                            ${sinhvien.maLop == l.maLop ? 'selected' : ''}>
                            ${l.tenLop} (${l.maKhoa})
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="tel" name="soDT" value="${sinhvien.soDT}"
                       placeholder="VD: 0901234567" maxlength="15">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="${sinhvien.email}"
                       placeholder="VD: example@email.com" maxlength="100">
            </div>
            <div class="form-group">
                <label>Địa chỉ</label>
                <input type="text" name="diaChi" value="${sinhvien.diaChi}"
                       placeholder="VD: Hà Nội" maxlength="200">
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">
                ${isEdit ? '💾 Cập nhật' : '➕ Thêm mới'}
            </button>
            <a href="${pageContext.request.contextPath}/sinhvien" class="btn btn-secondary">↩ Quay lại</a>
        </div>
    </form>
</div>

<script>
function validateForm() {
    const msv = document.getElementById('msv');
    if (msv && !msv.readOnly && !/^[A-Za-z0-9]+$/.test(msv.value.trim())) {
        alert('Mã sinh viên chỉ được chứa chữ cái và số!');
        msv.focus();
        return false;
    }
    return true;
}

// Set max date for ngaySinh
document.addEventListener('DOMContentLoaded', function() {
    const ngaySinh = document.querySelector('input[name="ngaySinh"]');
    if (ngaySinh) ngaySinh.max = new Date().toISOString().split('T')[0];
});
</script>

<%@ include file="/WEB-INF/footer.jsp" %>
