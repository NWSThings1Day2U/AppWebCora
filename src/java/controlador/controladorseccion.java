package controlador;

import dao.dashboardao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.dashboard;

/**
 *
 * @author USUARIO
 */
@WebServlet(name = "controladorseccion", urlPatterns = {"/controladorseccion"})
public class controladorseccion extends HttpServlet {

    private final String paginicio = "/vista/paneladmin.jsp";
    private final String pagusuarios = "/vista/gusuarios.jsp";
    private final String pagcategorias = "/vista/gcategorias.jsp";
    private final String pagproductos = "/vista/gproductos.jsp";
    private final String pagpedidos = "/vista/gpedidos.jsp";
    private final String pagcontacto = "/vista/gcontacto.jsp";
    private final String pagperfil = "/vista/gperfil.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String seccion = request.getParameter("seccion");
        if (seccion == null) {
            seccion = "inicio";
        }
        switch (seccion) {
            case "inicio":
                inicio(request, response);
                break;
            case "usuarios":
                usuarios(request, response);
                break;
            case "categorias":
                categorias(request, response);
                break;
            case "productos":
                productos(request, response);
                break;
            case "pedidos":
                pedidos(request, response);
                break;
            case "perfil":
                perfil(request, response);
                break;
            case "contacto":
                contacto(request, response);
                break;
            default:
                throw new AssertionError();
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

    private void inicio(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("paginaActual", "inicio");
        dao.dashboardao ddao = new dao.dashboardao();
        // TARJETAS PRINCIPALES
        request.setAttribute("totalVentas",ddao.totalVentas());
        request.setAttribute("totalPedidos", ddao.totalPedidos());
        request.setAttribute("totalClientes", ddao.totalClientes());
        request.setAttribute("totalProductos", ddao.totalProductos());
        // GRÁFICOS
        request.setAttribute("listaVentas", ddao.obtenerVentasPorMes());
        request.setAttribute("listaEstados", ddao.obtenerEstadosPedidos());
        request.setAttribute("listaCategorias", ddao.obtenerVentasCategorias());
        request.setAttribute("listaIngresosMPagos", ddao.obtenerIngresosMPagos());
        request.setAttribute("listaCantidadTipoE", ddao.obtenerCantidadTipoE());
        request.setAttribute("listaTallaVendidas", ddao.obtenerTallaVendidas());
        request.setAttribute("listaColoresVendidos", ddao.obtenerColoresVendidos());
        request.setAttribute("listaPedidosDia", ddao.obtenerPedidosDia());
        // TABLAS
        request.setAttribute("listaProductosVentidos", ddao.obtenerProductosVendidos());
        request.setAttribute("listaStockCritico", ddao.obtenerStockCritico());
        request.setAttribute("listaUltimosPedidos", ddao.obtenerUltimosPedidos());
        request.setAttribute("listaTopClientes", ddao.obtenerTopClientes());
        request.setAttribute("listaBajaRotacion", ddao.obtenerBajaRotacion());
        // INDICADORES
        request.setAttribute("listaCantidadClientes", ddao.obtenerCantidadClientes());
        request.setAttribute("listaTotaInventario", ddao.obtenerTotalInventario());
        request.setAttribute("listaCategoriaRentable", ddao.obtenerCategoriaRentable());
        request.setAttribute("listaMensajesPendientes", ddao.obtenerMensajesPendientes());
        request.setAttribute("listaMensajesRespondidos", ddao.obtenerMensajesRespondidas());
        request.setAttribute("listaHoras", ddao.obtenerTiempoRespuesta());
        request.setAttribute("listaVentaMes", ddao.obtenerVentasMes());
        request.setAttribute("listaPorcentaje", ddao.obtenerPorcentajeEntregado());
        request.setAttribute("listaTicket", ddao.obtenerTicketPromedio());
        request.setAttribute("listaCriticos", ddao.obtenerProductosCriticos());
        //resumen
        request.setAttribute("listaCrecimiento", ddao.obtenerCrecimientoVentas());
        request.getRequestDispatcher(paginicio).forward(request, response);
    }

    private void productos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("paginaActual", "productos");

        request.getRequestDispatcher("controladorproducto?accion=listar").forward(request, response);
    }

    private void usuarios(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("paginaActual", "usuarios");

        request.getRequestDispatcher("controladorusuarios").forward(request, response);    
    }

    private void categorias(HttpServletRequest request, HttpServletResponse response) 
             throws ServletException, IOException {
        request.setAttribute("paginaActual", "categorias");

        request.getRequestDispatcher("controladorcategoria").forward(request, response);    
    }
    
    private void pedidos(HttpServletRequest request, HttpServletResponse response) 
             throws ServletException, IOException {
        request.setAttribute("paginaActual", "pedidos");

        request.getRequestDispatcher("controladorpedido?accion=listar").forward(request, response);  
    }
    
    private void perfil(HttpServletRequest request, HttpServletResponse response)              
            throws ServletException, IOException {
        request.setAttribute("paginaActual", "perfil");

        request.getRequestDispatcher("controladorperfil").forward(request, response);
    }

    private void contacto(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        request.setAttribute("paginaActual", "contacto");

        request.getRequestDispatcher("controladorcontacto?accion=listar").forward(request, response);
    }
    
    

}
