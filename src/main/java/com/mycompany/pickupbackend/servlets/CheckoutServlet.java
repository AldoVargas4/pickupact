package com.mycompany.pickupbackend.servlets;
import com.mycompany.pickupbackend.DAO.ProductoDAO; 
import com.mycompany.pickupbackend.DAO.PedidoDAO;
import com.mycompany.pickupbackend.DAO.DetallePedidoDAO;
import com.mycompany.pickupbackend.Modelo.Pedido;
import com.mycompany.pickupbackend.Modelo.DetallePedido;
import com.mycompany.pickupbackend.util.Conexion;
import com.mycompany.pickupbackend.Modelo.Producto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    private Integer validarSesion(HttpSession session, HttpServletResponse response) throws IOException {
        Integer idUsuario = (Integer) session.getAttribute("idUsuario");
        if (idUsuario == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return null;
        }
        return idUsuario;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idUsuario = validarSesion(session, response);
        if (idUsuario == null) return;

        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");
        if (carrito == null || carrito.isEmpty()) {
            response.sendRedirect("cart.jsp?error=emptyCart");
            return;
        }

        double subtotal = carrito.stream()
                .mapToDouble(detalle -> detalle.getCantidad() * detalle.getPrecioUnitario())
                .sum();

        request.setAttribute("subtotal", subtotal);
        request.getRequestDispatcher("chackout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idUsuario = validarSesion(session, response);
        if (idUsuario == null) return;

        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");
        if (carrito == null || carrito.isEmpty()) {
            response.sendRedirect("cart.jsp?error=emptyCart");
            return;
        }

        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String metodoEnvio = request.getParameter("metodoEnvio");

        if (direccion == null || direccion.isEmpty() || telefono == null || telefono.isEmpty() || metodoEnvio == null) {
            response.sendRedirect("chackout.jsp?error=missingData");
            return;
        }

        double subtotal = carrito.stream()
                .mapToDouble(detalle -> detalle.getCantidad() * detalle.getPrecioUnitario())
                .sum();
        double costoEnvio = metodoEnvio.equals("delivery") ? 6.0 : 0.0;
        double total = subtotal + costoEnvio;

        try (Connection conexion = Conexion.getConnection()) {
    if (conexion == null) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al conectar con la base de datos.");
        return;
    }

    PedidoDAO pedidoDAO = new PedidoDAO(conexion);
    Pedido pedido = new Pedido();
    pedido.setIdUsuario(idUsuario);
    pedido.setFechaPedido(new Date());
    pedido.setTotal(total);
    pedido.setEstado("Pendiente");
    pedido.setDireccionEntrega(direccion);
    pedido.setTelefonoContacto(telefono);
    pedido.setMetodoEnvio(metodoEnvio);

    int idPedidoGenerado = pedidoDAO.insertarPedido(pedido);

    if (idPedidoGenerado > 0) {
        DetallePedidoDAO detallePedidoDAO = new DetallePedidoDAO(conexion);
ProductoDAO productoDAO = new ProductoDAO(conexion); // Asegúrate de importar ProductoDAO

for (DetallePedido detalle : carrito) {
    // Obtener el producto asociado al detalle
    Producto producto = productoDAO.obtenerProductoPorId(detalle.getIdProducto());
    if (producto == null) { 
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: Producto no encontrado para el detalle.");
        return;
    }

    // Completar la información del producto en el detalle
    detalle.setProducto(producto);
    detalle.setIdPedido(idPedidoGenerado);

    // Insertar el detalle del pedido
    if (!detallePedidoDAO.insertarDetallePedido(detalle)) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al guardar detalles del pedido.");
        return;
    }
}


        // Limpiar carrito de la sesión
        session.removeAttribute("carrito");

        // Agregar datos a la sesión para confirmación
        session.setAttribute("idPedido", idPedidoGenerado);
        session.setAttribute("direccionEntrega", direccion);
        session.setAttribute("telefonoContacto", telefono);
        session.setAttribute("metodoEnvio", metodoEnvio);
        session.setAttribute("totalPedido", total);
        session.setAttribute("detallesPedido", carrito);

        // Redirigir a confirmacion.jsp
        response.sendRedirect("confirmacion.jsp");
        return;

    } else {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al guardar el pedido.");
    }
} catch (SQLException e) {
    e.printStackTrace();
    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar el pedido.");
}

}
}
