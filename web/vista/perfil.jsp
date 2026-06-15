<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

            <div class="row g-4">
                <div class="col-md-8">
                    <h3 class="mb-3">Mis pedidos</h3>
                    <div class="table-responsive bg-white p-3 rounded shadow-sm">
                        <table class="table table-bordered align-middle text-center" style="border-color: #f3dcd4;">
                            <thead style="background-color: #fbf3f0;">
                                <tr>
                                    <th>Id transacción</th>
                                    <th>Dirección de entrega</th>
                                    <th>Monto total</th>
                                    <th>Costo del delivery</th>
                                    <th>Tipo de entrega</th>
                                    <th>Fecha de pedido</th>
                                    <th>Método de pago</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Lima, VES.</td>
                                    <td>300</td>
                                    <td>10</td>
                                    <td>delivery</td>
                                    <td><span class="badge bg-secondary-subtle text-dark">5/4/2026</span></td>
                                    <td>efectivo</td>
                                    <td><span class="text-warning fw-bold">Pendiente</span></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>física</td>
                                    <td>405</td>
                                    <td>Sin costo</td>
                                    <td>tienda</td>
                                    <td><span class="badge bg-secondary-subtle text-dark">9/9/2026</span></td>
                                    <td>yape</td>
                                    <td><span class="text-success fw-bold">Completado</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card p-4 text-center border-0 shadow-sm rounded-4 bg-white">
                        <c:set var="fotoPerfil" value="${empty sessionScope.imagen ? 'cuenta.jpg' : sessionScope.imagen}" />
                        <img src="${pageContext.request.contextPath}/recursos/${fotoPerfil}" 
                             class="img-fluid rounded-3 mb-3 mx-auto" alt="Foto de perfil" 
                             style="object-fit: cover; width: 100%; max-height: 220px;">
                        
                        <div class="text-start mb-3">
                            <label class="form-label fw-semibold text-muted small">Usuario</label>
                            <div class="form-control bg-light border-0 rounded-pill ps-3">${datosUsuario.nombreusuario}</div>
                        </div>

                        <div class="text-start mb-4">
                            <label class="form-label fw-semibold text-muted small">Correo Electrónico</label>
                            <div class="form-control bg-light border-0 rounded-pill ps-3">${datosUsuario.correo}</div>
                        </div>

                    </div>
                </div>
            </div>
        </main>

        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/pie.jsp" /> 

        <jsp:include page="/componentes/mensajes.jsp" /> 
    </body>
</html>