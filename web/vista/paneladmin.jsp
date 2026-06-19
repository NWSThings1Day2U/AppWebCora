<%-- 
    Document   : panel
    Created on : 4 may. 2026, 5:24:52 p. m.
    Author     : USUARIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Panel Administrador</title>
        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
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
        <link rel="stylesheet" href="estilos/estilosa.css">
        <link rel="stylesheet" href="estilos/dashboard.css">
        <link rel="stylesheet" href="estilos/piestilo.css">
    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "inicio");        

        %>
        <jsp:include page="../componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Panel de Control General (Dashboard)</h2>
            <div class="container mt-5 pt-4">
                <!-- KPIs -->
                <div class="row g-4 mb-4">

                    <div class="col-lg-3 col-md-6">
                        <div class="card shadow border-0 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted">Ventas Totales</h6>
                                        <h3>S/ ${totalVentas}</h3>
                                    </div>
                                    <i class="bi bi-cash-stack fs-1 text-success"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="card shadow border-0 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted">Pedidos</h6>
                                        <h3>${totalPedidos}</h3>
                                    </div>
                                    <i class="bi bi-cart-check fs-1 text-primary"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="card shadow border-0 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted">Clientes</h6>
                                        <h3>${totalClientes}</h3>
                                    </div>
                                    <i class="bi bi-people-fill fs-1 text-warning"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6">
                        <div class="card shadow border-0 h-100">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="text-muted">Productos</h6>
                                        <h3>${totalProductos}</h3>
                                    </div>
                                    <i class="bi bi-bag-fill fs-1 text-danger"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Graficos -->
                <div class="row g-4 mb-4">

                    <div class="col-lg-8">
                        <div class="card shadow border-0">
                            <div class="card-body">
                                <h5 class="mb-3">Ventas por Mes</h5>
                                <div class="chart-container">
                                    <canvas id="ventasMes"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card shadow border-0">
                            <div class="card-body">
                                <h5 class="mb-3">Estado Pedidos</h5>
                                <div class="chart-container">
                                    <canvas id="estadoPedidos"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Segunda fila -->
                <div class="row g-4 mb-4">

                    <div class="col-lg-6">
                        <div class="card shadow border-0">
                            <div class="card-body">
                                <h5>Categorías Más Vendidas</h5>
                                <div class="chart-container">
                                    <canvas id="categorias"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6">
                        <div class="card shadow border-0">
                            <div class="card-body">
                                <h5>Ventas por Método de Pago</h5>
                                <div class="chart-container" style="padding: 50px;">
                                <canvas id="metodosPago"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Tercera fila -->
                <div class="row g-4 mb-4">

                    <div class="col-lg-6">
                        <div class="card shadow border-0">
                            <div class="card-body">

                                <h5 class="mb-3">
                                    Top 10 Productos Más Vendidos
                                </h5>

                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Producto</th>
                                            <th>Vendidos</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listaProductosVentidos}" var="v">
                                        <tr>
                                            <td>${v.nombreproducto}</td>
                                            <td>${v.vendidos}</td>
                                        </tr>
                                        </c:forEach>
                                        
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card shadow border-0">
                            <div class="card-body">

                                <h5 class="mb-3 text-danger">
                                    Stock Crítico
                                </h5>

                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Producto</th>
                                            <th>Color</th>
                                            <th>Talla</th>
                                            <th>Stock Min</th>
                                            <th>Stock</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach items="${listaStockCritico}" var="s">
                                            <tr>
                                                <td>${s.nombreproducto}</td>
                                                <td>${s.color}</td>
                                                <td>${s.talla}</td>
                                                <td>${s.stock_min}</td>
                                                <td>
                                                    <%-- Lógica para definir la clase del badge --%>
                                                    <c:choose>
                                                        <c:when test="${s.stock <= s.stock_min}">
                                                            <span class="badge bg-danger">${s.stock}</span>
                                                        </c:when>
                                                        <c:when test="${s.stock <= (s.stock_min * 2)}">
                                                            <span class="badge bg-warning text-dark">${s.stock}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success">${s.stock}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>

                                </table>

                            </div>
                        </div>
                    </div>

                </div>

                <!-- Cuarta fila -->
                <div class="row g-4 mb-4">

                    <div class="col-lg-8">

                        <div class="card shadow border-0">

                            <div class="card-body">

                                <h5 class="mb-3">Últimos Pedidos</h5>

                                <table class="table table-hover">

                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Cliente</th>
                                            <th>Fecha</th>
                                            <th>Estado</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach items="${listaUltimosPedidos}" var="d">
                                        <tr>
                                            <td>${d.id_cliente}</td>
                                            <td>${d.cliente}</td>
                                            <td>${d.fecha_estimada}</td>
                                            <td>
                                               <c:choose>
                                                    <%-- Se usa toUpperCase() para que la comparación sea más robusta --%>
                                                    <c:when test="${fn:toUpperCase(d.estado_pedido) == 'CANCELADO'}">
                                                        <span class="badge bg-secondary">Cancelado</span>
                                                    </c:when>
                                                    <c:when test="${fn:toUpperCase(d.estado_pedido) == 'PENDIENTE'}">
                                                        <span class="badge bg-warning text-dark">Pendiente</span>
                                                    </c:when>
                                                    <c:when test="${fn:toUpperCase(d.estado_pedido) == 'CURSO'}">
                                                        <span class="badge bg-primary text-white">En curso</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">Entregado</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${d.total}</td>
                                        </tr>

                                        </c:forEach>
                                    </tbody>

                                </table>

                            </div>

                        </div>

                    </div>

                    <div class="col-lg-4">

                        <div class="card shadow border-0">

                            <div class="card-body">
                                <c:forEach items="${listaCantidadClientes}" var="d">
                                <h5 class="mb-3">Nuevos Clientes </h5>

                                <div class="alert alert-warning">
                                    <h3>${d.clientes_nuevos}</h3>
                                    Clientes registrados este mes
                                </div>

                                <hr>

                                <h5>Antiguos Clientes </h5>

                                <div class="alert alert-primary">
                                    <h3>${d.clientes_antiguos}</h3>
                                    Clientes registrados antes de este mes
                                </div>
                                </c:forEach>
                            </div>

                        </div>

                    </div>

                </div>
                <div class="row g-4 mb-4">

                    <div class="col-lg-8">

                        <div class="card shadow border-0">
                            <div class="card-body">

                                <h5 class="mb-3">
                                    <i class="bi bi-trophy-fill text-warning"></i>
                                    Top Clientes
                                </h5>

                                <div class="table-dashboard">

                                    <div class="table-responsive">

                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Cliente</th>
                                                    <th>Pedidos</th>
                                                    <th>Total Comprado</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <c:forEach items="${listaTopClientes}" var="d">
                                                <tr>
                                                    <td>${d.cliente}</td>
                                                    <td>${d.cantidad_pedidos}</td>
                                                    <td>S/ ${d.total}</td>
                                                </tr>
                                                </c:forEach>


                                            </tbody>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="col-lg-4">

                        <div class="card shadow border-0 bg-success text-white h-100">

                            <div class="card-body text-center">

                                <i class="bi bi-box-seam fs-1"></i>

                                <h2 class="mt-3">S/ ${listaTotaInventario}</h2>

                                <h5>Inventario Valorizado</h5>

                                <small>
                                    Valor total del stock disponible
                                </small>

                            </div>

                        </div>

                    </div>

                </div>
                <div class="row g-4 mb-4">

                        <div class="col-lg-6">

                            <div class="card shadow border-0">

                                <div class="card-body">

                                    <h5>Tallas Más Vendidas</h5>
                                    
                                    <canvas id="tallas"></canvas>
                                    
                                </div>

                            </div>

                        </div>

                        <div class="col-lg-6">

                            <div class="card shadow border-0">

                                <div class="card-body">

                                    <h5>Colores Más Vendidos</h5>

                                    <canvas id="coloresVendidos"></canvas>

                                </div>

                            </div>

                        </div>

                    </div>
                <div class="row g-4 mb-4">

                        <div class="col-lg-6">

                            <div class="card shadow border-0">

                                <div class="card-body">

                                    <h5>Delivery vs Recojo</h5>
                                    <div class="chart-container">
                                    <canvas id="entrega"></canvas>
                                    </div>
                                </div>

                            </div>

                        </div>

                        <div class="col-lg-6">

                            <div class="card shadow border-0">

                                <div class="card-body">

                                    <h5>Pedidos por Día</h5>
                                    <div class="chart-container">
                                    <canvas id="semanal"></canvas>
                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>
                <div class="row g-4 mb-4">

                <div class="col-lg-8">

                    <div class="card shadow border-0">

                        <div class="card-body">

                            <h5 class="text-danger">

                                <i class="bi bi-exclamation-triangle-fill"></i>

                                Productos con Baja Rotación

                            </h5>

                            <table class="table">

                                <thead>
                                    <tr>
                                        <th>Producto</th>
                                        <th>Total vendido</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach items="${listaBajaRotacion}" var="d">
                                    <tr>
                                        <td>${d.nombreproducto}</td>
                                        <td>${d.total}</td>
                                    </tr>
                                    </c:forEach>
                                </tbody>

                            </table>

                        </div>

                    </div>

                </div>

                    <div class="col-lg-4">
                        <div class="card shadow border-0 h-100 bg-warning text-dark">
                            <div class="card-body text-center">
                                <i class="bi bi-award-fill fs-1"></i>
                                <h3 class="mt-3 mb-4">Categorías Más Rentables</h3>

                                <!-- Contenedor flex/grid de Bootstrap -->
                                <div class="row g-3 justify-content-center">
                                    <c:forEach items="${listaCategoriaRentable}" var="d">
                                        <div class="col-6">      
                                            <p class="mb-1 text-truncate" title="${d.categoria}">
                                                <strong>${d.categoria}</strong>
                                            </p>
                                            <h4 class="fw-bold">S/ ${d.total}</h4>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="row g-4 mb-4">

                        <div class="col-lg-4">

                            <div class="card shadow border-0">

                                <div class="card-body text-center">

                                    <i class="bi bi-envelope-fill text-warning fs-1"></i>

                                    <h2>${listaMensajesPendientes}</h2>

                                    <p>Mensajes Pendientes</p>

                                </div>

                            </div>

                        </div>

                        <div class="col-lg-4">

                            <div class="card shadow border-0">

                                <div class="card-body text-center">

                                    <i class="bi bi-check-circle-fill text-success fs-1"></i>

                                    <h2>${listaMensajesRespondidos}</h2>

                                    <p>Mensajes Respondidos</p>

                                </div>

                            </div>

                        </div>

                        <div class="col-lg-4">

                            <div class="card shadow border-0">

                                <div class="card-body text-center">

                                    <i class="bi bi-clock-fill text-primary fs-1"></i>

                                    <h2>${listaHoras} h</h2>

                                    <p>Tiempo Promedio de Respuesta</p>

                                </div>

                            </div>

                        </div>

                    </div>

                                    <!-- Quinta fila -->
                                    <div class="row">

                                        <div class="col-lg-12">

                                            <div class="card shadow border-0">

                                                <div class="card-body">

                                                    <h5 class="mb-3">Resumen General</h5>

                                                    <div class="row text-center">

                                                        <div class="col-md-3">
                                                            <h4>S/ ${listaVentaMes}</h4>
                                                            <p>Ventas del Mes</p>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <h4>S/ ${listaTicket}</h4>
                                                            <p>Ticket Promedio</p>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <h4>${listaPorcentaje}%</h4>
                                                            <p>Pedidos Entregados</p>
                                                        </div>

                                                        <div class="col-md-3">
                                                            <h4>${listaCriticos}</h4>
                                                            <p>Productos Críticos</p>
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="mt-5">
                                        <div class="card shadow border-0 bg-dark text-white">

                        <div class="card-body">

                            <h4>
                                <i class="bi bi-bar-chart-line-fill"></i>
                                Resumen Ejecutivo
                            </h4>

                            <hr>

                            <ul class="mb-0">

                        <li>
                            Las ventas del mes alcanzaron
                            <strong>S/ ${listaVentaMes}</strong>.
                        </li>

                        <c:forEach items="${listaCategoriaRentable}" var="c" begin="0" end="0">
                            <li>
                                <strong>${c.categoria}</strong>
                                es la categoría líder en ingresos con
                                <strong>S/ ${c.total}</strong>.
                            </li>
                        </c:forEach>

                        <li>
                            Existen
                            <strong>${listaCriticos}</strong>
                            productos con stock crítico.
                        </li>

                        <c:forEach items="${listaTopClientes}" var="c" begin="0" end="0">
                            <li>
                                <strong>${c.cliente}</strong>
                                es el cliente con mayor volumen de compra.
                            </li>
                        </c:forEach>

                        <li>
                            Se tienen
                            <strong>${listaMensajesPendientes}</strong>
                            mensajes pendientes de atención.
                        </li>

                        <li>
                            El
                            <strong>${listaPorcentaje}%</strong>
                            de pedidos fueron entregados exitosamente.
                        </li>
                        <li>
                            Las ventas crecieron
                            <strong>${listaCrecimiento}%</strong>
                            respecto al mes anterior.
                        </li>
                    </ul>

                        </div>

                    </div>
                </div>
            </div>
        </main>
        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script>

            new Chart(document.getElementById('ventasMes'), {
                type: 'line',
                data: {
                    labels: [
                        <c:forEach items="${listaVentas}" var="v">
                            <c:choose>
                                <c:when test="${v.mes == 1}">"Ene"</c:when>
                                <c:when test="${v.mes == 2}">"Feb"</c:when>
                                <c:when test="${v.mes == 3}">"Mar"</c:when>
                                <c:when test="${v.mes == 4}">"Abr"</c:when>
                                <c:when test="${v.mes == 5}">"May"</c:when>
                                <c:when test="${v.mes == 6}">"Jun"</c:when>
                                <c:when test="${v.mes == 7}">"Jul"</c:when>
                                <c:when test="${v.mes == 8}">"Ago"</c:when>
                                <c:when test="${v.mes == 9}">"Sep"</c:when>
                                <c:when test="${v.mes == 10}">"Oct"</c:when>
                                <c:when test="${v.mes == 11}">"Nov"</c:when>
                                <c:when test="${v.mes == 12}">"Dic"</c:when>
                            </c:choose>
                            <c:if test="${!v.equals(listaVentas[listaVentas.size()-1])}">,</c:if>
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Ventas (S/)',
                        data: [
                            <c:forEach items="${listaVentas}" var="v" varStatus="status">
                                ${v.ventas}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ],
                        fill: true,
                        tension: 0.4,
                        borderColor: 'rgb(75, 192, 192)', 
                        backgroundColor: 'rgba(75, 192, 192, 0.2)' 
                    }]
                }
            });

            new Chart(document.getElementById('estadoPedidos'), {
                type: 'doughnut',
                data: {
                    labels: [
                        <c:forEach items="${listaEstados}" var="e" varStatus="status">
                            <c:choose>
                                <c:when test="${e.estado_pedido == 'pendiente'}">"Pendiente"</c:when>
                                <c:when test="${e.estado_pedido == 'curso'}">"En curso"</c:when>
                                <c:when test="${e.estado_pedido == 'entregado'}">"Entregado"</c:when>
                                <c:when test="${e.estado_pedido == 'CANCELADO'}">"Cancelado"</c:when>
                                <c:otherwise>"${e.estado_pedido}"</c:otherwise>
                            </c:choose>
                            <c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Cantidad',
                        data: [
                            <c:forEach items="${listaEstados}" var="e" varStatus="status">
                                ${e.cantidad_estado}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ],
                        backgroundColor: [
                            '#FFCE56', // Pendiente
                            '#36A2EB', // Curso
                            '#4BC0C0', // Entregado
                            '#FF6384'  // Cancelado
                        ]
                    }]
                },
                options: {
                    responsive: true
                }
            });

            new Chart(document.getElementById('categorias'), {
                type: 'bar',
                data: {
                    labels: [
                        <c:forEach items="${listaCategorias}" var="c" varStatus="status">
                            "${c.categoria}"<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ],
                    datasets: [{
                        label: 'Ventas por Categoría',
                        data: [
                            <c:forEach items="${listaCategorias}" var="c" varStatus="status">
                                ${c.cantidad_categoria}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ],
                        backgroundColor: [
                            'rgba(54, 162, 235, 0.6)',
                            'rgba(255, 99, 132, 0.6)',
                            'rgba(255, 206, 86, 0.6)',
                            'rgba(75, 192, 192, 0.6)',
                            'rgba(153, 102, 255, 0.6)'
                        ],
                        borderColor: [
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 99, 132, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            new Chart(document.getElementById('metodosPago'), {
                type: 'pie',
                data: {
                    labels: [
                        <c:forEach items="${listaIngresosMPagos}" var="i" varStatus="status">
                            "${i.metodo_pago}"<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ],
                    datasets: [{
                            label: 'Ventas por Metodo de pagos',
                            data: [
                                <c:forEach items="${listaIngresosMPagos}" var="i" varStatus="status">
                                    ${i.ingresospago}<c:if test="${!status.last}">,</c:if>
                                </c:forEach>
                            ]
                        }]
                }
            });
            new Chart(document.getElementById('tallas'),{
                type:'radar',
                data:{
                    labels:[
                            <c:forEach items="${listaTallaVendidas}" var="d" varStatus="status">
                                "${d.talla}"<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ],
                    datasets:[{
                        label:'Tallas mas Vendidas',
                        data: [
                            <c:forEach items="${listaTallaVendidas}" var="d" varStatus="status">
                                ${d.total}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ]
                    }]
                }
            });

            new Chart(document.getElementById('coloresVendidos'),{
                type:'polarArea',
                data:{
                    labels:[
                        <c:forEach items="${listaColoresVendidos}" var="d" varStatus="status">
                                "${d.color}"<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                    ],
                    datasets:[{
                        label:'Colores mas Vendidos',    
                        data:[
                            <c:forEach items="${listaColoresVendidos}" var="d" varStatus="status">
                                ${d.total}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ]
                    }]
                }
            });

            new Chart(document.getElementById('entrega'),{
                type:'pie',
                data:{
                    labels:[
                        <c:forEach items="${listaCantidadTipoE}" var="e" varStatus="status">
                            "${e.tipo_entrega}"<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ],
                    datasets:[{
                        
                        label: 'Tipo de Entrega',
                        data: [
                           <c:forEach items="${listaCantidadTipoE}" var="e" varStatus="status">
                                ${e.cantidadtipo}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ]
                        
                    }]
                }
            });

            new Chart(document.getElementById('semanal'),{
                type:'bar',
                data:{
                    labels:[<c:forEach items="${listaPedidosDia}" var="c" varStatus="status">
                                        "${c.fecha_estimada}"<c:if test="${!status.last}">,</c:if>
                                    </c:forEach>],
                    datasets:[{
                        label:'Pedidos',
                        data:[
                            <c:forEach items="${listaPedidosDia}" var="e" varStatus="status">
                                ${e.cantidad_pedidos}<c:if test="${!status.last}">,</c:if>
                            </c:forEach>
                        ]
                    }]
                }
            });
        </script>
        <jsp:include page="/componentes/pie.jsp" /> 
        <jsp:include page="/componentes/mensajes.jsp" /> 
    </body>
</html>
