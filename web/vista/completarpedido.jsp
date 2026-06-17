<%-- 
    Document   : completarpedido
    Created on : 16 jun. 2026, 1:00:25 a. m.
    Author     : USUARIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Completar pedido</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Luxurious+Roman&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <link rel="icon" href="recursos/logo_cora.png">
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
        <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>

        <link rel="stylesheet" href="estilos/estilos.css">
        <link rel="stylesheet" href="estilos/piestilo.css">
    </head>
    <body>
        <%
            request.setAttribute("paginaActual", "completarpedido");        
        %>
        <jsp:include page="/componentes/encabezado.jsp" />

        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Completar mi pedido</h2>
            
            <div class="row g-4 container-cuenta mx-auto">
                
                <div class="col-lg-7">
                    <div class="card tarjeta-personalizada-cora shadow-sm p-5 h-100">
                        
                        <h4 class="card-title text-center mb-4" style="color: #7c6753;">
                            <i class="fa-solid fa-truck-ramp-box me-2"></i>Tipo de Entrega
                        </h4>
                        
                        <div class="d-flex justify-content-center gap-3 mb-4">
                            <div class="flex-grow-1">
                                <input type="radio" class="btn-check btn-check-entrega" name="tipoEntregaToggle" id="btn-delivery" autocomplete="off" checked>
                                <label class="btn btn-outline-entrega w-100 rounded-pill py-2" for="btn-delivery" style="font-size: 1.05rem;">
                                    <i class="fa-solid fa-motorcycle me-2"></i>Delivery a Domicilio
                                </label>
                            </div>
                            <div class="flex-grow-1">
                                <input type="radio" class="btn-check btn-check-entrega" name="tipoEntregaToggle" id="btn-retiro" autocomplete="off">
                                <label class="btn btn-outline-entrega w-100 rounded-pill py-2" for="btn-retiro" style="font-size: 1.05rem;">
                                    <i class="fa-solid fa-shop me-2"></i>Recojo en Tienda
                                </label>
                            </div>
                        </div>

                        <hr class="mb-4" style="color: #AF2369;">

                        <div>
                            <div id="form-delivery-container">
                                <form action="procesar_pedido.jsp" method="POST">
                                    <input type="hidden" name="modalidad" value="delivery">
                                    
                                    <div class="mb-4">
                                        <label class="form-label subcora fw-bold">Dirección de entrega</label>

                                        <div class="row g-2">
                                            <div class="col-6">
                                                <!-- direccion -->
                                            <input type="text" class="form-control input-cora input-redondeado-cora mb-2" placeholder="Calle, Avenida, Número de departamento o casa..." required>
                                            </div>
                                            <!-- distrito -->
                                            <div class="col-6">
                                        <input type="text" class="form-control input-cora input-redondeado-cora" placeholder="Lima, Lima..." required>
                                            </div>
                                        </div>                                        

                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label subcora fw-bold">Fechas sugeridas de envío (máx 2)</label>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <input type="date" class="form-control input-cora input-redondeado-cora" required>
                                            </div>
                                            <div class="col-6">
                                                <input type="date" class="form-control input-cora input-redondeado-cora">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label subcora fw-bold">Método de pago preferido</label>
                                        <div class="d-flex gap-2">
                                            <input type="radio" class="btn-check" name="pago_del" id="tarjeta_del" checked>
                                            <label class="btn btn-pago-cora rounded-pill px-3 flex-grow-1 text-center" for="tarjeta_del">Tarjeta</label>

                                            <input type="radio" class="btn-check" name="pago_del" id="yape_del">
                                            <label class="btn btn-pago-cora rounded-pill px-3 flex-grow-1 text-center" for="yape_del">Yape</label>

                                            <input type="radio" class="btn-check" name="pago_del" id="efectivo_del">
                                            <label class="btn btn-pago-cora rounded-pill px-3 flex-grow-1 text-center" for="efectivo_del">Efectivo</label>
                                        </div>
                                    </div>

                                    <div class="text-center mt-5">
                                        <button type="submit" class="btn btn-confirmar">Confirmar Pedido</button>
                                    </div>
                                </form>
                            </div>

                            <div id="form-retiro-container" class="d-none">
                                <form action="procesar_pedido.jsp" method="POST">
                                    <input type="hidden" name="modalidad" value="retiro">
                                    
                                    <div class="mb-4">
                                        <label class="form-label subcora fw-bold">Fechas sugeridas de recojo en tienda (máx 2)</label>
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <input type="date" class="form-control input-cora input-redondeado-cora" required>
                                            </div>
                                            <div class="col-6">
                                                <input type="date" class="form-control input-cora input-redondeado-cora">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label subcora fw-bold">Método de pago al retirar</label>
                                        <div class="d-flex gap-2">
                                            <input type="radio" class="btn-check" name="pago_ret" id="tarjeta_ret" checked>
                                            <label class="btn btn-pago-cora rounded-pill px-3 flex-grow-1 text-center" for="tarjeta_ret">Tarjeta</label>

                                            <input type="radio" class="btn-check" name="pago_ret" id="yape_ret">
                                            <label class="btn btn-pago-cora rounded-pill px-3 flex-grow-1 text-center" for="yape_ret">Yape</label>

                                            <input type="radio" class="btn-check" name="pago_ret" id="efectivo_ret">
                                            <label class="btn btn-pago-cora rounded-pill px-3 flex-grow-1 text-center" for="efectivo_ret">Efectivo</label>
                                        </div>
                                    </div>

                                    <div class="text-center mt-5">
                                        <button type="submit" class="btn btn-confirmar">Confirmar Pedido</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
                
                <div class="col-lg-5">
                    <div class="card tarjeta-personalizada-cora shadow-sm p-5 h-100">
                        
                        <h4 class="card-title text-center mb-4" style="color: #7c6753;">
                            <i class="fa-solid fa-receipt me-2"></i>Resumen de Compra
                        </h4>

                        <div class="ticket-contenedor-cora">
                            
                            <div class="ticket-header-cora">
                                <span class="d-block fw-bold subcora text-uppercase" style="letter-spacing: 1px; font-size: 0.95rem;">Cora: hecho a mano</span>
                                <small class="text-muted">Ropa & Accesorios</small>
                            </div>

                            <div class="ticket-cuerpo">
                                
                                <div class="ticket-linea-item-cora">
                                    <div class="d-flex justify-content-between fw-bold text-wrap">
                                        <span>Blusa Artesanal Lino Cora</span>
                                        <span>S/ 120.00</span>
                                    </div>
                                    <div class="d-flex justify-content-start text-muted" style="font-size: 0.85rem;">
                                        <span>Cant: 1</span>
                                        <span class="ms-4">Talla: M</span>
                                    </div>
                                </div>

                                <div class="ticket-linea-item-cora mt-3">
                                    <div class="d-flex justify-content-between fw-bold text-wrap">
                                        <span>Pañuelo Seda Bordado a Mano</span>
                                        <span>S/ 45.00</span>
                                    </div>
                                    <div class="d-flex justify-content-start text-muted" style="font-size: 0.85rem;">
                                        <span>Cant: 1</span>
                                        <span class="ms-4">Color: Terracota</span>
                                    </div>
                                </div>

                                <div class="ticket-separador-cora"></div>

                                <div class="d-flex justify-content-between text-muted mb-2" style="font-size: 0.9rem;">
                                    <span>Subtotal de prendas</span>
                                    <span>S/ 165.00</span>
                                </div>
                                
                                <div class="d-flex justify-content-between text-muted mb-2" style="font-size: 0.9rem;">
                                    <span>Costo de envío</span>
                                    <span class="text-success fw-medium">¡Calculado al confirmar!</span>
                                </div>

                                <div class="ticket-separador-cora"></div>

                                <div class="d-flex justify-content-between align-items-center ticket-total-cora mt-3">
                                    <span class="text-uppercase" style="font-size: 0.9rem; letter-spacing: 0.5px;">Importe Total:</span>
                                    <span>S/ 165.00</span>
                                </div>
                                
                            </div> 

                        </div> </div>
                </div>
                
            </div> </main>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>
        
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const rdoDelivery = document.getElementById('btn-delivery');
                const rdoRetiro = document.getElementById('btn-retiro');
                
                const formDelivery = document.getElementById('form-delivery-container');
                const formRetiro = document.getElementById('form-retiro-container');

                rdoDelivery.addEventListener('change', function() {
                    if(this.checked) {
                        formDelivery.classList.remove('d-none');
                        formRetiro.classList.add('d-none');
                    }
                });

                rdoRetiro.addEventListener('change', function() {
                    if(this.checked) {
                        formRetiro.classList.remove('d-none');
                        formDelivery.classList.add('d-none');
                    }
                });
            });
        </script>

        <jsp:include page="/componentes/pie.jsp"/> 
        <jsp:include page="/componentes/mensajes.jsp" /> 
    </body>
</html>