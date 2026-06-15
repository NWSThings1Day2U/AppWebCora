<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.ItemCarrito"%>
<%@page import="java.util.ArrayList"%>

<%
ArrayList<ItemCarrito> carrito =(ArrayList<ItemCarrito>) session.getAttribute("carrito");

if(carrito == null){
    carrito = new ArrayList<>();
}

double total = 0;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font de google -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
        <!-- Iconos -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="icon" href="recursos/logo_cora.png">
        <!-- Alertify -->
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>

        <!-- CSS -->
        <link rel="stylesheet" href="estilos/estilos.css">
        <link rel="stylesheet" href="estilos/estiloscarrito.css">
        <link rel="stylesheet" href="estilos/piestilo.css">

    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "carrito");        

        %>
        <!-- header -->        
        <jsp:include page="/componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Tu carrito de compras</h2>
            <div class="content-carrito">
                <div class="row align-items-start">

                    <div class="col-lg-8 mb-4">
                        <div class="table-responsive">
                            <table class="table table-bordered table-carrito custom-table">
                                <thead>
                                    <tr>

                                        <th scope="col">Producto</th>
                                        <th scope="col">Precio</th>
                                        <th scope="col">Cantidad</th>
                                        <th scope="col">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                    if (carrito != null && !carrito.isEmpty()) {
                                        for(ItemCarrito item : carrito){

                                            total += item.getSubtotal();
                                    %>

                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center producto-contenedor">
                                                <a href="controladorcarrito?accion=confirmar_eliminar&idVariante=<%= item.getIdVariante() %>"
                                                    class="btn-eliminar-tacho mx-3">

                                                     <i class="fa-solid fa-trash"></i>

                                                 </a>

                                                <div class="producto-imagen-wrapper me-3">
                                                    <img src="recursos/<%= item.getImagen() %>" class="img-thumbnail producto-img-tabla">
                                                </div>

                                                <div class="producto-detalles">
                                                    <h5 class="producto-nombre"><%= item.getNombre() %></h5>
                                                    <p class="producto-meta mb-1">
                                                        Categoría: <span class="fw-normal text-muted"><%= item.getCategoria() %></span>
                                                    </p>
                                                    <p class="producto-meta mb-1">
                                                        Color: <span class="fw-normal text-muted"><%= item.getColor() %></span>
                                                    </p>
                                                    <p class="producto-meta mb-0">
                                                        Talla: <span class="fw-normal text-muted"><%= item.getTalla() %></span>
                                                    </p>
                                                </div>
                                            </div>
                                        </td>

                                        <td class="align-middle text-center precio-celda">
                                            S/ <%= String.format("%.2f", item.getPrecio()) %>
                                        </td>

                                        <td class="align-middle text-center">
                                            <div class="control-cantidad-box d-flex align-items-center justify-content-between mx-auto">
                                                <a href="controladorcarrito?accion=restar&idVariante=<%= item.getIdVariante() %>"
                                                   class="btn-cantidad-action">−</a>
                                                <span class="txt-cantidad-valor"><%= item.getCantidad() %></span>
                                                <a href="controladorcarrito?accion=sumar&idVariante=<%= item.getIdVariante() %>"
                                                   class="btn-cantidad-action">+</a>
                                            </div>
                                        </td>

                                        <td class="align-middle text-center subtotal-celda fw-semibold">
                                            S/ <%= String.format("%.2f", item.getSubtotal()) %>
                                        </td>
                                    </tr>
                                    
                                    <%      }
                                    %>
                                    <tr class="row-total">
                                        <td colspan="3"
                                            class="text-end fw-semibold text-total-lbl">
                                            Importe a pagar:
                                        </td>

                                        <td class="text-center fw-semibold text-total-val">
                                            S/ <%= String.format("%.2f", total) %>
                                        </td>
                                    </tr>
                                    <%    }
                                        else {
                                    %>
                                    <tr>
                                        <td colspan="4" class="text-center text-muted">Carrito vacio, agrega productos al carrito.</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    
                                    

                                </tbody>
                            </table>
                        </div>

                       <%
                            if (carrito != null && !carrito.isEmpty()) {
                        %>

                        <div class="d-flex justify-content-center gap-4 mt-5 container-botones">

                            <a
                                href="controladorcarrito?accion=confirmar_vaciar"
                                class="btn btn-carrito-action">

                                Vaciar lista

                            </a>

                            <a
                                href="controladorcarrito?accion=finalizar"
                                class="btn btn-carrito-action">

                                Finalizar compra

                            </a>

                        </div>

                        <%
                            } else {
                        %>

                        <div class="text-center mt-4">

                            <a href="controladorproducto?accion=listar"
                               class="btn btn-carrito-action">

                                Ir a comprar

                            </a>

                        </div>

                        <%
                            }
                        %>
                    </div>

                    <div class="col-lg-4 text-center text-lg-end container-foto-caja">
                        <img src="recursos/caja.jpg" alt="Caja Cora" class="img-fluid foto-maqueta">
                    </div>

                </div>
            </div>
        </main>

        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="../componentes/alertas.jsp" />   
        <jsp:include page="/componentes/pie.jsp" /> 

        <jsp:include page="/componentes/mensajes.jsp" /> 

    </body>
</html>
