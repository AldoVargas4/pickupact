<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException, com.mycompany.pickupbackend.util.Conexion" %>
<%@ page import="java.util.List, com.mycompany.pickupbackend.Modelo.DetallePedido" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List, com.mycompany.pickupbackend.Modelo.DetallePedido" %>

<%
    Integer idUsuario = (Integer) session.getAttribute("idUsuario");
    if (idUsuario == null) {
        response.sendRedirect("login.jsp?error=sessionExpired");
        return;
    }

    List<DetallePedido> carrito = (List<DetallePedido>) session.getAttribute("carrito");
    if (carrito == null || carrito.isEmpty()) {
        response.sendRedirect("cart.jsp?error=emptyCart");
        return;
    }

    double subtotal = carrito.stream()
            .mapToDouble(detalle -> detalle.getCantidad() * detalle.getPrecioUnitario())
            .sum();
    double costoEnvio = 6.0; // Valor inicial por defecto para envío delivery
    double total = subtotal + costoEnvio;
%>

<% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger text-center">
        <%= request.getAttribute("error") %>
    </div>
<% } %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Pick Up - Desayunos al instante</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    
    
    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>

<body>

    <!-- Spinner Start -->
    <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->


        <!-- Navbar Start -->
    <div class="container-fluid fixed-top">
        <div class="container topbar bg-primary d-none d-lg-block">
            <div class="d-flex justify-content-between">
                <div class="top-info ps-2">
                    <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> 
                        <a href="#" class="text-white">Calle Los Mercurios 241</a>
                    </small>
                    <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i>
                        <a href="#" class="text-white">atencionalcliente@pickup.com</a>
                    </small>
                </div>
                <div class="top-link pe-2">
                    <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
                    <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                    <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>
                </div>
            </div>
        </div>
        <div class="container px-0">
            <nav class="navbar navbar-light bg-white navbar-expand-xl">
                <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand">
                    <h1 class="text-primary display-6">Pick Up</h1>
                </a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto">
                        <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link active">Inicio</a>
                        <a href="${pageContext.request.contextPath}/testimonial.jsp" class="nav-item nav-link">Nosotros</a>
                        <a href="${pageContext.request.contextPath}/shop.jsp" class="nav-item nav-link">Productos</a>
                        <a href="${pageContext.request.contextPath}/cart.jsp" class="nav-item nav-link">Membresía</a>
                        <a href="${pageContext.request.contextPath}/contact.jsp" class="nav-item nav-link">Contáctanos</a>
                    </div>
                    <div class="d-flex m-3 me-0">
                        <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-primary"></i></button>
                        <a href="${pageContext.request.contextPath}/cart.jsp" class="position-relative me-4 my-auto">
                            <i class="fa fa-shopping-bag fa-2x"></i>
                            <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
                        </a>
                        <!-- Menú desplegable de usuario con condición de sesión -->
<div class="dropdown my-auto">
    <a href="#" class="dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="fas fa-user fa-2x"></i>
        <c:if test="${sessionScope.nombreUsuario != null}">
            <span>${sessionScope.nombreUsuario}</span>
        </c:if>
    </a>
    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
        <% if (session.getAttribute("nombreUsuario") == null) { %>
            <!-- Opciones para usuarios NO logeados -->
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login.jsp">Iniciar Sesión</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/register.jsp">Registrarse</a></li>
        <% } else { %>
            <!-- Opciones para usuarios logeados -->
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/verCuenta.jsp">Ver Mi Cuenta</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/misDatos.jsp">Mis Datos</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cambiarContrasena.jsp">Cambiar Contraseña</a></li>
            <!-- Enlace único para cerrar sesión -->
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/LogoutServlet">Cerrar Sesión</a></li>
        <% } %>
    </ul>
</div>





                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->

    <!-- Modal Search Start -->
    <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content rounded-0">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex align-items-center">
                    <div class="input-group w-75 mx-auto d-flex">
                        <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                        <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Search End -->

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Checkout</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart.jsp">Carrito</a></li>
            <li class="breadcrumb-item active text-white">Checkout</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

  <!-- Checkout Page -->
