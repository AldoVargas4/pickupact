package com.mycompany.pickupbackend.DAO;

import com.mycompany.pickupbackend.Modelo.DetallePedido;
import com.mycompany.pickupbackend.util.Conexion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DetallePedidoDAO {

    private Connection conexion;

    public DetallePedidoDAO(Connection conexion) {
        this.conexion = conexion;
    }

    // Método para insertar un detalle de pedido
    public boolean insertarDetallePedido(DetallePedido detalle) throws SQLException {
        String sql = "INSERT INTO detalle_pedidos (id_pedido, id_producto, cantidad, precio_unitario) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, detalle.getIdPedido());
            stmt.setInt(2, detalle.getIdProducto());
            stmt.setInt(3, detalle.getCantidad());
            stmt.setDouble(4, detalle.getPrecioUnitario());
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0; // Retorna true si se insertó correctamente
        }
    }

    // Método para obtener todos los detalles de un pedido por ID de pedido
    public List<DetallePedido> obtenerDetallesPorPedido(int idPedido) throws SQLException {
        String sql = "SELECT * FROM detalle_pedidos WHERE id_pedido = ?";
        List<DetallePedido> detalles = new ArrayList<>();
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idPedido);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    DetallePedido detalle = new DetallePedido();
                    detalle.setIdDetalle(rs.getInt("id_detalle"));
                    detalle.setIdPedido(rs.getInt("id_pedido"));
                    detalle.setIdProducto(rs.getInt("id_producto"));
                    detalle.setCantidad(rs.getInt("cantidad"));
                    detalle.setPrecioUnitario(rs.getDouble("precio_unitario"));
                    detalles.add(detalle);
                }
            }
        }
        return detalles;
    }

    // Método para listar todos los detalles de pedidos (opcional, para pruebas o administración)
    public List<DetallePedido> listarTodosLosDetalles() throws SQLException {
        String sql = "SELECT * FROM detalle_pedidos";
        List<DetallePedido> detalles = new ArrayList<>();
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                DetallePedido detalle = new DetallePedido();
                detalle.setIdDetalle(rs.getInt("id_detalle"));
                detalle.setIdPedido(rs.getInt("id_pedido"));
                detalle.setIdProducto(rs.getInt("id_producto"));
                detalle.setCantidad(rs.getInt("cantidad"));
                detalle.setPrecioUnitario(rs.getDouble("precio_unitario"));
                detalles.add(detalle);
            }
        }
        return detalles;
    }
}
