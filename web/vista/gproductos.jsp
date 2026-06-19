<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.productodao" %>
<%@ page import="modelo.productos" %>
<%@page import="modelo.categorias"%>
<%@page import="java.util.List"%>
<%
    List<modelo.categorias> listaCategorias = (List<modelo.categorias>) request.getAttribute("listaCategorias");
    List<modelo.productos> lista = (List<modelo.productos>) request.getAttribute("listaProductos");
    if (listaCategorias == null) {
        dao.categoriadao catDao = new dao.categoriadao();
        listaCategorias = catDao.mostrarCategorias();
    }
    if (lista == null) {
        dao.productodao prodDao = new dao.productodao();
        lista = prodDao.listarproductos();
    }
    int totalProductos = 0;
    int productosActivos = 0;
    int productosConDescuento = 0;

    if (lista != null) {
        totalProductos = lista.size();
        for (modelo.productos p : lista) {
            if (p.getEstado() == 1) {
                productosActivos++;
            }
            if (p.getDescuento() > 0) {
                productosConDescuento++;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="icon" href="recursos/logo_cora.png">
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
        <link rel="stylesheet" href="estilos/estilosa.css">
        <link rel="stylesheet" href="estilos/piestilo.css">
    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "productos");
        %>
        <jsp:include page="../componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Listado de Productos (Prendas & Accesorios)</h2>

            <div class="card p-4 border-top-0 rounded-bottom mb-5" style="box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);">
                <div class="d-flex align-items-center gap-2">
                    <form class="d-flex" id="formBuscar" onsubmit="return false;">
                        <div class="input-group">
                            <input class="form-control border-end-0" id="inputTermino" type="search" placeholder="Busca producto...">
                            <button class="input-group-text border-start-0 bg-white" type="button">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </form>

                    <button class="btn btn-primary px-3" data-bs-toggle="modal" data-bs-target="#modalInsertar">
                        <i class="fa-solid fa-box me-2"></i>Nuevo producto
                    </button>
                    
                    <div class="col-12 col-lg-7">
                        <div class="row g-2 justify-content-lg-end">
                            <div class="col-6 col-sm-4" style="max-width: 160px;">
                                <div class="p-2 text-center rounded border bg-light shadow-sm">
                                    <small class="text-muted d-block text-truncate">Total</small>
                                    <span class="fs-5 fw-bold text-dark"><%= totalProductos %></span>
                                </div>
                            </div>
                            <div class="col-6 col-sm-4" style="max-width: 160px;">
                                <div class="p-2 text-center rounded border bg-success-subtle shadow-sm">
                                    <small class="text-success d-block text-truncate">Activos</small>
                                    <span class="fs-5 fw-bold text-success"><%= productosActivos %></span>
                                </div>
                            </div>
                            <div class="col-6 col-sm-4" style="max-width: 160px;">
                                <div class="p-2 text-center rounded border bg-warning-subtle shadow-sm">
                                    <small class="text-warning-emphasis d-block text-truncate">Descuentos</small>
                                    <span class="fs-5 fw-bold text-warning-emphasis"><%= productosConDescuento %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm p-4">
                <div class="card-body">
                    <h4 class="mb-4 mt-4">Tabla productos</h4>
                    <div class="table-responsive text-center">
                        <table class="table table-hover table-bordered" id="tablaProductos">
                            <thead class="text-center" style="--bs-table-bg: #F5ECE1;">
                                <tr>
                                    <th>Id Producto</th>
                                    <th>Nombre</th>
                                    <th>Descripcion</th>
                                    <th>Imagen</th>
                                    <th>Categoria</th>
                                    <th>Stock Min.</th>
                                    <th>Descuento</th>
                                    <th>Estado</th>
                                    <th>Accion</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (lista == null || lista.isEmpty()) {
                                %>
                                <tr class="fila-producto no-registros">
                                    <td colspan="9" class="text-center text-muted">No hay registros de productos disponibles</td> 
                                </tr>
                                <%
                                    } else {
                                        for(productos prods: lista){
                                %>
                                <tr class="align-middle fila-producto" data-nombre="<%= prods.getNombre().toLowerCase() %>">
                                    <th scope="row" class="text-center"><%=prods.getId_producto()%></th>
                                    <td class="celda-nombre"><%=prods.getNombre()%></td>
                                    <td><%=prods.getDescripcion()%></td>
                                    <td class="text-center">
                                        <img src="recursos/<%= (prods.getImagen() != null && !prods.getImagen().isEmpty()) ? prods.getImagen() : "productos.jpg" %>" 
                                             alt="<%= prods.getNombre() %>" 
                                             width="60" 
                                             height="60" 
                                             style="object-fit: cover;" 
                                             class="rounded border shadow-sm">
                                    </td>
                                    <td><%=prods.getNombre_categoria()%></td>
                                    <td><%=prods.getStock_min()%></td>
                                    <td><%=prods.getDescuento()%></td>
                                    <td><%= (prods.getEstado() == 1) ? "Activo" : "Inactivo" %></td>
                                    <td>
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <a href="controladorproducto?accion=detalleproducto&id_producto=<%=prods.getId_producto()%>" class="btn btn-info btn-sm">
                                                <i class="fa-solid fa-eye"></i>
                                            </a>
                                            <button type="button" class="btn btn-warning btn-sm" onclick="prepararEditarProducto('<%= prods.getId_producto() %>', '<%= prods.getNombre().replace("'", "\\'") %>', '<%= prods.getDescripcion().replace("'", "\\'") %>', '<%= prods.getId_categoria() %>', '<%= prods.getStock_min() %>', '<%= prods.getDescuento() %>', '<%= prods.getImagen() %>', '<%= prods.getEstado() %>')">
                                                <i class="fa-solid fa-pencil"></i>
                                            </button>
                                            <button type="button" class="btn btn-danger btn-sm me-md-2" onclick="prepararEliminarProducto('<%= prods.getId_producto() %>')">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                                <tr id="sinResultados" style="display: none;">
                                    <td colspan="9" class="text-center text-muted p-4">No se encontraron productos que coincidan con la búsqueda.</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalInsertar" tabindex="-1" aria-labelledby="modalInsertarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalInsertarLabel">
                                <i class="fa-solid fa-box me-2"></i>Agregar Nuevo Producto
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formInsertarProducto" action="controladorproducto" method="POST" enctype="multipart/form-data" class="needs-validation" novalidate>
                                <input type="hidden" name="accion" value="guardar">
                                <div class="mb-3">
                                    <label for="nombreProducto" class="form-label">Nombre del Producto</label>
                                    <input type="text" class="form-control" id="nombreProducto" name="nombre" placeholder="Ej: Casaca patron mariposa" required minlength="3">
                                    <div class="invalid-feedback">Por favor, ingrese un nombre válido (mínimo 3 caracteres).</div>
                                </div>
                                <div class="mb-3">
                                    <label for="descripcionProducto" class="form-label">Descripción</label>
                                    <textarea class="form-control" id="descripcionProducto" name="descripcion" rows="3" placeholder="Breve descripción..." required></textarea>
                                    <div class="invalid-feedback">La descripción es obligatoria.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="imagenProducto" class="form-label">Imagen</label>
                                    <input type="file" class="form-control" id="imagenProducto" name="imagen" accept="image/*">
                                    <div class="form-text">Si no selecciona ninguna, se asignará una por defecto.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="nombreCategoria" class="form-label">Categoría</label>
                                    <select class="form-select" id="nombreCategoria" name="id_categoria" required>
                                        <option value="" selected disabled>Seleccione la categoría</option>
                                        <%
                                            if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                                for(modelo.categorias cat : listaCategorias) {
                                        %>
                                        <option value="<%= cat.getId_categoria() %>"><%= cat.getNombre() %></option>
                                        <%
                                                }
                                            } else {
                                        %>
                                        <option value="" disabled>No se cargaron categorías del servidor</option>
                                        <%
                                            }
                                        %>
                                    </select>
                                    <div class="invalid-feedback">Debe seleccionar una categoría de la lista.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="stockminProducto" class="form-label">Stock Mínimo</label>
                                    <input type="number" class="form-control" id="stockminProducto" name="stockminimo" min="0" required>
                                    <div class="invalid-feedback">El stock mínimo debe ser 0 o superior.</div>
                                </div>
                                <div class="mb-3">
                                    <label for="desProducto" class="form-label">Descuento</label>
                                    <div class="input-group has-validation">
                                        <input type="number" step="0.01" class="form-control" id="desProducto" name="descuento" min="0" max="100" value="0.00" required>
                                        <span class="input-group-text">%</span>
                                        <div class="invalid-feedback">Establezca un descuento válido entre 0 y 100.</div>
                                    </div>
                                </div>
                            </form> 
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" form="formInsertarProducto" class="btn btn-primary">Guardar Producto</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="modalEditarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <form id="formEditarProducto" action="controladorproducto" method="POST" enctype="multipart/form-data" class="modal-content needs-validation" novalidate>
                        <input type="hidden" name="accion" value="editar">
                        <input type="hidden" name="imagenActual" id="edit_imagen_actual">
                        <input type="hidden" name="id_producto" id="edit_id_producto"> 
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalEditarLabel">Editar Producto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="edit_nombre" class="form-label">Nombre del Producto</label>
                                <input type="text" class="form-control" id="edit_nombre" name="nombre" required minlength="3">
                                <div class="invalid-feedback">Por favor, ingrese un nombre válido (mínimo 3 caracteres).</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_descripcion" class="form-label">Descripción</label>
                                <textarea class="form-control" id="edit_descripcion" name="descripcion" rows="3" required></textarea>
                                <div class="invalid-feedback">La descripción es obligatoria.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_categoria" class="form-label">Categoría</label>
                                <select class="form-select" id="edit_categoria" name="id_categoria" required>
                                    <% if (listaCategorias != null) { 
                                        for(modelo.categorias cat : listaCategorias) { %>
                                        <option value="<%= cat.getId_categoria() %>"><%= cat.getNombre() %></option>
                                    <% } } %>
                                </select>
                                <div class="invalid-feedback">Debe seleccionar una categoría de la lista.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_stockmin" class="form-label">Stock Mínimo</label>
                                <input type="number" class="form-control" id="edit_stockmin" name="stockminimo" min="0" required>
                                <div class="invalid-feedback">El stock mínimo debe ser 0 o superior.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_descuento" class="form-label">Descuento</label>
                                <div class="input-group has-validation">
                                    <input type="number" step="0.01" class="form-control" id="edit_descuento" name="descuento" min="0" max="100" required>
                                    <span class="input-group-text">%</span>
                                    <div class="invalid-feedback">Establezca un descuento válido entre 0 y 100.</div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_imagen" class="form-label">Cambiar Imagen (Opcional)</label>
                                <input type="file" class="form-control" id="edit_imagen" name="imagen" accept="image/*">
                            </div>
                            <div class="mb-3">
                                <label for="edit_estado" class="form-label">Estado del Producto</label>
                                <select class="form-select" id="edit_estado" name="estado" required>
                                    <option value="1">Activo</option>
                                    <option value="0">Inactivo</option>
                                </select>
                            </div>  
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <form action="controladorproducto" method="POST" class="modal-content">
                        <input type="hidden" name="accion" value="eliminar">
                        <input type="hidden" name="id_producto" id="delete_id_producto">
                        <div class="modal-header">
                            <h5 class="modal-title">Eliminar Producto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            ¿Deseas eliminar el producto con ID: <strong id="lbl_delete_prod_id"></strong>?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-danger">Eliminar</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/pie.jsp" /> 
        <jsp:include page="/componentes/alertas.jsp" />   
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var forms = document.querySelectorAll('.needs-validation');
                Array.prototype.slice.call(forms).forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });

                // --- SISTEMA DE FILTRADO DINÁMICO EN TIEMPO REAL ---
                const inputBusqueda = document.getElementById('inputTermino');
                const filasProductos = document.querySelectorAll('.fila-producto:not(.no-registros)');
                const filaSinResultados = document.getElementById('sinResultados');

                if (inputBusqueda) {
                    inputBusqueda.addEventListener('input', function () {
                        const termino = this.value.toLowerCase().trim();
                        let coincidencias = 0;

                        filasProductos.forEach(fila => {
                            const nombreProducto = fila.getAttribute('data-nombre');
                            if (nombreProducto.includes(termino)) {
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

            function prepararEditarProducto(idProducto, nombre, descripcion, idCategoria, stockMin, descuento, imagen, estado) {
                var formEditar = document.getElementById('formEditarProducto');
                if (formEditar) {
                    formEditar.classList.remove('was-validated');
                }

                document.getElementById('edit_id_producto').value = idProducto;
                document.getElementById('edit_nombre').value = nombre;
                document.getElementById('edit_descripcion').value = descripcion;
                document.getElementById('edit_categoria').value = idCategoria;
                document.getElementById('edit_stockmin').value = stockMin;
                document.getElementById('edit_descuento').value = descuento;
                document.getElementById('edit_imagen_actual').value = imagen;
                document.getElementById('edit_estado').value = estado;

                var modal = new bootstrap.Modal(document.getElementById('modalEditar'));
                modal.show();
            }

            function prepararEliminarProducto(idProducto) {
                document.getElementById('delete_id_producto').value = idProducto;
                document.getElementById('lbl_delete_prod_id').innerText = idProducto;

                var modal = new bootstrap.Modal(document.getElementById('modalEliminar'));
                modal.show();
            }
        </script>
    </body>
</html>