package com.quanlysinhvien.servlet;

import com.quanlysinhvien.dao.*;
import com.quanlysinhvien.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/lop")
public class LopServlet extends HttpServlet {

    private final LopDAO  lopDAO  = new LopDAO();
    private final KhoaDAO khoaDAO = new KhoaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "list";
        try {
            switch (action) {
                case "add"    -> { req.setAttribute("khoaList", khoaDAO.getAll());
                                   req.getRequestDispatcher("/views/lop/form.jsp").forward(req, resp); }
                case "edit"   -> showEdit(req, resp);
                case "delete" -> { lopDAO.delete(req.getParameter("maLop"));
                                   resp.sendRedirect(req.getContextPath() + "/lop"); }
                default       -> list(req, resp);
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
            Lop lop = new Lop(req.getParameter("maLop"),
                              req.getParameter("tenLop"),
                              req.getParameter("maKhoa"));
            if ("insert".equals(req.getParameter("action"))) lopDAO.insert(lop);
            else lopDAO.update(lop);
            resp.sendRedirect(req.getContextPath() + "/lop");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setAttribute("lopList", lopDAO.getAll());
        req.getRequestDispatcher("/views/lop/list.jsp").forward(req, resp);
    }

    private void showEdit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.setAttribute("lop", lopDAO.findById(req.getParameter("maLop")));
        req.setAttribute("khoaList", khoaDAO.getAll());
        req.getRequestDispatcher("/views/lop/form.jsp").forward(req, resp);
    }
}
