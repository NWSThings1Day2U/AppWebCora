<%-- 
    Document   : contacto
    Created on : 14 may. 2026, 11:32:54 p. m.
    Author     : USUARIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.contacto"%>

<%
    contacto datos = (contacto) request.getAttribute("datosUsuario");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contacto</title>
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
            request.setAttribute("paginaActual", "contacto");        

        %>        
        <!-- header -->

        <jsp:include page="/componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Contáctanos</h2>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card p-4">
                        <div class="card-body mt-4">
                            <h5 class="card-title text-center">Detalles de contacto</h5>
                            <div class="container-fluid px-4"> 
                                <p><span class="subcora"><strong> <i class="fa-solid fa-phone me-2"></i>Teléfono:</strong> </span> 
                                    +51 947 672 377
                                </p>
                                <p><span class="subcora"><strong><i class="fa-solid fa-envelope me-2"></i>Correo:</strong></span>  corahechoamano@gmail.com</p>
                           
                                <p><span class="subcora"><strong> <i class="fa-solid fa-clock me-2"></i>Horario: </strong></span> 
                                    Lun a Dom: 10:00 a.m. - 10:00 p.m.
                                </p>

                                <p><span class="subcora"><strong> <i class="fa-solid fa-location-dot me-2"></i>Dirección:</strong></span> 
                                    Centro Comercial Larcomar, Tienda 220
                                </p>
                                <p><span class="subcora"><strong><i class="fa-solid fa-map me-2"></i>Distrito: </strong> </span> 
                                    Miraflores, Lima - Perú
                                </p>
                                
                                <div class="row">
                                    <div class="col-lg-12 mb-2 " style="margin-top: 25px">
                                        <iframe
                                            src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d3900.713097826473!2d-77.0330038!3d-12.1317721!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105b7e1b4b5a533%3A0xa549043226dcfb18!2sLarcomar!5e0!3m2!1ses!2spe!4v1778964452263!5m2!1ses!2spe" width="800" height="600" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"
                                            class="h-100 w-100" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                                    </div>
                                </div>
                            </div>

                        </div>
                        
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card p-4"> 
                        <div class="card-body mt-4">
                            <h5 class="card-title text-center">Envíanos un mensaje</h5>
                            <div class="container-fluid px-4">
                                <form action="controladorcontacto" id="formContacto" method="POST" class="needs-validation" novalidate>
                                    <input type="hidden" name="accion" value="registrar">
                                    
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Nombre Completo: </label>
                                            <div class="input-group">
                                                <input type="text" class="form-control input-cora" name="nombre" value="<%= datos != null ? datos.getNombre() : "" %>" <%= datos != null ? "readonly" : "" %> minlength="4" required 
                                                       pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$" >
                                                <div class="invalid-feedback">Solo letras y 4 digitos min.</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Teléfono: </label>
                                            <div class="input-group">
                                                <input type="text" class="form-control val-numero input-cora" name="telefono" value="<%= datos != null ? datos.getTelefono() : "" %>" <%= datos != null ? "readonly" : "" %> required 
                                                       maxlength="9" pattern="9\d{8}" >
                                                <div class="invalid-feedback">Debe empezar con 9 y tener 9 dígitos.</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Correo: </label>
                                            <div class="input-group">
                                                <input type="email" class="form-control input-cora" name="correo" value="<%= datos != null ? datos.getCorreo() : "" %>" <%= datos != null ? "readonly" : "" %> required>
                                                <div class="invalid-feedback">Correo no válido.</div>
                                            </div>
                                        </div>
                                        
                                         <div class="col-md-6">
                                            <label class="form-label">Asunto: </label>
                                            <div class="input-group">
                                                <input type="text" class="form-control input-cora" name="asunto" required>
                                                <div class="invalid-feedback">Ingrese un asusnto.</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-4 "> 
                                        <div class="col-md-12">
                                            <label class="form-label" for="descripcion">Descripción (opcional): </label>
                                            <div class="input-group">
                                                <textarea class="form-control textarea-cora" id="descripcion" name="descripcion" rows="4"  ></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100 mb-2"> Enviar</button>
                                    
                                </form>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </main>
        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/pie.jsp"/> 
                
        <jsp:include page="/componentes/mensajes.jsp" /> 
        <script>
            (() => {
                'use strict';

                const forms = document.querySelectorAll('.needs-validation');

                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {

                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }

                        form.classList.add('was-validated');

                    }, false);
                });
            })();
        </script>
    </body>
</html>
