<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập – Quản Lý Sinh Viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background: linear-gradient(135deg, #1e4d8c 0%, #2c6fad 60%, #4a9fd4 100%); min-height:100vh; display:flex; align-items:center; justify-content:center; }
        .auth-box { background:#fff; border-radius:12px; box-shadow:0 8px 32px rgba(0,0,0,.25); width:100%; max-width:420px; overflow:hidden; }
        .auth-header { background:linear-gradient(135deg,#1e4d8c,#2c6fad); color:#fff; text-align:center; padding:32px 24px 24px; }
        .auth-header .logo { font-size:48px; margin-bottom:8px; }
        .auth-header h1 { font-size:20px; font-weight:700; margin:0; letter-spacing:.5px; }
        .auth-header p  { font-size:13px; opacity:.85; margin:6px 0 0; }
        .auth-body { padding:28px 32px 32px; }
        .auth-body .form-group { margin-bottom:18px; }
        .auth-body label { font-weight:600; font-size:13px; color:#444; margin-bottom:6px; display:block; }
        .input-icon { position:relative; }
        .input-icon span { position:absolute; left:12px; top:50%; transform:translateY(-50%); font-size:16px; pointer-events:none; }
        .input-icon input { padding-left:38px; width:100%; padding-top:10px; padding-bottom:10px; border:1.5px solid #d0dce8; border-radius:6px; font-size:14px; transition:border-color .2s; }
        .input-icon input:focus { border-color:#2c6fad; outline:none; box-shadow:0 0 0 3px rgba(44,111,173,.12); }
        .remember-row { display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; font-size:13px; }
        .remember-row label { display:flex; align-items:center; gap:6px; cursor:pointer; color:#555; font-weight:normal; margin:0; }
        .remember-row a { color:#2c6fad; text-decoration:none; }
        .btn-login { width:100%; padding:12px; background:linear-gradient(135deg,#1e4d8c,#2c6fad); color:white; border:none; border-radius:6px; font-size:15px; font-weight:600; cursor:pointer; letter-spacing:.3px; transition:opacity .2s, transform .1s; }
        .btn-login:hover { opacity:.9; transform:translateY(-1px); }
        .btn-login:active { transform:translateY(0); }
        .auth-footer { text-align:center; margin-top:20px; font-size:13px; color:#666; }
        .auth-footer a { color:#2c6fad; font-weight:600; text-decoration:none; }
        .divider { border:none; border-top:1px solid #eee; margin:20px 0; }
        .show-pw { position:absolute; right:12px; top:50%; transform:translateY(-50%); cursor:pointer; font-size:16px; background:none; border:none; padding:0; color:#888; }
    </style>
</head>
<body>
<div class="auth-box">
    <div class="auth-header">
        <div class="logo">🎓</div>
        <h1>HỆ THỐNG QUẢN LÝ SINH VIÊN</h1>
        <p>Vui lòng đăng nhập để tiếp tục</p>
    </div>
    <div class="auth-body">

        <%-- Thông báo --%>
        <c:if test="${param.success == 'registered'}">
            <div class="alert alert-success" style="margin-bottom:18px">
                ✔ Đăng ký thành công! Hãy đăng nhập.
            </div>
        </c:if>
        <c:if test="${param.logout == 'true'}">
            <div class="alert alert-info" style="margin-bottom:18px">
                👋 Bạn đã đăng xuất thành công.
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger" style="margin-bottom:18px">✖ ${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <div class="form-group">
                <label>Tên đăng nhập</label>
                <div class="input-icon">
                    <span>👤</span>
                    <input type="text" name="tenDangNhap" required
                           value="${not empty tenDangNhap ? tenDangNhap : cookie['qlsv_user'].value}"
                           placeholder="Nhập tên đăng nhập..." autocomplete="username">
                </div>
            </div>

            <div class="form-group">
                <label>Mật khẩu</label>
                <div class="input-icon" style="position:relative">
                    <span>🔒</span>
                    <input type="password" name="matKhau" id="matKhau" required
                           placeholder="Nhập mật khẩu..." autocomplete="current-password">
                    <button type="button" class="show-pw" onclick="togglePw('matKhau','eyeIcon')">
                        <span id="eyeIcon">👁️</span>
                    </button>
                </div>
            </div>

            <div class="remember-row">
                <label><input type="checkbox" name="remember"> Ghi nhớ đăng nhập</label>
                <a href="${pageContext.request.contextPath}/doimatkhau">Đổi mật khẩu?</a>
            </div>

            <button type="submit" class="btn-login">🔐 ĐĂNG NHẬP</button>
        </form>

        <hr class="divider">
        <div class="auth-footer">
            Chưa có tài khoản?
            <a href="${pageContext.request.contextPath}/dangky">Đăng ký ngay</a>
        </div>
    </div>
</div>

<script>
function togglePw(fieldId, iconId) {
    const field = document.getElementById(fieldId);
    const icon  = document.getElementById(iconId);
    if (field.type === 'password') {
        field.type = 'text';
        icon.textContent = '🙈';
    } else {
        field.type = 'password';
        icon.textContent = '👁️';
    }
}
</script>
</body>
</html>