<div class="container py-5">
    <h2 class="mb-4 text-center">Revisar y Confirmar Pedido</h2>

    <!-- Resumen del pedido -->
    <div class="mb-4">
        <h4>Resumen del Pedido</h4>
        <table class="table table-bordered">
    <thead>
        <tr>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Precio Unitario</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        <% if (carrito != null && !carrito.isEmpty()) { %>
            <% for (DetallePedido detalle : carrito) { %>
                <tr>
                    <td><%= detalle.getProducto() != null ? detalle.getProducto().getNombre() : "Producto no disponible" %></td>
                    <td><%= detalle.getCantidad() %></td>
                    <td>S/ <%= detalle.getPrecioUnitario() %></td>
                    <td>S/ <%= detalle.getCantidad() * detalle.getPrecioUnitario() %></td>
                </tr>
            <% } %>
        <% } else { %>
            <tr>
                <td colspan="4">El carrito está vacío.</td>
            </tr>
        <% } %>
    </tbody>
    <tfoot>
        <tr>
            <th colspan="3" class="text-end">Subtotal:</th>
            <th>S/ <%= subtotal %></th>
        </tr>
        <tr>
            <th colspan="3" class="text-end">Costo de Envío:</th>
            <th id="costoEnvio">S/ 6.00</th>
        </tr>
        <tr>
            <th colspan="3" class="text-end">Total:</th>
            <th id="total">S/ <%= subtotal + 6.00 %></th>
        </tr>
    </tfoot>
</table>


    </div>

    <!-- Formulario de datos del cliente -->
    <form action="CheckoutServlet" method="post">
    <div class="mb-3">
        <label for="direccion" class="form-label">Dirección de Entrega</label>
        <input type="text" class="form-control" id="direccion" name="direccion" required>
    </div>
    <div class="mb-3">
        <label for="telefono" class="form-label">Teléfono de Contacto</label>
        <input type="text" class="form-control" id="telefono" name="telefono" required>
    </div>
    <div class="mb-3">
        <label for="metodoEnvio" class="form-label">Método de Envío</label>
        <select class="form-select" id="metodoEnvio" name="metodoEnvio" required>
            <option value="delivery">Delivery</option>
            <option value="recojo">Recojo</option>
        </select>
    </div>
    <div class="mb-3">
        <label for="metodoPago" class="form-label">Método de Pago</label>
        <select class="form-select" id="metodoPago" name="metodoPago" required>
            <option value="efectivo">Efectivo</option>
            <option value="tarjeta">Tarjeta</option>
            <option value="yape">Yape</option>
        </select>
    </div>
    <button type="submit" class="btn btn-success w-100">Confirmar Pedido</button>
</form>

</div>


<!-- Validación con JavaScript -->
<script>
    function validarFormulario() {
        const direccion = document.getElementById("direccion").value.trim();
        const telefono = document.getElementById("telefono").value.trim();
        const metodoEnvio = document.getElementById("metodoEnvio").value;

        if (direccion === "" || telefono === "" || metodoEnvio === "") {
            alert("Por favor, completa todos los campos requeridos.");
            return false;
        }
        return true;
    }
