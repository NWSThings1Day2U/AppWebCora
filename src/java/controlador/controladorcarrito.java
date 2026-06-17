package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.productodao;
import jakarta.servlet.annotation.MultipartConfig;
import java.util.ArrayList;
import modelo.ItemCarrito;
import modelo.productos;

/**
 *
 * @author USUARIO
 */
@WebServlet(name = "controladorcarrito", urlPatterns = {"/controladorcarrito"})
@MultipartConfig
public class controladorcarrito extends HttpServlet {

    private final String paglistar = "/vista/carrito.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion == null || accion.isEmpty()) {
            listar(request, response);
            return;
        }

        switch (accion) {
            case "agregar":
                agregar(request, response);
                break;
            case "listar":
                listar(request, response);
                break;
            case "sumar":
                sumar(request, response);
                break;
            case "restar":
                restar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "confirmar_eliminar":
                confirmarEliminar(request, response);
                break;
            case "vaciar":
                vaciar(request, response);
                break;

            case "confirmar_vaciar":
                confirmarVaciar(request, response);
                break;
            case "finalizar":
                finalizar(request, response);
                break;
            default:
                response.sendRedirect("controladorcarrito?accion=listar");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void agregar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String idVarianteStr = request.getParameter("id_variante");
        
        if (idVarianteStr == null || idVarianteStr.isBlank()) {

            session.setAttribute("error","Debe seleccionar una talla y color.");

            response.sendRedirect("controladorproducto?accion=listar");
            return;
        }

        int idVariante = Integer.parseInt(idVarianteStr);

        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        productodao dao = new productodao();

        productos p = dao.obtenerVariante(idVariante);

        if (p != null) {

            boolean existe = false;

            for (ItemCarrito item : carrito) {

                if (item.getIdVariante() == idVariante) {

                    item.setCantidad(
                            item.getCantidad() + cantidad
                    );

                    existe = true;
                    break;
                }
            }

            if (!existe) {

                ItemCarrito item = new ItemCarrito();

                item.setIdVariante(p.getId_variante());
                item.setIdProducto(p.getId_producto());
                item.setCategoria(p.getNombre_categoria());
                item.setNombre(p.getNombre());
                item.setImagen(p.getImagen());

                item.setColor(p.getColor());
                item.setTalla(p.getTalla());

                item.setPrecio(p.getPrecio());
                item.setCantidad(cantidad);

                carrito.add(item);
            }
        }

        session.setAttribute("carrito", carrito);
        session.setAttribute("success1", "Producto agregado al carrito.");
        response.sendRedirect("controladorproducto?accion=detalleproducto&id_producto="+p.getId_producto()+"&id_categoria="+p.getId_categoria());
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/vista/carrito.jsp").forward(request, response);
    }

    private void sumar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        int idVariante = Integer.parseInt(request.getParameter("idVariante"));

        if (carrito != null) {

            for (ItemCarrito item : carrito) {

                if (item.getIdVariante() == idVariante) {

                    item.setCantidad(
                            item.getCantidad() + 1
                    );

                    break;
                }
            }
        }

        response.sendRedirect(
                "controladorcarrito?accion=listar"
        );
    }

    private void restar(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");

        int idVariante = Integer.parseInt(request.getParameter("idVariante"));

        if (carrito != null) {

            for (ItemCarrito item : carrito) {

                if (item.getIdVariante() == idVariante) {

                    if (item.getCantidad() > 1) {

                        item.setCantidad(
                                item.getCantidad() - 1
                        );
                    }

                    break;
                }
            }
        }

        response.sendRedirect("controladorcarrito?accion=listar");
    }

    private void confirmarEliminar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String idVariante = request.getParameter("idVariante");

        session.setAttribute("info", "¿Estás seguro de que deseas eliminar este producto?");
        session.setAttribute("urlConfirmacion", "controladorcarrito?accion=eliminar&idVariante=" + idVariante);

        response.sendRedirect("controladorcarrito?accion=listar");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        ArrayList<ItemCarrito> carrito = (ArrayList<ItemCarrito>) session.getAttribute("carrito");
        int idVariante = Integer.parseInt(request.getParameter("idVariante"));

        if (carrito != null) {
            carrito.removeIf(item -> item.getIdVariante() == idVariante);
            session.setAttribute("success", "Producto eliminado con éxito.");
        }
        response.sendRedirect("controladorcarrito?accion=listar");
    }

    private void confirmarVaciar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();

        session.setAttribute("info", "¿Deseas vaciar por completo todo tu carrito de compras?");
        session.setAttribute("urlConfirmacion", "controladorcarrito?accion=vaciar");

        response.sendRedirect("controladorcarrito?accion=listar");
    }

    private void vaciar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("carrito");
        session.setAttribute("success", "El carrito se ha vaciado.");
        response.sendRedirect("controladorcarrito?accion=listar");
    }

    private void finalizar(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        Integer id = (Integer) session.getAttribute("id");
        String rol = (String) session.getAttribute("rol");
        try {
            if (id == null) {
                request.getSession().setAttribute("error", "Necesita iniciar sesion para procesar su pedido, sino tiene cuenta puede crearse una.");
                response.sendRedirect("controladorpagina?pagina=cuenta");

            }else{
                if (rol.equals("cliente")) {
                    request.getSession().setAttribute("success", "Carrito guardado correctamente.");
                    response.sendRedirect("controladorpagina?pagina=completarpedido");
                }
            }
            
            
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Surgio un error, intente de nuevo.");
            response.sendRedirect("controladorcarrito");
            e.printStackTrace();
        }
        
    }
}
