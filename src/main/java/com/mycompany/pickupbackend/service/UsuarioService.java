package com.mycompany.pickupbackend.service;

import com.mycompany.pickupbackend.DAO.UsuarioDAO;
import com.mycompany.pickupbackend.Modelo.Usuario;

public class UsuarioService {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    // Método para registrar un nuevo usuario
    public boolean registrarUsuario(Usuario usuario) {
        // Verificar si el nombre ya está registrado
        Usuario usuarioExistente = usuarioDAO.buscarUsuarioPorNombre(usuario.getNombre());
        if (usuarioExistente != null) {
            // El nombre ya está registrado
            return false;
        }

        // Registrar el nuevo usuario
        return usuarioDAO.registrarUsuario(usuario);
    }

    // Método para iniciar sesión
    public Usuario iniciarSesion(String nombre, String password) {
        Usuario usuario = usuarioDAO.buscarUsuarioPorNombre(nombre);
        if (usuario != null && usuario.getPassword().equals(password)) {
            // La contraseña coincide
            return usuario;
        }
        return null; // Nombre o contraseña incorrectos
    }
    
    //Verificación de correo en login
    public boolean verificarCorreoExistente(String email) {
    return usuarioDAO.verificarCorreoExistente(email);
}
}
