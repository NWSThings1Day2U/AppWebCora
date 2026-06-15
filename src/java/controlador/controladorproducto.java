package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.productodao;
import jakarta.servlet.annotation.MultipartConfig;
import java.util.ArrayList;
import modelo.productos;

@WebServlet(name = "controladorproducto", urlPatterns = {"/controladorproducto"})
@MultipartConfig
public class controladorproducto extends HttpServlet {

    private productodao prodDao = new productodao();
    private final String paglistar = "/vista/gproductos.jsp";
    private final String paglistarcliente = "/vista/productos.jsp";
    private final String pagdetalle = "/vista/detalleproducto.jsp";
    private final String pagdetallecliente = "/vista/productodetalle.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null || accion.isEmpty()) {
            listar(request, response);
            return;
        }

        switch (accion) {
            // --- ACCIONES DE PRODUCTO BASE ---
            case "listar":
                listar(request, response);
                break;
            case "guardar":
                guardar(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "detalleproducto":
                detalle(request, response);
                break;

            // --- ACCIONES DE VARIANTES (SUB-CRUD) ---
            case "guardarVariante":
                guardarVariante(request, response);
                break;
            case "editarVariante":
                editarVariante(request, response);
                break;
            case "eliminarVariante":
                eliminarVariante(request, response);
                break;

            default:
                response.sendRedirect("controladorproducto?accion=listar");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // 1. GESTIÓN DE PRODUCTO BASE
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        String rol = (String) session.getAttribute("rol");
        if (id != null) {
            if ("admin".equals(rol)) {
                ArrayList<productos> listaProductos = prodDao.listarproductos();
                request.setAttribute("listaProductos", listaProductos);

                dao.categoriadao catDao = new dao.categoriadao();
                ArrayList<modelo.categorias> listaCategorias = catDao.mostrarCategorias();
                request.setAttribute("listaCategorias", listaCategorias);

                request.getRequestDispatcher(paglistar).forward(request, response);
            } else {
                dao.categoriadao catDao = new dao.categoriadao();
                ArrayList<modelo.categorias> listaCategorias = catDao.mostrarCategorias();
                request.setAttribute("listaCategorias", listaCategorias);
                ArrayList<productos> lista = prodDao.listarProductosCatalogo();

                request.setAttribute("listaProductos", lista);
                request.getRequestDispatcher(paglistarcliente).forward(request, response);
            }
        } else {
            dao.categoriadao catDao = new dao.categoriadao();

            ArrayList<modelo.categorias> listaCategorias = catDao.mostrarCategorias();

            ArrayList<modelo.productos> lista = prodDao.listarProductosCatalogo();

            request.setAttribute("listaCategorias", listaCategorias);
            request.setAttribute("listaProductos", lista);

            request.getRequestDispatcher(paglistarcliente).forward(request, response);
        }
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");

            Part filePart = request.getPart("imagen");
            String imagen = (filePart != null && filePart.getSize() > 0)
                    ? filePart.getSubmittedFileName()
                    : "productos.jpg";

            String idCat = request.getParameter("id_categoria");

            if (idCat == null || idCat.trim().isEmpty()) {
                throw new Exception("No se recibió la categoría");
            }

            int idCategoria = Integer.parseInt(idCat);
            int stockMinimo = Integer.parseInt(request.getParameter("stockminimo"));
            double descuento = Double.parseDouble(request.getParameter("descuento"));
            int estado = 1;

            productos producto = new productos();
            producto.setId_categoria(idCategoria);
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setImagen(imagen);
            producto.setStock_min(stockMinimo);
            producto.setDescuento(descuento);
            producto.setEstado(estado);

            prodDao.registrarproducto(producto);
            session.setAttribute("success", "El producto base se registró correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error al registrar producto: " + e.getMessage());
        }
        response.sendRedirect("controladorproducto?accion=listar");
    }

    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int idProducto = Integer.parseInt(request.getParameter("id_producto"));
            int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");

            Part filePart = request.getPart("imagen");
            String imagen;
            if (filePart != null && filePart.getSize() > 0) {
                imagen = filePart.getSubmittedFileName();
            } else {
                imagen = request.getParameter("imagenActual");
            }

            int stockMinimo = Integer.parseInt(request.getParameter("stockminimo"));
            double descuento = Double.parseDouble(request.getParameter("descuento"));
            int estado = Integer.parseInt(request.getParameter("estado"));

            productos producto = new productos();
            producto.setId_producto(idProducto);
            producto.setId_categoria(idCategoria);
            producto.setNombre(nombre);
            producto.setDescripcion(descripcion);
            producto.setImagen(imagen);
            producto.setStock_min(stockMinimo);
            producto.setDescuento(descuento);
            producto.setEstado(estado);

            prodDao.actualizarproducto(producto);
            session.setAttribute("success", "El producto se actualizó correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error al actualizar producto: " + e.getMessage());
        }
        response.sendRedirect("controladorproducto?accion=listar");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int idProducto = Integer.parseInt(request.getParameter("id_producto"));

            prodDao.eliminarproducto(idProducto);
            session.setAttribute("success", "El producto y todas sus variantes asociadas se eliminaron correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error al eliminar producto: " + e.getMessage());
        }
        response.sendRedirect("controladorproducto?accion=listar");
    }

    private void detalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        String rol = (String) session.getAttribute("rol");
        int idProducto= Integer.parseInt(request.getParameter("id_producto"));

                System.out.println("ID PRODUCTO = " + idProducto);

                productos producto = prodDao.obtenerProducto(idProducto);

                System.out.println("PRODUCTO = " + producto);

                ArrayList<productos> variantes = prodDao.listarVariantes(idProducto);

                System.out.println("VARIANTES SIZE = " + variantes.size());

                request.setAttribute("producto", producto);
                request.setAttribute("variantes", variantes);
            if (id != null) {
                
                    if (rol.equals("admin")) {
                        
                        request.getRequestDispatcher(pagdetalle).forward(request, response);
                    }else {
                        request.getRequestDispatcher(pagdetallecliente).forward(request, response);
                    }
            }else {
                request.getRequestDispatcher(pagdetallecliente).forward(request, response);
            }
        
    }

    // 2. GESTIÓN DE VARIANTES (SUB-CRUD)
    private void guardarVariante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idProducto = Integer.parseInt(request.getParameter("id_producto"));
        try {
            String color = request.getParameter("color");
            String talla = request.getParameter("talla");
            int stock = Integer.parseInt(request.getParameter("stock"));
            double precio = Double.parseDouble(request.getParameter("precio"));

            productos variante = new productos();
            variante.setId_producto(idProducto);
            variante.setColor(color);
            variante.setTalla(talla);
            variante.setStock(stock);
            variante.setPrecio(precio);

            prodDao.registrarVariante(variante);
            session.setAttribute("success", "Variante agregada con éxito.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "No se pudo agregar la variante: " + e.getMessage());
        }
        response.sendRedirect("controladorproducto?accion=detalleproducto&id_producto=" + idProducto);
    }

    private void editarVariante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idProducto = Integer.parseInt(request.getParameter("id_producto"));
        try {
            int idVariante = Integer.parseInt(request.getParameter("id_variante"));
            String color = request.getParameter("color");
            String talla = request.getParameter("talla");
            int stock = Integer.parseInt(request.getParameter("stock"));
            double precio = Double.parseDouble(request.getParameter("precio"));

            productos variante = new productos();
            variante.setId_variante(idVariante);
            variante.setColor(color);
            variante.setTalla(talla);
            variante.setStock(stock);
            variante.setPrecio(precio);

            prodDao.actualizarVariante(variante);
            session.setAttribute("success", "Variante actualizada con éxito.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "No se pudo actualizar la variante: " + e.getMessage());
        }
        response.sendRedirect("controladorproducto?accion=detalleproducto&id_producto=" + idProducto);
    }

    private void eliminarVariante(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idProducto = Integer.parseInt(request.getParameter("id_producto"));
        try {
            int idVariante = Integer.parseInt(request.getParameter("id_variante"));

            prodDao.eliminarVariante(idVariante);
            session.setAttribute("success", "Variante eliminada correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "No se pudo eliminar la variante: " + e.getMessage());
        }
        response.sendRedirect("controladorproducto?accion=detalleproducto&id_producto=" + idProducto);
    }
}
