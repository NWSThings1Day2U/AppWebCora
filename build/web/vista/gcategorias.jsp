<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="modelo.categorias"%>
<%@page import="java.util.List"%>

<%
    List<categorias> listaCategorias = (List<categorias>) request.getAttribute("listaCategorias");
    int totalCategorias = 0;

    if (listaCategorias != null) {
        totalCategorias = listaCategorias.size();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion Categorias</title>
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
            request.setAttribute("paginaActual", "categorias");
        %>
        <jsp:include page="../componentes/encabezado.jsp" />
        
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Listado de Categorias</h2>

            <div class="card p-4 border-top-0 rounded-bottom mb-5" style="box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);">
                <div class="d-flex align-items-center gap-2">

                    <form class="d-flex" id="formBuscar" onsubmit="return false;">
                        <div class="input-group">
                            <input class="form-control border-end-0"
                                   id="inputTermino"
                                   type="search"
                                   placeholder="Busca categoría...">

                            <button class="input-group-text border-start-0 bg-white"
                                    type="button">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </form>

                    <button class="btn btn-primary px-3"
                            data-bs-toggle="modal"
                            data-bs-target="#modalInsertar">
                        <i class="fa-solid fa-tags me-2"></i>Nueva categoría
                    </button>

                    <div class="col-12 col-lg-7">
                        <div class="row g-2 justify-content-lg-end">

                            <div class="col-6 col-sm-4" style="max-width: 180px;">
                                <div class="p-2 text-center rounded border bg-light shadow-sm">
                                    <small class="text-muted d-block">
                                        Total Categorías
                                    </small>

                                    <span class="fs-5 fw-bold text-dark">
                                        <%= totalCategorias %>
                                    </span>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
            
            <div class="card shadow-sm p-4">
                <div class="card-body">
                    <h4 class="mb-4 mt-4">Tabla categorias</h4>

                    <table class="table table-hover table-bordered">
                        <thead class="text-center" style="--bs-table-bg: #F5ECE1;">
                            <tr>
                                <th>Id Categoria</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Imagen</th>
                                <th>Accion</th>                                    
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                    for (categorias cat : listaCategorias) {
                            %>
                            <tr class="align-middle fila-categoria" data-nombre="<%= cat.getNombre().toLowerCase() %>">
                                <th scope="row" class="text-center"><%= cat.getId_categoria() %></th>
                                <td><%= cat.getNombre() %></td>
                                <td><%= cat.getDescripcion() %></td>
                                <td class="text-center">
                                    <img src="recursos/<%= (cat.getImagen() != null && !cat.getImagen().isEmpty()) ? cat.getImagen() : "categorias.jpg" %>" 
                                         alt="<%= cat.getNombre() %>" 
                                         width="60" 
                                         height="60" 
                                         style="object-fit: cover;" 
                                         class="rounded border shadow-sm">
                                </td>
                                <td class="text-center">
                                    <div class="d-flex flex-wrap justify-content-center gap-2">
                                        
                                        <button type="button" class="btn btn-warning btn-sm" 
                                                onclick="prepararEditar('<%= cat.getId_categoria() %>', '<%= cat.getNombre() %>', '<%= cat.getDescripcion() %>', '<%= cat.getImagen() %>')">
                                            <i class="fa-solid fa-pencil"></i>
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="prepararEliminar('<%= cat.getId_categoria() %>')">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="5" class="text-center text-muted">No se encontraron categorías registradas.</td>
                            </tr>
                            <%
                                }
                            %>
                            <tr id="sinResultados" style="display:none;">
                                <td colspan="5" class="text-center text-muted p-4">
                                    No se encontraron categorías que coincidan con la búsqueda.
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal fade" id="modalInsertar" tabindex="-1" aria-labelledby="modalInsertarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalInsertarLabel"><i class="fa-solid fa-tags me-2"></i>Agregar Nueva Categoría</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formInsertarCategoria" action="controladorcategoria" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="accion" value="insertar">
                                <div class="mb-3">
                                    <label class="form-label">Nombre de la Categoría</label>
                                    <input type="text" class="form-control" name="nombre" placeholder="Ej: Chompa" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Descripción</label>
                                    <textarea class="form-control" name="descripcion" rows="3" placeholder="Breve descripción..." required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Imagen de la Categoría</label>
                                    <input type="file" class="form-control" name="imagen" accept="image/*">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" form="formInsertarCategoria" class="btn btn-primary" style="background-color: #5a67d8; border-color: #5a67d8;">Guardar Categoría</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="modalEditarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <form action="controladorcategoria" method="POST" enctype="multipart/form-data" class="modal-content">
                        <input type="hidden" name="accion" value="editar">
                        <input type="hidden" name="id_categoria" id="edit_id_categoria">
                        <input type="hidden" name="imagenActual" id="edit_imagen_actual">

                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="modalEditarLabel">Editar categoria</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="edit_nombre" class="form-label">Nombre de la Categoría</label>
                                <input type="text" class="form-control" id="edit_nombre" name="nombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="edit_descripcion" class="form-label">Descripción</label>
                                <textarea class="form-control" id="edit_descripcion" name="descripcion" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="edit_imagen" class="form-label">Cambiar Imagen (Opcional)</label>
                                <input type="file" class="form-control" id="edit_imagen" name="imagen" accept="image/*">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary" style="background-color: #5a67d8; border-color: #5a67d8;">Guardar datos</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <form action="controladorcategoria" method="POST" class="modal-content">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id_categoria" id="delete_id_categoria">

                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="modalEliminarLabel">Eliminar categoria</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            ¿Deseas eliminar esta categoria con id: <strong id="lbl_delete_id"></strong>?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-danger">Aceptar</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        
        <jsp:include page="../componentes/alertas.jsp" />   
        <script>
            function prepararEditar(id, nombre, descripcion, imagen) {
                document.getElementById('edit_id_categoria').value = id;
                document.getElementById('edit_nombre').value = nombre;
                document.getElementById('edit_descripcion').value = descripcion;
                document.getElementById('edit_imagen_actual').value = imagen; 
                
                var modal = new bootstrap.Modal(document.getElementById('modalEditar'));
                modal.show();
            }

            function prepararEliminar(id) {
                document.getElementById('delete_id_categoria').value = id;
                document.getElementById('lbl_delete_id').innerText = id;
                
                var modal = new bootstrap.Modal(document.getElementById('modalEliminar'));
                modal.show();
            }
            document.addEventListener('DOMContentLoaded', function () {

                const inputBusqueda = document.getElementById('inputTermino');
                const filasCategorias = document.querySelectorAll('.fila-categoria');
                const filaSinResultados = document.getElementById('sinResultados');

                if (inputBusqueda) {

                    inputBusqueda.addEventListener('input', function () {

                        const termino = this.value.toLowerCase().trim();
                        let coincidencias = 0;

                        filasCategorias.forEach(fila => {

                            const nombre = fila.getAttribute('data-nombre');

                            if (nombre.includes(termino)) {
                                fila.style.display = '';
                                coincidencias++;
                            } else {
                                fila.style.display = 'none';
                            }

                        });

                        if (coincidencias === 0 && termino !== '') {
                            filaSinResultados.style.display = '';
                        } else {
                            filaSinResultados.style.display = 'none';
                        }

                    });

                }

            });
        </script>
    </body>
</html>