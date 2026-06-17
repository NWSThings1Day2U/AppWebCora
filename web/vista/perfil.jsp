<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="modelo.pedido"%>
<%@page import="java.util.List"%>
<%
    List<modelo.pedido> misPedidos = (List<pedido>) request.getAttribute("listaMispedidos");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mi Perfil</title>
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
        <link rel="stylesheet" href="estilos/piestilo.css">
    </head>
    <body > 
<%
            request.setAttribute("paginaActual", "perfil");        

        %>
        <!-- header -->        
        <jsp:include page="/componentes/encabezado.jsp" />
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;">
            <h2 class="mb-4 text-center text-dark font-luxurious">Mi Perfil</h2>

            <div class="row g-4 mt-4">
                
                <div class="col-md-8">
                    <div class="card-historia">
                        <h3 class="mb-4 subcora" style="border-bottom: 2px solid #f2dfdd; padding-bottom: 10px;">Mis pedidos</h3>
                        <div class="table-responsive">
                            <table class="table align-middle text-center" style="border-color: #f2dfdd;">
                                <thead style="background-color: #faf8f5; color: #7c6753;">
                                    <tr>
                                        <th>Cód.</th>
                                        <th>Dirección</th>
                                        
                                        <th>Delivery</th>
                                        <th>Tipo</th>
                                        <th>Pago</th>
                                        <th>Estado</th>
                                        <th>Entrega estimada</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    if (misPedidos != null && !misPedidos.isEmpty()) {
                                        for (pedido p : misPedidos) {
                                    %>
                                    <tr style="background-color: #ffffff;">
                                        <td class="fw-bold" style="color: #a68b6d;">#<%=p.getId_pedido()%></td>
                                        <td style="text-transform: capitalize;"><%=p.getDireccion().toLowerCase()%></td>
                                        
                                        <%  
                                            String mensaje = "";
                                            double monto = p.getCosto_delivery();
                                            if (monto == 0) {
                                                mensaje = "<span class='text-muted'>No aplica</span>";
                                            } else {
                                                mensaje = "S/. " + monto;
                                            }
                                        %>
                                        <td><%= mensaje%></td>
                                        <td><%=p.getTipo_entrega()%></td>
                                        
                                        <td>Efectivo</td>
                                        <td>
                                            <%
                                                String est = (p.getEstado() != null) ? p.getEstado().toLowerCase() : "";
                                                String badgeStyle = "";

                                                if (est.equals("pendiente")) badgeStyle = "color: #b8860b; font-weight: bold;"; 
                                                else if (est.equals("curso")) badgeStyle = "color: #a68b6d; font-weight: bold;"; 
                                                else if (est.equals("entregado")) badgeStyle = "color: #556b2f; font-weight: bold;"; 
                                                else if (est.equals("cancelado")) badgeStyle = "color: #B1564E; text-decoration: line-through;"; 
                                            %>
                                            <span style="<%= badgeStyle %> text-transform: capitalize;"><%= est %></span>
                                        </td>
                                        <td>
                                            <% if ("cancelado".equals(est)) { %>
                                                <span style="color: #B1564E; font-weight: bold;">Cancelado</span>

                                            <% } else if ("pendiente".equals(est)) { %>
                                                <span>Por definirse</span>

                                            <% } else if (("curso".equals(est) || "entregado".equals(est)) && p.getFechaEntregaMin() == null) { %>
                                                <span>Sin fecha aún</span>

                                            <% } else if (p.getFechaEntregaMin() != null) { %>
                                                <span>
                                                    <%= p.getFechaEntregaMin() %>
                                                    -
                                                    <%= p.getFechaEntregaMax() %>
                                                </span>

                                            <% } else { %>
                                                <span>Por definirse</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-primary py-2" onclick="abrirDetalle(<%=p.getId_pedido()%>)">
                                                <i class="fa-solid fa-eye"></i>
                                            </button>
                                        </td>

                                    </tr>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">No se encontraron pedidos registrados.</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card-valor text-center">
                        <h3 class="mb-4 subcora" style="border-bottom: 2px solid #f2dfdd; padding-bottom: 10px; text-align: left;">Mis Datos</h3>
                        
                        <c:set var="fotoPerfil" value="${empty sessionScope.imagen ? 'cuenta.jpg' : sessionScope.imagen}" />
                        <img src="${pageContext.request.contextPath}/recursos/${fotoPerfil}" 
                             class="img-fluid rounded-circle mb-4 shadow-sm mx-auto" alt="Foto de perfil" 
                             style="object-fit: cover; width: 140px; height: 140px; border: 3px solid #f2dfdd;">
                        <div class="px-4">
                            <div class="text-start mb-3">
                                <label class="form-label fw-bold" style="color: #7c6753;">Usuario</label>
                                <div class="p-2" style="background-color: #faf8f5; border: 1px solid #dcc8d1;">
                                    ${datosUsuario.nombreusuario}
                                </div>
                            </div>

                            <div class="text-start mb-3">
                                <label class="form-label fw-bold" style="color: #7c6753;">Correo Electrónico</label>
                                <div class="p-2" style="background-color: #faf8f5; border: 1px solid #dcc8d1;">
                                    ${datosUsuario.correo}
                                </div>
                            </div>

                            <div class="text-start mb-4">
                                <label class="form-label fw-bold" style="color: #7c6753;">Teléfono</label>
                                <div class="p-2" style="background-color: #faf8f5; border: 1px solid #dcc8d1;">
                                    ${datosUsuario.telefono}
                                </div>
                            </div>
                        </div>
                        <div class="text-center mt-4 pt-4 px-4 mb-4" style="border-top: 1px dashed #dcc8d1;">
                            <p class="small text-muted mb-3">
                                ¿Deseas cambiar tus datos de perfil? Ponte en contacto con nuestro equipo.
                            </p>
                            <a href="controladorcontacto?accion=listar" class="btn btn-primary w-100 py-2">
                                Contáctanos
                            </a>
                        </div>
                    </div>
                </div>
                
            </div>
             <div class="modal fade" id="modalDetallePedido" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalLabel">Detalles del Pedido</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body" id="modalDetalleBody">
                            </div>
                    </div>
                </div>
            </div>                   
        </main>
         <script>
            function abrirDetalle(idPedido) {
                const modalBody = document.getElementById('modalDetalleBody');
                modalBody.innerHTML = '<div class="text-center p-3">Cargando...</div>';

                const myModal = new bootstrap.Modal(document.getElementById('modalDetallePedido'));
                myModal.show();

                fetch('controladorpedido?accion=detalle&id=' + idPedido)
                    .then(response => response.text())
                    .then(html => {
                        modalBody.innerHTML = html;
                    })
                    .catch(err => {
                        modalBody.innerHTML = '<p class="text-danger">Error al cargar el detalle.</p>';
                    });
            }
        </script>                 
        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/pie.jsp" /> 

        <jsp:include page="/componentes/mensajes.jsp" /> 
    </body>
</html>