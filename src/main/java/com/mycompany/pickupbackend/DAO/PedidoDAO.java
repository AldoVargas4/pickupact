package com.mycompany.pickupbackend.DAO;

import com.mycompany.pickupbackend.Modelo.Pedido;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PedidoDAO {

    private Connection conexion;

    public PedidoDAO(Connection conexion) {
        this.conexion = conexion;
    }

    // Método para insertar un pedido
    public int insertarPedido(Pedido pedido) throws SQLException {
        String sql = "INSERT INTO pedidos (id_usuario, fecha_pedido, total, estado, direccion_entrega, telefono_contacto, metodo_envio) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, pedido.getIdUsuario());
            stmt.setTimestamp(2, new java.sql.Timestamp(pedido.getFechaPedido().getTime()));
            stmt.setDouble(3, pedido.getTotal());
            stmt.setString(4, pedido.getEstado());
            stmt.setString(5, pedido.getDireccionEntrega());
            stmt.setString(6, pedido.getTelefonoContacto());
            stmt.setString(7, pedido.getMetodoEnvio());

            int filasAfectadas = stmt.executeUpdate();

            if (filasAfectadas > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Retorna el ID generado para el pedido
                    }
                }
            }
            throw new SQLException("No se pudo insertar el pedido, no se generó un ID.");
        }
    }

    // Método para obtener un pedido por ID
    public Pedido obtenerPedidoPorId(int idPedido) throws SQLException {
        String sql = "SELECT * FROM pedidos WHERE id_pedido = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idPedido);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Pedido pedido = new Pedido();
                    pedido.setIdPedido(rs.getInt("id_pedido"));
                    pedido.setIdUsuario(rs.getInt("id_usuario"));
                    pedido.setFechaPedido(rs.getTimestamp("fecha_pedido"));
                    pedido.setTotal(rs.getDouble("total"));
                    pedido.setEstado(rs.getString("estado"));
                    pedido.setDireccionEntrega(rs.getString("direccion_entrega")); // Nuevo campo
                    pedido.setTelefonoContacto(rs.getString("telefono_contacto")); // Nuevo campo
                    pedido.setMetodoEnvio(rs.getString("metodo_envio"));           // Nuevo campo
                    return pedido;
                }
            }
        }
        return null; // Retorna null si no se encuentra el pedido
    }

    // Método para actualizar el estado de un pedido
    public boolean actualizarEstadoPedido(int idPedido, String nuevoEstado) throws SQLException {
        String sql = "UPDATE pedidos SET estado = ? WHERE id_pedido = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, nuevoEstado);
            stmt.setInt(2, idPedido);
            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0; // Retorna true si se actualizó al menos una fila
        }
    }

    // Método para listar todos los pedidos
    public List<Pedido> listarPedidos() throws SQLException {
        List<Pedido> pedidos = new ArrayList<>();
        String sql = "SELECT * FROM pedidos";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Pedido pedido = new Pedido();
                pedido.setIdPedido(rs.getInt("id_pedido"));
                pedido.setIdUsuario(rs.getInt("id_usuario"));
                pedido.setFechaPedido(rs.getTimestamp("fecha_pedido"));
                pedido.setTotal(rs.getDouble("total"));
                pedido.setEstado(rs.getString("estado"));
                pedido.setDireccionEntrega(rs.getString("direccion_entrega")); // Nuevo campo
                pedido.setTelefonoContacto(rs.getString("telefono_contacto")); // Nuevo campo
                pedido.setMetodoEnvio(rs.getString("metodo_envio"));           // Nuevo campo
                pedidos.add(pedido);
            }
        }
        return pedidos;
    }
}
