/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.mycompany.pickupbackend.util.Conexion;
import com.mycompany.pickupbackend.DAO.ProductoDAO;
import com.mycompany.pickupbackend.Modelo.Producto;
/**
 *
 * @author minay
 */
@WebServlet("/TestProductoServlet")
public class TestProductoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection con = Conexion.getConnection();
        if (con == null) {
            response.getWriter().write("Error: No se pudo conectar a la base de datos.");
            return;
        }

        try {
            ProductoDAO productoDAO = new ProductoDAO(con);
            List<Producto> productos = productoDAO.getAllProductos();

            // Configurar respuesta como texto plano
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();

            // Imprimir productos directamente
            if (productos.isEmpty()) {
                out.println("No se encontraron productos.");
            } else {
                for (Producto producto : productos) {
                    out.println("Producto: " + producto.getNombre());
                    out.println("Descripción: " + producto.getDescripcion());
                    out.println("Precio: " + producto.getPrecio());
                    out.println("Imagen: " + producto.getImagen());
                    out.println("---------------------------------");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error al obtener los productos: " + e.getMessage());
        }
    }
}
