package com.mycompany.pickupbackend.DAO;

import com.mycompany.pickupbackend.Modelo.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    private Connection con; // Conexión a la base de datos

    // Constructor que recibe la conexión
    public ProductoDAO(Connection con) {
        this.con = con;
    }

    /**
     * Obtiene todos los productos de la base de datos
     *
     * @return Lista de productos
     * @throws Exception en caso de error en la consulta
     */
    public List<Producto> getAllProductos() throws Exception {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT id_producto, nombre, descripcion, precio, imagen FROM productos";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setImagen(rs.getString("imagen"));

                productos.add(producto); // Agrega el producto a la lista
            }
        } catch (Exception e) {
            throw new Exception("Error al obtener productos: " + e.getMessage(), e);
        }
        return productos;
    }

    /**
     * Obtiene un producto por su ID
     *
     * @param idProducto ID del producto
     * @return Producto correspondiente al ID
     * @throws SQLException Si ocurre algún error en la consulta
     */
    public Producto obtenerProductoPorId(int idProducto) throws SQLException {
        String query = "SELECT * FROM productos WHERE id_producto = ?";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, idProducto);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Producto producto = new Producto();
                    producto.setIdProducto(rs.getInt("id_producto"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setImagen(rs.getString("imagen"));
                    return producto;
                }
            }
        }
        return null; // Si no se encuentra el producto
    }

    /**
     * Método alternativo para obtener un producto por su ID (con manejo de excepciones personalizado)
     *
     * @param idProducto ID del producto
     * @return Producto correspondiente al ID
     * @throws Exception Si no se encuentra el producto o hay un error en la consulta
     */
    public Producto getProductoPorId(int idProducto) throws Exception {
        String sql = "SELECT id_producto, nombre, descripcion, precio, imagen FROM productos WHERE id_producto = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idProducto);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Producto producto = new Producto();
                    producto.setIdProducto(rs.getInt("id_producto"));
                    producto.setNombre(rs.getString("nombre"));
                    producto.setDescripcion(rs.getString("descripcion"));
                    producto.setPrecio(rs.getDouble("precio"));
                    producto.setImagen(rs.getString("imagen"));
                    return producto;
                } else {
                    throw new Exception("Producto no encontrado con ID: " + idProducto);
                }
            }
        }
    }
}
