<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.usuariodao" %>
<%@ page import="modelo.usuarios" %>
<%@page import="java.util.List"%>
<%
    List<modelo.usuarios> listaUsuarios = (List<modelo.usuarios>) request.getAttribute("listaUsuarios");
    if (listaUsuarios == null) {
        dao.usuariodao usuDao = new dao.usuariodao();
        listaUsuarios = usuDao.listarusuarios();
    }
    int totalUsuarios = 0;
    int UsuariosActivos = 0;
    int Clientes = 0;
    int Admin =0;
    if (listaUsuarios != null) {
        totalUsuarios = listaUsuarios.size();
        for (modelo.usuarios usu : listaUsuarios) {
            if (usu.getEstadousuario() == 1) {
                UsuariosActivos++;
            }
            
           if (usu.getRol().equals("cliente")) {
                Clientes++;
            }
            if(usu.getRol().equals("admin")){
                Admin++;
            }
            
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion Usuarios</title>
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
    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "usuarios");
        %>
        <jsp:include page="../componentes/encabezado.jsp" />
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Listado de Usuarios</h2>

            <div class="card p-4 border-top-0 rounded-bottom mb-5" style="box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 w-100">

                <!-- BLOQUE IZQUIERDO: Buscador y Botón Nuevo Usuario -->
                <div class="d-flex align-items-center gap-2">
                     <form class="d-flex" id="formBuscar" onsubmit="return false;">
                        <div class="input-group">
                            <input class="form-control border-end-0" id="inputTermino" type="search" placeholder="Busca usuario...">
                            <button class="input-group-text border-start-0 bg-white" type="button">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </form>

                    <button class="btn btn-primary px-3 text-nowrap" 
                            data-bs-toggle="modal" 
                            data-bs-target="#modalInsertar" style="background-color: #dcaea8; border-color: #dcaea8; color: #4a2c2a;">
                        <i class="fa-solid fa-user-plus me-2"></i>Nuevo Usuario
                    </button>
                </div>

                <!-- BLOQUE DERECHO: Métricas alineadas horizontalmente -->
                <div class="d-flex gap-2 justify-content-end flex-wrap">
                    <div style="width: 110px;">
                        <div class="p-2 text-center rounded border bg-light shadow-sm">
                            <small class="text-muted d-block text-truncate">Total</small>
                            <span class="fs-5 fw-bold text-dark"><%= totalUsuarios %></span>
                        </div>
                    </div>
                    <div style="width: 110px;">
                        <div class="p-2 text-center rounded border bg-info-subtle shadow-sm">
                            <small class="text-info d-block text-truncate">Activos</small>
                            <span class="fs-5 fw-bold text-info"><%= UsuariosActivos %></span>
                        </div>
                    </div>
                    <div style="width: 110px;">
                        <div class="p-2 text-center rounded border bg-success-subtle shadow-sm">
                            <small class="text-success d-block text-truncate">Clientes</small>
                            <span class="fs-5 fw-bold text-success"><%= Clientes%></span>
                        </div>
                    </div>
                    <div style="width: 125px;">
                        <div class="p-2 text-center rounded border bg-danger-subtle shadow-sm">
                            <small class="text-danger d-block text-truncate">Admins</small>
                            <span class="fs-5 fw-bold text-danger"><%= Admin%></span>
                        </div>
                    </div>
                </div>

            </div>
        </div>

            <ul class="nav nav-tabs " id="pestanasUsuarios" role="tablist">
                <li class="nav-item active-cora" role="presentation">
                    <button class="nav-link active link-cora" id="general-tab"  data-bs-toggle="tab" data-bs-target="#panel-general" type="button" role="tab" aria-controls="panel-general" aria-selected="true">
                        General
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link link-cora" id="clientes-tab" data-bs-toggle="tab" data-bs-target="#panel-clientes" type="button" role="tab" aria-controls="panel-clientes" aria-selected="false">
                        Clientes
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link link-cora" id="admin-tab" data-bs-toggle="tab" data-bs-target="#panel-admin" type="button" role="tab" aria-controls="panel-admin" aria-selected="false">
                        Administradores
                    </button>
                </li>
            </ul>

            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm p-4 border-top-0 rounded-bottom">
                        <div class="card-body">

                            <div class="tab-content table-" id="contenidoPestanas">

                                <div class="tab-pane fade show active" id="panel-general" role="tabpanel" aria-labelledby="general-tab">
                                    <h4 class="mb-4 mt-2">Todos los usuarios</h4>
                                    <div class="table-responsive">
                                    <table class="table table-hover table-bordered">
                                        <thead class="text-center" style="--bs-table-bg: #F5ECE1;">
                                            <tr>
                                                <th>Id Usuario</th><th>Nombre de Usuario</th><th>Nombre completo</th><th>Dni</th><th>Correo</th><th>Teléfono</th><th>Imagen</th><th>Rol</th><th>Estado</th><th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if (listaUsuarios == null || listaUsuarios.isEmpty()) {
                                            %>
                                            <tr>
                                                <td colspan="10" class="text-center text-muted">No hay registros de usuarios disponibles</td> 
                                            </tr>
                                            <%
                                                } else {
                                                    for(usuarios usu: listaUsuarios){
                                                        String estado ="Inactivo";
                                                        String color = "text-bg-secondary";
                                                        if(usu.getEstadousuario()==1){
                                                            estado = "Activo";
                                                            color = "text-bg-primary";
                                                        }
                                            %>
                                            <tr class="align-middle fila-usuario" data-nombre="<%= usu.getNombreusuario().toLowerCase() %>">
                                                <th scope="row" class="text-center"><%=usu.getIdUsuario()%></th>
                                                <td><%=usu.getNombreusuario()%></td>
                                                <td><%=usu.getNombrecompleto()%></td>
                                                <td><%=usu.getDni()%></td>
                                                <td><%=usu.getCorreo()%></td>
                                                <td><%=usu.getTelefono()%></td>
                                                <td class="text-center">
                                                    <img src="recursos/<%= (usu.getImagen() != null && !usu.getImagen().isEmpty()) ? usu.getImagen() : "cuenta.jpg" %>" 
                                                         alt="<%= usu.getNombreusuario() %>" 
                                                         width="60" 
                                                         height="60" 
                                                         style="object-fit: cover;" 
                                                         class="rounded border shadow-sm">
                                                </td>
                                                <td><%=usu.getRol()%></td>
                                                <td><span class="badge <%=color%>"><%=estado%></span></td>
                                                <td class="text-center">
                                                    <div class="d-flex flex-wrap justify-content-center gap-2">
                                                        <button type="button"
                                                                class="btn btn-warning btn-sm btn-editar"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalEditar"

                                                                data-id="<%= usu.getIdUsuario() %>"
                                                                data-user="<%= usu.getNombreusuario() %>"
                                                                data-nombre="<%= usu.getNombrecompleto() %>"
                                                                data-dni="<%= usu.getDni() %>"
                                                                data-correo="<%= usu.getCorreo() %>"
                                                                data-telefono="<%= usu.getTelefono() %>"
                                                                data-estado="<%= usu.getEstadousuario() %>"
                                                                data-rol="<%= usu.getRol() %>"
                                                                data-imagen="<%= usu.getImagen() %>">

                                                            <i class="fa-solid fa-pencil"></i>
                                                        </button>
                                                        <button type="button"
                                                                class="btn btn-danger btn-sm btn-eliminar"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalEliminar"
                                                                data-id="<%= usu.getIdUsuario() %>">

                                                            <i class="fa-solid fa-trash"></i>
                                                        </button>

                                                    </div>
                                                         
                                                </td>
                                                
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                            <tr class="sinResultados" style="display: none;">
                                    <td colspan="10" class="text-center text-muted p-4">No se encontraron usuarios que coincidan con la búsqueda.</td>
                                </tr>
                                        </tbody>
                                    </table>
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="panel-clientes" role="tabpanel" aria-labelledby="clientes-tab">
                                    <h4 class="mb-4 mt-2 text-success">Tabla de clientes</h4>
                                    <table class="table table-hover table-bordered">
                                        <thead class="text-center" style="--bs-table-bg: #F5ECE1;">
                                            <tr>
                                                <th>Id Usuario</th><th>Nombre de Usuario</th><th>Nombre completo</th><th>Dni</th><th>Correo</th><th>Teléfono</th><th>Imagen</th><th>Estado</th><th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if (listaUsuarios == null || listaUsuarios.isEmpty()) {
                                            %>
                                            <tr>
                                                <td colspan="10" class="text-center text-muted">No hay registros de usuarios disponibles</td> 
                                            </tr>
                                            <%
                                                } else {
                                                    for(usuarios usu: listaUsuarios){
                                                        if(usu.getRol().equals("cliente")){
                                                            String estado ="Inactivo";
                                                            String color = "text-bg-secondary";
                                                            if(usu.getEstadousuario()==1){
                                                                estado = "Activo";
                                                                color = "text-bg-primary";
                                                            }
                                            %>
                                            <tr class="align-middle fila-usuario" data-nombre="<%= usu.getNombreusuario().toLowerCase() %>">
                                                <th scope="row" class="text-center"><%=usu.getIdUsuario()%></th>
                                                <td><%=usu.getNombreusuario()%></td>
                                                <td><%=usu.getNombrecompleto()%></td>
                                                <td><%=usu.getDni()%></td>
                                                <td><%=usu.getCorreo()%></td>
                                                <td><%=usu.getTelefono()%></td>
                                                <td class="text-center">
                                                    <img src="recursos/<%= (usu.getImagen() != null && !usu.getImagen().isEmpty()) ? usu.getImagen() : "cuenta.jpg" %>" 
                                                         alt="<%= usu.getNombreusuario() %>" 
                                                         width="60" 
                                                         height="60" 
                                                         style="object-fit: cover;" 
                                                         class="rounded border shadow-sm">
                                                </td>
                                                <td><span class="badge <%=color%>"><%=estado%></span></td>
                                                <td class="text-center">
                                                    <div class="d-flex flex-wrap justify-content-center gap-2">
                                                       <button type="button"
                                                                class="btn btn-warning btn-sm btn-editar"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalEditar"

                                                                data-id="<%= usu.getIdUsuario() %>"
                                                                data-user="<%= usu.getNombreusuario() %>"
                                                                data-nombre="<%= usu.getNombrecompleto() %>"
                                                                data-dni="<%= usu.getDni() %>"
                                                                data-correo="<%= usu.getCorreo() %>"
                                                                data-telefono="<%= usu.getTelefono() %>"
                                                                data-estado="<%= usu.getEstadousuario() %>"
                                                                data-rol="<%= usu.getRol() %>"
                                                                data-imagen="<%= usu.getImagen() %>">

                                                            <i class="fa-solid fa-pencil"></i>
                                                        </button>
                                                        <button type="button"
                                                                class="btn btn-danger btn-sm btn-eliminar"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalEliminar"
                                                                data-id="<%= usu.getIdUsuario() %>">

                                                            <i class="fa-solid fa-trash"></i>
                                                        </button>
                                                    </div>
                                                         
                                                </td>
                                                
                                            </tr>
                                            <%          }
                                                    }
                                                }
                                            %>
                                            <tr class="sinResultados" style="display: none;">
                                    <td colspan="9" class="text-center text-muted p-4">No se encontraron usuarios que coincidan con la búsqueda.</td>
                                </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="tab-pane fade" id="panel-admin" role="tabpanel" aria-labelledby="admin-tab">
                                    <h4 class="mb-4 mt-2 text-danger">Tabla de administradores</h4>
                                    <table class="table table-hover table-bordered">
                                        <thead class="text-center" style="--bs-table-bg: #F5ECE1;">
                                            <tr>
                                                <th>Id Usuario</th><th>Nombre de Usuario</th><th>Nombre completo</th><th>Dni</th><th>Correo</th><th>Teléfono</th><th>Imagen</th><th>Estado</th><th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if (listaUsuarios == null || listaUsuarios.isEmpty()) {
                                            %>
                                            <tr>
                                                <td colspan="10" class="text-center text-muted">No hay registros de usuarios disponibles</td> 
                                            </tr>
                                            <%
                                                } else {
                                                    for(usuarios usu: listaUsuarios){
                                                        if(usu.getRol().equals("admin")){

                                                            String estado ="Inactivo";
                                                            String color = "text-bg-secondary";
                                                            if(usu.getEstadousuario()==1){
                                                                estado = "Activo";
                                                                color = "text-bg-primary";
                                                            }
                                            %>
                                            <tr class="align-middle fila-usuario" data-nombre="<%= usu.getNombreusuario().toLowerCase() %>">
                                                <th scope="row" class="text-center"><%=usu.getIdUsuario()%></th>
                                                <td><%=usu.getNombreusuario()%></td>
                                                <td><%=usu.getNombrecompleto()%></td>
                                                <td><%=usu.getDni()%></td>
                                                <td><%=usu.getCorreo()%></td>
                                                <td><%=usu.getTelefono()%></td>
                                                <td class="text-center">
                                                    <img src="recursos/<%= (usu.getImagen() != null && !usu.getImagen().isEmpty()) ? usu.getImagen() : "cuenta.jpg" %>" 
                                                         alt="<%= usu.getNombreusuario() %>" 
                                                         width="60" 
                                                         height="60" 
                                                         style="object-fit: cover;" 
                                                         class="rounded border shadow-sm">
                                                </td>
                                                <td><span class="badge <%=color%>"><%=estado%></span></td>
                                                <td class="text-center">
                                                    <div class="d-flex flex-wrap justify-content-center gap-2">
                                                        <button type="button"
                                                                class="btn btn-warning btn-sm btn-editar"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalEditar"

                                                                data-id="<%= usu.getIdUsuario() %>"
                                                                data-user="<%= usu.getNombreusuario() %>"
                                                                data-nombre="<%= usu.getNombrecompleto() %>"
                                                                data-dni="<%= usu.getDni() %>"
                                                                data-correo="<%= usu.getCorreo() %>"
                                                                data-telefono="<%= usu.getTelefono() %>"
                                                                data-estado="<%= usu.getEstadousuario() %>"
                                                                data-rol="<%= usu.getRol() %>"
                                                                data-imagen="<%= usu.getImagen() %>">

                                                            <i class="fa-solid fa-pencil"></i>
                                                        </button>
                                                        <button type="button"
                                                                class="btn btn-danger btn-sm btn-eliminar"
                                                                data-bs-toggle="modal"
                                                                data-bs-target="#modalEliminar"
                                                                data-id="<%= usu.getIdUsuario() %>">

                                                            <i class="fa-solid fa-trash"></i>
                                                        </button>
                                                    </div>
                                                         
                                                </td>
                                                
                                            </tr>
                                            <%          }
                                                    }
                                                }
                                            %>
                                            <tr class="sinResultados" style="display: none;">
                                    <td colspan="9" class="text-center text-muted p-4">No se encontraron usuarios que coincidan con la búsqueda.</td>
                                </tr>
                                        </tbody>
                                    </table>
                                </div>

                            </div> 

                        </div>
                    </div>
                </div>
            </div>
            
            <div class="modal fade" id="modalInsertar" tabindex="-1" aria-labelledby="modalInsertarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalInsertarLabel"><i class="fa-solid fa-user me-2"></i>Agregar Nuevo Usuario</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formRegistrarUsuario" action="controladorusuarios" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="accion" value="registrarusuarios">
                                <div class="mb-3">
                                    <label class="form-label">Nombre Completo </label>
                
                                    <input type="text" class="form-control input-cora" name="nombre" required 
                                           pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$" placeholder="Escribe nombre">
                                    <div class="invalid-feedback">Solo letras.</div>
               
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Dni </label>
                                    <input type="text" class="form-control val-numero input-cora" name="dni" required 
                                        maxlength="8" pattern="\d{8}" placeholder="Escribe Dni">
                                    <div class="invalid-feedback">Deben ser 8 dígitos.</div>
       
                    
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Correo </label>
                                    <input type="email" class="form-control input-cora" name="correo" required 
                                            placeholder="Escribe correo">
                                    <div class="invalid-feedback">Correo no válido.</div>
                                    
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Teléfono </label>
                                    <input type="text" class="form-control val-numero input-cora" name="telefono" required 
                                    maxlength="9" pattern="9\d{8}" placeholder="Escribe nro telefonico">
                                    <div class="invalid-feedback">Debe empezar con 9 y tener 9 dígitos.</div>
                                    
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Imagen de Usuario</label>
                                    <input type="file" class="form-control" name="imagen" accept="image/*">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Contraseña</label>
                                    <div class="input-group group-cora">
                                        <input type="password" class="form-control input-cora" name="contrasena" id="reg_pass" 
                                               required minlength="6" placeholder="Escribe contraseña">
                                        <span class="input-group-text" id="togglePassword1" style="border-left: none; cursor: pointer;">
                                           <i class="fa-regular fa-eye" id="eyeIcon1"></i>
                                        </span>
                                        <div class="invalid-feedback">Mínimo 6 caracteres.</div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Confirmación</label>
                                    <div class="input-group group-cora">
                                        <input type="password" class="form-control input-cora" name="confirmar_contrasena" id="reg_pass_conf" 
                                               required placeholder="Escribe nuevamente contraseña">
                                        <span class="input-group-text" id="togglePassword2" style="border-left: none; cursor: pointer;">
                                            <i class="fa-regular fa-eye" id="eyeIcon2"></i>
                                        </span>
                                        <div class="invalid-feedback" id="pass_match_error">Las contraseñas no coinciden.</div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Rol</label>
                                    <select class="form-select" name="id_rol" required>
                                        <option value="" disabled selected>Selecciona rol de usuario</option>
                                        <option value="1">admin</option>
                                        <option value="2">cliente</option>
                                    </select>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" form="formRegistrarUsuario" class="btn btn-primary" style="background-color: #5a67d8; border-color: #5a67d8;">Guardar Usuario</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="modalEditarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <form id="formEditarUsuarios" action="controladorusuarios" method="POST" enctype="multipart/form-data" class="modal-content needs-validation" novalidate>
                        <input type="hidden" name="accion" value="editarusuario">
                        <input type="hidden" name="imagenActual" id="edit_imagen_actual">
                        <input type="hidden" name="id_usuario" id="edit_id_usuario"> 
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalEditarLabel">Editar Usuario</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="edit_nombre" class="form-label">Nombre del Usuario</label>
                                <input type="text" class="form-control" id="edit_nombre" name="nombreusuario" required minlength="3">
                                <div class="invalid-feedback">Por favor, ingrese un nombre válido (mínimo 3 caracteres).</div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="edit_contrasena" class="form-label">Nueva contraseña</label>
                               <div class="input-group group-cora">
                                        <input type="password" class="form-control input-cora" name="contrasena" id="reg_contra" 
                                                minlength="6" placeholder="Escribe contraseña">
                                        <span class="input-group-text" id="togglePassword3" style="border-left: none; cursor: pointer;">
                                           <i class="fa-regular fa-eye" id="eyeIcon3"></i>
                                        </span>
                                        <div class="invalid-feedback">Mínimo 6 caracteres.</div>
                                    </div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_contrasena" class="form-label">Confirmar contraseña</label>
                                <div class="input-group group-cora">
                                        <input type="password" class="form-control input-cora" name="confirmar_contrasena" id="reg_contra_conf" 
                                                placeholder="Escribe nuevamente contraseña">
                                        <span class="input-group-text" id="togglePassword4" style="border-left: none; cursor: pointer;">
                                            <i class="fa-regular fa-eye" id="eyeIcon4"></i>
                                        </span>
                                        <div class="invalid-feedback" id="contra_match_error">Las contraseñas no coinciden.</div>
                                    </div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_descripcion" class="form-label">Nombre completo</label>
                                <input type="text" class="form-control input-cora" name="nombre" required 
                                           pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$" placeholder="Escribe nombre">
                                    <div class="invalid-feedback">Solo letras.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_stockmin" class="form-label">Correo</label>
                                <input type="email" class="form-control input-cora" name="correo" required  placeholder="Escribe correo">
                                <div class="invalid-feedback">Correo no válido.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_descuento" class="form-label">DNI</label>
                                <input type="text" class="form-control val-numero input-cora" name="dni" required 
                                        maxlength="8" pattern="\d{8}" placeholder="Escribe Dni">
                                    <div class="invalid-feedback">Deben ser 8 dígitos.</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Teléfono </label>
                                    <input type="text" class="form-control val-numero input-cora" name="telefono" required 
                                    maxlength="9" pattern="9\d{8}" placeholder="Escribe nro telefonico">
                                    <div class="invalid-feedback">Debe empezar con 9 y tener 9 dígitos.</div>
                            </div>
                            <div class="mb-3">
                                <label for="edit_imagen" class="form-label">Cambiar Imagen (Opcional)</label>
                                <input type="file" class="form-control" id="edit_imagen" name="imagen" accept="image/*">
                            </div>
                            <div class="mb-3">
                                    <label class="form-label">Rol</label>
                                    <select class="form-select" name="id_rol" required>
                                        <option value="" disabled selected>Selecciona rol de usuario</option>
                                        <option value="1">admin</option>
                                        <option value="2">cliente</option>
                                    </select>
                                </div>
                            <div class="mb-3">
                                <label for="edit_estado" class="form-label">Estado del Usuario</label>
                                <select class="form-select" id="edit_estado" name="estado" required>
                                    <option value="1">Activo</option>
                                    <option value="0">Inactivo</option>
                                </select>
                            </div>  
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        </div>
                    </form>
                </div>
            </div>                                
            <div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <form action="controladorusuarios" method="POST" class="modal-content">
                        <input type="hidden" name="accion" value="eliminarusuario">
                        <input type="hidden" name="id_usuario" id="delete_id_usuario">
                        <div class="modal-header">
                            <h5 class="modal-title">Desactivar Usuario</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            ¿Deseas desactivar el Usuario con ID: <strong id="lbl_delete_usuario_id"></strong>?
                            <br><strong>No tendra acceso al sistema</strong>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-danger">Eliminar</button>
                        </div>
                    </form>
                </div>
            </div>                                
        </main>

        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="../componentes/alertas.jsp" /> 
                <jsp:include page="../componentes/mensajes.jsp" />  
        <script>
            
            (function () {
                'use strict';
                const forms = document.querySelectorAll('.needs-validation');
                Array.from(forms).forEach(form => {
                    form.addEventListener('submit', event => {
                        const p1 = document.getElementById('reg_pass');
                        const p2 = document.getElementById('reg_pass_conf');

                        if (p1 && p2 && p1.value !== p2.value) {
                            p2.setCustomValidity('Invalid');
                        } else if (p2) {
                            p2.setCustomValidity('');
                        }

                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });

                document.querySelectorAll('.val-numero').forEach(input => {
                    input.addEventListener('input', function () {
                        this.value = this.value.replace(/\D/g, '');
                    });
                });
            })();

            function setupPasswordToggle(buttonId, inputId, iconId) {
                const btn = document.getElementById(buttonId);
                const input = document.getElementById(inputId);
                const icon = document.getElementById(iconId);

                if (btn && input && icon) {
                    btn.addEventListener('click', function () {
                        if (input.type === "password") {
                            input.type = "text";
                            icon.classList.replace('fa-eye', 'fa-eye-slash');
                        } else {
                            input.type = "password";
                            icon.classList.replace('fa-eye-slash', 'fa-eye');
                        }
                        this.classList.toggle('active');
                        input.classList.toggle('is-visible');
                    });
                }
            }

            setupPasswordToggle('togglePassword1', 'reg_pass', 'eyeIcon1');
            setupPasswordToggle('togglePassword2', 'reg_pass_conf', 'eyeIcon2');
            setupPasswordToggle('togglePassword3', 'reg_contra', 'eyeIcon3');
            setupPasswordToggle('togglePassword4', 'reg_contra_conf', 'eyeIcon4');
            
            // --- SISTEMA DE FILTRADO DINÁMICO EN TIEMPO REAL ---
           const inputBusqueda = document.getElementById('inputTermino');

            inputBusqueda.addEventListener('input', function () {
                const termino = this.value.toLowerCase().trim();

                document.querySelectorAll('tbody').forEach(tbody => {

                    const filas = tbody.querySelectorAll('tr[data-nombre]');
                    const filaSinResultados = tbody.querySelector('.sinResultados');

                    let coincidencias = 0;

                    filas.forEach(fila => {
                        const nombre = fila.dataset.nombre;

                        if (nombre.includes(termino)) {
                            fila.style.display = '';
                            coincidencias++;
                        } else {
                            fila.style.display = 'none';
                        }
                    });

                    if (filaSinResultados) {
                        filaSinResultados.style.display =
                                (coincidencias === 0 && termino !== '')
                                ? ''
                                : 'none';
                    }
                });
            });
            
            
            
            document.querySelectorAll('.btn-editar').forEach(btn => {

                btn.addEventListener('click', function () {

                    document.getElementById('edit_id_usuario').value =
                            this.dataset.id;

                    document.getElementById('edit_nombre').value =
                            this.dataset.user;

                    document.querySelector('#formEditarUsuarios input[name="nombre"]').value =
                            this.dataset.nombre;

                    document.querySelector('#formEditarUsuarios input[name="dni"]').value =
                            this.dataset.dni;

                    document.querySelector('#formEditarUsuarios input[name="correo"]').value =
                            this.dataset.correo;

                    document.querySelector('#formEditarUsuarios input[name="telefono"]').value =
                            this.dataset.telefono;

                    document.getElementById('edit_estado').value =
                            this.dataset.estado;

                    // Rol
                    const rolSelect =
                            document.querySelector('#formEditarUsuarios select[name="id_rol"]');

                    if (this.dataset.rol === 'admin') {
                        rolSelect.value = "1";
                    } else {
                        rolSelect.value = "2";
                    }

                    document.getElementById('edit_imagen_actual').value =
                            this.dataset.imagen;
                });

            });


            document.querySelectorAll('.btn-eliminar').forEach(btn => {

                btn.addEventListener('click', function () {

                    const id = this.dataset.id;

                    document.getElementById('delete_id_usuario').value = id;

                    document.getElementById('lbl_delete_usuario_id').textContent = id;
                });

            });

            const form = document.getElementById('formEditarUsuarios');

            form.addEventListener('submit', event => {

                const p1 = document.getElementById('reg_contra');
                const p2 = document.getElementById('reg_contra_conf');

                if (p1.value !== '' || p2.value !== '') {

                    if (p1.value.length < 6) {
                        p1.setCustomValidity('Invalid');
                    } else {
                        p1.setCustomValidity('');
                    }

                    if (p1.value !== p2.value) {
                        p2.setCustomValidity('Invalid');
                    } else {
                        p2.setCustomValidity('');
                    }
                } else {
                    p1.setCustomValidity('');
                    p2.setCustomValidity('');
                }

                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');
            });
        </script>

    </body>
</html>
