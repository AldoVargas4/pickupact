package com.mycompany.pickupbackend.servlets;

import com.mycompany.pickupbackend.DAO.ProductoDAO;
import com.mycompany.pickupbackend.Modelo.Producto;
import com.mycompany.pickupbackend.util.Conexion;
import com.mycompany.pickupbackend.Modelo.DetallePedido;
import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import jakarta.servlet.ServletException;    
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con = Conexion.getConnection();
        if (con == null) {
            System.err.println("Error al obtener conexión a la base de datos.");
            response.sendRedirect("error.jsp");
            return;
        }

        // Manejar las acciones del carrito
        String accion = request.getParameter("accion");
        if (accion != null) {
            switch (accion) {
                case "agregar":
                    agregarAlCarrito(request, response);
                    break;
                case "eliminar":
                    eliminarDelCarrito(request, response);
                    break;
                case "actualizarCantidad":
                    actualizarCantidad(request, response);
                    break;
                default:
                    mostrarProductos(request, response, con);
            }
        } else {
            mostrarProductos(request, response, con);
        }
    }

    private void mostrarProductos(HttpServletRequest request, HttpServletResponse response, Connection con)
            throws ServletException, IOException {
        try {
            ProductoDAO productoDAO = new ProductoDAO(con);
            List<Producto> productos = productoDAO.getAllProductos();
            request.setAttribute("productos", productos);
            request.getRequestDispatcher("shop.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void agregarAlCarrito(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        try (Connection con = Conexion.getConnection()) {
            String productoIdParam = request.getParameter("productoId");
            String cantidadParam = request.getParameter("cantidad");

            if (productoIdParam == null || cantidadParam == null ||
                productoIdParam.isEmpty() || cantidadParam.isEmpty()) {
                response.sendRedirect("cart.jsp?error=invalidInput");
                return;
            }

            int idProducto = Integer.parseInt(productoIdParam);
            int cantidad = Integer.parseInt(cantidadParam);

            // Obtener el producto desde la base de datos
            ProductoDAO productoDAO = new ProductoDAO(con);
            Producto producto = productoDAO.getProductoPorId(idProducto);

            if (producto == null) {
                response.sendRedirect("cart.jsp?error=productNotFound");
                return;
            }

            boolean existe = false;

            // Verificar si el producto ya está en el carrito
            for (DetallePedido item : carrito) {
                if (item.getIdProducto() == idProducto) {
                    item.setCantidad(item.getCantidad() + cantidad); // Actualizar cantidad
                    existe = true;
                    break;
                }
            }

            // Si no existe, agregarlo al carrito
            if (!existe) {
                DetallePedido nuevoDetalle = new DetallePedido();
                nuevoDetalle.setIdProducto(idProducto);
                nuevoDetalle.setCantidad(cantidad);
                nuevoDetalle.setPrecioUnitario(producto.getPrecio());
                carrito.add(nuevoDetalle);
            }

            // Guardar el carrito en la sesión
            session.setAttribute("carrito", carrito);
            response.sendRedirect("cart.jsp?success=added");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=invalidInput");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void eliminarDelCarrito(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");

        if (carrito != null) {
            try {
                int idProducto = Integer.parseInt(request.getParameter("productoId"));
                carrito.removeIf(item -> item.getIdProducto() == idProducto);
                session.setAttribute("carrito", carrito);
                response.sendRedirect("cart.jsp?success=removed");
            } catch (NumberFormatException e) {
                response.sendRedirect("cart.jsp?error=invalidInput");
            }
        } else {
            response.sendRedirect("cart.jsp?error=emptyCart");
        }
    }

    private void actualizarCantidad(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");

        if (carrito != null) {
            try {
                int idProducto = Integer.parseInt(request.getParameter("productoId"));
                int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));

                if (nuevaCantidad < 1) {
                    response.sendRedirect("cart.jsp?error=invalidQuantity");
                    return;
                }

                // Actualizar la cantidad en el carrito
                for (DetallePedido item : carrito) {
                    if (item.getIdProducto() == idProducto) {
                        item.setCantidad(nuevaCantidad);
                        break;
                    }
                }

                session.setAttribute("carrito", carrito);
                response.sendRedirect("cart.jsp?success=updated");
            } catch (NumberFormatException e) {
                response.sendRedirect("cart.jsp?error=invalidInput");
            }
        } else {
            response.sendRedirect("cart.jsp?error=emptyCart");
        }
    }
}
