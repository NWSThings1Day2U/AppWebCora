<%-- 
    Document   : detallepedido
    Created on : 15 jun. 2026, 3:31:46 a. m.
    Author     : USUARIO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="modelo.pedido"%>
<%@page import="modelo.detallepedido"%>
<%@page import="modelo.totalpedido"%>
<%@page import="java.util.List"%>

<%
pedido pedido = (pedido)request.getAttribute("pedido");
totalpedido total =(totalpedido)request.getAttribute("totalPedido");
List<detallepedido> detalles =(List<detallepedido>)request.getAttribute("detallePedido");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detalle pedido #<%=pedido.getId_pedido()%></title>
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
        <style>

            .card-cora {
                border: 1px solid rgba(93, 84, 75, 0.15);
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
                overflow: hidden;
            }

            .card-header-cora {
                background-color: #F5ECE1 !important;
                border-bottom: 1px solid rgba(93, 84, 75, 0.15);
                color: #5d544b;
            }

            .thead-cora {
                background-color: #5d544b !important;
                color: #ffffff !important;
            }
            
            .table-cora td {
                vertical-align: middle;
            }

            .info-icon-box {
                width: 35px;
                height: 35px;
                background-color: #F5ECE1;
                color: #5d544b;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 8px;
                margin-right: 12px;
            }
        </style>
    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "pedidos");
        %>
        <jsp:include page="../componentes/encabezado.jsp" />
        
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;">
            
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <h2 class="cora-title-main m-0 fs-1">Pedido #<%=pedido.getId_pedido()%></h2>

                <a href="controladorpedido?accion=listar" class="btn btn-secondary">
                    <i class="fa-solid fa-arrow-left me-2"></i> Volver al listado
                </a>
            </div>

            <div class="card card-cora mb-4">
                <div class="card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-md-4 mb-3 mb-md-0 border-end border-light-subtle">
                            <div class="d-flex align-items-center">
                                <div class="info-icon-box"><i class="fa-solid fa-user"></i></div>
                                <div>
                                    <small class="text-muted d-block uppercase fw-semibold" style="font-size: 0.8rem;">Cliente</small>
                                    <strong class="fs-5 text-dark"><%=pedido.getNombreCompleto()%></strong>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3 mb-md-0 border-end border-light-subtle">
                            <div class="d-flex align-items-center">
                                <div class="info-icon-box"><i class="fa-solid fa-calendar-days"></i></div>
                                <div>
                                    <small class="text-muted d-block fw-semibold" style="font-size: 0.8rem;">Fecha de Pedido</small>
                                    <span class="fs-6 text-secondary "><%=pedido.getFecha_pedido()%></span>
                                </div>
                            </div>
                        </div>
                             
                                


                        <div class="col-md-4">
                            <div class="d-flex align-items-end">
                                <div class="info-icon-box"><i class="fa-solid fa-circle-info"></i></div>
                                <div>
                                    <small class="text-muted d-block mb-1 fw-semibold" style="font-size: 0.8rem;">Estado actual</small>
                                    <% 
                                        String estado = pedido.getEstado().toLowerCase();
                                        if(estado.contains("pendiente")) { 
                                    %>
                                        <span class="badge bg-warning-subtle text-warning-emphasis border border-warning px-3 py-2 fs-6 rounded-pill">
                                            Pendiente
                                        </span>
                                    <% } else if(estado.contains("curso") || estado.contains("curso")) { %>
                                        <span class="badge bg-info-subtle text-info border border-info px-3 py-2 fs-6 rounded-pill">
                                             En Proceso
                                        </span>
                                    <% } else if(estado.contains("entregado") || estado.contains("enviado")) { %>
                                        <span class="badge bg-success-subtle text-success border border-success px-3 py-2 fs-6 rounded-pill">
                                            Entregado
                                        </span>
                                    <% } else { %>
                                        <span class="badge bg-secondary-subtle text-secondary-emphasis border border-secondary px-3 py-2 fs-6 rounded-pill">
                                            <%=pedido.getEstado()%>
                                        </span>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                                
                         <div class="col-md-4 mb-3 mb-md-0 border-end border-light-subtle">
                            <div class="d-flex align-items-center">
                                <div class="info-icon-box"><i class="fa-solid fa-calendar-days"></i></div>
                                <div>
                                    <small class="text-muted d-block fw-semibold" style="font-size: 0.8rem;">Entrega estimada</small>
                                    <% if(pedido.getFechaEntregaMin() != null){ %>
                                        <span>
                                            <%= pedido.getFechaEntregaMin() %>
                                            -
                                            <%= pedido.getFechaEntregaMax() %>
                                        </span>
                                    <% } %>
                                </div>
                            </div>
                        </div>          
                    </div>
                </div>
            </div>

            <div class="card card-cora mb-4">
                <div class="card-header card-header-cora py-3">
                    <h4 class="mb-0 fw-bold fs-5"><i class="fa-solid fa-basket-shopping me-2"></i>Artículos Solicitados</h4>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered table-cora text-center mb-0">
                            <thead class="thead-cora">
                                <tr>
                                    <th class="text-start ps-4 py-3">Producto</th>
                                    <th class="py-3">Color</th>
                                    <th class="py-3">Talla</th>
                                    <th class="py-3">Cantidad</th>
                                    <th class="py-3">Precio Unitario</th>
                                    <th class="py-3">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                for(detallepedido d : detalles){
                                %>
                                <tr>
                                    <td class="text-start ps-4 fw-bold text-secondary"><%=d.getNombreProducto()%></td>
                                    <td><span class="badge bg-light text-dark border px-3 py-1.5"><%=d.getColor()%></span></td>
                                    <td><span class="fw-bold text-dark"><%=d.getTalla()%></span></td>
                                    <td class="fw-semibold"><%=d.getCantidad()%></td>
                                    <td class="text-muted">S/. <%=d.getPrecioUnitario()%></td>
                                    <td class="fw-bold text-dark">S/. <%=d.getSubtotal()%></td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row justify-content-end">
                <div class="col-md-5">
                    <div class="card card-cora bg-body-tertiary">
                        <div class="card-body p-4">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="text-muted">Subtotal del Pedido:</span>
                                <span class="fw-semibold text-dark">S/. <%=total.getSubtotal()%></span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted">Costo de Envío (Delivery):</span>
                                <span class="fw-semibold text-dark">S/. <%=pedido.getCosto_delivery()%></span>
                            </div>
                            <hr class="my-2" style="border-color: rgba(93, 84, 75, 0.15);">
                            <div class="d-flex justify-content-between align-items-center mt-2">
                                <h4 class="mb-0 text-dark fw-bold">Total Final:</h4>
                                <h3 class="mb-0 fw-bold" style="color: #5d544b; font-size: 1.85rem;">S/. <%=total.getTotal()%></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/pie.jsp" /> 
        <jsp:include page="/componentes/alertas.jsp" /> 
    </body>
</html>