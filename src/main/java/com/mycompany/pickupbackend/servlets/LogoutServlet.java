package com.mycompany.pickupbackend.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Obtener la sesión actual, si existe
        if (session != null) {
            session.invalidate(); // Invalida la sesión para cerrar la sesión del usuario
        }
        response.sendRedirect("logout.jsp"); // Redirige al usuario a logout.jsp
    }
}
