package com.mycompany.pickupbackend.servlets;

import com.mycompany.pickupbackend.DAO.UsuarioDAO;
import com.mycompany.pickupbackend.Modelo.Usuario;
import com.mycompany.pickupbackend.Modelo.DetallePedido;
import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Validar credenciales
    Usuario usuario = usuarioDAO.validarUsuario(username, password);

    if (usuario != null) {
        // Credenciales correctas, iniciar sesión
        HttpSession session = request.getSession();
        session.setAttribute("idUsuario", usuario.getId_usuario()); // Agregar ID del usuario a la sesión
        session.setAttribute("nombreUsuario", usuario.getNombre());
        session.setAttribute("emailUsuario", usuario.getEmail());
        session.setAttribute("telefonoUsuario", usuario.getTelefono());
        session.setAttribute("direccionUsuario", usuario.getDireccion());

        // Crear un carrito vacío
        session.setAttribute("carrito", new ArrayList<DetallePedido>());

        response.sendRedirect("index.jsp");
    } else {
        // Credenciales incorrectas
        request.setAttribute("errorMensaje", "Credenciales incorrectas. Por favor, intenta de nuevo.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
}

}
