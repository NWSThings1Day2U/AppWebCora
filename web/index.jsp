<%-- 
    Document   : index
    Created on : 4 may. 2026, 2:55:36 p. m.
    Author     : USUARIO
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.categorias"%>
<%@page import="java.util.List"%>

<%
    List<categorias> listaCategorias = (List<categorias>) request.getAttribute("listaCategorias");
    String idCategoria = request.getParameter("id_categoria");

    int totalCategorias = 0;

    if (listaCategorias != null) {
        totalCategorias = listaCategorias.size();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Inicio</title>
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
        <link rel="stylesheet" href="estilos/cuerpoinicio.css">
        <link rel="stylesheet" href="estilos/piestilo.css">

    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "inicio");
        %>
        <!-- header -->
        <jsp:include page="componentes/encabezado.jsp" />
        
        <main class="main-layout w-100 mt-0 pt-0" style="margin-bottom: 150px;">

            <div class="container-fluid p-0 m-0">
                <div id="carouselExampleCaptions" class="carousel slide custom-carousel" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>

                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="recursos/banner1.png" class="carousel-img" alt="Cora Hecho a Mano">
                            <div class="carousel-caption custom-caption">
                                <h2 class="caption-title">Cora: Hecho a Mano</h2>
                                <p class="caption-text">Descubre prendas exclusivas tejidas a mano que cuentan una historia en cada hilo.</p>
                                <a href="controladorpagina?pagina=productos" class="btn btn-artesanal">Explorar Tienda</a>
                            </div>
                        </div>

                        <div class="carousel-item">
                            <img src="recursos/banner2.jpg" class="carousel-img" alt="Proceso 100% Artesanal">
                            <div class="carousel-caption custom-caption">
                                <h2 class="caption-title">Conócenos: Somos CORAje y CORAzón</h2>
                                <p class="caption-text">Cada pieza nace de manos artesanas dedicadas a mantener viva nuestra cultura y texturas.</p>
                                <a href="controladorpagina?pagina=nosotros" class="btn btn-artesanal">Sobre nosotros</a>
                            </div>
                        </div>

                        <div class="carousel-item">
                            <img src="recursos/banner3.jpg" class="carousel-img" alt="Regalos Únicos">
                            <div class="carousel-caption custom-caption">
                                <h2 class="caption-title">Diseños Unicos: Prendas y Accesorios</h2>
                                <p class="caption-text">Llevamos la calidez y el arte local directo a la puerta de tu hogar.</p>
                                <a href="controladorpagina?pagina=productos" class="btn btn-artesanal">Comprar Ahora</a>
                            </div>
                        </div>
                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Anterior</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Siguiente</span>
                    </button>
                </div>
            </div>
            <div class="container mt-5 pt-4">
                <h2 class="text-center mb-5 section-main-title" style="font-weight: bold;margin-top: 50px">¡Bienvenido a Cora: Hecho a mano!</h2>

                <div class="row align-items-center my-5 g-5">
                    <div class="col-lg-6">
                        <div class="ratio ratio-16x9 video-container-artesanal">
                            <iframe width="560" height="315" src="https://www.youtube.com/embed/OOICwbZ_trg?si=NfdpZ4d6eWugwduw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="ps-lg-4 text-block-cora" style="text-align: justify">
                            <h3 class="story-title mt-1 mb-3">Nuestro comienzo con el sueño 'Cora'</h3>
                            <p class="story-text">
                                En <strong>Cora: Hecho a Mano</strong>, entendemos que la identidad y la creatividad son los activos más valiosos de nuestra cultura. Por ello, con el respaldo y reconocimiento de <strong>Indecopi</strong>, consolidamos nuestro sueño formalmente para llevar el arte de nuestras raíces a nuevos horizontes.
                            </p>
                            <p class="story-text">
                                No solo diseñamos prendas, construimos una marca con denominación de origen y calidad competitiva. Hoy nos proyectamos al mundo como <strong>moda artesanal peruana de exportación</strong>, demostrando que detrás de cada puntada hay coraje, historia y el talento de manos apasionadas que merecen ser reconocidas a nivel global.
                            </p>
                        </div>
                    </div>
                </div>

                <h4 class="text-center catalog-title"
                    style="color:#dbb1ad;margin-top:100px;margin-bottom:70px;font-weight:bold;">
                    Los Favoritos de la Semana
                </h4>

                <div class="container">

                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <c:choose>
                            <c:when test="${not empty listaTop4Productos}">
                                <c:forEach items="${listaTop4Productos}" var="p">
                                    <div class="col">
                                        <div class="card categoria-card h-100 shadow-sm border-0">
                                            <img src="recursos/${p.imagen}"
                                                 class="card-img-top"
                                                 style="height:320px; object-fit:cover; border-radius: 12px;">
                                            <div class="card-body text-center">
                                                <span class="badge bg-primary mb-2" style=" background-color: #c4b5a8 !important;">
                                                    ${p.categoria}
                                                </span>
                                                <h5 class="card-title">
                                                    ${p.nombreproducto}
                                                </h5>
                                                <h4 style="color:#7c6753;">
                                                    Desde <span style="color:#dbb1ad;">S/ ${p.precio}</span>
                                                </h4>
                                                <small class="text-muted">
                                                    ${p.vendidos} unidades vendidas
                                                </small>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <div class="col-12">
                                    <small class="text-muted text-center">No hay productos disponibles</small>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                </div>               
                <h4 class="text-center catalog-title" style="color:#dbb1ad; margin-top: 100px; margin-bottom: 70px; font-weight: bold;">Categorías disponibles</h4>

                <div class="container mb-5">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 justify-content-center">
                        <%
                            if (listaCategorias != null && !listaCategorias.isEmpty()) {
                                for (categorias cat : listaCategorias) {
                        %>
                        <div class="col">
                            <div class="card h-100 categoria-card border-0 shadow-sm">
                                <div class="categoria-img-container position-relative overflow-hidden">
                                    <img src="recursos/<%=cat.getImagen()%>" class="w-100 h-100 object-fit-cover img-categoria-base" style="border-radius: 12px;" alt="<%=cat.getNombre()%>">
                                    <div class="position-absolute top-0 start-0 w-100 h-100 overlay-categoria-rosa"></div>
                                </div>

                                <div class="card-body d-flex flex-column text-center p-4">
                                    <h5 class="categoria-card-title mb-2"><%=cat.getNombre()%></h5>
                                    <p class="categoria-card-text text-muted flex-grow-1 small"><%=cat.getDescripcion()%></p>

                                    <div class="mt-3">
                                        <a href="controladorproducto?accion=listar&id_categoria=<%=cat.getId_categoria()%>" class="btn btn-categoria-artesanal">
                                            Ver productos
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            }else {
                        %>
                        <div class="col-12">
                            <small class="text-muted">No hay categorías disponibles</small>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <h4 class="text-center catalog-title" style="color:#dbb1ad; margin-top: 100px; margin-bottom: 70px; font-weight: bold;">Videos de nuestra pasarela</h4>
                <div class="container mb-5">
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center">

                        <div class="col">
                            <div class="instagram-card">
                                <iframe class="instagram-media" 
                                        src="https://www.instagram.com/reel/DMqbL3TSB_k/embed/" 
                                        allowtransparency="true" 
                                        frameborder="0" 
                                        scrolling="no">
                                </iframe>
                            </div>
                        </div>

                        <div class="col">
                            <div class="instagram-card">
                                <iframe class="instagram-media" 
                                        src="https://www.instagram.com/reel/DMDdg9BA_jT/embed/" 
                                        allowtransparency="true" 
                                        frameborder="0" 
                                        scrolling="no">
                                </iframe>
                            </div>
                        </div>

                        <div class="col">
                            <div class="instagram-card">
                                <iframe class="instagram-media" 
                                        src="https://www.instagram.com/reel/DMEMvF9SApA/embed/" 
                                        allowtransparency="true" 
                                        frameborder="0" 
                                        scrolling="no">
                                </iframe>
                            </div>
                        </div>

                    </div>
                </div>

                <h4 class="text-center catalog-title" style="color:#dbb1ad;margin-top: 100px;margin-bottom: 70px; font-weight: bold;">Visitános</h4>


                <div class="row align-items-center ">
                    <div class="col-lg-6 d-flex justify-content-center">
                        <video controls autoplay loop muted class="w-100" style="max-width: 500px; height: 250px; object-fit: cover; border-radius: 8px;" poster="pic.png">
                            <source src="recursos/video-cora1.mp4" type="video/mp4">
                            Tu navegador no soporta la reproducción de videos en HTML.
                        </video>
                    </div>



                    <div class="col-lg-6">
                        <div class="ps-lg-4 text-block-cora" style="text-align: justify" >
                            <h3 class="story-title mt-1 mb-3">Te esperamos en nuestra tienda presencial</h3>
                            <p class="story-text">
                                En <strong>Centro Comercial Larcomar, Tienda 220</strong>, del distrido de Miraflores en la ciudad de lima, Perú.  </p>
                            <a href="controladorpagina?pagina=contacto" class="btn btn-artesanal">Ver detalles</a>

                        </div>
                    </div>
                </div>



                <h4 class="text-center catalog-title" style="color:#dbb1ad; margin-top: 100px; margin-bottom: 70px; font-weight: bold;">Galería</h4>

                <div class="row row-cols-1 row-cols-md-3 g-4 justify-content-center">
                    <div class="col">
                        <div class="position-relative overflow-hidden rounded-3 shadow-sm text-center galeria-item" style="height: 350px;">
                            <img src="recursos/pic1.jpg" class="w-100 h-100 object-fit-cover img-base" alt="Galería 1">
                            <div class="position-absolute top-0 start-0 w-100 h-100 overlay-rosa"></div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="position-relative overflow-hidden rounded-3 shadow-sm text-center galeria-item" style="height: 350px;">
                            <img src="recursos/pic2.jpg" class="w-100 h-100 object-fit-cover img-base" alt="Galería 2">
                            <div class="position-absolute top-0 start-0 w-100 h-100 overlay-rosa"></div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="position-relative overflow-hidden rounded-3 shadow-sm text-center galeria-item" style="height: 350px;">
                            <img src="recursos/pic3.jpg" class="w-100 h-100 object-fit-cover img-base" alt="Galería 3">
                            <div class="position-absolute top-0 start-0 w-100 h-100 overlay-rosa"></div>
                        </div>
                    </div>
                </div>

            </div>   
        </main>

        <jsp:include page="/componentes/pie.jsp" /> 

        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>

        <jsp:include page="/componentes/mensajes.jsp" /> 

    </body>
</html>

