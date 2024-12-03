package com.mycompany.pickupbackend.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.mycompany.pickupbackend.DAO.UsuarioDAO;
import com.mycompany.pickupbackend.Modelo.Usuario;

@WebServlet("/GoogleOAuthCallbackServlet")
public class GoogleOAuthCallbackServlet extends HttpServlet {
    
    private static final String CLIENT_ID = "99887984915-a8eprr4ji1u6n3tmrvgkeqvmnpsi3icq.apps.googleusercontent.com";
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idTokenString = request.getParameter("credential");
        
        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(), JSON_FACTORY)
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken idToken = verifier.verify(idTokenString);
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();

                // Obtén la información del usuario desde el token
                String userId = payload.getSubject();
                String email = payload.getEmail();
                String nombre = (String) payload.get("name");

                // Comprueba si el usuario ya existe en tu base de datos
                UsuarioDAO usuarioDAO = new UsuarioDAO();
                Usuario usuario = usuarioDAO.buscarUsuarioPorEmail(email);

                if (usuario == null) {
                    // Si el usuario no existe, crea una nueva cuenta
                    usuario = new Usuario();
                    usuario.setNombre(nombre);
                    usuario.setEmail(email);
                    usuario.setIdRol(2);  // rol de usuario normal
                    usuario.setIdMembresia(0); // sin membresía inicial
                    usuarioDAO.registrarUsuario(usuario);
                }

                // Inicia sesión creando una sesión en el servidor
                HttpSession session = request.getSession();
                session.setAttribute("nombreUsuario", usuario.getNombre());
                session.setAttribute("emailUsuario", usuario.getEmail());
                response.sendRedirect("index.jsp");
            } else {
                // Token inválido
                response.sendRedirect("login.jsp?error=token_invalido");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=autenticacion_fallida");
        }
    }
}
