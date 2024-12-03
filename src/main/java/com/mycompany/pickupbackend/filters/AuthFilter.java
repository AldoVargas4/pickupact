package com.mycompany.pickupbackend.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización si es necesaria
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Verificar la sesión y el usuario autenticado
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("nombreUsuario") != null);

        // Obtener la URI de la solicitud actual
        String currentURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Excepciones (vistas accesibles sin restricciones)
        boolean isPublicPage = currentURI.equals(contextPath + "/index.jsp")
                || currentURI.equals(contextPath + "/shop.jsp")
                || currentURI.equals(contextPath + "/testimonial.jsp")
                || currentURI.equals(contextPath + "/contact.jsp")
                || currentURI.equals(contextPath + "/login.jsp")
                || currentURI.equals(contextPath + "/register.jsp")
                || currentURI.equals(contextPath + "/registroExitoso.jsp")
                || currentURI.contains("/css/")
                || currentURI.contains("/js/")
                || currentURI.contains("/img/");

        // Acciones restringidas (requieren sesión activa)
        boolean isRestrictedAction = currentURI.equals(contextPath + "/cart.jsp")
                || currentURI.contains(contextPath + "/ProductoServlet");

        if (isLoggedIn || isPublicPage) {
            // Continuar con la solicitud si es una vista pública o el usuario está autenticado
            chain.doFilter(request, response);
        } else if (isRestrictedAction) {
            // Redirigir al login si intenta acceder a acciones restringidas sin sesión activa
            httpResponse.sendRedirect(contextPath + "/login.jsp");
        } else {
            // Para cualquier otra página, permitir la navegación
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Limpieza si es necesaria
    }
}
