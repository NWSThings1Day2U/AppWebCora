<%-- 
    Document   : detalleproducto
    Created on : 11 jun. 2026, 11:12:04 p. m.
    Author     : USUARIO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="modelo.productos"%>
<%@ page import="java.util.List" %>
<%@page import="java.util.ArrayList"%>
<%
productos producto = (productos) request.getAttribute("producto");
ArrayList<productos> variantes = (ArrayList<productos>) request.getAttribute("variantes");
%>

<%
int stockNormal = 0;
int stockBajo = 0;
int stockCritico = 0;

if (variantes != null) {

    int limiteBajo = producto.getStock_min() * 2;

    for (productos v : variantes) {

        int stock = v.getStock();

        if (stock <= producto.getStock_min()) {
            stockCritico++;
        }
        else if (stock <= limiteBajo) {
            stockBajo++;
        }
        else {
            stockNormal++;
        }
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle Producto #<%= producto.getId_producto() %></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="icon" href="recursos/logo_cora.png">
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
        <link rel="stylesheet" href="estilos/estilosa.css">
    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "productos");
        %>
        <jsp:include page="../componentes/encabezado.jsp" />
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Detalle del Producto #<%= producto.getId_producto() %></h2>

                <a href="controladorproducto?accion=listar"
                   class="btn btn-secondary">
                    <i class="fa-solid fa-arrow-left"></i>
                    Volver
                </a>
            </div>

            <!-- CABECERA DEL PRODUCTO -->
            <div class="card shadow-sm mb-4">
                <div class="card-body">

                    <div class="row">

                        <div class="col-md-3 text-center">

                            <img
                                 src="recursos/<%= (producto.getImagen() != null && !producto.getImagen().isEmpty()) ? producto.getImagen() : "productos.jpg" %>" 
                                 alt="<%= producto.getNombre() %>" 
                                class="img-fluid rounded border"
                                style="max-height:220px; object-fit:cover;">

                        </div>

                        <div class="col-md-9">

                            <h3><%= producto.getNombre() %></h3>

                            <p class="text-muted">
                                <%= producto.getDescripcion() %>
                            </p>

                            <div class="row mb-3">

                            <div class="col-md-4">
                                <strong>Categoría:</strong><br>
                                <%= producto.getNombre_categoria() %>
                            </div>

                            <div class="col-md-4">
                                <strong>Stock mínimo:</strong><br>
                                <%= producto.getStock_min() %>
                            </div>

                            <div class="col-md-4">
                                <strong>Descuento:</strong><br>
                                <%= producto.getDescuento() %> %
                            </div>

                        </div>

                        <div class="row g-2">

                            <div class="col-md-4">
                                <div class="p-2 text-center rounded border bg-success-subtle shadow-sm">
                                    <small class="text-success d-block">
                                        Variantes Normales
                                    </small>

                                    <span class="fs-5 fw-bold text-success">
                                        <%= stockNormal %>
                                    </span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="p-2 text-center rounded border bg-warning-subtle shadow-sm">
                                    <small class="text-warning-emphasis d-block">
                                        Stock Bajo
                                    </small>

                                    <span class="fs-5 fw-bold text-warning-emphasis">
                                        <%= stockBajo %>
                                    </span>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="p-2 text-center rounded border bg-danger-subtle shadow-sm">
                                    <small class="text-danger d-block">
                                        Stock Crítico
                                    </small>

                                    <span class="fs-5 fw-bold text-danger">
                                        <%= stockCritico %>
                                    </span>
                                </div>
                            </div>

                        </div>

                        </div>

                    </div>

                </div>
            </div>

            <!-- BLOQUE VARIANTES -->

            <div class="card shadow-sm">

                <div class="card-header d-flex justify-content-between align-items-center">

                    <h4 class="mb-0">
                        Variantes Registradas
                    </h4>

                    <button
                        class="btn btn-primary"
                        data-bs-toggle="modal"
                        data-bs-target="#modalAgregarVariante">

                        <i class="fa-solid fa-boxes-stacked"></i>
                        Nueva Variante

                    </button>

                </div>

                <div class="card-body">

                    <div class="table-responsive">

                        <table class="table table-hover table-bordered text-center">

                            <thead style="--bs-table-bg: #F5ECE1;">

                                <tr>
                                    <th>ID</th>
                                    <th>Color</th>
                                    <th>Talla</th>
                                    <th>Stock</th>
                                    <th>Precio</th>
                                    <th>Acciones</th>
                                </tr>

                            </thead>

                            <tbody>

                                <% if(variantes == null || variantes.isEmpty()) { %>

                                <tr>
                                    <td colspan="6">
                                        No existen variantes registradas.
                                    </td>
                                </tr>

                                <% } else {

                                    for(productos v : variantes){
                                %>

                                <tr>

                                    <td><%= v.getId_variante() %></td>

                                    <td><%= v.getColor() %></td>

                                    <td><%= v.getTalla() %></td>

                                    <td><%= v.getStock() %></td>

                                    <td>S/ <%= v.getPrecio() %></td>

                                    <td>

                                        <button
                                            class="btn btn-warning btn-sm"
                                            onclick="editarVariante(
                                                    '<%= v.getId_variante() %>',
                                                    '<%= v.getColor() %>',
                                                    '<%= v.getTalla() %>',
                                                    '<%= v.getStock() %>',
                                                    '<%= v.getPrecio() %>'
                                                    )">

                                            <i class="fa-solid fa-pencil"></i>

                                        </button>

                                        <button
                                            class="btn btn-danger btn-sm"
                                            onclick="eliminarVariante(
                                                    '<%= v.getId_variante() %>'
                                                    )">

                                            <i class="fa-solid fa-trash"></i>

                                        </button>

                                    </td>

                                </tr>

                                <% }} %>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </main>
        <div class="modal fade"
             id="modalAgregarVariante">

            <div class="modal-dialog">

                <form action="controladorproducto"
                      method="post"
                      class="modal-content">

                    <input type="hidden"
                           name="accion"
                           value="guardarVariante">

                    <input type="hidden"
                           name="id_producto"
                           value="<%= producto.getId_producto() %>">

                    <div class="modal-header">

                        <h5 class="modal-title">
                            Nueva Variante
                        </h5>

                        <button type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"></button>

                    </div>

                    <div class="modal-body">

                        <div class="mb-3">
                            <label>Color</label>
                            <input type="text"
                                   name="color"
                                   class="form-control"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label>Talla</label>

                            <select name="talla"
                                    class="form-select"
                                    required>

                                <option value="">Seleccione</option>
                                <option>S</option>
                                <option>M</option>
                                <option>L</option>
                                <option>XL</option>
                                <option>Unico</option>

                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Stock</label>
                            <input type="number"
                                   name="stock"
                                   class="form-control"
                                   min="0"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label>Precio</label>
                            <input type="number"
                                   name="precio"
                                   class="form-control"
                                   step="0.01"
                                   min="0"
                                   required>
                        </div>

                    </div>

                    <div class="modal-footer">

                        <button type="button"
                                class="btn btn-secondary"
                                data-bs-dismiss="modal">

                            Cancelar

                        </button>

                        <button type="submit"
                                class="btn btn-primary">

                            Guardar

                        </button>

                    </div>

                </form>

            </div>

        </div>
        <div class="modal fade"
             id="modalEditarVariante">

            <div class="modal-dialog">

                <form action="controladorproducto"
                      method="post"
                      class="modal-content">

                    <input type="hidden"
                           name="accion"
                           value="editarVariante">

                    <input type="hidden"
                           name="id_producto"
                           value="<%= producto.getId_producto() %>">

                    <input type="hidden"
                           id="edit_id_variante"
                           name="id_variante">

                    <div class="modal-header">
                        <h5>Editar Variante</h5>
                        <button type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">

                        <div class="mb-3">
                            <label>Color</label>
                            <input type="text"
                                   id="edit_color"
                                   name="color"
                                   class="form-control">
                        </div>

                        <div class="mb-3">
                            <label>Talla</label>

                            <select id="edit_talla"
                                    name="talla"
                                    class="form-select">

                                <option>S</option>
                                <option>M</option>
                                <option>L</option>
                                <option>XL</option>
                                <option>Unico</option>

                            </select>

                        </div>

                        <div class="mb-3">
                            <label>Stock</label>
                            <input type="number"
                                   id="edit_stock"
                                   name="stock"
                                   class="form-control">
                        </div>

                        <div class="mb-3">
                            <label>Precio</label>
                            <input type="number"
                                   id="edit_precio"
                                   name="precio"
                                   step="0.01"
                                   class="form-control">
                        </div>

                    </div>

                    <div class="modal-footer">

                        <button type="submit"
                                class="btn btn-primary">

                            Guardar Cambios

                        </button>

                    </div>

                </form>

            </div>

        </div>
        <div class="modal fade"
             id="modalEliminarVariante">

            <div class="modal-dialog">

                <form action="controladorproducto"
                      method="post"
                      class="modal-content">

                    <input type="hidden"
                           name="accion"
                           value="eliminarVariante">

                    <input type="hidden"
                           name="id_producto"
                           value="<%= producto.getId_producto() %>">

                    <input type="hidden"
                           id="delete_id_variante"
                           name="id_variante">

                    <div class="modal-header">

                        <h5>Eliminar Variante</h5>

                        <button type="button"
                                class="btn-close"
                                data-bs-dismiss="modal"></button>

                    </div>

                    <div class="modal-body">

                        ¿Desea eliminar esta variante con id #<%= producto.getId_producto() %> ?

                    </div>

                    <div class="modal-footer">

                        <button type="submit"
                                class="btn btn-danger">

                            Eliminar

                        </button>

                    </div>

                </form>

            </div>

        </div>
        <script>
            function editarVariante(id, color, talla, stock, precio) {

                document.getElementById("edit_id_variante").value = id;
                document.getElementById("edit_color").value = color;
                document.getElementById("edit_talla").value = talla;
                document.getElementById("edit_stock").value = stock;
                document.getElementById("edit_precio").value = precio;

                new bootstrap.Modal(document.getElementById("modalEditarVariante")).show();
            }

            function eliminarVariante(id) {

                document.getElementById( "delete_id_variante" ).value = id;

                new bootstrap.Modal( document.getElementById("modalEliminarVariante")).show();
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>        
        <jsp:include page="/componentes/alertas.jsp" />   
    </body>
</html>
