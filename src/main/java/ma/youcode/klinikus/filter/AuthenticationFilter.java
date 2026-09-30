package ma.youcode.klinikus.filter;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.klinikus.model.User;
import ma.youcode.klinikus.model.enums.Role;

/**
 * Vérifie que l'utilisateur est connecté et que son rôle correspond à la
 * section demandée :
 * /infirmier/* -> INFIRMIER, /generaliste/* -> GENERALISTE.
 * Déclaré dans web.xml APRÈS CSRFFilter.
 */
public class AuthenticationFilter implements Filter {

    public static final String SESSION_USER = "utilisateur";

    private static final Map<String, Role> ROLE_PAR_SECTION = Map.of(
            "/infirmier", Role.INFIRMIER,
            "/generaliste", Role.GENERALISTE);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = CSRFFilter.chemin(req);

        // Pages publiques
        if (path.equals("/login") || path.startsWith("/assets/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute(SESSION_USER);

        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Role roleRequis = roleRequis(path);
        if (roleRequis != null && user.getRole() != roleRequis) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Accès refusé pour votre rôle.");
            return;
        }

        // Empêche l'affichage d'une page protégée depuis le cache après déconnexion
        // (bouton Retour)
        res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        chain.doFilter(request, response);
    }

    private static Role roleRequis(String path) {
        for (Map.Entry<String, Role> e : ROLE_PAR_SECTION.entrySet()) {
            String section = e.getKey();
            if (path.equals(section) || path.startsWith(section + "/")) {
                return e.getValue();
            }
        }
        return null; // page réservée aux connectés, sans rôle particulier (ex. /logout)
    }
}