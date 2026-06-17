package controlador;

import dao.contactodao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.ArrayList;
import modelo.contacto;
import util.servicioemail;

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
            case "registrar":
                registrar(request, response);
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
            } else {
                contacto datos = dao.obtenerDatosContactoUsuario(id);
                request.setAttribute("datosUsuario", datos);
                request.getRequestDispatcher(paglistarcontacto).forward(request, response);
            }
        } else {
            request.getRequestDispatcher(paglistarcontacto).forward(request, response);
        }
    }

    private void registrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        String rol = (String) session.getAttribute("rol");
        try {
            String nombre = request.getParameter("nombre");
            String telefono = request.getParameter("telefono");
            String correo = request.getParameter("correo");
            String asunto = request.getParameter("asunto");
            String descripcion = request.getParameter("descripcion");

            if(nombre == null || nombre.trim().isEmpty()){
                session.setAttribute("error","Debe ingresar un nombre.");
                response.sendRedirect( "controladorcontacto?accion=listar");
            }

            if(!nombre.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")){
                session.setAttribute("error","El nombre solo debe contener letras.");
                response.sendRedirect("controladorcontacto?accion=listar");
            }

            if(!telefono.matches("^9\\d{8}$")){
                session.setAttribute("error", "Teléfono inválido.");
                response.sendRedirect("controladorcontacto?accion=listar");
            }

            if(!correo.matches( "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")){
                session.setAttribute("error","Correo inválido.");
                response.sendRedirect( "controladorcontacto?accion=listar");
            }

            if(asunto == null || asunto.trim().length() < 3){
                session.setAttribute("error","Ingrese un asunto válido.");
                response.sendRedirect("controladorcontacto?accion=listar");
            }

            contacto con = new contacto();
            con.setNombre(nombre);
            con.setTelefono(telefono);
            con.setCorreo(correo);
            con.setAsunto(asunto);
            con.setMensaje(descripcion);

            boolean exito = dao.registrarContacto(con);

            if(exito){
                session.setAttribute("success","El mensaje se registró correctamente.");
            }else{
                session.setAttribute("error","No se pudo registrar el mensaje." );
            }

            response.sendRedirect("controladorcontacto?accion=listar");
        } catch (Exception e) {
            e.printStackTrace();

            session.setAttribute("error", "Error al registrar el mensaje.");

            response.sendRedirect( "controladorcontacto?accion=listar");
        }
    }

    private void redactar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idContacto = Integer.parseInt(request.getParameter("id_contacto"));
        String correo = request.getParameter("correo");
        String nombre = request.getParameter("nombre");
        String asuntoConsulta = request.getParameter("asunto");
        String mensajeConsulta = request.getParameter("mensaje");
        String respuestaTexto = request.getParameter("respuesta");
        
        servicioemail servicio = new servicioemail();

        boolean okCorreo = servicio.enviarRespuesta(
                correo, nombre, asuntoConsulta, mensajeConsulta,
                respuestaTexto
        );

        if (okCorreo) {

            boolean okBD = dao.responderContacto(
                    idContacto,
                    respuestaTexto
            );

            if (okBD) {
                session.setAttribute( "success", "Respuesta enviada correctamente."
                );
            }

        } else {

            session.setAttribute("error", "No se pudo enviar el correo.");
        }

        response.sendRedirect( "controladorcontacto?accion=listar" );
    }
}
