package com.quanlysinhvien.servlet;

import com.quanlysinhvien.dao.NguoiDungDAO;
import com.quanlysinhvien.model.NguoiDung;
import com.quanlysinhvien.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/dangky")
public class DangKyServlet extends HttpServlet {

    private final NguoiDungDAO dao = new NguoiDungDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("nguoidung") != null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String tenDangNhap  = req.getParameter("tenDangNhap");
        String hoTen        = req.getParameter("hoTen");
        String email        = req.getParameter("email");
        String matKhau      = req.getParameter("matKhau");
        String xacNhanMK    = req.getParameter("xacNhanMK");

        // Giữ lại giá trị form nếu lỗi
        req.setAttribute("tenDangNhap", tenDangNhap);
        req.setAttribute("hoTen", hoTen);
        req.setAttribute("email", email);

        // Validate
        if (isEmpty(tenDangNhap) || isEmpty(hoTen) || isEmpty(email)
                || isEmpty(matKhau) || isEmpty(xacNhanMK)) {
            req.setAttribute("error", "Vui lòng điền đầy đủ tất cả các trường!");
            req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
            return;
        }
        if (tenDangNhap.trim().length() < 4 || tenDangNhap.trim().length() > 50) {
            req.setAttribute("error", "Tên đăng nhập phải từ 4–50 ký tự!");
            req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
            return;
        }
        if (!tenDangNhap.trim().matches("[a-zA-Z0-9_]+")) {
            req.setAttribute("error", "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới!");
            req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
            return;
        }
        if (!email.trim().matches("^[\\w.+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$")) {
            req.setAttribute("error", "Địa chỉ email không hợp lệ!");
            req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
            return;
        }
        if (!PasswordUtil.isStrong(matKhau)) {
            req.setAttribute("error", "Mật khẩu phải ít nhất 8 ký tự, gồm chữ hoa, chữ thường và số!");
            req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
            return;
        }
        if (!matKhau.equals(xacNhanMK)) {
            req.setAttribute("error", "Xác nhận mật khẩu không khớp!");
            req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
            return;
        }

        try {
            if (dao.existsTenDangNhap(tenDangNhap.trim())) {
                req.setAttribute("error", "Tên đăng nhập \"" + tenDangNhap.trim() + "\" đã tồn tại!");
                req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
                return;
            }
            if (dao.existsEmail(email.trim())) {
                req.setAttribute("error", "Email \"" + email.trim() + "\" đã được sử dụng!");
                req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
                return;
            }

            NguoiDung nd = new NguoiDung();
            nd.setTenDangNhap(tenDangNhap.trim());
            nd.setHoTen(hoTen.trim());
            nd.setEmail(email.trim());
            nd.setMatKhau(matKhau); // DAO sẽ hash

            dao.register(nd);
            resp.sendRedirect(req.getContextPath() + "/login?success=registered");

        } catch (Exception e) {
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/auth/dangky.jsp").forward(req, resp);
        }
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }
}
