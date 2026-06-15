package controlador;

import dao.categoriadao;
import dao.productodao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.ArrayList;
import java.util.List;
import modelo.*;
/**
 *
 * @author USUARIO
 */
@WebServlet(name = "controladorpagina", urlPatterns = {"/controladorpagina"})
public class controladorpagina extends HttpServlet {

    private final String paginicio = "/index.jsp";
    private final String pagproductos = "/vista/productos.jsp";
    private final String pagnosotros = "/vista/nosotros.jsp";
    private final String pagpcontacto = "/vista/contacto.jsp";
    private final String pagpcarrito = "/vista/carrito.jsp";
    private final String pagplupa = "/vista/lupa.jsp";
    private final String pagpcuenta = "/vista/cuenta.jsp";
    private final String pagperfil = "/vista/perfil.jsp";
    private final String pagdetalle = "/vista/detalleproducto.jsp";
    
    categoriadao dao = new categoriadao();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String pagina = request.getParameter("pagina");
        if (pagina == null) {
            pagina = "inicio";
        }
        switch (pagina) {
            case "inicio":
                inicio(request, response);
                break;
            case "productos":
                productos(request, response);
                break;
            case "nosotros":
                nosotros(request, response);
                break;
            case "contacto":
                contacto(request, response);
                break;
            case "carrito":
                carrito(request, response);
                break;
            case "lupa":
                lupa(request, response);
                break;
            case "cuenta":
                cuenta(request, response);
                break;
            case "perfil":
                request.getRequestDispatcher("controladorperfil").forward(request, response);
                break;
            case "buscar":
                buscar(request,response);
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
        HttpSession session = request.getSession();
        List<categorias> lista = dao.mostrarCategorias();
        request.setAttribute("listaCategorias", lista);
        Integer idUsuario = (Integer) session.getAttribute("id");
        request.getRequestDispatcher(paginicio).forward(request, response);
    }
    private void buscar(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

       String pagina = request.getParameter("pagina");

        if ("buscar".equals(pagina)) {
            String termino = request.getParameter("termino");

            productodao pdao = new productodao();
            ArrayList<productos> lista = pdao.buscarProductos(termino);

            request.setAttribute("resultados", lista);

            request.getRequestDispatcher("vista/busqueda.jsp").forward(request, response);
        }
        }

    private void productos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("paginaActual", "productos");
        
        request.getRequestDispatcher("controladorproducto?accion=listar").forward(request, response);
    }

    private void nosotros(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("paginaActual", "nosotros");
        request.getRequestDispatcher(pagnosotros).forward(request, response);
    }

    private void contacto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("paginaActual", "contacto");
        request.getRequestDispatcher("controladorcontacto?accion=listar").forward(request, response);
    }

    private void carrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                request.setAttribute("paginaActual", "carrito");
        request.getRequestDispatcher(pagpcarrito).forward(request, response);
    }

    private void lupa(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                request.setAttribute("paginaActual", "lupa");

        request.getRequestDispatcher(pagplupa).forward(request, response);
    }

    private void cuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                request.setAttribute("paginaActual", "cuenta");

        request.getRequestDispatcher(pagpcuenta).forward(request, response);
    }


}
