package com.mycompany.pickupbackend.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase para gestionar la conexión a la base de datos.
 */
public class Conexion {

    // Detalles de conexión
    private static final String URL = "jdbc:mysql://localhost:3306/pick_up";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    /**
     * Método para obtener la conexión a la base de datos.
     * @return La conexión a la base de datos o null si ocurre un error.
     */
    public static Connection getConnection() {
        try {
            // Registrar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Intentar conectar y devolver la conexión
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace(); // Imprimir el error si el driver no se encuentra
        } catch (SQLException e) {
            e.printStackTrace(); // Imprimir el error de conexión
        }
        return null; // Devolver null si ocurre un error
    }

    /**
     * Método principal para probar la conexión.
     */
    public static void main(String[] args) {
        Connection connection = Conexion.getConnection();
        if (connection != null) {
            System.out.println("Conexión exitosa a la base de datos.");
        } else {
            System.out.println("Error al conectar a la base de datos.");
        }
    }
}
