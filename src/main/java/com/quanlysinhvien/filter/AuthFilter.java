package com.quanlysinhvien.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // Các URL không cần đăng nhập
    private static final String[] PUBLIC_URLS = {
        "/login", "/dangky", "/css/", "/js/", "/images/"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI().substring(req.getContextPath().length());

        // Cho phép các URL công khai
        for (String pub : PUBLIC_URLS) {
            if (uri.startsWith(pub)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Kiểm tra session
        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("nguoidung") != null;

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}
