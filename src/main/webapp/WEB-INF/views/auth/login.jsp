<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <% String erreur=(String) request.getAttribute("erreur"); String email=(String) request.getAttribute("email"); if
        (email==null) { email="" ; } String csrfToken=(String) session.getAttribute("csrfToken"); %>

        <!DOCTYPE html>
        <html lang="fr">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Connexion - Klinikus</title>

            <!-- Bootstrap 5 CDN -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        </head>

        <body class="d-flex align-items-center justify-content-center min-vh-100"
            style="background: linear-gradient(135deg, #e0f2fe 0%, #f0f9ff 100%); font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">

            <main class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-12 col-sm-10 col-md-8 col-lg-5 col-xl-4">

                        <!-- Carte de connexion -->
                        <div class="card border-0 shadow-lg rounded-4 overflow-hidden"
                            style="backdrop-filter: blur(10px); background-color: rgba(255, 255, 255, 0.95);">

                            <div class="card-body p-4 p-sm-5">

                                <!-- En-tête -->
                                <div class="text-center mb-4">
                                    <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 text-primary rounded-circle mb-3"
                                        style="width: 60px; height: 60px;">
                                        <i class="bi bi-hospital fs-2"></i>
                                    </div>
                                    <h1 class="h3 fw-bold text-primary m-0" style="letter-spacing: -0.5px;">Klinikus
                                    </h1>
                                    <p class="text-muted small mt-1">Connectez-vous à votre espace</p>
                                </div>

                                <!-- Alert d'erreur -->
                                <% if (erreur !=null) { %>
                                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center rounded-3 mb-4"
                                        role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                                        <div>
                                            <%= erreur %>
                                        </div>
                                    </div>
                                    <% } %>

                                        <!-- Formulaire -->
                                        <form method="post" action="${pageContext.request.contextPath}/login">

                                            <input type="hidden" name="_csrf" value="<%= csrfToken %>">

                                            <!-- Champ Email -->
                                            <div class="mb-3">
                                                <label for="email"
                                                    class="form-label fw-semibold text-secondary small">Adresse
                                                    Email</label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light border-end-0 text-muted"
                                                        style="border-radius: 0.5rem 0 0 0.5rem;">
                                                        <i class="bi bi-envelope"></i>
                                                    </span>
                                                    <input type="email"
                                                        class="form-group form-control bg-light border-start-0 py-2"
                                                        id="email" name="email" value="<%= email %>"
                                                        placeholder="exemple@email.com" required autocomplete="email"
                                                        style="border-radius: 0 0.5rem 0.5rem 0;">
                                                </div>
                                            </div>

                                            <!-- Champ Mot de passe -->
                                            <div class="mb-4">
                                                <label for="motDePasse"
                                                    class="form-label fw-semibold text-secondary small">Mot de
                                                    passe</label>
                                                <div class="input-group">
                                                    <span class="input-group-text bg-light border-end-0 text-muted"
                                                        style="border-radius: 0.5rem 0 0 0.5rem;">
                                                        <i class="bi bi-lock"></i>
                                                    </span>
                                                    <input type="password"
                                                        class="form-group form-control bg-light border-start-0 py-2"
                                                        id="motDePasse" name="motDePasse"
                                                        placeholder="Votre mot de passe" required
                                                        autocomplete="current-password"
                                                        style="border-radius: 0 0.5rem 0.5rem 0;">
                                                </div>
                                            </div>

                                            <!-- Bouton de soumission -->
                                            <button type="submit"
                                                class="btn btn-primary btn-login w-100 py-2.5 fw-semibold shadow-sm rounded-3"
                                                style="background-color: #0284c7; border: none; transition: all 0.2s ease;">
                                                <i class="bi bi-box-arrow-in-right me-2"></i>Se connecter
                                            </button>

                                        </form>

                            </div>
                        </div>

                        <!-- Pied de page discret -->
                        <div class="text-center mt-4">
                            <p class="text-muted small">&copy; <%= java.time.Year.now().getValue() %> Klinikus. Tous
                                    droits réservés.</p>
                        </div>

                    </div>
                </div>
            </main>

            <!-- Bootstrap JS Bundle CDN -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>