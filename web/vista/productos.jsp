<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.productodao" %>
<%@ page import="modelo.productos" %>
<%@page import="modelo.categorias"%>
<%@page import="java.util.List"%>
<%
    List<modelo.categorias> listaCategorias = (List<modelo.categorias>) request.getAttribute("listaCategorias");
    List<modelo.productos> lista = (List<modelo.productos>) request.getAttribute("listaProductos");
    String categoriaSeleccionada = request.getParameter("id_categoria");
    if(categoriaSeleccionada == null){
        categoriaSeleccionada = "todos";
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Productos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="icon" href="recursos/logo_cora.png">
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>

        <link class="stylesheet" rel="stylesheet" href="estilos/estilos.css">
        <link rel="stylesheet" href="estilos/piestilo.css">
        <link rel="stylesheet" href="estilos/estilosprod.css">
    </head>
    <body class="productos-body">
        <% request.setAttribute("paginaActual", "productos"); %>

        <jsp:include page="/componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center titulo-principal">Nuestro Catálogo de Productos</h2>

            <div class="row">
                <aside class="sidebar col-md-2">
                    <h3>Categorías</h3>
                    <ul class="lista-categorias">

                        <li>
                            <a href="#" class="filtro-btn <%= categoriaSeleccionada.equals("todos") ? "active" : "" %>" data-categoria="todos">
                                Todos
                            </a>
                        </li>

                        <% for(categorias cat : listaCategorias) { %>
                        <%
                            int cantidad = 0;

                            for(productos p : lista){
                                if(p.getId_categoria() == cat.getId_categoria()){
                                    cantidad++;
                                }
                            }
                        %>

                        <li>
                            <a href="#"
                                class="filtro-btn <%= categoriaSeleccionada.equals(String.valueOf(cat.getId_categoria())) ? "active" : "" %>"
                                data-categoria="<%= cat.getId_categoria() %>">

                                <%= cat.getNombre() %> (<%= cantidad %>)

                            </a>
                        </li>
                        <% } %>

                    </ul>
                </aside>

                <section class="col-md-10">
                    <div class="d-flex justify-content-end mb-4">
                        <div class="dropdown-ordenar">
                            <select class="form-select select-ordenar" id="select-ordenar">
                                <option value="predeterminado" selected>Orden Predeterminado</option>
                                <option value="barato">Precio: Menor a Mayor</option>
                                <option value="caro">Precio: Mayor a Menor</option>
                            </select>
                        </div>
                    </div>

                    <div class="row row-cols-1 row-cols-md-3 g-4 ps-5 pt-2" id="contenedor-productos">
                        <% 
                        int index = 0;
                        for(productos prods: lista){ 
                            index++;
                        %>
                        <div class="col producto-item"
                             data-categoria="<%= prods.getId_categoria() %>"
                             data-precio="<%= prods.getPrecio() %>"
                             data-orden="<%= index %>">
                            <div class="card h-100">
                                <div class="card-img-container">
                                    <img src="recursos/<%= (prods.getImagen() != null && !prods.getImagen().isEmpty()) ? prods.getImagen() : "productos.jpg" %>" 
                                         alt="<%= prods.getNombre() %>" 
                                         style="object-fit: cover;" 
                                         class="card-img-top">
                                </div>
                                <div class="card-body d-flex justify-content-between align-items-end">
                                    <div class="info-meta">
                                        <h5 class="card-title"><%=prods.getNombre()%></h5>
                                        <strong class="precio-texto">Desde S/<%=prods.getPrecio()%></strong>
                                    </div>
                                        <a href="controladorproducto?accion=detalleproducto&id_producto=<%=prods.getId_producto()%>&id_categoria=<%=prods.getId_categoria()%>" style="text-decoration: none;">                                    
                                        <button class="btn-ojo-ver" title="Ver producto">
                                            <i class="fa-regular fa-eye"></i>
                                        </button>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </section>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/pie.jsp" /> 
        <jsp:include page="/componentes/mensajes.jsp" /> 

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const contenedor = document.getElementById("contenedor-productos");
                const botonesFiltro = document.querySelectorAll(".filtro-btn");
                const selectOrdenar = document.getElementById("select-ordenar");
                let productos = Array.from(document.querySelectorAll(".producto-item"));

                let categoriaActual = "todos";

                botonesFiltro.forEach(boton => {
                    boton.addEventListener("click", (e) => {
                        e.preventDefault();

                        botonesFiltro.forEach(btn => btn.classList.remove("active"));
                        boton.classList.add("active");

                        categoriaActual = boton.getAttribute("data-categoria");
                        aplicarFiltrosYOrden();
                    });
                });

                selectOrdenar.addEventListener("change", () => {
                    aplicarFiltrosYOrden();
                });

                function aplicarFiltrosYOrden() {
                    productos.forEach(producto => {

                        const categoriaProducto =
                                producto.getAttribute("data-categoria");

                        if (
                                categoriaActual === "todos" ||
                                categoriaProducto === categoriaActual
                                ) {

                            producto.style.display = "block";

                        } else {

                            producto.style.display = "none";

                        }
                    });

                    // --- ORDENAMIENTO POR PRECIO ---
                    const metodoOrden = selectOrdenar.value;

                    productos.sort((a, b) => {
                        const precioA = parseFloat(a.getAttribute("data-precio"));
                        const precioB = parseFloat(b.getAttribute("data-precio"));
                        const ordenA = parseInt(a.getAttribute("data-orden"));
                        const ordenB = parseInt(b.getAttribute("data-orden"));

                        if (metodoOrden === "barato") {
                            return precioA - precioB;
                        } else if (metodoOrden === "caro") {
                            return precioB - precioA;
                        } else {
                            return ordenA - ordenB;
                        }
                    });

                    productos.forEach(producto => {
                        contenedor.appendChild(producto);
                    });
                }
                
                categoriaActual = "<%= categoriaSeleccionada %>";
                aplicarFiltrosYOrden();

                document.querySelectorAll(".filtro-btn").forEach(btn => {
                    if (btn.dataset.categoria === categoriaActual) {
                        btn.classList.add("active");
                    } else {
                        btn.classList.remove("active");
                    }
                });
            });
        </script>
    </body>
</html>