
package controlador;

import dao.usuariodao;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import modelo.usuarios;

/**
 *
 * @author USUARIO
 */
@WebServlet(name = "controladorusuarios", urlPatterns = {"/controladorusuarios"})
@MultipartConfig 
public class controladorusuarios extends HttpServlet {

    private usuariodao usu = new usuariodao();
    
    private final String paglistar = "/vista/gusuarios.jsp";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null || accion.isEmpty()) {
            listarusuarios(request, response);
            return;
        }
        switch (accion) {
            case "listarusuarios":
                listarusuarios(request, response);
                break;
            case "registrarusuarios":
                registrarusuarios(request, response);
                break;
            case "editarusuario":
                editarusuario(request, response);
                break;
            case "eliminarusuario":
                eliminarusuario(request, response);
                break;
            default:
                listarusuarios(request, response);
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

    private void listarusuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<usuarios> listaUsuarios = usu.listarusuarios();
        request.setAttribute("listaUsuarios", listaUsuarios);
        request.getRequestDispatcher(paglistar).forward(request, response);
    }
    
    private void registrarusuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String dni = request.getParameter("dni");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        
        String pass = request.getParameter("contrasena");
        Part filePart = request.getPart("imagen");
        String imagen = (filePart != null && filePart.getSize() > 0) ? filePart.getSubmittedFileName() : "cuenta.jpg";
        
        String rol = request.getParameter("id_rol");

        if (rol == null || rol.isEmpty()) {
            request.getSession().setAttribute("error", "Seleccione un rol.");
            response.sendRedirect("controladorusuarios?accion=listarusuarios");
            return;
        }

        int idrol = Integer.parseInt(rol);
        
        String nombreForm = nombre.trim();
        String primerNombre = nombreForm.split(" ")[0].toLowerCase();
        String userDefecto = primerNombre + (System.currentTimeMillis() % 1000);
        
        if (usu.registrarusuarios(userDefecto, pass, nombre, dni, correo, telefono,imagen, idrol)) {
            request.getSession().setAttribute("registroExitoso", "El nombre de usuario es: " + userDefecto);
            response.sendRedirect("controladorusuarios?accion=listarusuarios");
        } else {
            request.getSession().setAttribute("error", "Error al registrar. El DNI o Correo ya existen.");
            response.sendRedirect("controladorusuarios?accion=listarusuarios");
        }
    }

    private void editarusuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer id = (Integer) session.getAttribute("id");
            String rolSesion  = (String) session.getAttribute("rol");
            // 1. Capturar los parámetros obligatorios del formulario de edición
            int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
            String user = request.getParameter("nombreusuario");
            String nombre = request.getParameter("nombre");
            String dni = request.getParameter("dni");
            String correo = request.getParameter("correo");
            String telefono = request.getParameter("telefono");
            
            String pass = request.getParameter("contrasena");
            String confirm = request.getParameter("confirmar_contrasena");
            if(!pass.equals(confirm)){
                request.getSession().setAttribute("error",
                    "Las contraseñas no coinciden");
                response.sendRedirect("controladorusuarios?accion=listarusuarios");
                return;
            }
            // Capturar el rol y el estado
            int idRol = Integer.parseInt(request.getParameter("id_rol"));
            int estado = Integer.parseInt(request.getParameter("estado"));
            if(id != null && id == idUsuario){

                if(
                    ("admin".equals(rolSesion) && idRol != 1) ||
                    ("cliente".equals(rolSesion) && idRol != 2)
                ){
                    session.setAttribute("error",
                        "No puedes modificar tu propio rol.");
                    response.sendRedirect(
                        "controladorusuarios?accion=listarusuarios");
                    return;
                }

                if(estado == 0){
                    session.setAttribute("error",
                        "No puedes desactivar tu propia cuenta.");
                    response.sendRedirect(
                        "controladorusuarios?accion=listarusuarios");
                    return;
                }
            }
            Part filePart = request.getPart("imagen");
            String imagen = null;
            if (filePart != null && filePart.getSize() > 0) {
                imagen = filePart.getSubmittedFileName();
            }

            if (usu.editarusuario(idUsuario, user, pass, nombre, dni, correo, telefono, imagen, idRol, estado)) {
                request.getSession().setAttribute("registroExitoso", "Usuario actualizado correctamente.");
            } else {
                request.getSession().setAttribute("error", "Error al actualizar el usuario. Verifique si el nombre de usuario, DNI o correo ya están registrados.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Datos inválidos o error en el procesamiento del formulario.");
        }
        
        response.sendRedirect("controladorusuarios?accion=listarusuarios");
    }

    private void eliminarusuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer id = (Integer) session.getAttribute("id");

            int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));

            if(id != null && id == idUsuario){
                session.setAttribute(
                    "error",
                    "No puedes desactivar tu propia cuenta."
                );

                response.sendRedirect(
                    "controladorusuarios?accion=listarusuarios"
                );
                return;
            }

            if (usu.desactivarusuario(idUsuario)) {
                request.getSession().setAttribute("registroExitoso", "Usuario desactivado con éxito.");
            } else {
                request.getSession().setAttribute("error", "No se pudo desactivar el usuario.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "ID de usuario no válido.");
        }
        
        response.sendRedirect("controladorusuarios?accion=listarusuarios");
    }

}
