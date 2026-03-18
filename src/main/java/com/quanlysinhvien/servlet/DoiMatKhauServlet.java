package com.quanlysinhvien.servlet;

import com.quanlysinhvien.dao.NguoiDungDAO;
import com.quanlysinhvien.model.NguoiDung;
import com.quanlysinhvien.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/doimatkhau")
public class DoiMatKhauServlet extends HttpServlet {

    private final NguoiDungDAO dao = new NguoiDungDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/auth/doimatkhau.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session  = req.getSession(false);
        NguoiDung   nguoidung = (NguoiDung) session.getAttribute("nguoidung");

        String matKhauCu  = req.getParameter("matKhauCu");
        String matKhauMoi = req.getParameter("matKhauMoi");
        String xacNhan    = req.getParameter("xacNhan");

        if (!PasswordUtil.verify(matKhauCu, nguoidung.getMatKhau())) {
            req.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            req.getRequestDispatcher("/views/auth/doimatkhau.jsp").forward(req, resp);
            return;
        }
        if (!PasswordUtil.isStrong(matKhauMoi)) {
            req.setAttribute("error", "Mật khẩu mới phải ít nhất 8 ký tự, có chữ hoa, chữ thường và số!");
            req.getRequestDispatcher("/views/auth/doimatkhau.jsp").forward(req, resp);
            return;
        }
        if (!matKhauMoi.equals(xacNhan)) {
            req.setAttribute("error", "Xác nhận mật khẩu mới không khớp!");
            req.getRequestDispatcher("/views/auth/doimatkhau.jsp").forward(req, resp);
            return;
        }

        try {
            dao.doiMatKhau(nguoidung.getMaND(), matKhauMoi);
            // Cập nhật session
            nguoidung.setMatKhau(PasswordUtil.hash(matKhauMoi));
            session.setAttribute("nguoidung", nguoidung);
            resp.sendRedirect(req.getContextPath() + "/dashboard?success=changedpw");
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/auth/doimatkhau.jsp").forward(req, resp);
        }
    }
}
