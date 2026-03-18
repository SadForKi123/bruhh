package com.quanlysinhvien.servlet;

import com.quanlysinhvien.dao.NguoiDungDAO;
import com.quanlysinhvien.model.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final NguoiDungDAO dao = new NguoiDungDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Nếu đã đăng nhập, chuyển về dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("nguoidung") != null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String tenDangNhap = req.getParameter("tenDangNhap");
        String matKhau     = req.getParameter("matKhau");

        // Validate rỗng
        if (tenDangNhap == null || tenDangNhap.trim().isEmpty()
                || matKhau == null || matKhau.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            req.setAttribute("tenDangNhap", tenDangNhap);
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        try {
            NguoiDung nd = dao.login(tenDangNhap.trim(), matKhau);
            if (nd != null) {
                // Tạo session
                HttpSession session = req.getSession(true);
                session.setAttribute("nguoidung", nd);
                session.setMaxInactiveInterval(30 * 60); // 30 phút

                // Ghi nhớ tên đăng nhập nếu tick "remember me"
                String remember = req.getParameter("remember");
                if ("on".equals(remember)) {
                    Cookie cookie = new Cookie("qlsv_user", tenDangNhap.trim());
                    cookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                    cookie.setHttpOnly(true);
                    resp.addCookie(cookie);
                }

                resp.sendRedirect(req.getContextPath() + "/dashboard");
            } else {
                req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng, hoặc tài khoản đã bị khoá!");
                req.setAttribute("tenDangNhap", tenDangNhap);
                req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
        }
    }
}
