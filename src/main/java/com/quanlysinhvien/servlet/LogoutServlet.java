package com.quanlysinhvien.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();

        // Xoá cookie remember
        Cookie cookie = new Cookie("qlsv_user", "");
        cookie.setMaxAge(0);
        resp.addCookie(cookie);

        resp.sendRedirect(req.getContextPath() + "/login?logout=true");
    }
}
