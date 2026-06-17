package controlador;

import dao.pedidodao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;
import modelo.pedido;
import servicio.pedidosadminservicio;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import java.sql.Date;
import modelo.ItemCarrito;
/**
 *
 * @author USUARIO
 */
@WebServlet(name = "controladorpedido", urlPatterns = {"/controladorpedido"})
public class controladorpedido extends HttpServlet {

    private pedidodao pdao = new pedidodao();
    private final String paglistaradmin = "/vista/gpedidos.jsp";
    private pedidosadminservicio padmin = new pedidosadminservicio();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");

        if (accion == null || accion.isEmpty()) {
            listar(request, response);
            return;
        }

        switch (accion) {

            case "listar":
                listar(request, response);
                break;
            case "nuevo":
                nuevo(request, response);
                break;

            case "guardarAdmin":
                guardarAdmin(request, response);
                break;
            case "detalle":
                detalle(request, response);
                break;

            case "cambiarEstado":
                cambiarEstado(request, response);
                break;

            case "anular":
                anular(request, response);
                break;

            case "pendientes":
                pendientes(request, response);
                break;

            case "entregados":
                entregados(request, response);
                break;

            default:
                listar(request, response);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        String rol = (String) session.getAttribute("rol");

        if (id != null) {
            if ("admin".equals(rol)) {
                List<modelo.pedido> lista = pdao.listarTodos();
                request.setAttribute("listaPedidos", lista);
                request.setAttribute("clientes",pdao.listarClientes());
                request.setAttribute("variantes",pdao.listarVariantesDisponibles());
                request.getRequestDispatcher(paglistaradmin).forward(request, response);
            } else {
                response.sendRedirect("controladorperfil");
            }

        } else {
            response.sendRedirect("controladorpagina?accion=inicio");
        }

    }

    private void detalle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idPedido = Integer.parseInt(request.getParameter("id"));
        Integer id = (Integer) session.getAttribute("id");
        String rol = (String) session.getAttribute("rol");
        request.setAttribute("detallePedido", pdao.detallePedido(idPedido));

        request.setAttribute("pedido", pdao.obtenerPedido(idPedido));

        request.setAttribute("totalPedido", pdao.obtenerTotal(idPedido));

