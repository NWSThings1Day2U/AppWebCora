<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid px-4">
    <form action="controladorusuario" id="formRegistro" method="POST" class="needs-validation" novalidate>
        <input type="hidden" name="accion" value="registro">

        <div class="row mb-4">
            <div class="col-md-6">
                <label class="form-label">Nombre Completo: </label>
                <div class="input-group">
                    <input type="text" class="form-control input-cora" name="nombre" required 
                           pattern="^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$" placeholder="Ingresa tu nombre">
                    <div class="invalid-feedback">Solo letras.</div>
                </div>
            </div>
            <div class="col-md-6">
                <label class="form-label">Dni: </label>
                <div class="input-group">
                    <input type="text" class="form-control val-numero input-cora" name="dni" required 
                           maxlength="8" pattern="\d{8}" placeholder="Ingresa tu Dni">
                    <div class="invalid-feedback">Deben ser 8 dígitos.</div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6">
                <label class="form-label">Correo: </label>
                <div class="input-group">
                    <input type="email" class="form-control input-cora" name="correo" required 
                           placeholder="Ingresa tu correo">
                    <div class="invalid-feedback">Correo no válido.</div>
                </div>
            </div>
            <div class="col-md-6">
                <label class="form-label">Teléfono: </label>
                <div class="input-group">
                    <input type="text" class="form-control val-numero input-cora" name="telefono" required 
                           maxlength="9" pattern="9\d{8}" placeholder="Ingresa tu nro telefonico">
                    <div class="invalid-feedback">Debe empezar con 9 y tener 9 dígitos.</div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6">
                <label class="form-label">Contraseña: </label>
                <div class="input-group group-cora">
                    <input type="password" class="form-control input-cora" name="contrasena" id="reg_pass" 
                           required minlength="6" placeholder="Ingresa tu contraseña">
                    <span class="input-group-text" id="togglePassword1" style="border-left: none; cursor: pointer;">
                       <i class="fa-regular fa-eye" id="eyeIcon1"></i>
                    </span>
                    <div class="invalid-feedback">Mínimo 6 caracteres.</div>
                </div>
            </div>
            <div class="col-md-6">
                <label class="form-label">Confirmación: </label>
                <div class="input-group group-cora">
                    <input type="password" class="form-control input-cora" name="confirmar_contrasena" id="reg_pass_conf" 
                           required placeholder="Ingresa nuevamente tu contraseña">
                    <span class="input-group-text" id="togglePassword2" style="border-left: none; cursor: pointer;">
                        <i class="fa-regular fa-eye" id="eyeIcon2"></i>
                    </span>
                    <div class="invalid-feedback" id="pass_match_error">Las contraseñas no coinciden.</div>
                </div>
            </div>
        </div>

        <button type="submit" class="btn btn-primary mt-4 w-100 mb-3"> Registrarse  </button>
    </form>
</div> 
<p class="card-text text-center mt-3 ">
    <small class="text-body-secondary ">¿Ya tienes cuenta? <a href="controladorpagina?pagina=cuenta&modo=login" class="link-cora-card" >Iniciar Sesión</a></small>
</p>   
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
</script>
