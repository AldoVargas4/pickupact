<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    
 <style>
        /* Estilo general del cuerpo */
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        /* Contenedor principal */
        .container {
            max-width: 800px;
            padding: 30px;
            margin: 0 auto;
        }

        /* Estilo de la tarjeta */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            padding: 30px;
            background-color: #fff;
        }

        /* Título del formulario */
        .form-title {
            font-size: 1.8rem;
            font-weight: bold;
            color: #343a40;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Etiquetas de formulario */
        .form-label {
            font-weight: bold;
            color: #495057;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        /* Campos de entrada */
        .form-control {
            border-radius: 8px;
            padding: 12px;
            font-size: 15px;
            border: 1px solid #ced4da;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #80bdff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        /* Botón */
        .btn-primary {
            font-weight: bold;
            padding: 12px;
            font-size: 16px;
            border-radius: 8px;
            background-color: #28a745;
            border: none;
            color: #fff;
            transition: background-color 0.3s;
            width: 100%;
            margin-top: 20px;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        /* Alertas de éxito y error */
        .alert {
            font-size: 14px;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>

    
    <meta charset="UTF-8">
    <title>Cambiar Contraseña - Pick Up</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="keywords" content="">
    <meta name="description" content="">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Navbar Start -->
    <div class="container-fluid fixed-top">
        <div class="container topbar bg-primary d-none d-lg-block">
            <div class="d-flex justify-content-between">
                <div class="top-info ps-2">
                    <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#" class="text-white">Calle Los Mercurios 241</a></small>
                    <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">atencionalcliente@pickup.com</a></small>
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
                <a href="index.jsp" class="navbar-brand"><h1 class="text-primary display-6">Pick Up</h1></a>
                <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars text-primary"></span>
                </button>
                <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                    <div class="navbar-nav mx-auto">
                        <a href="index.jsp" class="nav-item nav-link active">Inicio</a>
                        <a href="testimonial.jsp" class="nav-item nav-link">Nosotros</a>
                        <a href="shop.jsp" class="nav-item nav-link">Productos</a>
                        <a href="cart.jsp" class="nav-item nav-link">Membresía</a>
                        <a href="contact.jsp" class="nav-item nav-link">Contáctanos</a>
                    </div>
                    <div class="d-flex m-3 me-0">
                        <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-primary"></i></button>
                        <a href="cart.jsp" class="position-relative me-4 my-auto">
                            <i class="fa fa-shopping-bag fa-2x"></i>
                            <span class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1" style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
                        </a>
                        <!-- Menú desplegable de usuario con condición de sesión -->
                        <div class="dropdown my-auto">
                            <a href="#" class="dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user fa-2x"></i>
                                <c:if test="${pageContext.request.userPrincipal != null}">
                                    <span>${pageContext.request.userPrincipal.name}</span>
                                </c:if>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                <% if (session.getAttribute("nombreUsuario") == null) { %>
                                    <li><a class="dropdown-item" href="login.jsp">Iniciar Sesión</a></li>
                                    <li><a class="dropdown-item" href="register.jsp">Registrarse</a></li>
                                <% } else { %>
                                    <li><a class="dropdown-item" href="verCuenta.jsp">Ver Mi Cuenta</a></li>
                                    <li><a class="dropdown-item" href="misDatos.jsp">Mis Datos</a></li>
                                    <li><a class="dropdown-item" href="logout.jsp">Cerrar Sesión</a></li>
                                <% } %>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->

    <!-- Header Banner Start -->
    <div class="header-banner">
        <img src="img/banner.jpg" alt="Encabezado de Cambiar Contraseña" class="banner-img">
        <h2 class="banner-text">Cambia tu Contraseña</h2>
    </div>
    <!-- Header Banner End -->
    
<!-- Cambiar Contraseña Formulario Start -->
<div class="container my-5" style="padding-top: 150px;">

    <div class="row justify-content-center">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4 w-100">
                <div class="card shadow w-100">
                    <div class="card-body">
                        <h2 class="form-title text-center mb-4">Cambiar Contraseña</h2>
                        <!-- Mensajes de éxito o error -->
                        <% if (request.getAttribute("mensaje") != null) { %>
                            <div class="alert alert-success text-center"><%= request.getAttribute("mensaje") %></div>
                        <% } %>
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger text-center"><%= request.getAttribute("error") %></div>
                        <% } %>
                        <form action="CambiarContrasenaServlet" method="POST">
                            <div class="mb-3">
                                <label for="nuevaContrasena" class="form-label">Nueva Contraseña</label>
                                <input type="password" name="nuevaContrasena" class="form-control" id="nuevaContrasena" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmarContrasena" class="form-label">Confirmar Nueva Contraseña</label>
                                <input type="password" name="confirmarContrasena" class="form-control" id="confirmarContrasena" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Cambiar Contraseña</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Cambiar Contraseña Formulario End -->


        <!-- Footer Start -->
    <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
        <div class="container py-5">
            <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(226, 175, 24, 0.5) ;">
                <div class="row g-4">
                    <div class="col-lg-3">
                        <a href="#">
                            <h1 class="text-primary mb-0">Pick Up</h1>
                            <p class="text-secondary mb-0">Desayunos a domicilio</p>
                        </a>
                    </div>
                    <div class="col-lg-6">
    <div class="subscription-container mx-auto">
        <input class="form-control" type="email" placeholder="Tu correo">
        <button type="submit" class="btn-subscribe">Suscríbete</button>
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
                        <h4 class="text-light mb-3">¿Por qué elegirnos?</h4>
                        <p class="mb-4">En Pick Up, creemos que el mejor recurso que debemos cuidar es el tiempo de nuestros clientes, por eso les ofrecemos una solución de envío delivery. Sabemos que las mañanas deben ser simples y deliciosas.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="d-flex flex-column text-start footer-item">
                        <h4 class="text-light mb-3">Cuenta</h4>
                        <a class="btn-link" href="">Mi Perfil</a>
                        <a class="btn-link" href="">Métodos de Pago</a>
                        <a class="btn-link" href="">Facturación</a>
                        <a class="btn-link" href="">Seguridad y Privacidad</a>
                        <a class="btn-link" href="">Suscripciones</a>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="footer-item">
                        <h4 class="text-light mb-3">Contacto</h4>
                        <p>Address: Calle Los Mercurios 241</p>
                        <p>Email: atencionalcliente@pickup.com</p>
                        <p>Phone: +51 942102558</p>
                        <p>Aceptamos tarjetas</p>
                        <img src="img/payment.png" class="img-fluid" alt="">
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="d-flex flex-column text-start footer-item">
                        <h4 class="text-light mb-3">Ayuda y Soporte</h4>
                        <a class="btn-link" href="">Preguntas Frecuentes</a>
                        <a class="btn-link" href="">Centro de Ayuda</a>
                        <a class="btn-link" href="">Soporte Técnico</a>
                        <a class="btn-link" href="">Política de Devoluciones</a>
                        <a class="btn-link" href="">Términos y condiciones</a>
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
                <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>Pick Up 2024</a>
            </div>
            
        </div>
    </div>
</div>
<!-- Copyright End -->
<!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

</body>

</html>