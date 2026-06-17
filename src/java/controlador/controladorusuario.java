package controlador;

import dao.usuariodao;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.usuarios;

/**
 *
 * @author USUARIO
 */
@WebServlet(name = "controladorusuario", urlPatterns = {"/controladorusuario"})
public class controladorusuario extends HttpServlet {

     private usuariodao us = new usuariodao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if ("login".equals(accion)) {
            Login(request, response);
        } else if ("registro".equals(accion)) {
            Registro(request, response);
        }
    }

    private void Login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombreusu = request.getParameter("usuario");
        String contra = request.getParameter("contrasena");
        String recordar = request.getParameter("recordar");

        usuarios usu = us.validar(nombreusu, contra);

        if (usu != null) {
            if (usu.getEstadousuario() != 1) { 
                request.getSession().setAttribute("error", "Su cuenta está inhabilitada. Contacte al administrador.");
                response.sendRedirect("controladorpagina?pagina=cuenta&modo=login");
                return;
            }
            Cookie cUsuario = new Cookie("user_cora", nombreusu);
            cUsuario.setPath("/");
            if (recordar != null && recordar.equals("on")) {
                cUsuario.setMaxAge(60 * 60 * 24 * 30);
            } else {
                cUsuario.setMaxAge(0); 
            }
            response.addCookie(cUsuario);
            String fotoPerfil = (usu.getImagen() != null && !usu.getImagen().trim().isEmpty())
            ? usu.getImagen()
            : "cuenta.jpg";

            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuario", usu.getNombreusuario());
            sesion.setAttribute("rol", usu.getRol());
            sesion.setAttribute("id", usu.getIdUsuario());
            sesion.setAttribute("imagen", fotoPerfil);
            sesion.setAttribute("correo", usu.getCorreo());
            sesion.setAttribute("success", "Bienvenido " + usu.getNombreusuario());

            if ("admin".equals(usu.getRol())) {
                response.sendRedirect("controladorseccion?seccion=inicio");
            } else {
                response.sendRedirect("controladorpagina?pagina=perfil");
            }
        } else {
            request.getSession().setAttribute("error", "Datos incorrectos, intente de nuevo!");
            response.sendRedirect("controladorpagina?pagina=cuenta&modo=login");
        }
    }

    private void Registro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String dni = request.getParameter("dni");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String pass = request.getParameter("contrasena");

        String nombreForm = nombre.trim();
        String primerNombre = nombreForm.split(" ")[0].toLowerCase();
        String userDefecto = primerNombre + (System.currentTimeMillis() % 1000);

        if (us.registrar(userDefecto, pass, nombre, dni, correo, telefono)) {
            request.getSession().setAttribute("registroExitoso", "¡Bienvenido(a) a la plataforma! Tu usuario es: " + userDefecto);
            response.sendRedirect("controladorpagina?pagina=cuenta");
        } else {
            request.getSession().setAttribute("error", "Error al registrar. El DNI o Correo ya existen.");
            response.sendRedirect("controladorpagina?pagina=cuenta&modo=registro");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("controladorpagina?pagina=inicio");
    }

}
