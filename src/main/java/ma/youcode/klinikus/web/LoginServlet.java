package ma.youcode.klinikus.web;

import java.io.IOException;
import java.util.Optional;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.youcode.klinikus.filter.AuthenticationFilter;
import ma.youcode.klinikus.model.User;
import ma.youcode.klinikus.model.enums.Role;
import ma.youcode.klinikus.service.AuthService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String VUE_LOGIN = "/WEB-INF/views/auth/login.jsp";

    private AuthService authService;

    @Override
    public void init() {
        this.authService = (AuthService) getServletContext().getAttribute("authService");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        HttpSession session = req.getSession(false);
        User deja = session == null ? null : (User) session.getAttribute(AuthenticationFilter.SESSION_USER);
        if (deja != null) {
            resp.sendRedirect(req.getContextPath() + urlAccueil(deja.getRole()));
            return;
        }
        req.getRequestDispatcher(VUE_LOGIN).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String motDePasse = req.getParameter("motDePasse");

        Optional<User> resultat = authService.authentifier(email, motDePasse);

        if (resultat.isEmpty()) {
            req.setAttribute("erreur", "Email ou mot de passe incorrect.");
            req.setAttribute("email", email);
            req.getRequestDispatcher(VUE_LOGIN).forward(req, resp);
            return;
        }

        User user = resultat.get();
        user.setPassword(null);

        HttpSession ancienne = req.getSession(false);
        if (ancienne != null) {
            ancienne.invalidate();
        }
        HttpSession session = req.getSession(true);
        session.setAttribute(AuthenticationFilter.SESSION_USER, user);

        resp.sendRedirect(req.getContextPath() + urlAccueil(user.getRole()));
    }

    private static String urlAccueil(Role role) {
        return switch (role) {
            case INFIRMIER -> "/infirmier/patients";
            case GENERALISTE -> "/generaliste/attente";
        };
    }
}