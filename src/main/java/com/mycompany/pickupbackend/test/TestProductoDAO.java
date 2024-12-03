package com.mycompany.pickupbackend.test;

import com.mycompany.pickupbackend.DAO.ProductoDAO;
import com.mycompany.pickupbackend.Modelo.Producto;
import com.mycompany.pickupbackend.util.Conexion;

import java.sql.Connection;
import java.util.List;

public class TestProductoDAO {
    public static void main(String[] args) {
        Connection con = Conexion.getConnection(); // Obtener la conexión
        if (con != null) {
            try {
                ProductoDAO productoDAO = new ProductoDAO(con); // Instanciar el DAO
                List<Producto> productos = productoDAO.getAllProductos(); // Llamar al método
                for (Producto p : productos) {
                    System.out.println("ID: " + p.getIdProducto());
                    System.out.println("Nombre: " + p.getNombre());
                    System.out.println("Descripción: " + p.getDescripcion());
                    System.out.println("Precio: " + p.getPrecio());
                    System.out.println("Imagen: " + p.getImagen());
                    System.out.println("---------------------------------");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("No se pudo establecer conexión con la base de datos.");
        }
    }
}
