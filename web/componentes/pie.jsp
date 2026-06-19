<%-- 
    Document   : pie
    Context    : Componente de pie de página para Cora: Hecho a Mano
--%>
<%@page import="modelo.categorias"%>
<%@page import="dao.categoriadao"%>
<%@page import="java.util.List"%>
<%
    dao.categoriadao catDao = new dao.categoriadao();
    List<categorias> listaCategorias = catDao.mostrarCategorias();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String paginaActual = (String) request.getAttribute("paginaActual");
%>
<c:choose>
    <c:when test="${sessionScope.rol == 'admin'}">
        <style>
            .mini-pie {
                background-color: #fbf3f0 !important; 
                padding: 30px 40px !important;
                border-top: 2px solid #e6c2bf !important; 
            }

            .mini-cabecera {
                display: flex !important;
                justify-content: space-between !important;
                align-items: center !important;
                margin-bottom: 20px !important;
            }

            .mini-logo {
                display: flex !important;
                align-items: center !important;
                gap: 15px !important;
            }

            .mini-logo img {
                height: 40px !important;
                width: auto !important;
            }

            .mini-logo p {
                font-size: 18px !important;
                font-weight: 600;
                margin: 0 !important;
                color: #5d544b !important; 
            }

            .mini-redes {
                display: flex;
                gap: 15px;
            }

            .mini-redes a {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 35px;
                height: 35px;
                background: #f2dfdd; 
                border-radius: 50%;
                color: #a68b6d; 
                transition: 0.3s;
                text-decoration: none;
            }

            .mini-redes a:hover {
                background: #e6c2bf; 
                color: #4a4a4a;
            }

            .mini-derechos {
                text-align: center;
                border-top: 1px solid #dcc8d1; 
                padding-top: 15px;
                margin-top: 10px;
            }

            .mini-derechos p {
                font-size: 11px !important;
                color: #a68b6d !important;
                margin: 0 !important;
            }
        </style>

        <footer class="pie mini-pie">
            <div class="mini-cabecera">
                <div class="mini-logo">
                    <img src="recursos/logo_cora.png" alt="Cora Logo">
                    <p>Cora: Hecho a Mano</p>
                </div>
                <div class="mini-redes">
                    <a href="https://www.facebook.com/profile.php?id=100063828570893" target="_blank"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="https://wa.me/947672377" target="_blank"><i class="fa-brands fa-whatsapp"></i></a>
                    <a href="mailto:corahechoamano@gmail.com"><i class="fa-regular fa-envelope"></i></a>
                    <a href="https://www.instagram.com/cora.hechoamano?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==" target="_blank"><i class="fa-brands fa-instagram"></i></a>
                </div>
            </div>
            <div class="mini-derechos">
                <p>&copy; 2026 Cora: Hecho a Mano | Todos los derechos reservados.</p>
            </div>
        </footer>
    </c:when>
    <c:otherwise >
        <footer class="pie">
            <div class="cabecera">
                <div class="logo">
                    <img src="recursos/logo_cora.png" alt="Cora Logo">
                    <p>Cora: Hecho a Mano</p>
                </div>
                <div class="redes">
                    <span><a href="https://www.facebook.com/profile.php?id=100063828570893" target="_blank"><i class="fa-brands fa-facebook-f"></i></a></span>
                    <span><a href="https://wa.me/947672377" target="_blank"><i class="fa-brands fa-whatsapp"></i></a></span>
                    <span><a href="mailto:corahechoamano@gmail.com"><i class="fa-regular fa-envelope"></i></a></span>
                    <span><a href="https://www.instagram.com/cora.hechoamano?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==" target="_blank"><i class="fa-brands fa-instagram"></i></a></span>
                </div>
            </div>
            <hr>

            <div class="seccion">
                <div>
                    <h2>Acerca de Nosotros</h2>
                    <ul class="info-lista">
                        <li>
                            <span class="subcora"><i class="fa-solid fa-clock"></i> Horario de Atención:</span>
                        </li>
                        <li class="info-detalle">Lun a Dom: 10:00 a.m. - 10:00 p.m.</li>

                        <li>
                            <span class="subcora"><i class="fa-solid fa-location-dot"></i> Dirección:</span>
                        </li>
                        <li class="info-detalle">Centro Comercial Larcomar, Tienda 220, Miraflores, Lima, Perú.</li>

                        <li>
                            <span class="subcora"><i class="fa-solid fa-phone"></i> Teléfono:</span>
                        </li>
                        <li class="info-detalle">Telf: +51 947 672 377</li>

                        <li>
                            <span class="subcora"><i class="fa-solid fa-envelope"></i> Correo:</span>
                        </li>
                        <li class="info-detalle">corahechoamano@gmail.com</li>
                    </ul>
                </div>

                <div>
                    <h2>Secciones</h2>
                    <a href="controladorpagina?pagina=inicio" class="d-block">Inicio</a>
                    <a href="controladorpagina?pagina=productos" class="d-block">Productos</a>
                    <a href="controladorpagina?pagina=nosotros" class="d-block">Nosotros</a>
                    <a href="controladorpagina?pagina=contacto" class="d-block">Contacto</a>
                </div>

                <div class="categorias-col">
                    <h2>Categorías</h2>
                    <div class="row row-cols-2 g-1">
                        <%
                            if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                for(categorias cat : listaCategorias) {
                        %>
                        <div class="col">
                            <a href="controladorproducto?accion=listar&id_categoria=<%=cat.getId_categoria()%>" class="d-block text-truncate">
                                <%=cat.getNombre()%>
                            </a>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="col-12">
                            <small class="text-muted">No hay categorías disponibles</small>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <div>
                    <h2>Información</h2>
                    <a href="#" class="d-block">Términos y Condiciones</a>
                    <a href="#" class="d-block">Política de Privacidad</a>
                    <a href="#" class="d-block">Política de Envíos y Entregas</a>
                    <a href="#" class="d-block">Cuidado de Previas</a>
                    <p class="reclamaciones-link mt-2">
                        <a href="#"><i class="fa-solid fa-book-open me-1"></i> Libro de Reclamaciones</a>
                    </p>
                </div>
            </div>

            <div class="derechos">
                <p><i class="fa-regular fa-copyright"></i> 2026 Cora: Hecho a Mano | Todos los derechos reservados.</p>
            </div>
        </footer>
    </c:otherwise>

</c:choose>
