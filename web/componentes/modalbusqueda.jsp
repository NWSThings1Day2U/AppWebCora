<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="modalBusqueda" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content" style="background-color: #f5f1ec; border: none;">
            <div class="container d-flex justify-content-end pt-4 pe-5">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="font-size: 1.5rem; color: #dbb1ad;"></button>
            </div>
            <div class="modal-body d-flex flex-column align-items-center">
                <div class="w-50 position-relative mb-3" style="max-width: 600px;">
                    <input type="text" id="inputBuscar" class="form-control-buscar" placeholder="Buscar en nuestra tienda..." autocomplete="off">
                    <i class="fa-solid fa-magnifying-glass posicion-lupa"></i>
                </div>
                <div class="sugerencias-contenedor mb-5 text-center">
                    <span class="text-muted small">Sugerencias:</span>
                    <a href="#" class="link-sugerencia" onclick="buscarSugerencia('Vestidos')">Vestidos</a>
                    <a href="#" class="link-sugerencia" onclick="buscarSugerencia('Pantalones')">Pantalones</a>
                    <a href="#" class="link-sugerencia" onclick="buscarSugerencia('Collares')">Collares</a>
                </div>
                <div class="container">
                    <div id="contenedorResultados" class="row g-4 justify-content-center">
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const inputBuscar = document.getElementById("inputBuscar");
    const contenedorResultados = document.getElementById("contenedorResultados");
    const miModal = document.getElementById('modalBusqueda');

    if (miModal) {
        miModal.addEventListener('shown.bs.modal', function () {
            const inputEncabezado = document.querySelector('input[name="termino"]');
            
            if (inputEncabezado && inputBuscar && inputEncabezado.value.trim() !== "") {
                inputBuscar.value = inputEncabezado.value;
                inputBuscar.dispatchEvent(new Event('input')); 
            }
            if (inputBuscar) {
                inputBuscar.focus(); 
            }
        });
    }

    if (inputBuscar) {
        inputBuscar.addEventListener("input", function () {
            let texto = inputBuscar.value.trim();

            if (texto.length >= 2) { 
                let url = 'controladorpagina?pagina=buscar&termino=' + encodeURIComponent(texto);

                fetch(url)
                    .then(response => response.text())
                    .then(html => {
                        contenedorResultados.innerHTML = html;
                    })
                    .catch(error => {
                        console.error("Error al recuperar los productos:", error);
                    });
            } else {
                contenedorResultados.innerHTML = ""; 
            }
        });
    }
});

function buscarSugerencia(palabra) {
    const inputBuscar = document.getElementById("inputBuscar");
    if(inputBuscar) {
        inputBuscar.value = palabra;
        inputBuscar.dispatchEvent(new Event('input'));
    }
}
</script>

<style>
    body {
    font-family: "Luxurious Roman", serif;
    background-color: #f5f1ec;
}
.form-control-buscar {
    width: 100%;
    border: none;
    border-bottom: 1px solid #a68b6d;
    background-color: white;
    padding: 15px 45px 15px 20px;
    font-size: 1.2rem;
    color: #382c2b;
    border-radius: 4px;
    outline: none;
}
.form-control-buscar::placeholder {
    color: #a68b6d;
}
.posicion-lupa {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
    color: #6b584c;
    font-size: 1.2rem;
}
.link-sugerencia {
    color: #dbb1ad;
    text-decoration: none;
    margin-left: 10px;
    font-size: 0.9rem;
}
.link-sugerencia:hover {
    text-decoration: underline;
    color: #c99a96;
}
.card-busqueda-pasteleria {
    border: none;
    background: transparent;
    transition: transform 0.2s;
    cursor: pointer;
}
.card-busqueda-pasteleria:hover {
    transform: translateY(-5px);
}
.card-busqueda-pasteleria img {
    border-radius: 8px;
    object-fit: cover;
    height: 220px;
    width: 100%;
}
.titulo-producto-busqueda {
    color: #a88480;
    font-size: 1rem;
    margin-top: 10px;
    font-weight: 500;
}
.precio-producto-busqueda {
    color: #dbb1ad;
    font-size: 0.9rem;
}
</style>
