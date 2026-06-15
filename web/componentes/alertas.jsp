<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<c:if test="${not empty sessionScope.success}">
    <script>
        Swal.fire({
            icon: 'success',
            title: '¡Excelente!',
            text: '${sessionScope.success}',
            confirmButtonColor: '#5a67d8',
            timer: 3000,
            timerProgressBar: true
        });
    </script>
    <c:remove var="success" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.success1}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Producto agregado',
            text: '${sessionScope.success1}',
            showConfirmButton: false,
            timer: 1800,
            toast: true,
            position: 'top-end'
        });
    </script>
    <c:remove var="success1" scope="session"/>
</c:if>
<c:if test="${not empty sessionScope.error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: '¡Ups, hubo un problema!',
            text: '${sessionScope.error}',
            confirmButtonColor: '#5a67d8'
        });
    </script>
    <c:remove var="error" scope="session"/>
</c:if>
    
<c:if test="${not empty sessionScope.info}">
    <script>
        Swal.fire({
            title: "Confirmación",
            icon: "info",
            text: "${sessionScope.info}",
            showCancelButton: true,
            focusConfirm: false,
            confirmButtonColor: '#5a67d8',
            cancelButtonColor: '#e53e3e',
            confirmButtonText: '<i class="fa fa-thumbs-up"></i> ¡Por supuesto!',
            cancelButtonText: '<i class="fa fa-thumbs-down"></i> Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                let urlDestino = "${sessionScope.urlConfirmacion}";
                if (urlDestino) {
                    window.location.href = urlDestino;
                }
            }
        });
    </script>
    <c:remove var="info" scope="session"/>
    <c:remove var="urlConfirmacion" scope="session"/>
</c:if>
    
    