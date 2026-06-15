<%-- 
    Document   : cuenta
    Created on : 4 may. 2026, 8:06:05 p. m.
    Author     : USUARIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%
        String titulo;
        String modo = request.getParameter("modo");
        if (modo == null) {
            modo = "login"; 
        }
        switch (modo) {
            case "registro":
                titulo ="Registrar Cuenta";
                break;
            case "login":
                titulo ="Inicio de Sesión";
                break;
            case "olvido":
                titulo ="Recuperar Contraseña";
                break;
            
            default:
                titulo = "Inicio de Sesión";
        }        
    %>        
    <title>Cuenta: <%=titulo%></title>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/estilos.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/estilosa.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/estilos/piestilo.css">
    </head>
    <body> 

        <%
            request.setAttribute("paginaActual", "cuenta");
        %>
        <!-- header -->
        <jsp:include page="../componentes/encabezado.jsp" />

        <div class="container mt-5 pt-4 container-cuenta" style="margin-top: 80px; margin-bottom: 150px;">
            <h2 class="mb-5 text-center">Mi cuenta</h2>

            <div class="card-group shadow-sm">
                <!-- 
                <div class="card">
                    <div class="card-body">
                        
                        <h5 class="card-title">Acceder a cuenta</h5>
                <jsp:include page="../vista/login.jsp" />
            </div>
        </div>
                -->

                <%
                        if (modo != null && modo.equals("registro")){
                %>    


                <div class="card p-0"> 
                    <img src="${pageContext.request.contextPath}/recursos/registro.jpg" class="img-fluid w-100 h-100" style="object-fit: cover;" alt="registroimg">
                </div>
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Registrar una cuenta</h5>
                        <jsp:include page="../vista/registro.jsp" />
                    </div>
                </div>

                <%
                        } else {
                %>

                <div class="card p-0"> 
                    <img src="${pageContext.request.contextPath}/recursos/login.jpg" class="img-fluid w-100 h-100" style="object-fit: cover;" alt="loginimg">
                </div>
                <div class="card">
                    <div class="card-body">

                        <h5 class="card-title">Acceder a cuenta</h5>
                        <jsp:include page="../vista/login.jsp" />
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <!-- SweetAlert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
        <jsp:include page="/componentes/pie.jsp" /> 

        <jsp:include page="/componentes/mensajes.jsp" /> 

    </body>
</html>