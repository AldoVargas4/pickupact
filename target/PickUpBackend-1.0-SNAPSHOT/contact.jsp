    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
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

        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Contáctanos</h1>
        </div>
        <!-- Single Page Header End -->

        <!-- Contact Start -->
        <div class="container-fluid contact py-5">
            <div class="container py-5">
                <div class="p-5 bg-light rounded">
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="text-center mx-auto" style="max-width: 700px;">
                                <h1 class="text-primary">Horario de Atención</h1>
                                <p class="mb-4">Lunes a viernes: 6:00 a.m. – 12:00 p.m. Sábados y domingos: 7:00 a.m. – 1:00 p.m.</p>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="h-100 rounded">
                                <iframe class="rounded w-100" 
                                style="height: 400px;" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3902.8370556434875!2d-77.08419836939629!3d-11.985774407047922!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105ce684372d7c7%3A0x3e0a0af8860141ff!2sC.%20los%20Mercurios%20241%2C%20Lima%2015109!5e0!3m2!1ses!2spe!4v1727670146599!5m2!1ses!2spe" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <form>
                                <input type="text" class="w-100 form-control border-0 py-3 mb-4" placeholder="Nombre">
                                <input type="email" class="w-100 form-control border-0 py-3 mb-4" placeholder="Correo">
                                <textarea class="w-100 form-control border-0 mb-4" rows="5" cols="10" placeholder="Mensaje"></textarea>
                                <button class="w-100 btn form-control border-secondary py-3 bg-white text-primary" type="submit">Enviar</button>
                            </form>
                        </div>
                        <div class="col-lg-5">
                            <div class="d-flex p-4 rounded mb-4 bg-white">
                                <i class="fas fa-map-marker-alt fa-2x text-primary me-4"></i>
                                <div>
                                    <h4>Dirección</h4>
                                    <p class="mb-2">Calle Los Mercurios 241</p>
                                </div>
                            </div>
                            <div class="d-flex p-4 rounded mb-4 bg-white">
                                <i class="fas fa-envelope fa-2x text-primary me-4"></i>
                                <div>
                                    <h4>Correo</h4>
                                    <p class="mb-2">atencionalcliente@pickup.com</p>
                                </div>
                            </div>
                            <div class="d-flex p-4 rounded bg-white">
                                <i class="fa fa-phone-alt fa-2x text-primary me-4"></i>
                                <div>
                                    <h4>Teléfono</h4>
                                    <p class="mb-2">(+51)942102558</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact End -->

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
                                <input class="form-control border-0 w-100 py-3 px-4 rounded-pill" type="number" placeholder="Tu correo">
                                <button type="submit" class="btn btn-primary border-0 py-3 px-4 position-absolute rounded-pill text-white" style="top: 0; right: 0;">Suscríbete</button>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="d-flex justify-content-end pt-3">
                                <a class="btn btn-outline-secondary me-2 btn-md-square rounded-circle" href=""><i class="fab fa-twitter"></i></a>
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
                            <img src="${pageContext.request.contextPath}/img/payment.png" class="img-fluid" alt="">
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

        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/lightbox/js/lightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>

    </html>