        if ("admin".equals(rol)) {
            request.getRequestDispatcher("/vista/detallepedido.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/vista/detalle_fragmento.jsp").forward(request, response);
        }

    }

    private void cambiarEstado(HttpServletRequest request,HttpServletResponse response)
        throws IOException {

        HttpSession session = request.getSession();

        int idPedido = Integer.parseInt(request.getParameter("id"));

        pedido p = pdao.obtenerPedido(idPedido);

        if (p != null &&"cancelado".equalsIgnoreCase(p.getEstado())) {

            session.setAttribute("error","No se puede modificar un pedido cancelado.");

            response.sendRedirect("controladorpedido?accion=listar");
            return;
        }

        String estado = request.getParameter("estado");
        String fechaMinStr = request.getParameter("fechaMin");
        String fechaMaxStr = request.getParameter("fechaMax");

        Date fechaMin = null;
        Date fechaMax = null;

        if(fechaMinStr != null && !fechaMinStr.isEmpty()){
            fechaMin = Date.valueOf(fechaMinStr);
        }

        if(fechaMaxStr != null && !fechaMaxStr.isEmpty()){
            fechaMax = Date.valueOf(fechaMaxStr);
        }
        if (pdao.cambiarEstado(idPedido, estado,fechaMin,fechaMax)) {

            session.setAttribute("success", "Estado actualizado correctamente.");

        } else {

            session.setAttribute("error", "No se pudo actualizar el estado.");

        }

        response.sendRedirect("controladorpedido?accion=listar");
    }

    private void anular(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        int idPedido = Integer.parseInt(request.getParameter("id"));
        pedido p = pdao.obtenerPedido(idPedido);

        if(p != null &&
           "cancelado".equalsIgnoreCase(p.getEstado())){

            session.setAttribute("error", "El pedido ya se encuentra cancelado.");

            response.sendRedirect("controladorpedido?accion=listar");
            return;
        }
        pdao.anularPedido(idPedido);
        
        response.sendRedirect("controladorpedido?accion=listar");
    }

    private void pendientes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<pedido> lista = pdao.listarPendientes();

        request.setAttribute("listaPedidos", lista);

        request.getRequestDispatcher(paglistaradmin).forward(request, response);
    }

    private void entregados(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<pedido> lista = pdao.listarEntregados();

        request.setAttribute("listaPedidos", lista);

        request.getRequestDispatcher(paglistaradmin).forward(request, response);
    }
    
    private void nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("clientes", pdao.listarClientes());

        request.setAttribute("variantes", pdao.listarVariantesDisponibles());

        request.getRequestDispatcher("controladorpedido?accion=listar").forward(request, response);
    }
    
    private void guardarAdmin(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
        HttpSession session = request.getSession();
        String idUsuarioStr = request.getParameter("idUsuario");

        if(idUsuarioStr == null || idUsuarioStr.isEmpty()){
            session.setAttribute("error", "Debe seleccionar un cliente.");
            response.sendRedirect("controladorpedido?accion=listar");
            return;
        }

        int idUsuario = Integer.parseInt(idUsuarioStr);
        String tipoEntrega = request.getParameter("tipoEntrega");

        if(tipoEntrega == null ||
           (!tipoEntrega.equals("delivery")
            && !tipoEntrega.equals("fisico"))){

            session.setAttribute(
                "error",
                "Debe seleccionar un tipo de entrega válido."
            );

            response.sendRedirect(
                "controladorpedido?accion=listar"
            );

            return;
        }

        String costoStr = request.getParameter("costoDelivery");

        double costoDelivery = 0;

        if(costoStr != null && !costoStr.trim().isEmpty()){
            costoDelivery = Double.parseDouble(costoStr);
        }

        if(costoDelivery < 0){

            session.setAttribute(
                "error",
                "El costo de delivery no puede ser negativo."
            );

            response.sendRedirect(
                "controladorpedido?accion=listar"
            );

            return;
        }

        String direccion =request.getParameter("direccion");

        if("delivery".equals(tipoEntrega)){

            if(direccion == null ||
               direccion.trim().isEmpty()){

                session.setAttribute(
                    "error",
                    "Debe ingresar una dirección para delivery."
                );

                response.sendRedirect(
                    "controladorpedido?accion=listar"
                );

                return;
            }

        }
        
        String metodoPago = request.getParameter("metodoPago");

        if(metodoPago == null ||
           metodoPago.trim().isEmpty()){

            session.setAttribute(
                "error",
                "Debe seleccionar un método de pago."
            );

            response.sendRedirect(
                "controladorpedido?accion=listar"
            );

            return;
        }
        String estado = "pendiente";
        String carritoJson = request.getParameter("carrito");
        if(carritoJson == null ||
           carritoJson.trim().isEmpty()){

            session.setAttribute(
                "error",
                "Debe agregar al menos un producto."
            );

            response.sendRedirect(
                "controladorpedido?accion=listar"
            );

            return;
        }
        Gson gson = new Gson();
        Type listType = new TypeToken<List<ItemCarrito>>(){}.getType();

        List<ItemCarrito> carrito = gson.fromJson(carritoJson, listType);

        if(carrito == null || carrito.isEmpty()){

            session.setAttribute(
                "error",
                "Debe agregar al menos un producto."
            );

            response.sendRedirect(
                "controladorpedido?accion=listar"
            );

            return;
        }

        
        boolean ok = padmin.registrarPedidoAdmin( idUsuario,tipoEntrega,costoDelivery,direccion, metodoPago,estado, carrito);
        if (ok) {
            session.setAttribute("success","El pedido se registró correctamente.");
        }else{
            session.setAttribute("error","No se pudo registrar el pedido." );
        }
        response.sendRedirect("controladorpedido?accion=listar");
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

}
