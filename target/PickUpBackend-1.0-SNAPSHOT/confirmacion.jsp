<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, com.mycompany.pickupbackend.Modelo.DetallePedido" %>
<%
    // Validar si el usuario está logueado
    Integer idUsuario = (Integer) session.getAttribute("idUsuario");
    if (idUsuario == null) {
        response.sendRedirect("login.jsp?error=sessionExpired");
        return;
    }

    // Validar que los datos del pedido existan en la sesión
    Integer idPedido = (Integer) session.getAttribute("idPedido");
    String direccionEntrega = (String) session.getAttribute("direccionEntrega");
    String telefonoContacto = (String) session.getAttribute("telefonoContacto");
    String metodoEnvio = (String) session.getAttribute("metodoEnvio");
    Double totalPedido = (Double) session.getAttribute("totalPedido");
    List<DetallePedido> detallesPedido = (List<DetallePedido>) session.getAttribute("detallesPedido");

    if (idPedido == null || direccionEntrega == null || telefonoContacto == null || metodoEnvio == null || totalPedido == null) {
        request.setAttribute("error", "Faltan datos del pedido. Por favor, revisa tu carrito.");
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Confirmación de Pedido - Pick Up</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Navbar Start -->
    <div class="container-fluid fixed-top">
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand">
                    <h1 class="text-primary display-6">Pick Up</h1>
                </a>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->

    <!-- Confirmation Page Start -->
    <div class="container-fluid py-5">
        <div class="container py-5 text-center">
            <h1 class="mb-4">¡Gracias por tu pedido!</h1>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("error") %>
                </div>
            <% } else { %>
                <p class="mb-4">Tu pedido se ha procesado correctamente.</p>

                <!-- Mostrar el ID del pedido -->
                <div class="alert alert-success">
                    <h3>Pedido #: <strong><%= idPedido %></strong></h3>
                </div>

                <!-- Mostrar los detalles del pedido -->
                <h4 class="mb-3">Detalles del Pedido</h4>
                <ul class="list-group mb-4 text-start">
                    <li class="list-group-item"><strong>Dirección de Entrega:</strong> <%= direccionEntrega %></li>
                    <li class="list-group-item"><strong>Teléfono de Contacto:</strong> <%= telefonoContacto %></li>
                    <li class="list-group-item"><strong>Método de Envío:</strong> <%= metodoEnvio %></li>
                    <li class="list-group-item"><strong>Costo de Envío:</strong> S/ <%= "delivery".equals(metodoEnvio) ? "6.00" : "0.00" %></li>
                </ul>

                <!-- Tabla de Productos -->
                <h4 class="mb-3">Productos en tu Pedido</h4>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">Producto</th>
                            <th scope="col">Cantidad</th>
                            <th scope="col">Precio Unitario</th>
                            <th scope="col">Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (detallesPedido != null && !detallesPedido.isEmpty()) { 
                            for (DetallePedido detalle : detallesPedido) { %>
                                <tr>
                                    <td><%= detalle.getProducto().getNombre() %></td>
                                    <td><%= detalle.getCantidad() %></td>
                                    <td>S/ <%= detalle.getPrecioUnitario() %></td>
                                    <td>S/ <%= detalle.getCantidad() * detalle.getPrecioUnitario() %></td>
                                </tr>
                            <% } 
                        } else { %>
                            <tr>
                                <td colspan="4" class="text-center">No hay productos en tu pedido.</td>
                            </tr>
                        <% } %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="3" class="text-end">Subtotal:</th>
                            <th>S/ <%= totalPedido - ("delivery".equals(metodoEnvio) ? 6.00 : 0.00) %></th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-end">Costo de Envío:</th>
                            <th>S/ <%= "delivery".equals(metodoEnvio) ? "6.00" : "0.00" %></th>
                        </tr>
                        <tr>
                            <th colspan="3" class="text-end">Total:</th>
                            <th>S/ <%= totalPedido %></th>
                        </tr>
                    </tfoot>
                </table>

                <!-- Botón para volver a la página principal -->
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">Volver al inicio</a>
                </div>
                <% 
                    // Limpiar los datos de la sesión
                    session.removeAttribute("idPedido");
                    session.removeAttribute("direccionEntrega");
                    session.removeAttribute("telefonoContacto");
                    session.removeAttribute("metodoEnvio");
                    session.removeAttribute("totalPedido");
                    session.removeAttribute("detallesPedido");
                %>
            <% } %>
        </div>
    </div>
    <!-- Confirmation Page End -->

    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h4 class="text-light mb-3">Pick Up</h4>
                    <p>Gracias por confiar en nuestros servicios.</p>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>

</html>
