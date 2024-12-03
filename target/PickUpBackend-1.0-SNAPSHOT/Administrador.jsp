<%@page import="java.util.Iterator"%>
<%@page import="com.mycompany.pickupbackend.Modelo.Usuario"%>
<%@page import="com.mycompany.pickupbackend.DAO.ClasificacionDAO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - Pick-up</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome (para los íconos) -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

        <!-- CSS personalizado -->
        <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
    </head>
    <body>
        <!-- Botón para mostrar/ocultar sidebar -->
        <button class="toggle-sidebar-btn" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Sidebar -->
        <div class="sidebar">
            <h2>Pick-Up</h2>
            <a href="${pageContext.request.contextPath}/dashboard.jsp"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/gestionProductos.jsp"><i class="fas fa-box"></i> Gestión de Productos</a>
            <a href="${pageContext.request.contextPath}/Administrador.jsp"><i class="fas fa-users"></i> Gestión de Clientes</a>
            <a href="${pageContext.request.contextPath}/gestionPedidos.jsp"><i class="fas fa-shopping-cart"></i> Gestión de Pedidos</a>
            <a href="#"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a>
        </div>

        <!-- Contenido principal -->
        <div class="content">
            <h1 class="mb-4">Gestión de Clientes</h1>
            <p>En esta sección, puedes gestionar los clientes registrados en la tienda.</p>

            <!-- Tabla de Clientes -->
            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <% ClasificacionDAO dao = new ClasificacionDAO();
                    List<Usuario> list = dao.ListarUsuarios();
                    Iterator<Usuario> iter = list.iterator();
                    Usuario per = null;
                    while (iter.hasNext()) {
                        per = iter.next();

                %>
                <tbody>

                    <tr>
                        <td><%=per.getId_usuario()%></td>
                        <td><%=per.getNombre()%></td>
                        <td><%=per.getEmail()%></td>
                        <td><%=per.getTelefono()%></td>
                        <td>
                            <!-- Formulario para eliminar el usuario -->
                            <form action="${pageContext.request.contextPath}/EliminarUsuariosServlet" method="post">
                                <input type="hidden" name="id_usuario" value="<%= per.getId_usuario()%>" />
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Eliminar
                                </button>
                            </form>
                        </td>



                        <%}%>
                </tbody>
            </table>

            <!-- Sección de reportes -->
            <h2 class="mt-4">Reportes</h2>
            <p>Genera un reporte con los datos de los clientes.</p>
            <!-- Formulario para invocar el servlet -->
            <form action="${pageContext.request.contextPath}/GenerarExcelServlet" method="post">
                <button type="submit" class="btn btn-success">Descargar en formato XLSX</button>
            </form>
        </div>

        <!-- Scripts -->
        <script>
            function toggleSidebar() {
                const sidebar = document.querySelector('.sidebar');
                sidebar.classList.toggle('hidden');
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
