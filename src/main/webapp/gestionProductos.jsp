<%@page import="java.util.Iterator"%>
<%@page import="com.mycompany.pickupbackend.Modelo.Producto"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.pickupbackend.DAO.ProductosDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Productos</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome (para los íconos) -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/adminstyle.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/productostyle.css" rel="stylesheet">
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
        <div class="content">
            <h2 class="text-center mb-4">Gestión de Productos</h2>
             <h2 class="mt-4">Reportes</h2>
        <p>Genera un reporte con los datos de los Productos.</p>
        <form action="${pageContext.request.contextPath}/GenerarExcelServletProducto" method="post">
                <button type="submit" class="btn btn-success">Descargar en formato XLSX</button>
            </form>

            <!-- Formulario para añadir producto -->
            <div class="form-container mb-5">
                <form id="productForm" action="productoServlet" method="POST">
                    <div class="mb-3">
                        <label for="productId" class="form-label">ID Producto</label>
                        <input type="number" class="form-control" id="productId" min="1" required>
                    </div>
                    <div class="mb-3">
                        <label for="productName" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="productName" name="productName" required>
                    </div>
                    <div class="mb-3">
                        <label for="productDescription" class="form-label">Descripción</label>
                        <input type="text" class="form-control" id="productDescription" name="productDescription" required>
                    </div>
                    <div class="mb-3">
                        <label for="productPrice" class="form-label">Precio</label>
                        <input type="number" class="form-control" id="productPrice" name="productPrice" min="0.01" step="0.01" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Añadir Producto</button>
                </form>
            </div>

            <h3 class="text-center">Lista de Productos</h3>
            <!-- Tabla de productos -->
            <table class="table table-striped mt-3">
                <thead>
                    <tr>
                        <th>ID Producto</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Acciones</th> <!-- Columna para el botón de eliminar -->
                    </tr>
                </thead>
                <%ProductosDAO dao = new ProductosDAO();
               List<Producto> list = dao.ListarProductos();
               Iterator<Producto> iter = list.iterator();
               Producto per = null;
               while (iter.hasNext()) {                       
                       per=iter.next();

                %> 
                <tbody>
                        <tr>
                            <td><%=per.getIdProducto() %></td>
                            <td><%=per.getNombre() %></td>
                            <td><%=per.getDescripcion() %></td>
                            <td><%=per.getPrecio() %></td>
                                                    <td>
                            <!-- Formulario para eliminar el producto -->
                            <form action="${pageContext.request.contextPath}/EliminarProductosServlet" method="post">
                                <input type="hidden" name="id_producto" value="<%= per.getIdProducto()%>" />
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Eliminar
                                </button>
                            </form>
                        </td>
                        </tr>
                  <%}%>
                </tbody>
            </table>
        </div>
        <script>
            function toggleSidebar() {
                const sidebar = document.querySelector('.sidebar');
                sidebar.classList.toggle('hidden');
            }</script>


        <!-- Bootstrap y JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/gestionProducto.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
