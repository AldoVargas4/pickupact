package com.mycompany.pickupbackend.servlets;

import com.mycompany.pickupbackend.DAO.UsuarioDAO;
import com.mycompany.pickupbackend.Modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/ActualizarDatosServlet")
public class ActualizarDatosServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("nombreUsuario") == null) {
            response.sendRedirect("login.jsp"); // Redirige a login si no hay sesión
            return;
        }

        // Obtener los datos del formulario
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");

        // Obtener el email del usuario de la sesión (no editable)
        String email = (String) session.getAttribute("emailUsuario");

        // Crear un objeto Usuario con los datos actualizados
        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setEmail(email);
        usuario.setTelefono(telefono);
        usuario.setDireccion(direccion);

        // Verificar si el campo de contraseña se ha enviado
        String password = request.getParameter("password");
        if (password != null && !password.trim().isEmpty()) {
            usuario.setPassword(password); // Actualiza la contraseña solo si se ha proporcionado una nueva
        } else {
            // Obtener la contraseña actual de la base de datos y mantenerla si no se envió una nueva
            Usuario usuarioActual = usuarioDAO.buscarUsuarioPorNombre(nombre);
            if (usuarioActual != null) {
                usuario.setPassword(usuarioActual.getPassword()); // Mantener la contraseña actual
            }
        }

        // Intentar actualizar el usuario en la base de datos
        boolean actualizado = usuarioDAO.actualizarUsuario(usuario);

        if (actualizado) {
            // Actualizar los atributos de sesión
            session.setAttribute("nombreUsuario", nombre);
            session.setAttribute("telefonoUsuario", telefono);
            session.setAttribute("direccionUsuario", direccion);

            // Redirigir con mensaje de éxito
            response.sendRedirect("misDatos.jsp?success=true");
        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("misDatos.jsp?error=true");
        }
    }
}
