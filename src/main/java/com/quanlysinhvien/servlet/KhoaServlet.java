package com.quanlysinhvien.servlet;

import com.quanlysinhvien.dao.KhoaDAO;
import com.quanlysinhvien.model.Khoa;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/khoa")
public class KhoaServlet extends HttpServlet {

    private final KhoaDAO khoaDAO = new KhoaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";
        try {
            switch (action) {
                case "add"    -> req.getRequestDispatcher("/views/khoa/form.jsp").forward(req, resp);
                case "edit"   -> { req.setAttribute("khoa", khoaDAO.findById(req.getParameter("maKhoa")));
                                   req.getRequestDispatcher("/views/khoa/form.jsp").forward(req, resp); }
                case "delete" -> { khoaDAO.delete(req.getParameter("maKhoa"));
                                   resp.sendRedirect(req.getContextPath() + "/khoa"); }
                default       -> { req.setAttribute("khoaList", khoaDAO.getAll());
                                   req.getRequestDispatcher("/views/khoa/list.jsp").forward(req, resp); }
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        try {
            Khoa k = new Khoa(req.getParameter("maKhoa"), req.getParameter("tenKhoa"));
            if ("insert".equals(req.getParameter("action"))) khoaDAO.insert(k);
            else khoaDAO.update(k);
            resp.sendRedirect(req.getContextPath() + "/khoa");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }
}
