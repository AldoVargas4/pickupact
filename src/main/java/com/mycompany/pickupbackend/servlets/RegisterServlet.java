package com.mycompany.pickupbackend.servlets;

import com.mycompany.pickupbackend.util.Conexion;
import com.mycompany.pickupbackend.Modelo.Usuario;
import com.mycompany.pickupbackend.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.util.Scanner;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final UsuarioService usuarioService = new UsuarioService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Captura el token de reCAPTCHA desde el formulario
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

        // Verifica el token de reCAPTCHA
        if (!verifyCaptcha(gRecaptchaResponse)) {
            request.setAttribute("errorMensaje", "Por favor, verifica el CAPTCHA.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; // Detiene el flujo si el CAPTCHA no es válido
        }

        // Verificar la conexión
        Connection connectionTest = Conexion.getConnection();
        if (connectionTest != null) {
            System.out.println("Conexión válida desde el Servlet.");
        } else {
            System.out.println("Error: la conexión es null desde el Servlet.");
        }

        // Recoger los datos del formulario
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");

        // **Verificación de correo duplicado**
        if (usuarioService.verificarCorreoExistente(email)) {
            request.setAttribute("errorMensaje", "El correo electrónico ya está registrado.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return; // Detiene el flujo si el correo ya existe
        }
        
        // Crear un nuevo objeto Usuario
        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setEmail(email);
        usuario.setPassword(password);
        usuario.setDireccion(direccion);
        usuario.setTelefono(telefono);

        // Asignar valores por defecto
        usuario.setIdRol(2); // 2 representa el rol de "Usuario" en la tabla roles
        usuario.setIdMembresia(0); // 0 representa "sin membresía"

        // Validar y registrar el usuario
        boolean registroExitoso = usuarioService.registrarUsuario(usuario);

        if (registroExitoso) {
            response.sendRedirect("registroExitoso.jsp");
        } else {
            request.setAttribute("errorMensaje", "El correo electrónico ya está registrado.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private boolean verifyCaptcha(String gRecaptchaResponse) {
        String secretKey = "TU_CLAVE_SECRETA"; // Reemplaza con tu clave secreta de reCAPTCHA
        try {
            String url = "https://www.google.com/recaptcha/api/siteverify";
            URL obj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();
            con.setRequestMethod("POST");
            con.setDoOutput(true);

            String postParams = "secret=" + "6LfjVngqAAAAAIsbfKKxNdGLBblUs8llAcpt_d3S" + "&response=" + gRecaptchaResponse;
            try (OutputStream os = con.getOutputStream()) {
                os.write(postParams.getBytes());
                os.flush();
            }

            Scanner in = new Scanner(con.getInputStream());
            StringBuilder response = new StringBuilder();
            while (in.hasNextLine()) {
                response.append(in.nextLine());
            }
            in.close();

            return response.toString().contains("\"success\": true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
