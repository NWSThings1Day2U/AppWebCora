<%-- 
    Document   : productodetalle
    Created on : 12 jun. 2026, 1:01:06 a. m.
    Author     : USUARIO
    Vista: cliente
--%>
<%@page import="modelo.productos"%>
<%@page import="java.util.ArrayList"%>

<%
productos producto = (productos) request.getAttribute("producto");

ArrayList<productos> variantes = (ArrayList<productos>) request.getAttribute("variantes");
String idCategoria = request.getParameter("id_categoria");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Producto: <%= producto.getNombre() %></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="icon" href="recursos/logo_cora.png">
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
        <link rel="stylesheet" href="estilos/estilosprodcliente.css">
        <link class="stylesheet" rel="stylesheet" href="estilos/estilos.css">
        <link rel="stylesheet" href="estilos/piestilo.css">
        
    </head>
    <body>
        <% request.setAttribute("paginaActual", "productos"); %>

        <jsp:include page="/componentes/encabezado.jsp" />
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;">
            
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center align-items-start gap-3 mb-5 pb-3 border-bottom-cora">
                <h2 class="m-0 text-start titulo-principal-custom">
                    <span class="marca-titulo"><i class="fa-brands fa-diaspora me-2"></i>Producto:</span> <%= producto.getNombre() %>
                </h2>
                
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb m-0 breadcrumb-custom">
                        <li class="breadcrumb-item"><a href="controladorproducto?accion=listar">Catálogo</a></li>
                        <li class="breadcrumb-item">
                            <a href="controladorproducto?accion=listar&id_categoria=<%= idCategoria %>">
                                <%= producto.getNombre_categoria() %>
                            </a>
                        </li>
                        <li class="breadcrumb-item active" style="font-weight: bold;color: #D18F89 !important;" aria-current="page"><%= producto.getNombre() %></li>
                    </ol>
                </nav>
            </div>

            <div class="tarjeta-producto-custom p-4 p-md-5">
                <div class="row g-4 align-items-center">
                    
                    <div class="col-md-5 text-center">
                        <img
                            src="recursos/<%= (producto.getImagen() != null && !producto.getImagen().isEmpty()) ? producto.getImagen() : "productos.jpg" %>" 
                            alt="<%= producto.getNombre() %>" 
                            class="img-producto-custom">
                    </div>

                    <div class="col-md-7">
                        <form id="formAgregarCarrito" action="controladorcarrito" method="POST">
                            <input type="hidden" name="accion" value="agregar">
                            <input type="hidden" name="id_variante" id="idVarianteSeleccionada">
                            <div class="row g-3">
                                
                                <div class="col-sm-6">
                                    <label class="label-custom">Nombre completo:</label>
                                    <div class="input-falso-custom text-capitalize">
                                        <%= producto.getNombre() %>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <label class="label-custom">Precio:</label>
                                    <div class="input-falso-custom fw-bold precio-destacado" id="precioProducto">
                                        S/ <%= variantes.get(0).getPrecio() %>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <label for="selectColor" class="label-custom">Color:</label>
                                    <div class="select-wrapper-custom">
                                        <select id="selectColor" class="form-select select-custom" required>
                                            <option value="" disabled selected>Elegir color</option>
                                            <%
                                            java.util.HashSet<String> colores = new java.util.HashSet<>();
                                            for(productos v : variantes){
                                                if(!colores.contains(v.getColor())){
                                                    colores.add(v.getColor());
                                            %>
                                            <option value="<%= v.getColor() %>"><%= v.getColor() %></option>
                                            <%
                                                }
                                            }
                                            %>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <label for="selectTalla" class="label-custom">Talla:</label>
                                    <div class="select-wrapper-custom">
                                        <select id="selectTalla" name="talla" class="form-select select-custom" required disabled>
                                            <option value="" disabled selected>Selecciona primero un color</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <label class="label-custom">Categoría:</label>
                                    <div class="input-falso-custom text-capitalize">
                                        <%= producto.getNombre_categoria() %>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <label for="inputCantidad" class="label-custom">Cantidad:</label>
                                    <input type="number" id="inputCantidad" name="cantidad" class="form-control input-cantidad-custom" value="1" min="1" required>
                                </div>

                                <div class="col-12 mt-4">
                                    <label class="label-custom">Descripción:</label>
                                    <div class="descripcion-box-custom">
                                        <%= producto.getDescripcion() %>
                                    </div>
                                </div>

                                <div class="col-12 text-center mt-4">
                                    <button type="submit" class="btn btn-agregar-custom">
                                       <i class="fa-solid fa-cart-plus me-2"></i> Agregar a carrito 
                                    </button>
                                </div>

                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </main>

                                    
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/pie.jsp" />         
        <jsp:include page="/componentes/alertas.jsp" />   
        <script>
        const variantes = [
            <% for(int i=0; i < variantes.size(); i++) { 
                productos v = variantes.get(i); %>
                {
                    id: "<%= v.getId_variante() %>",
                    color: "<%= v.getColor() %>",
                    talla: "<%= v.getTalla() %>",
                    precio: <%= v.getPrecio() %>
                }<%= (i < variantes.size() - 1) ? "," : "" %>
            <% } %>
        ];

        // Elementos del DOM
        const selectColor = document.getElementById("selectColor");
        const selectTalla = document.getElementById("selectTalla");
        const inputCantidad = document.getElementById("inputCantidad");
        const precioProducto = document.getElementById("precioProducto");

        let precioUnitarioSeleccionado = 0;

        // Función para actualizar la vista de precios totales
        function actualizarPrecio() {
            const cantidad = parseInt(inputCantidad.value) || 1;
            if (precioUnitarioSeleccionado > 0) {
                const precioTotal = precioUnitarioSeleccionado * cantidad;
                precioProducto.innerHTML = "S/ " + precioTotal.toFixed(2);
            } else {
                precioProducto.innerHTML = "S/ 0.00";
            }
        }

        // 2. Evento cuando cambia el COLOR
        selectColor.addEventListener("change", function() {
            const colorSeleccionado = this.value;
            
            selectTalla.innerHTML = '<option value="" disabled selected>Elegir opción</option>';
            selectTalla.disabled = false;
            
            const variantesFiltradas = variantes.filter(v => v.color === colorSeleccionado);
            
            variantesFiltradas.forEach(v => {
                const opt = document.createElement("option");
                opt.value = v.id;
                opt.textContent = v.talla;
                opt.setAttribute("data-precio", v.precio);
                selectTalla.appendChild(opt);
            });

            precioUnitarioSeleccionado = 0;
            actualizarPrecio();
        });

        // 3. Evento cuando cambia la TALLA
        selectTalla.addEventListener("change", function() {
            const opcionElegida = this.options[this.selectedIndex];
            precioUnitarioSeleccionado = parseFloat(opcionElegida.getAttribute("data-precio"));
            
            actualizarPrecio();
        });
        selectTalla.addEventListener("change", function() {

            document.getElementById("idVarianteSeleccionada").value =
                this.value;

        });
        // 4. Evento cuando cambia la CANTIDAD
        inputCantidad.addEventListener("input", function() {
            if (this.value < 1) this.value = 1;
            actualizarPrecio();
        });
        </script>
        
    </body>
</html>
