<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng ký – Quản Lý Sinh Viên</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        body { background: linear-gradient(135deg,#1e4d8c 0%,#2c6fad 60%,#4a9fd4 100%); min-height:100vh; display:flex; align-items:center; justify-content:center; padding:24px; }
        .auth-box { background:#fff; border-radius:12px; box-shadow:0 8px 32px rgba(0,0,0,.25); width:100%; max-width:480px; overflow:hidden; }
        .auth-header { background:linear-gradient(135deg,#1e4d8c,#2c6fad); color:#fff; text-align:center; padding:28px 24px 20px; }
        .auth-header .logo { font-size:42px; margin-bottom:6px; }
        .auth-header h1 { font-size:18px; font-weight:700; margin:0; }
        .auth-header p  { font-size:13px; opacity:.85; margin:4px 0 0; }
        .auth-body { padding:24px 32px 28px; }
        .form-group { margin-bottom:16px; }
        .form-group label { font-weight:600; font-size:13px; color:#444; margin-bottom:5px; display:block; }
        .input-icon { position:relative; }
        .input-icon span.icon { position:absolute; left:11px; top:50%; transform:translateY(-50%); font-size:15px; pointer-events:none; }
        .input-icon input { padding-left:36px; width:100%; padding-top:9px; padding-bottom:9px; border:1.5px solid #d0dce8; border-radius:6px; font-size:14px; transition:border-color .2s; }
        .input-icon input:focus { border-color:#2c6fad; outline:none; box-shadow:0 0 0 3px rgba(44,111,173,.12); }
        .input-icon input.error { border-color:#dc3545; }
        .strength-bar { height:4px; border-radius:2px; margin-top:5px; background:#eee; overflow:hidden; }
        .strength-fill { height:100%; width:0; border-radius:2px; transition:width .3s, background .3s; }
        .strength-hint { font-size:11px; color:#888; margin-top:3px; }
        .btn-register { width:100%; padding:12px; background:linear-gradient(135deg,#1e4d8c,#2c6fad); color:white; border:none; border-radius:6px; font-size:15px; font-weight:600; cursor:pointer; transition:opacity .2s, transform .1s; }
        .btn-register:hover { opacity:.9; transform:translateY(-1px); }
        .auth-footer { text-align:center; margin-top:18px; font-size:13px; color:#666; }
        .auth-footer a { color:#2c6fad; font-weight:600; text-decoration:none; }
        .show-pw { position:absolute; right:10px; top:50%; transform:translateY(-50%); cursor:pointer; font-size:15px; background:none; border:none; padding:0; color:#888; }
        .req-list { font-size:12px; color:#888; margin:4px 0 0 0; padding-left:16px; }
        .req-list li.ok  { color:#28a745; }
        .req-list li.bad { color:#dc3545; }
    </style>
</head>
<body>
<div class="auth-box">
    <div class="auth-header">
        <div class="logo">📝</div>
        <h1>TẠO TÀI KHOẢN MỚI</h1>
        <p>Hệ Thống Quản Lý Sinh Viên</p>
    </div>
    <div class="auth-body">

        <c:if test="${not empty error}">
            <div class="alert alert-danger" style="margin-bottom:16px">✖ ${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/dangky" onsubmit="return validateForm()">

            <div class="form-group">
                <label>Tên đăng nhập <span style="color:red">*</span></label>
                <div class="input-icon">
                    <span class="icon">👤</span>
                    <input type="text" name="tenDangNhap" id="tenDangNhap" required
                           value="${tenDangNhap}" placeholder="4–50 ký tự, chữ/số/_"
                           maxlength="50" oninput="checkUsername(this)">
                </div>
                <div id="usernameMsg" style="font-size:12px;margin-top:3px"></div>
            </div>

            <div class="form-group">
                <label>Họ và tên <span style="color:red">*</span></label>
                <div class="input-icon">
                    <span class="icon">🪪</span>
                    <input type="text" name="hoTen" required value="${hoTen}"
                           placeholder="VD: Nguyễn Văn An" maxlength="100">
                </div>
            </div>

            <div class="form-group">
                <label>Email <span style="color:red">*</span></label>
                <div class="input-icon">
                    <span class="icon">✉️</span>
                    <input type="email" name="email" required value="${email}"
                           placeholder="VD: example@email.com" maxlength="100">
                </div>
            </div>

            <div class="form-group">
                <label>Mật khẩu <span style="color:red">*</span></label>
                <div class="input-icon" style="position:relative">
                    <span class="icon">🔒</span>
                    <input type="password" name="matKhau" id="matKhau" required
                           placeholder="Ít nhất 8 ký tự" oninput="checkStrength(this.value)">
                    <button type="button" class="show-pw" onclick="togglePw('matKhau','eye1')">
                        <span id="eye1">👁️</span>
                    </button>
                </div>
                <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
                <ul class="req-list" id="reqList">
                    <li id="req-len">Ít nhất 8 ký tự</li>
                    <li id="req-upper">Có chữ hoa (A–Z)</li>
                    <li id="req-lower">Có chữ thường (a–z)</li>
                    <li id="req-digit">Có chữ số (0–9)</li>
                </ul>
            </div>

            <div class="form-group">
                <label>Xác nhận mật khẩu <span style="color:red">*</span></label>
                <div class="input-icon" style="position:relative">
                    <span class="icon">🔐</span>
                    <input type="password" name="xacNhanMK" id="xacNhanMK" required
                           placeholder="Nhập lại mật khẩu" oninput="checkMatch()">
                    <button type="button" class="show-pw" onclick="togglePw('xacNhanMK','eye2')">
                        <span id="eye2">👁️</span>
                    </button>
                </div>
                <div id="matchMsg" style="font-size:12px;margin-top:3px"></div>
            </div>

            <button type="submit" class="btn-register">✅ ĐĂNG KÝ</button>
        </form>

        <div class="auth-footer">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        </div>
    </div>
</div>

<script>
function togglePw(id, iconId) {
    const f = document.getElementById(id);
    const e = document.getElementById(iconId);
    f.type = f.type === 'password' ? 'text' : 'password';
    e.textContent = f.type === 'password' ? '👁️' : '🙈';
}

function checkUsername(inp) {
    const msg = document.getElementById('usernameMsg');
    const v = inp.value.trim();
    if (v.length < 4)                      { msg.style.color='#dc3545'; msg.textContent='⚠ Tối thiểu 4 ký tự'; }
    else if (!/^[a-zA-Z0-9_]+$/.test(v))  { msg.style.color='#dc3545'; msg.textContent='⚠ Chỉ được dùng chữ, số, _'; }
    else                                    { msg.style.color='#28a745'; msg.textContent='✔ Hợp lệ'; }
}

function checkStrength(pw) {
    const len   = pw.length >= 8;
    const upper = /[A-Z]/.test(pw);
    const lower = /[a-z]/.test(pw);
    const digit = /[0-9]/.test(pw);
    const score = [len, upper, lower, digit].filter(Boolean).length;

    const fill  = document.getElementById('strengthFill');
    const colors = ['#dc3545','#fd7e14','#ffc107','#28a745'];
    fill.style.width   = (score * 25) + '%';
    fill.style.background = colors[score - 1] || '#eee';

    const toggle = (id, ok) => {
        const el = document.getElementById(id);
        el.className = ok ? 'ok' : 'bad';
    };
    toggle('req-len',   len);
    toggle('req-upper', upper);
    toggle('req-lower', lower);
    toggle('req-digit', digit);
}

function checkMatch() {
    const pw  = document.getElementById('matKhau').value;
    const pw2 = document.getElementById('xacNhanMK').value;
    const msg = document.getElementById('matchMsg');
    if (!pw2) { msg.textContent = ''; return; }
    if (pw === pw2) { msg.style.color='#28a745'; msg.textContent='✔ Mật khẩu khớp'; }
    else            { msg.style.color='#dc3545'; msg.textContent='✖ Mật khẩu không khớp'; }
}

function validateForm() {
    const pw  = document.getElementById('matKhau').value;
    const pw2 = document.getElementById('xacNhanMK').value;
    if (pw !== pw2) { alert('Xác nhận mật khẩu không khớp!'); return false; }
    const len   = pw.length >= 8;
    const upper = /[A-Z]/.test(pw);
    const lower = /[a-z]/.test(pw);
    const digit = /[0-9]/.test(pw);
    if (!len || !upper || !lower || !digit) {
        alert('Mật khẩu chưa đủ mạnh. Vui lòng kiểm tra lại yêu cầu!');
        return false;
    }
    return true;
}
</script>
</body>
</html>
