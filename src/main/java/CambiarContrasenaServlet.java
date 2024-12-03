import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// Importar UsuarioDAO y otros elementos necesarios
import com.mycompany.pickupbackend.DAO.UsuarioDAO;

@WebServlet("/CambiarContrasenaServlet")
public class CambiarContrasenaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String emailUsuario = (String) session.getAttribute("emailUsuario"); // Usar el email de la sesión
        String nuevaContrasena = request.getParameter("nuevaContrasena");
        String confirmarContrasena = request.getParameter("confirmarContrasena");

        try {
            // Verificar si el usuario está en la sesión
            if (emailUsuario == null || emailUsuario.isEmpty()) {
                request.setAttribute("error", "No se encontró el usuario en la sesión. Por favor, inicia sesión nuevamente.");
                request.getRequestDispatcher("cambiarContrasena.jsp").forward(request, response);
                return;
            }

            // Validar las contraseñas
            if (nuevaContrasena == null || nuevaContrasena.isEmpty() || confirmarContrasena == null || confirmarContrasena.isEmpty()) {
                request.setAttribute("error", "Las contraseñas no pueden estar vacías.");
                request.getRequestDispatcher("cambiarContrasena.jsp").forward(request, response);
                return;
            }

            if (!nuevaContrasena.equals(confirmarContrasena)) {
                request.setAttribute("error", "Las nuevas contraseñas no coinciden.");
                request.getRequestDispatcher("cambiarContrasena.jsp").forward(request, response);
                return;
            }

            // Intentar actualizar la contraseña
            if (usuarioDAO.actualizarContrasena(emailUsuario, nuevaContrasena)) {
                request.setAttribute("mensaje", "Contraseña cambiada exitosamente.");
            } else {
                request.setAttribute("error", "Hubo un problema al actualizar la contraseña. Por favor, inténtalo nuevamente.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error interno. Inténtalo más tarde.");
        }

        // Redirigir al formulario de cambio de contraseña con el mensaje correspondiente
        request.getRequestDispatcher("cambiarContrasena.jsp").forward(request, response);
    }
}


