package com.mycompany.pickupbackend.servlets;

import com.mycompany.pickupbackend.DAO.PedidoDAO;
import com.mycompany.pickupbackend.DAO.DetallePedidoDAO;
import com.mycompany.pickupbackend.Modelo.Pedido;
import com.mycompany.pickupbackend.Modelo.DetallePedido;
import com.mycompany.pickupbackend.util.Conexion;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
@WebServlet("/procesarPedido")
public class ProcesarPedidoServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProcesarPedidoServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validar variables de sesión
        if (request.getSession().getAttribute("idUsuario") == null ||
            request.getSession().getAttribute("detallesPedido") == null ||
            request.getSession().getAttribute("totalPedido") == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Datos insuficientes para procesar el pedido.");
            return;
        }

        // Validar datos del formulario
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String metodoEnvio = request.getParameter("metodoEnvio");

        if (direccion == null || direccion.isEmpty() ||
            telefono == null || telefono.isEmpty() ||
            metodoEnvio == null || metodoEnvio.isEmpty()) {
            LOGGER.warning("Datos del formulario incompletos. Dirección: " + direccion + ", Teléfono: " + telefono +
                           ", Método de envío: " + metodoEnvio);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Datos del formulario incompletos.");
            return;
        }

        try (Connection conexion = Conexion.getConnection()) {
            if (conexion == null) {
                LOGGER.severe("No se pudo establecer conexión con la base de datos.");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "No se pudo establecer conexión con la base de datos.");
                return;
            }

            // Crear un nuevo pedido
            Pedido pedido = new Pedido();
            pedido.setIdUsuario((Integer) request.getSession().getAttribute("idUsuario"));
            pedido.setFechaPedido(new java.util.Date());
            pedido.setTotal((Double) request.getSession().getAttribute("totalPedido"));
            pedido.setEstado("Pendiente");
            pedido.setDireccionEntrega(direccion);  // Asignar dirección del cliente
            pedido.setTelefonoContacto(telefono);  // Asignar teléfono del cliente
            pedido.setMetodoEnvio(metodoEnvio);    // Asignar método de envío

            // Insertar el pedido en la base de datos
            PedidoDAO pedidoDAO = new PedidoDAO(conexion);
            int idPedidoGenerado = pedidoDAO.insertarPedido(pedido);

            // Obtener la lista de detalles del pedido desde la sesión
            @SuppressWarnings("unchecked")
            List<DetallePedido> detallesPedido = (List<DetallePedido>) request.getSession().getAttribute("detallesPedido");

            if (detallesPedido == null || detallesPedido.isEmpty()) {
                LOGGER.warning("No hay detalles en el pedido para el usuario con ID: " +
                               request.getSession().getAttribute("idUsuario"));
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "El carrito está vacío.");
                return;
            }

            // Asignar el ID del pedido a cada detalle y guardarlos en la base de datos
            DetallePedidoDAO detallePedidoDAO = new DetallePedidoDAO(conexion);
            for (DetallePedido detalle : detallesPedido) {
                detalle.setIdPedido(idPedidoGenerado);
                detallePedidoDAO.insertarDetallePedido(detalle);
            }

            // Configurar datos para la página de confirmación
            request.setAttribute("idPedido", idPedidoGenerado);
            request.setAttribute("direccion", direccion);
            request.setAttribute("telefono", telefono);
            request.setAttribute("metodoEnvio", metodoEnvio);

            // Limpiar variables de sesión relacionadas con el carrito
            request.getSession().removeAttribute("detallesPedido");
            request.getSession().removeAttribute("totalPedido");

            // Redirigir a la página de confirmación
            request.getRequestDispatcher("confirmacion.jsp").forward(request, response);

        } catch (SQLException e) {
            // Registrar el error y enviar respuesta HTTP 500
            LOGGER.severe("Error al procesar el pedido para el usuario con ID: " +
                          request.getSession().getAttribute("idUsuario") + ". Detalles: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar el pedido.");
        }
    }
}
