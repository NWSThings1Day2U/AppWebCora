<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestion Pedidos</title>
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
            request.setAttribute("paginaActual", "pedidos");
        %>
        <jsp:include page="../componentes/encabezado.jsp" />
        <main class="container mt-5 pt-4" style="margin-top: 180px; margin-bottom: 150px;"> 
            <h2 class="mb-5 text-center">Listado de Pedidos</h2>
            
            <div class="card p-4 border-top-0 rounded-bottom mb-5" style="box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);">
                <div class="d-flex align-items-center gap-2">
                    <form class="d-flex" action="controladorpagina" method="GET">
                        <input type="hidden" name="pagina" value="lupa">
                        <div class="input-group">
                            <input class="form-control border-end-0" name="termino" type="search" placeholder="Busca pedido...">
                            <button class="input-group-text border-start-0 bg-white" type="submit">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </form>

                    <button class="btn btn-primary px-3" 
                            data-bs-toggle="modal" 
                            data-bs-target="#modalInsertar" >
                        <i class="fa-solid fa-clipboard-list me-2"></i>Nuevo pedido
                    </button>
                </div>
            </div>
            <div class="card shadow-sm p-4">
                <div class="card-body"><h4 class="mb-4 mt-4">Tabla pedidos</h4>

                    <table class="table table-hover table-bordered">
                        <thead class="text-center" style="--bs-table-bg: #F5ECE1;">
                            <tr>
                                <th>Id Pedido</th>
                                <th>Nombre cliente</th>
                                <th>Productos</th>
                                <th>Fecha pedido</th>
                                <th>Cantidad</th>
                                <th>Precio unitario</th>
                                <th>Tipo entrega</th>
                                <th>Costo delivery</th>
                                <th>Dirección</th>
                                <th>Método de pago</th>
                                <th>Estado</th>                                
                                <th>Accion</th>                                    

                            </tr>
                        </thead>
                        <tbody>
                            <tr class="align-middle">
                                <th scope="row" class="text-center">1</th>
                                <td>Mark</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>@mdo</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>@mdo</td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>@mdo</td>
                                <td class="text-center">
                                    <div class="d-flex flex-wrap justify-content-center gap-2">
                                        <button type="button" class="btn btn-danger btn-sm" onclick="">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                        <button type="button" class="btn btn-warning btn-sm" 
                                                onclick="">
                                            <i class="fa-solid fa-pencil"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div></div>
        </main>

        <!-- Bootstrap y alertify -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>

    </body>
</html>
