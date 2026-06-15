<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="estilos/estilosa.css">
    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "perfil");
        %>
        <jsp:include page="../componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Mi Perfil</h2>

            <div class="card p-4 border-top-0 rounded-bottom mb-5" style="box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);">
                    <form action="controladorperfil" id="formPerfil" method="POST" enctype="multipart/form-data" class="needs-validation" novalidate>
                        <div class="row g-0">
                            <div class="col-md-5">
                                <div class="position-relative h-100 p-4" >
                                    <img id="previewImagen" src="${pageContext.request.contextPath}/recursos/${sessionScope.imagen}"
                                         class="img-fluid rounded-start h-100" alt="Foto de perfil"
                                         style="object-fit: cover; width: 100%; min-height: 400px;border-radius: 6px;">

                                    <div id="contenedorImagen" class="position-absolute bottom-0 p-5" 
                                        style="display: none; width: 100%; background: rgba(255,255,255,0.9); padding: 1rem; justify-content: center; align-items: center;">

                                       <label for="imagenPerfil" class="btn btn-foto-cora m-0">
                                           <i class="fa-solid fa-camera me-2"></i> Cambiar foto
                                       </label>

                                       <input type="file" id="imagenPerfil" name="imagenPerfil" accept="image/*" hidden>
                                   </div>
                                                                   
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="card-body p-4 m-4">
                                    <div class="row mb-4 align-items-center">
                                        <div class="col-auto">
                                            <div class="d-flex align-items-center justify-content-center " style="color: #B1564E;" >
                                                <i class="fa-solid fa-user fs-5"></i>
                                            </div>
                                        </div>

                                        <div class="col">
                                            <h4 class="m-0" style="color: #BF746E;">
                                                Información Personal
                                            </h4>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Nombre de Usuario: </label>
                                            <input type="text" class="form-control input-cora editable" name="nombreUsuario" 
                                                   value="${datosUsuario.nombreusuario}" ${not empty sessionScope.error ? '' : 'disabled'} >
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">ID: </label>
                                            <input type="number" class="form-control input-cora" value="${datosUsuario.idUsuario}" readonly disabled>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Nombre completo: </label>
                                            <input type="text" class="form-control input-cora editable" name="nombreCompleto" 
                                                   value="${datosUsuario.nombrecompleto}" required 
                                                   ${not empty sessionScope.error ? '' : 'disabled'}>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">DNI: </label>
                                            <input type="text" class="form-control input-cora" value="${datosUsuario.dni}" readonly disabled>
                                        </div>
                                    </div>

                                    <div class="row mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Nro. Telefónico: </label>
                                            <input type="text" class="form-control input-cora editable" name="telefono" 
                                                   value="${datosUsuario.telefono}" required 
                                                   ${not empty sessionScope.error ? '' : 'disabled'} pattern="9\d{8}" maxlength="9" 
                                                   title="El teléfono debe empezar con 9 y tener 9 dígitos numéricos.">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Correo Electrónico: </label>
                                            <input type="email" class="form-control input-cora editable" name="correo" 
                                                   value="${datosUsuario.correo}" required 
                                                   ${not empty sessionScope.error ? '' : 'disabled'} pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                                                   title="Ingrese un correo electrónico válido (ejemplo@dominio.com)">
                                        </div>
                                    </div>

                                    <div id="seccionPassword" style="display: ${not empty sessionScope.error ? 'block' : 'none'};">
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <label class="form-label">Nueva Contraseña: </label>
                                                <input type="password" class="form-control input-cora editable" name="contrasena" 
                                                       minlength="6"  ${not empty sessionScope.error ? '' : 'disabled'}>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Confirmar Contraseña: </label>
                                                <input type="password" class="form-control input-cora editable" name="confirmar_contrasena" 
                                                       minlength="6"  ${not empty sessionScope.error ? '' : 'disabled'}>
                                            </div>
                                        </div>
                                    </div>

                                    <button type="button" id="btnEditar" class="btn btn-primary-cora w-100 mb-2" 
                                            style="display: ${not empty sessionScope.error ? 'none' : 'block'}; ">
                                        <i class="fa-solid fa-pencil me-2"></i> Editar información
                                    </button>

                                    <button type="submit" id="btnGuardar" class="btn btn-primary-cora w-100 mb-2" 
                                            style="display: ${not empty sessionScope.error ? 'block' : 'none'}; ">
                                        <i class="fa-solid fa-floppy-disk me-2"></i> Guardar cambios
                                    </button>


                                </div>
                            </div>
                        </div>
                    </form>

                </div>
        </main>

        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        <jsp:include page="../componentes/mensajes.jsp" />
        <script>
            document.getElementById('btnEditar').addEventListener('click', function () {
                const campos = document.querySelectorAll('.editable');
                campos.forEach(campo => campo.disabled = false);

                document.getElementsByName('nombreUsuario')[0].disabled = false;

                document.getElementById('seccionPassword').style.display = 'block';
                const contenedor = document.getElementById('contenedorImagen');

                contenedor.style.display = 'flex'; 
                contenedor.style.justifyContent = 'center';
                this.style.display = 'none';
                document.getElementById('btnGuardar').style.display = 'block';
            });
        </script>
        <script>
            document.getElementById("imagenPerfil").addEventListener("change", function (e) {

                const archivo = e.target.files[0];

                if (archivo) {
                    const lector = new FileReader();

                    lector.onload = function (event) {
                        document.getElementById("previewImagen").src = event.target.result;
                    };

                    lector.readAsDataURL(archivo);
                }

            });
        </script>
    </body>
</html>
