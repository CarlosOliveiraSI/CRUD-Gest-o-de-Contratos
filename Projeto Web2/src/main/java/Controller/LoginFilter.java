package Controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*") 
public class LoginFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);

        boolean usuarioLogado = (session != null && session.getAttribute("usuarioLogado") != null);

        boolean acessandoLogin = uri.endsWith("login") || uri.endsWith("login.jsp") || uri.contains("Login");
        boolean acessandoStatic = uri.contains("/css/") || uri.contains("/js/") || uri.contains("/images/");

        if (usuarioLogado || acessandoLogin || acessandoStatic) {
            chain.doFilter(request, response); 
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }
}
