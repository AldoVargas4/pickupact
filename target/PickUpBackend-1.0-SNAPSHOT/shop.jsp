<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    // Verifica si los productos están en la solicitud
    if (request.getAttribute("productos") == null) {
        // Redirige al servlet
        response.sendRedirect(request.getContextPath() + "/ProductoServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Fruitables - Vegetable Website Template</title>
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

    <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>

<!-- Navbar Start -->
<div class="container-fluid fixed-top">
    <div class="container topbar bg-primary d-none d-lg-block">
        <div class="d-flex justify-content-between">
            <div class="top-info ps-2">
                <small class="me-3">
                    <i class="fas fa-map-marker-alt me-2 text-secondary"></i> 
                    <a href="#" class="text-white">Calle Los Mercurios 241</a>
                </small>
                <small class="me-3">
                    <i class="fas fa-envelope me-2 text-secondary"></i>
                    <a href="#" class="text-white">atencionalcliente@pickup.com</a>
                </small>
            </div>
            <div class="top-link pe-2">
                <a href="#" class="text-white">
                    <small class="text-white mx-2">Privacy Policy</small>/
                </a>
                <a href="#" class="text-white">
                    <small class="text-white mx-2">Terms of Use</small>/
                </a>
                <a href="#" class="text-white">
                    <small class="text-white ms-2">Sales and Refunds</small>
                </a>
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
                    <!-- Icono de búsqueda -->
                    <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal">
                        <i class="fas fa-search text-primary"></i>
                    </button>
                    <!-- Icono de carrito -->
                    <a href="${pageContext.request.contextPath}/cart.jsp" class="position-relative me-4 my-auto">
                        <i class="fa fa-shopping-bag fa-2x"></i>
                        <!-- Contador dinámico del carrito -->
                        <c:if test="${not empty sessionScope.totalProductos}">
                            <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" 
                                  style="top: -5px; left: 15px; height: 20px; min-width: 20px;">
                                ${sessionScope.totalProductos}
                            </span>
                        </c:if>
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

    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Shop</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
            <li class="breadcrumb-item active text-white">Shop</li>
        </ol>
    </div>

    <!-- AQUI EL CATALOGO DE PRODUCTOS -->
<div class="container mt-5">
    <h2 class="text-center mb-4">Catálogo de Productos</h2>
    <div class="row">
        <c:forEach var="producto" items="${productos}">
            <div class="col-md-4 mb-4">
                <div class="card h-100">
                    <!-- Imagen del producto -->
                    <img src="${producto.imagen}" class="card-img-top" alt="${producto.nombre}">
                    <div class="card-body">
                        <!-- Nombre del producto -->
                        <h5 class="card-title">${producto.nombre}</h5>
                        <!-- Descripción del producto -->
                        <p class="card-text">${producto.descripcion}</p>
                        <!-- Precio del producto -->
                        <p class="card-text text-primary">S/ ${producto.precio}</p>

                        <!-- Formulario para agregar al carrito -->
                        <form action="${pageContext.request.contextPath}/ProductoServlet" method="get">
                            <!-- Campo oculto con el ID del producto -->
                            <input type="hidden" name="productoId" value="${producto.idProducto}">
                            <!-- Campo oculto con el precio del producto -->
                            <input type="hidden" name="precio" value="${producto.precio}">
                            <!-- Campo para seleccionar la cantidad -->
                            <div class="input-group mb-3">
                                <input type="number" name="cantidad" class="form-control" id="cantidad_${producto.idProducto}" min="1" value="1" aria-label="Cantidad">
                            </div>
                            <!-- Botón para agregar al carrito -->
                            <input type="hidden" name="accion" value="agregar">
                            <button type="submit" class="btn btn-primary w-100">Agregar al carrito</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<!-- AQUI TERMINA EL CATALOGO DE PRODUCTOS -->


        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
            <div class="container py-5">
                <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
                    <div class="row g-4">
                        <div class="col-lg-3">
                            <a href="#">
                                <h1 class="text-primary mb-0">Fruitables</h1>
                                <p class="text-secondary mb-0">Fresh products</p>
                            </a>
                        </div>
                        <div class="col-lg-6">
                            <div class="position-relative mx-auto">
                                <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="number" placeholder="Your Email">
                                <button type="submit" class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white" style="top: 0; right: 0;">Subscribe Now</button>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="d-flex justify-content-end pt-3">
                                <a class="btn  btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i class="fab fa-youtube"></i></a>
                                <a class="btn btn-outline-secondary btn-md-square rounded-circle" href=""><i class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-item">
                            <h4 class="text-light mb-3">Why People Like us!</h4>
                            <p class="mb-4">typesetting, remaining essentially unchanged. It was 
                                popularised in the 1960s with the like Aldus PageMaker including of Lorem Ipsum.</p>
                            <a href="" class="btn border-secondary py-2 px-4 rounded-pill text-primary">Read More</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column text-start footer-item">
                            <h4 class="text-light mb-3">Shop Info</h4>
                            <a class="btn-link" href="">About Us</a>
                            <a class="btn-link" href="">Contact Us</a>
                            <a class="btn-link" href="">Privacy Policy</a>
                            <a class="btn-link" href="">Terms & Condition</a>
                            <a class="btn-link" href="">Return Policy</a>
                            <a class="btn-link" href="">FAQs & Help</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column text-start footer-item">
                            <h4 class="text-light mb-3">Account</h4>
                            <a class="btn-link" href="">My Account</a>
                            <a class="btn-link" href="">Shop details</a>
                            <a class="btn-link" href="">Shopping Cart</a>
                            <a class="btn-link" href="">Wishlist</a>
                            <a class="btn-link" href="">Order History</a>
                            <a class="btn-link" href="">International Orders</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="footer-item">
                            <h4 class="text-light mb-3">Contact</h4>
                            <p>Address: 1429 Netus Rd, NY 48247</p>
                            <p>Email: Example@gmail.com</p>
                            <p>Phone: +0123 4567 8910</p>
                            <p>Payment Accepted</p>
                            <img src="img/payment.png" class="img-fluid" alt="">
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
                        <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>Your Site Name</a>, All right reserved.</span>
                    </div>
                    <div class="col-md-6 my-auto text-center text-md-end text-white">
                        <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                        <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                        <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                        Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a> Distributed By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
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
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script>
    // Función para capturar el ID y la cantidad del producto
    function agregarAlCarrito(productoId) {
        const cantidadInput = document.getElementById(`cantidad_${productoId}`);
        const cantidad = parseInt(cantidadInput.value);

        // Validar que la cantidad sea válida
        if (cantidad < 1 || isNaN(cantidad)) {
            alert("Por favor, ingresa una cantidad válida.");
            return; // Detener el proceso si la cantidad no es válida
        }

        // Construir la URL para redirigir al servlet
        const url = `${"${pageContext.request.contextPath}"}/ProductoServlet?accion=agregar&productoId=${productoId}&cantidad=${cantidad}`;
        
        // Redireccionar al servlet con los parámetros
        window.location.href = url;
    }
</script>
    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    </body>

</html> 