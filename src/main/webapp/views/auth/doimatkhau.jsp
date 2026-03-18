<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value=""/>
<%@ include file="/WEB-INF/header.jsp" %>

<div class="card" style="max-width:460px;margin:auto">
    <div class="card-header">🔑 Đổi mật khẩu</div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">✖ ${error}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/doimatkhau"
          onsubmit="return validateForm()">

        <div class="form-group">
            <label>Mật khẩu hiện tại <span style="color:red">*</span></label>
            <input type="password" name="matKhauCu" required placeholder="Nhập mật khẩu hiện tại">
        </div>
        <div class="form-group">
            <label>Mật khẩu mới <span style="color:red">*</span></label>
            <input type="password" name="matKhauMoi" id="matKhauMoi" required
                   placeholder="Ít nhất 8 ký tự, chữ hoa, thường, số">
            <small style="color:#888">Tối thiểu 8 ký tự, gồm chữ hoa, thường và số</small>
        </div>
        <div class="form-group">
            <label>Xác nhận mật khẩu mới <span style="color:red">*</span></label>
            <input type="password" name="xacNhan" id="xacNhan" required
                   placeholder="Nhập lại mật khẩu mới">
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary">💾 Lưu mật khẩu mới</button>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">↩ Huỷ</a>
        </div>
    </form>
</div>

<script>
function validateForm() {
    const pw  = document.getElementById('matKhauMoi').value;
    const pw2 = document.getElementById('xacNhan').value;
    if (pw !== pw2) { alert('Xác nhận mật khẩu mới không khớp!'); return false; }
    if (pw.length < 8 || !/[A-Z]/.test(pw) || !/[a-z]/.test(pw) || !/[0-9]/.test(pw)) {
        alert('Mật khẩu mới chưa đủ mạnh!');
        return false;
    }
    return true;
}
</script>

<%@ include file="/WEB-INF/footer.jsp" %>
