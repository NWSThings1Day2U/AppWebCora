<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String paginaActual = (String) request.getAttribute("paginaActual");
%>
<c:choose>

    <c:when test="${sessionScope.rol == 'admin'}">
        <header>
            <nav class="navbar fixed-top navbar-admin-cora" >
                <div class="container-fluid d-flex align-items-center justify-content-between">                    
                    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
                        <i class="fa-solid fa-bars custom-sandwich"></i>
                    </button>

                    <a class="navbar-brand d-flex align-items-center me-1" href="${pageContext.request.contextPath}/controladorseccion?seccion=inicio" style="padding-left: 20px">
                        <img src="${pageContext.request.contextPath}/recursos/logo_cora.png" alt="Logodelaclinica" class="logo-animado" style="width: 50px;">

                    </a>
                    <div class="me-auto d-none d-md-block" >
                        <h6 class="m-0 fw-bold title-welcome">
                            <c:choose>
                                <c:when test="${paginaActual == 'usuarios'}">Gestión de Usuarios</c:when>
                                <c:when test="${paginaActual == 'categorias'}">Gestión de Categorías</c:when>
                                <c:when test="${paginaActual == 'productos'}">Gestión de Productos</c:when>
                                <c:when test="${paginaActual == 'pedidos'}">Gestión de Pedidos</c:when>
                                <c:when test="${paginaActual == 'perfil'}">Gestión de Perfil</c:when>

                                <c:otherwise>¡Bienvenido, ${sessionScope.usuario}!</c:otherwise>
                            </c:choose>
                        </h6>
                        <p class="m-0 subtitle-admin">
                            <c:choose>
                                <c:when test="${paginaActual == 'inicio' || empty paginaActual}">Panel de administración Cora</c:when>
                                <c:otherwise>Administración de ${paginaActual}</c:otherwise>
                            </c:choose>
                        </p>
                    </div>


                    <div class="d-flex align-items-center gap-3">
                        <a class="text-decoration-none" href="controladorseccion?seccion=perfil">
                            <div class="card admin-profile-card-mini shadow-sm">
                                <div class="row g-0 align-items-center ">
                                    <div class="col-auto p-0">
                                        <div class="avatar-placeholder">
                                            <img src="${pageContext.request.contextPath}/recursos/${sessionScope.imagen}" 
                                                 class="profile-img-split" 
                                                 alt="Perfil">
                                        </div>
                                    </div>
                                    <div class="col px-2 d-none d-lg-block">
                                        <div class="card-body p-0">
                                            <p class="admin-name-text">${sessionScope.usuario}</p>
                                            <p class="admin-email-text">${sessionScope.correo != null ? sessionScope.correo : 'Sin correo'}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </a>

                        <a href="controladorsalida" class="btn btn-logout-cora shadow-sm">
                            <span class="d-none d-sm-inline">Salir</span>
                            <i class="fa-solid fa-arrow-right-from-bracket"></i>
                        </a>
                    </div>

                    <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
                        <div class="offcanvas-header border-bottom">
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                            <a class="navbar-brand logo-admin mb-4 d-block text-center" href="controladorseccion?seccion=inicio">
                                <img src="recursos/logo_cora.png" alt="logoCora" style="width: 70px;">
                                <h5 class="mt-2 fw-bold" style="color: #dbb1ad;">Cora: Hecho a mano</h5>
                                <p class="text-muted small">Panel administrador</p>
                            </a>
                            <ul class="navbar-nav gap-2">
                                <li class="nav-item">
                                    <a class="nav-link ${paginaActual == 'inicio' || empty paginaActual ? 'active' : ''}" 
                                       href="controladorseccion?seccion=inicio">
                                        <i class="fa-solid fa-chart-line me-2"></i>Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${paginaActual == 'usuarios' ? 'active' : ''}" 
                                       href="controladorseccion?seccion=usuarios">
                                        <i class="fa-solid fa-users me-2"></i>Usuarios
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${paginaActual == 'categorias' ? 'active' : ''}" 
                                       href="controladorseccion?seccion=categorias">
                                        <i class="fa-solid fa-tags me-2"></i>Categorías
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${paginaActual == 'productos' ? 'active' : ''}" 
                                       href="controladorseccion?seccion=productos">
                                        <i class="fa-solid fa-boxes-stacked me-2"></i>Productos
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${paginaActual == 'pedidos' ? 'active' : ''}" 
                                       href="controladorseccion?seccion=pedidos">
                                        <i class="fa-solid fa-clipboard-list me-2"></i>Pedidos
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${paginaActual == 'contacto' ? 'active' : ''}" 
                                       href="controladorseccion?seccion=contacto">
                                        <i class="fa-solid fa-address-book me-2"></i>Contacto
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link ${paginaActual == 'perfil' ? 'active' : ''}" 
                                       href="controladorseccion?seccion=perfil">
                                        <i class="fa-solid fa-user me-2"></i>Perfil
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

    </c:when>

    <c:when test="${sessionScope.rol == 'cliente'}">

        <header>

            <nav class="navbar navbar-expand-lg fixed-top" style="background-color: #e6dcd2;">

                <div class="container-fluid" >

                    <a class="navbar-brand logo ms-5 me-5" href="controladorpagina?pagina=inicio">
                        <img src="recursos/logo_cora.png" alt="logoCora">
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">

                        <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-5">
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=inicio" class="text-decoration-none text-black <%= "inicio".equals(paginaActual) ? "active" : "" %>">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=productos" class="text-decoration-none text-black <%= "productos".equals(paginaActual) ? "active" : "" %>">Productos</a>
                            </li>
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=nosotros" class="text-decoration-none text-black <%= "nosotros".equals(paginaActual) ? "active" : "" %>">Nosotros</a>
                            </li>
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=contacto" class="text-decoration-none text-black <%= "contacto".equals(paginaActual) ? "active" : "" %>">Contacto</a>
                            </li>
                        </ul>

                        <div class="d-flex me-5 gap-2 align-items-center">

                            <form class="d-flex" action="controladorpagina" method="GET">
                                <input type="hidden" name="pagina" value="buscar">
                                <div class="input-group">
                                    <input class="form-control border-end-0" name="termino" type="search" placeholder="Busca productos...">
                                    
                                    <button type="button" class="btn btn-outline-secondary input-group-text border-start-0" data-bs-toggle="modal" data-bs-target="#modalBusqueda">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </div>
                            </form>

                            <a href="controladorpagina?pagina=carrito"
                               class="btn btn-outline-secondary position-relative">

                                <i class="fa-solid fa-basket-shopping"></i>

                                <%
                                    int cantidadCarrito = 0;

                                    java.util.ArrayList<modelo.ItemCarrito> carrito =
                                        (java.util.ArrayList<modelo.ItemCarrito>)
                                        session.getAttribute("carrito");

                                    if(carrito != null){
                                        for(modelo.ItemCarrito item : carrito){
                                            cantidadCarrito += item.getCantidad();
                                        }
                                    }
                                %>

                                <% if(cantidadCarrito > 0){ %>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger badge-carrito">
                                    <%= cantidadCarrito %>
                                </span>
                                <% } %>

                            </a>


                            <a href="controladorpagina?pagina=perfil" class="btn btn-outline-secondary <%= "perfil".equals(paginaActual) ? "active" : "" %>">
                                <span>¡Hola, ${sessionScope.usuario}!  <i class="fa-solid fa-user-check"></i></span>
                            </a>
                            <a href="controladorsalida" class="btn btn-outline-secondary <%= "cuenta".equals(paginaActual) ? "active" : "" %>"">
                                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                            </a>
                        </div>

                    </div>
                </div>
        </header>
        <jsp:include page="modalbusqueda.jsp" />                        
    </c:when>

    <c:otherwise>
        <header>
            <nav class="navbar navbar-expand-lg fixed-top" style="background-color: #e6dcd2;">
                <div class="container-fluid" style="padding: 10px;">

                    <a class="navbar-brand logo ms-5 me-5" href="controladorpagina?pagina=inicio">
                        <img src="recursos/logo_cora.png" alt="logoCora">
                    </a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo02">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">

                        <ul class="navbar-nav me-auto mb-2 mb-lg-0 gap-5">
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=inicio" class="text-decoration-none text-black <%= "inicio".equals(paginaActual) ? "active" : "" %>">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=productos" class="text-decoration-none text-black <%= "productos".equals(paginaActual) ? "active" : "" %>">Productos</a>
                            </li>
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=nosotros" class="text-decoration-none text-black <%= "nosotros".equals(paginaActual) ? "active" : "" %>">Nosotros</a>
                            </li>
                            <li class="nav-item">
                                <a href="controladorpagina?pagina=contacto" class="text-decoration-none text-black <%= "contacto".equals(paginaActual) ? "active" : "" %>">Contacto</a>
                            </li>
                        </ul>

                        <div class="d-flex me-5 gap-2 align-items-center">

                            <form class="d-flex" action="controladorpagina" method="GET">
                                <input type="hidden" name="pagina" value="buscar">
                                <div class="input-group">
                                    <input class="form-control border-end-0" name="termino" type="search" placeholder="Busca productos...">
                                    
                                    <button type="button" class="btn btn-outline-secondary input-group-text border-start-0" data-bs-toggle="modal" data-bs-target="#modalBusqueda">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </div>
                            </form>

                            <a href="controladorpagina?pagina=carrito"
                               class="btn btn-outline-secondary position-relative">

                                <i class="fa-solid fa-basket-shopping"></i>

                                <%
                                    int cantidadCarrito = 0;

                                    java.util.ArrayList<modelo.ItemCarrito> carrito =
                                        (java.util.ArrayList<modelo.ItemCarrito>)
                                        session.getAttribute("carrito");

                                    if(carrito != null){
                                        for(modelo.ItemCarrito item : carrito){
                                            cantidadCarrito += item.getCantidad();
                                        }
                                    }
                                %>

                                <% if(cantidadCarrito > 0){ %>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger badge-carrito">
                                    <%= cantidadCarrito %>
                                </span>
                                <% } %>

                            </a>

                            <a href="controladorpagina?pagina=cuenta" class="btn btn-outline-secondary <%= "cuenta".equals(paginaActual) ? "active" : "" %>">
                                <i class="fa-solid fa-user"></i>
                            </a>

                        </div>

                    </div>
                </div>
            </nav>
        </header>
        <jsp:include page="modalbusqueda.jsp" />                        
    </c:otherwise>

</c:choose>

