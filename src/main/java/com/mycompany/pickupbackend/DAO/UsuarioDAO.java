package com.mycompany.pickupbackend.DAO;

import com.mycompany.pickupbackend.Modelo.Usuario;
import com.mycompany.pickupbackend.util.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class UsuarioDAO {

    // Método para registrar un nuevo usuario en la base de datos
    public boolean registrarUsuario(Usuario usuario) {

    // Verificar la conexión
    Connection connectionTest = Conexion.getConnection();
    if (connectionTest != null) {
        System.out.println("Conexión válida desde el DAO.");
    } else {
        System.out.println("Error: la conexión es null desde el DAO.");
        return false; // Salir si la conexión es null
    }

    // Asignar valores por defecto directamente
    usuario.setIdMembresia(1); // 1 representa la membresía básica
    usuario.setIdRol(2); // 2 representa el rol de "Usuario"

    String sql = "INSERT INTO usuarios (nombre, email, password, direccion, telefono, id_membresia, id_rol) VALUES (?, ?, ?, ?, ?, ?, ?)";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        // Configurar los valores del PreparedStatement
        ps.setString(1, usuario.getNombre());
        ps.setString(2, usuario.getEmail());
        ps.setString(3, usuario.getPassword());
        ps.setString(4, usuario.getDireccion());
        ps.setString(5, usuario.getTelefono());
        ps.setInt(6, usuario.getIdMembresia()); // Usar siempre el id_membresia = 1
        ps.setInt(7, usuario.getIdRol()); // Usar siempre el id_rol = 2

        // Ejecutar la actualización y verificar las filas afectadas
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Usuario registrado exitosamente.");
            return true;
        } else {
            System.out.println("No se pudo registrar el usuario.");
            return false;
        }

    } catch (SQLException e) {
        e.printStackTrace(); // Imprimir el error en la consola
        return false;
    }
}


    // Método para buscar un usuario por nombre
    public Usuario buscarUsuarioPorNombre(String nombre) 
    {
        String sql = "SELECT * FROM usuarios WHERE nombre = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPassword(rs.getString("password"));
                usuario.setDireccion(rs.getString("direccion"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setIdMembresia(rs.getInt("id_membresia"));
                usuario.setIdRol(rs.getInt("id_rol"));
                return usuario;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Agregar esto para ver el error si ocurre
        }
        return null; // Devuelve null si no se encuentra el usuario
    }
    
  
public Usuario validarUsuario(String username, String password) {
    Usuario usuario = null;
    String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
    
    try (Connection conn = Conexion.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setString(1, username);
        stmt.setString(2, password);

        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("id_usuario"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setTelefono(rs.getString("telefono")); // Agregar esto
                usuario.setDireccion(rs.getString("direccion")); // Agregar esto
                // Agregar otros campos si es necesario
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return usuario;
}


    public boolean actualizarUsuario(Usuario usuario) {
    String sql = "UPDATE usuarios SET nombre = ?, telefono = ?, direccion = ?, password = ? WHERE email = ?";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, usuario.getNombre());
        ps.setString(2, usuario.getTelefono());
        ps.setString(3, usuario.getDireccion());
        ps.setString(4, usuario.getPassword()); // Asegúrate de manejar la contraseña adecuadamente
        ps.setString(5, usuario.getEmail());
        
        return ps.executeUpdate() > 0; // Retorna true si se actualizó alguna fila
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

// Método para buscar un usuario por correo electrónico
    public Usuario buscarUsuarioPorEmail(String email) {
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        try (Connection connection = Conexion.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setId_usuario(resultSet.getInt("id"));
                usuario.setNombre(resultSet.getString("nombre"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setIdRol(resultSet.getInt("id_rol"));
                usuario.setIdMembresia(resultSet.getInt("id_membresia"));
                return usuario;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
public boolean verificarCorreoExistente(String correo) {
    boolean existe = false;
    String sql = "SELECT COUNT(*) FROM usuarios WHERE correo = ?";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, correo);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            existe = rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return existe;
}
  
  
 public boolean verificarContrasena(String email, String contrasenaActual) {
    String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, email);
        ps.setString(2, contrasenaActual);

        try (ResultSet rs = ps.executeQuery()) {
            return rs.next(); // Si encuentra un resultado, la contraseña es correcta
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false; // Retorna false si no coincide la contraseña
}

public boolean actualizarContrasena(String nombreUsuario, String nuevaContrasena) {
    String sql = "UPDATE usuarios SET password = ? WHERE nombre = ?";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, nuevaContrasena);
        ps.setString(2, nombreUsuario);

        int rowsAffected = ps.executeUpdate();
        System.out.println("Filas afectadas: " + rowsAffected); // Imprime el número de filas actualizadas
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}



   
    
}
