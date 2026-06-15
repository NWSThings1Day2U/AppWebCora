package controlador;

import dao.categoriadao;
import modelo.categorias;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "controladorcategoria", urlPatterns = {"/controladorcategoria"})
@MultipartConfig 
public class controladorcategoria extends HttpServlet {

    categoriadao dao = new categoriadao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        if (accion == null || accion.isEmpty()) {
            List<categorias> lista = dao.mostrarCategorias();
            request.setAttribute("listaCategorias", lista);
            request.getRequestDispatcher("vista/gcategorias.jsp").forward(request, response);
            return;
        }

        switch (accion) {
            case "insertar":
                insertar(request, response);
                break;
            case "editar":
                editar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                response.sendRedirect("controladorcategoria");
        }
    }

   private void insertar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        try {
            categorias cat = new categorias();
            cat.setNombre(request.getParameter("nombre"));
            cat.setDescripcion(request.getParameter("descripcion"));
            
            Part filePart = request.getPart("imagen");
            String fileName = (filePart != null) ? filePart.getSubmittedFileName() : null;
            cat.setImagen(fileName != null && !fileName.isEmpty() ? fileName : "categorias.jpg");

            dao.insertarCategoria(cat);
            session.setAttribute("success", "La categoría se ha registrado correctamente.");
        } catch (Exception e) {
            session.setAttribute("error", "No se pudo registrar la categoría: " + e.getMessage());
        }
        response.sendRedirect("controladorcategoria");
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        try {
            categorias cat = new categorias();
            cat.setId_categoria(Integer.parseInt(request.getParameter("id_categoria")));
            cat.setNombre(request.getParameter("nombre"));
            cat.setDescripcion(request.getParameter("descripcion"));

            Part filePart = request.getPart("imagen");
            String fileName = (filePart != null) ? filePart.getSubmittedFileName() : null;

            if (fileName != null && !fileName.isEmpty()) {
                cat.setImagen(fileName);
            } else {
                String imagenActual = request.getParameter("imagenActual");
                cat.setImagen(imagenActual); 
            }

            dao.editarCategoria(cat);
            session.setAttribute("success", "La categoría se ha actualizado correctamente.");
        } catch (Exception e) {
            session.setAttribute("error", "No se pudo actualizar la categoría: " + e.getMessage());
        }
        response.sendRedirect("controladorcategoria");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id_categoria"));
            dao.eliminarCategoria(id);
            session.setAttribute("success", "La categoría ha sido eliminada con éxito.");
        } catch (Exception e) {
            session.setAttribute("error", "No se pudo eliminar la categoría: " + e.getMessage());
        }
        response.sendRedirect("controladorcategoria");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}