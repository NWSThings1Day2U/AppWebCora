package filtros;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/vista/*", "/componentes/*", "/controladorseccion"})
public class filtroseguridad implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession sesion = req.getSession(false);

        String uri = req.getRequestURI();
        String query = req.getQueryString();

        boolean esPaginaCuentaJsp = uri.endsWith("/cuenta.jsp");
        boolean esControladorCuenta = uri.contains("/controladorpagina") && query != null && query.contains("pagina=cuenta");

        boolean logueado = (sesion != null && sesion.getAttribute("usuario") != null);

        if (logueado || esPaginaCuentaJsp || esControladorCuenta) {
            res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            res.setHeader("Pragma", "no-cache");
            res.setDateHeader("Expires", 0);

            chain.doFilter(request, response);
        } else {
            res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            HttpSession revisarSesion = req.getSession(false);
            boolean esPorInactividad = false;

            if (revisarSesion != null) {
                try {
                    long ultimaVez = revisarSesion.getLastAccessedTime();
                    long ahora = System.currentTimeMillis();
                    int maximoInactivoSegundos = revisarSesion.getMaxInactiveInterval();

                    if ((ahora - ultimaVez) >= (maximoInactivoSegundos * 1000L)) {
                        esPorInactividad = true;
                    }
                } catch (IllegalStateException e) {
                    esPorInactividad = true;
                }
            } else if (req.getRequestedSessionId() != null) {
                esPorInactividad = true;
            }

            if (esPorInactividad) {
                req.getSession(true).setAttribute("expirado", "Su sesión ha expirado por inactividad. Por favor, ingrese de nuevo.");
            } else {
                req.getSession(true).setAttribute("error", "Acceso restringido. Por favor, inicia sesión.");
            }

            res.sendRedirect(req.getContextPath() + "/controladorpagina?pagina=cuenta");
        }

    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
