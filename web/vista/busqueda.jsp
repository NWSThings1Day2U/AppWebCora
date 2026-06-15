<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${not empty resultados}">
        <c:forEach var="p" items="${resultados}">
            <div class="col-6 col-md-4 col-lg-3">
                <a href="controladorproducto?accion=detalleproducto&id_producto=${p.id_producto}&id_categoria=${p.id_categoria}" class="text-decoration-none">
                    <div class="card card-busqueda-pasteleria text-center">
                        <img src="recursos/${p.imagen != null ? p.imagen : 'default.jpg'}" class="card-img-top shadow-sm" alt="${p.nombre}">
                        <div class="card-body p-2">
                            <h6 class="titulo-producto-busqueda m-0">${p.nombre}</h6>
                            <p class="precio-producto-busqueda m-0">Desde S/ ${p.precio}</p>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="col-12 text-center pt-4">
            <p class="text-muted" style="font-style: italic;">No se encontraron productos para tu búsqueda.</p>
        </div>
    </c:otherwise>
</c:choose>