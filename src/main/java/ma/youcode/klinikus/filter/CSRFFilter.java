package ma.youcode.klinikus.filter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Protection CSRF : un token aléatoire est créé en session (s'il est absent),
 * puis vérifié sur chaque requête POST (champ caché "_csrf").
 * Déclaré dans web.xml AVANT AuthenticationFilter.
 */
public class CSRFFilter implements Filter {

    public static final String SESSION_KEY = "csrfToken";
    public static final String PARAM_NAME = "_csrf";

    private static final SecureRandom RANDOM = new SecureRandom();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Ressources statiques : pas de session ni de vérification
        String path = chemin(req);
        if (path.startsWith("/assets/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(true);
        String token = (String) session.getAttribute(SESSION_KEY);
        if (token == null) {
            token = genererToken();
            session.setAttribute(SESSION_KEY, token);
        }

        if ("POST".equalsIgnoreCase(req.getMethod())) {
            // Doit être fait avant la première lecture des paramètres (accents dans les
            // formulaires)
            req.setCharacterEncoding("UTF-8");

            String envoye = req.getParameter(PARAM_NAME);
            if (envoye == null || !egaux(token, envoye)) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Jeton CSRF invalide ou manquant.");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private static String genererToken() {
        byte[] octets = new byte[32];
        RANDOM.nextBytes(octets);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(octets);
    }

    // Comparaison en temps constant
    private static boolean egaux(String a, String b) {
        return MessageDigest.isEqual(a.getBytes(StandardCharsets.UTF_8), b.getBytes(StandardCharsets.UTF_8));
    }

    static String chemin(HttpServletRequest req) {
        String pathInfo = req.getPathInfo();
        return req.getServletPath() + (pathInfo == null ? "" : pathInfo);
    }
}