</script>

 <script>
        function actualizarTotal() {
            const metodoEnvio = document.getElementById('metodoEnvio').value;
            const costoEnvio = metodoEnvio === 'delivery' ? 6.0 : 0.0;
            const subtotal = parseFloat(<%= subtotal %>);
            const total = subtotal + costoEnvio;

            document.getElementById('costoEnvio').textContent = costoEnvio.toFixed(2);
            document.getElementById('total').textContent = total.toFixed(2);
        }
    </script>


    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
        <div class="container py-5">
            <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5);">
                <div class="row g-4">
                    <div class="col-lg-3">
                        <a href="#">
                            <h1 class="text-primary mb-0">Pick Up</h1>
                            <p class="text-secondary mb-0">Desayunos a domicilio</p>
                        </a>
                    </div>
                    <div class="col-lg-6">
                        <div class="position-relative mx-auto">
                            <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="text" placeholder="Tu correo">
                            <button type="submit" class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white" style="top: 0; right: 0;">Suscríbete</button>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="d-flex justify-content-end pt-3">
                            <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="#"><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="#"><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href="#"><i class="fab fa-youtube"></i></a>
                            <a class="btn btn-outline-secondary btn-md-square rounded-circle" href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <div class="footer-item">
                        <h4 class="text-light mb-3">¿Por qué elegirnos?</h4>
                        <p class="mb-4">En Pick Up, creemos que el mejor recurso que debemos cuidar es el tiempo de nuestros clientes, por eso les ofrecemos una solución de envío delivery. Sabemos que las mañanas deben ser simples y deliciosas.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="d-flex flex-column text-start footer-item">
                        <h4 class="text-light mb-3">Cuenta</h4>
                        <a class="btn-link" href="#">Mi Perfil</a>
                        <a class="btn-link" href="#">Métodos de Pago</a>
                        <a class="btn-link" href="#">Facturación</a>
                        <a class="btn-link" href="#">Seguridad y Privacidad</a>
                        <a class="btn-link" href="#">Suscripciones</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="footer-item">
                        <h4 class="text-light mb-3">Contacto</h4>
                        <p>Address: Calle Los Mercurios 241</p>
                        <p>Email: atencionalcliente@pickup.com</p>
                        <p>Phone: +51 942102558</p>
                        <p>Aceptamos tarjetas</p>
                        <img src="${pageContext.request.contextPath}/img/payment.png" class="img-fluid" alt="">
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="d-flex flex-column text-start footer-item">
                        <h4 class="text-light mb-3">Ayuda y Soporte</h4>
                        <a class="btn-link" href="#">Preguntas Frecuentes</a>
                        <a class="btn-link" href="#">Centro de Ayuda</a>
                        <a class="btn-link" href="#">Soporte Técnico</a>
                        <a class="btn-link" href="#">Política de Devoluciones</a>
                        <a class="btn-link" href="#">Términos y condiciones</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->

    <!-- Copyright Start -->
    <div class="container-fluid copyright bg-dark py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>Pick Up 2024</a>, Todos los derechos reservados.</span>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Script para calcular el total dinámicamente -->
    <script>
    function actualizarTotal() {
        const subtotal = parseFloat(<%= session.getAttribute("subtotal") != null ? session.getAttribute("subtotal") : 0 %>);
        const metodoEnvio = document.getElementById('metodoEnvio').value;
        let costoEnvio = 0;

        // Ajustar el costo de envío dependiendo del método seleccionado
        if (metodoEnvio === 'delivery') {
            costoEnvio = 6.00;
        } else if (metodoEnvio === 'recojo') {
            costoEnvio = 0.00;
        }

        // Actualizar los valores en el DOM
        document.getElementById('costoEnvio').textContent = costoEnvio.toFixed(2);
        document.getElementById('total').textContent = (subtotal + costoEnvio).toFixed(2);

        // Actualizar los campos ocultos
        document.getElementById('inputCostoEnvio').value = costoEnvio.toFixed(2);
        document.getElementById('inputTotal').value = (subtotal + costoEnvio).toFixed(2);
    }
</script>
    
    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
    function validarFormulario() {
        const direccion = document.getElementById("direccion").value.trim();
        const telefono = document.getElementById("telefono").value.trim();
        const metodoEnvio = document.getElementById("metodoEnvio").value;

        if (direccion === "" || telefono === "" || metodoEnvio === "") {
            alert("Por favor, completa todos los campos requeridos.");
            return false;
        }
        return true;
    }
</script>

<script>
    function actualizarCostoEnvio() {
        const metodoEnvio = document.getElementById('metodoEnvio').value;
        const costoEnvioElement = document.getElementById('costoEnvio');
        const totalElement = document.getElementById('total');
        const subtotal = parseFloat(<%= subtotal %>); // Tomar el subtotal desde el servidor

        let costoEnvio = 0;
        if (metodoEnvio === 'delivery') {
            costoEnvio = 6.0;
        } else if (metodoEnvio === 'recojo') {
            costoEnvio = 0.0;
        }

        // Actualizar el DOM
        costoEnvioElement.textContent = `S/ ${costoEnvio.toFixed(2)}`;
        totalElement.textContent = `S/ ${(subtotal + costoEnvio).toFixed(2)}`;
    }

    // Asignar el evento al elemento del select
    document.getElementById('metodoEnvio').addEventListener('change', actualizarCostoEnvio);
</script>

</body>

</html>
