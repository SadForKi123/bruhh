package com.quanlysinhvien.servlet;

import com.quanlysinhvien.dao.*;
import com.quanlysinhvien.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/sinhvien")
public class SinhVienServlet extends HttpServlet {

    private final SinhVienDAO svDAO = new SinhVienDAO();
    private final LopDAO lopDAO     = new LopDAO();
    private final KhoaDAO khoaDAO   = new KhoaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add"    -> showAddForm(req, resp);
                case "edit"   -> showEditForm(req, resp);
                case "delete" -> deleteSinhVien(req, resp);
                case "search" -> searchSinhVien(req, resp);
                default       -> listSinhVien(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("insert".equals(action))   insertSinhVien(req, resp);
            else if ("update".equals(action)) updateSinhVien(req, resp);
            else listSinhVien(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    // ── Danh sách ────────────────────────────────────────────────────────────
    private void listSinhVien(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        List<SinhVien> list = svDAO.getAll();
        List<Lop>      lops = lopDAO.getAll();
        req.setAttribute("sinhvienList", list);
        req.setAttribute("lopList", lops);
        req.setAttribute("total", list.size());
        req.getRequestDispatcher("/views/sinhvien/list.jsp").forward(req, resp);
    }

    // ── Tìm kiếm ─────────────────────────────────────────────────────────────
    private void searchSinhVien(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        String ten      = req.getParameter("tenSV");
        String gioiTinh = req.getParameter("gioiTinh");
        String maLop    = req.getParameter("maLop");

        List<SinhVien> list = svDAO.search(ten, gioiTinh, maLop);
        List<Lop>      lops = lopDAO.getAll();
        req.setAttribute("sinhvienList", list);
        req.setAttribute("lopList", lops);
        req.setAttribute("total", list.size());
        req.setAttribute("searchTen", ten);
        req.setAttribute("searchGioiTinh", gioiTinh);
        req.setAttribute("searchLop", maLop);
        req.getRequestDispatcher("/views/sinhvien/list.jsp").forward(req, resp);
    }

    // ── Form thêm ────────────────────────────────────────────────────────────
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        req.setAttribute("lopList", lopDAO.getAll());
        req.getRequestDispatcher("/views/sinhvien/form.jsp").forward(req, resp);
    }

    // ── Form sửa ────────────────────────────────────────────────────────────
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        String msv = req.getParameter("msv");
        SinhVien sv = svDAO.findById(msv);
        if (sv == null) {
            resp.sendRedirect(req.getContextPath() + "/sinhvien?error=notfound");
            return;
        }
        req.setAttribute("sinhvien", sv);
        req.setAttribute("lopList", lopDAO.getAll());
        req.getRequestDispatcher("/views/sinhvien/form.jsp").forward(req, resp);
    }

    // ── Thêm ─────────────────────────────────────────────────────────────────
    private void insertSinhVien(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        SinhVien sv = buildFromRequest(req);
        if (svDAO.existsMsv(sv.getMsv())) {
            req.setAttribute("error", "Mã sinh viên đã tồn tại!");
            req.setAttribute("sinhvien", sv);
            req.setAttribute("lopList", lopDAO.getAll());
            req.getRequestDispatcher("/views/sinhvien/form.jsp").forward(req, resp);
            return;
        }
        svDAO.insert(sv);
        resp.sendRedirect(req.getContextPath() + "/sinhvien?success=added");
    }

    // ── Cập nhật ─────────────────────────────────────────────────────────────
    private void updateSinhVien(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        SinhVien sv = buildFromRequest(req);
        svDAO.update(sv);
        resp.sendRedirect(req.getContextPath() + "/sinhvien?success=updated");
    }

    // ── Xóa ──────────────────────────────────────────────────────────────────
    private void deleteSinhVien(HttpServletRequest req, HttpServletResponse resp)
            throws Exception {
        String msv = req.getParameter("msv");
        svDAO.delete(msv);
        resp.sendRedirect(req.getContextPath() + "/sinhvien?success=deleted");
    }

    // ── Build SinhVien từ request ─────────────────────────────────────────────
    private SinhVien buildFromRequest(HttpServletRequest req) {
        SinhVien sv = new SinhVien();
        sv.setMsv(req.getParameter("msv").trim().toUpperCase());
        sv.setHoVaTen(req.getParameter("hoVaTen").trim());
        sv.setNgaySinh(LocalDate.parse(req.getParameter("ngaySinh")));
        sv.setGioiTinh(req.getParameter("gioiTinh"));
        sv.setDiaChi(req.getParameter("diaChi"));
        sv.setEmail(req.getParameter("email"));
        sv.setSoDT(req.getParameter("soDT"));
        sv.setMaLop(req.getParameter("maLop"));
        return sv;
    }
}
