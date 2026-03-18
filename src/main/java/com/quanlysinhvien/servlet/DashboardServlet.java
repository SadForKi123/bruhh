package com.quanlysinhvien.servlet;

import com.quanlysinhvien.dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({"/dashboard", ""})
public class DashboardServlet extends HttpServlet {

    private final SinhVienDAO svDAO   = new SinhVienDAO();
    private final LopDAO      lopDAO  = new LopDAO();
    private final KhoaDAO     khoaDAO = new KhoaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("totalSV",   svDAO.countAll());
            req.setAttribute("totalLop",  lopDAO.getAll().size());
            req.setAttribute("totalKhoa", khoaDAO.getAll().size());
            req.setAttribute("khoaList",  khoaDAO.getAll());
            req.getRequestDispatcher("/views/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }
}
