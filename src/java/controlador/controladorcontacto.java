
package controlador;
import dao.contactodao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import java.util.ArrayList;
import modelo.contacto;

/**
 *
 * @author USUARIO
 */
@WebServlet(name = "controladorcontacto", urlPatterns = {"/controladorcontacto"})
public class controladorcontacto extends HttpServlet {

    private contactodao dao = new contactodao();
    private final String paglistar = "/vista/gcontacto.jsp";
    private final String paglistarcontacto = "/vista/contacto.jsp";
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
            case "redactar":
                redactar(request, response);
                break;
            case "detalle":
                detalle(request, response);
                break;
            default:
                response.sendRedirect("controladorcontacto?accion=listar");  
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



    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        String rol = (String) session.getAttribute("rol");
        if (id != null) {
            if ("admin".equals(rol)) {
                ArrayList<modelo.contacto> lista = dao.listarcontactos();
                request.setAttribute("listaContacto", lista);
                request.getRequestDispatcher(paglistar).forward(request, response);
            }else {
                request.getRequestDispatcher(paglistarcontacto).forward(request, response);
            }
        } else {
            request.getRequestDispatcher(paglistarcontacto).forward(request, response);
        }
    }

    private void detalle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {


    }

    private void redactar( HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

    int idContacto = Integer.parseInt(request.getParameter("id_contacto"));

    String respuestaTexto = request.getParameter("respuesta");

    boolean ok =dao.responderContacto(idContacto, respuestaTexto);

    if(ok){
        response.sendRedirect("controladorcontacto?accion=listar");
    }
}
}