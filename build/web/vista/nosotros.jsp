<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nosotros</title>
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
    <body>
        <%
            request.setAttribute("paginaActual", "nosotros");        

        %>
        <!-- header -->        
        <jsp:include page="/componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Sobre nosotros</h2>
            
             <div class='mb-5'>
                <h4 class="mb-5 text-center" style="color:#e6c2bf; font-weight: bold;">Nuestra historia</h4>
                <div class="container-fluid px-4">
                    <div class="card card-historia border-0 mb-3">
                        <div class="row g-0 align-items-center"> <div class="col-md-4">
                                <img src="${pageContext.request.contextPath}/recursos/historia.png" class="img-fluid rounded-4" alt="historiaimg">
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <p class="card-text ms-2">
                                        CORA Hecho a mano nació con el CORAzón puesto en nuestras raíces y el CORAje de emprender un camino con un propósito claro: preservar la identidad cultural del Perú a través de la moda sostenible. 
                                        Lo que inició como un sueño en la sala de nuestro hogar, se ha convertido hoy en un proyecto de impacto que lleva el arte peruano a todo el mundo. 
                                        Creemos firmemente que cada prenda no es solo una pieza de vestir, sino un lienzo vivo donde cada puntada y cada nudo cuenta una historia ancestral. 
                                        Colaboramos de forma estrecha con maestras artesanas de diversas regiones andinas y amazónicas del país, fusionando el diseño contemporáneo con técnicas tradicionales.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>            
                </div>
            </div>
            <div class='mb-5'>
                <h4 class="mb-5 text-center" style="color:#e6c2bf; font-weight: bold;">Nuestros valores</h4>
                <div class="container-fluid px-4">
                    <div class="row g-0 gap-5 justify-content-center">
                        <div class="card card-valor border-0" style="width: 20rem;">
                            <img src="${pageContext.request.contextPath}/recursos/v1.jpg" class="card-img-top rounded-4" alt="valor1">
                            <div class="card-body">
                                <h5 class="card-title text-center mt-3">Identidad Cultural</h5>
                                <p class="card-text">
                                    Preservamos y honramos con orgullo las técnicas textiles y tradiciones ancestrales de las artesanas peruanas en cada uno de nuestros diseños.                                 </p>
                            </div>
                        </div>
                        <div class="card card-valor border-0" style="width: 20rem;">
                            <img src="${pageContext.request.contextPath}/recursos/v2.jpg" class="card-img-top rounded-4" alt="valor2">
                            <div class="card-body">
                                <h5 class="card-title text-center mt-3">Moda Sostenible</h5>
                                <p class="card-text">
                                    Impulsamos un consumo responsable a través de la producción a mano y prácticas conscientes que respetan los tiempos del artesano y minimizan el impacto ambiental.                                 </p>
                            </div>
                        </div>
                        <div class="card card-valor border-0" style="width: 20rem;">
                            <img src="${pageContext.request.contextPath}/recursos/v3.jpg" class="card-img-top rounded-4" alt="valor3">
                            <div class="card-body">
                                <h5 class="card-title text-center mt-3">Impacto Social (Empoderamiento)</h5>
                                <p class="card-text">
                                    Fomentamos el comercio justo y el crecimiento económico de mujeres rurales de los Andes y la Amazonía, convirtiendo el arte en su principal motor de desarrollo.                                 </p>
                            </div>
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
