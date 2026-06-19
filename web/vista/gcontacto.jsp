<%-- 
    Document   : gcontacto
    Created on : 9 jun. 2026, 11:52:50 p. m.
    Author     : USUARIO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="modelo.contacto"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<modelo.contacto> lista = (ArrayList<modelo.contacto>) request.getAttribute("listaContacto");
    int totalcontactos = 0; 
    int respondidas =0;
    int pendientes = 0;
    if (lista != null) {
        totalcontactos = lista.size();
        for (modelo.contacto c : lista) {
            if ("Pendiente".equals(c.getEstado())) {
                pendientes++;
            }else{
                respondidas++;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion Contacto</title>
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
        <link rel="stylesheet" href="estilos/estilosa.css">
        <link rel="stylesheet" href="estilos/piestilo.css">
    </head>
    <body>
         <%
            request.setAttribute("paginaActual", "contacto");
            
        %>
        <jsp:include page="../componentes/encabezado.jsp" />
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Gestión de Contáctanos</h2>
            <div class="card p-4 border-top-0 rounded-bottom mb-5" style="box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);">
                <div class="d-flex align-items-center gap-2">
                    <form class="d-flex w-50" id="formBuscar" onsubmit="return false;">
                        <div class="input-group">
                            <input class="form-control border-end-0" id="inputTermino" type="search" placeholder="Busca nombre de remitente...">
                            <button class="input-group-text border-start-0 bg-white" type="button">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </form>
                    <div class="col-12 col-lg-7">
                        <div class="row g-2 justify-content-lg-end">
                            <div class="col-6 col-sm-4" style="max-width: 160px;">
                                <div class="p-2 text-center rounded border bg-light shadow-sm">
                                    <small class="text-muted d-block text-truncate">Total</small>
                                    <span class="fs-5 fw-bold text-dark"><%= totalcontactos %></span>
                                </div>
                            </div>
                            <div class="col-6 col-sm-4" style="max-width: 160px;">
                                <div class="p-2 text-center rounded border bg-warning-subtle shadow-sm">
                                    <small class="text-warning d-block text-truncate">Pendientes</small>
                                    <span class="fs-5 fw-bold text-warning"><%= pendientes %></span>
                                </div>
                            </div>
                            <div class="col-6 col-sm-4" style="max-width: 160px;">
                                <div class="p-2 text-center rounded border bg-success-subtle shadow-sm">
                                    <small class="text-success-emphasis d-block text-truncate">Respondidas</small>
                                    <span class="fs-5 fw-bold text-success-emphasis"><%= respondidas %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card shadow-sm p-4">
                <div class="card-body">
                    <h4 class="mb-4 mt-4">Tabla contacto</h4>
                    <div class="table-responsive text-center">
                        <table class="table table-hover table-bordered" id="tablaContacto">
                            <thead class="text-center" style="--bs-table-bg: #F5ECE1;">
                                <tr>
                                    <th scope="col">Id Contacto</th>
                                    <th scope="col"> Nombre de Remitente</th>
                                    <th scope="col">Telefono</th>
                                    <th scope="col">Correo</th>
                                    <th scope="col">Asunto</th>
                                    <th scope="col">Mensaje</th>
                                    <th scope="col">Fecha</th>
                                    <th scope="col">Estado</th>
                                    
                                    <th scope="col">Accion</th>
                                </tr>
                            </thead>
                            
                            <tbody>
                                <%
                                    if (lista == null || lista.isEmpty()) {
                                %>
                                    <tr class="fila-contacto no-registros">
                                        <td colspan="9" class="text-center text-muted">No hay registros de contactos disponibles</td> 
                                    </tr>
                                <%  
                                    } else {
                                        for (contacto con : lista) {
                                %>
                                    <tr class="align-middle fila-contacto" data-nombre="<%= con.getNombre().toLowerCase() %>">
                                        <th scope="row" class="text-center"><%= con.getId_contacto() %></th>
                                        <td><%=con.getNombre()%></td> 
                                        <td><%=con.getTelefono()%></td>
                                        <td><%=con.getCorreo()%></td>
                                        <td><%=con.getAsunto()%></td>
                                        <td><%=con.getMensaje()%></td>
                                        <td><%=con.getFecha()%></td>
                                        <td>
                                        <% if("Pendiente".equals(con.getEstado())) { %>
                                            <span class="badge bg-warning text-dark">
                                                Pendiente
                                            </span>
                                        <% } else { %>
                                            <span class="badge bg-success">
                                                Respondido
                                            </span>
                                        <% } %>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex flex-wrap justify-content-center gap-2">
                                                <% if("Pendiente".equals(con.getEstado())) { %>
                                                <button type="button" class="btn btn-redactar btn-sm"
                                                        onclick="prepararRedactar(
                                                            '<%= con.getId_contacto() %>',
                                                            '<%= con.getNombre() %>',
                                                            '<%= con.getCorreo() %>',
                                                            '<%= con.getAsunto() %>',
                                                            '<%= con.getMensaje() %>')">
                                                    <i class="fa-solid fa-envelope-open-text"></i>
                                                </button>
                                                    <% } else { %>
                                                    <button type="button" class="btn btn-success btn-sm"
                                                            onclick="verRespuesta(
                                                                '<%= con.getRespuesta() %>',
                                                                '<%= con.getFecha_respuesta() %>')">
                                                        <i class="fa-solid fa-eye"></i>
                                                    </button>
                                                 <% } %>
                                            </div>
                                        </td>
                                    </tr>
                                <%  
                                        } 
                                    } 
                                %>
                                <tr id="sinResultados" style="display:none;">
                                    <td colspan="9" class="text-center text-muted p-4">
                                        No se encontraron remitentes que coincidan con la búsqueda.
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
                                
             <div class="modal fade" id="modalRedactar" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <form action="controladorcontacto" method="POST" class="modal-content" id="formResponder">

                        <input type="hidden" name="accion" value="redactar">
                        <input type="hidden" name="id_contacto" id="re_id_contacto">
                        <input type="hidden" name="nombre" id="re_nombre_hidden">
                        <input type="hidden" name="asunto" id="re_asunto_hidden">
                        <input type="hidden" name="mensaje" id="re_mensaje_hidden">
                        <div class="modal-header">
                            <h5 class="modal-title">Responder contacto</h5>
                            <button type="button"
                                    class="btn-close"
                                    data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">

                            <div class="mb-3">
                                <label>Nombre</label>
                                <input type="text"
                                       id="re_nombre"
                                       class="form-control"
                                       readonly>
                            </div>

                            <div class="mb-3">
                                <label>Correo</label>
                                <input type="email"
                                       id="re_correo"
                                       name="correo"
                                       class="form-control"
                                       readonly>
                            </div>

                            <div class="mb-3">
                                <label>Asunto Original</label>
                                <input type="text"
                                       id="re_asunto"
                                       class="form-control"
                                       readonly>
                            </div>

                            <div class="mb-3">
                                <label>Mensaje recibido</label>
                                <textarea id="re_mensaje"
                                          class="form-control"
                                          rows="4"
                                          readonly></textarea>
                            </div>

                            <div class="mb-3">
                                <label>Respuesta</label>
                                <textarea name="respuesta"
                                          class="form-control"
                                          rows="6"
                                          required></textarea>
                            </div>

                        </div>

                        <div class="modal-footer">
                            <button type="submit"
                                    class="btn btn-primary">
                                Enviar respuesta
                            </button>
                        </div>

                    </form>
                </div>

            </div>  
            <div class="modal fade" id="modalDetalle" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <div class="modal-header">
                            <h5 class="modal-title">
                                Respuesta enviada
                            </h5>
                        </div>

                        <div class="modal-body">

                            <p>
                                <strong>Fecha:</strong>
                                <span id="detalle_fecha"></span>
                            </p>

                            <textarea id="detalle_respuesta"
                                      class="form-control"
                                      rows="8"
                                      readonly></textarea>

                        </div>

                    </div>
                </div>
            </div>
        </main>
        <!-- Bootstrap y alertify -->
        <jsp:include page="/componentes/pie.jsp" /> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="/componentes/alertas.jsp" />  
        <script>
            function prepararRedactar(id, nombre, correo,  asunto, mensaje) {
                document.getElementById('re_id_contacto').value = id;
                document.getElementById('re_nombre').value = nombre;
                document.getElementById('re_correo').value = correo; 
                document.getElementById('re_asunto').value = asunto; 
                document.getElementById('re_mensaje').value = mensaje;
                document.getElementById('re_nombre_hidden').value = nombre;
                document.getElementById('re_asunto_hidden').value = asunto;
                document.getElementById('re_mensaje_hidden').value = mensaje;
                var modal = new bootstrap.Modal(document.getElementById('modalRedactar'));
                modal.show();
            }
 
            
            document.addEventListener('DOMContentLoaded', function () {

                const inputBusqueda = document.getElementById('inputTermino');
                const filasContacto = document.querySelectorAll('.fila-contacto');
                const filaSinResultados = document.getElementById('sinResultados');

                if (inputBusqueda) {

                    inputBusqueda.addEventListener('input', function () {

                        const termino = this.value.toLowerCase().trim();
                        let coincidencias = 0;

                        filasContacto.forEach(fila => {

                            const nombre = fila.getAttribute('data-nombre');

                            if (nombre.includes(termino)) {
                                fila.style.display = '';
                                coincidencias++;
                            } else {
                                fila.style.display = 'none';
                            }

                        });

                        if (coincidencias === 0 && termino !== '') {
                            filaSinResultados.style.display = '';
                        } else {
                            filaSinResultados.style.display = 'none';
                        }

                    });

                }

            });
            function verRespuesta(respuesta, fecha){

                document.getElementById("detalle_respuesta").value = respuesta;
                document.getElementById("detalle_fecha").innerText = fecha;

                var modal = new bootstrap.Modal(
                    document.getElementById("modalDetalle")
                );

                modal.show();
            }
        </script>
        
        <script>
            document.getElementById("formResponder")
            .addEventListener("submit", function(e){

                e.preventDefault();

                Swal.fire({
                    title: '¿Enviar respuesta?',
                    text: 'Se enviará el correo al cliente y el estado cambiará a Respondido.',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#5a67d8',
                    cancelButtonColor: '#e53e3e',
                    confirmButtonText: 'Sí, enviar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {

                    if(result.isConfirmed){
                        this.submit();
                    }

                });

            });
        </script>
    </body>
</html>
