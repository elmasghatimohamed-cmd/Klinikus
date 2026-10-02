<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Connexion - Klinikus</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/assets/js/tw-config.js"></script>
    <style type="text/tailwindcss">
        @layer components {
            .ic { @apply fill-none stroke-current; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; }
            .inp { @apply w-full rounded-xl border-[1.5px] border-line bg-white py-3 pl-11 pr-3.5 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20; }
            .lbl { @apply mb-1.5 block text-sm font-semibold; }
        }
    </style>
</head>

<body
    class="relative min-h-screen overflow-hidden bg-g9 font-sans text-ink">

    <!-- Background : blurred BADMED image + dark green overlay -->
    <div class="pointer-events-none absolute inset-0 scale-110 bg-cover bg-center blur-2xl"
        style="background-image:url('${pageContext.request.contextPath}/assets/img/BADMED.png')" aria-hidden="true">
    </div>
    <div class="pointer-events-none absolute inset-0 bg-g9/80" aria-hidden="true"></div>
    <div class="pointer-events-none absolute -left-32 top-1/4 h-96 w-96 rounded-full bg-g5/25 blur-3xl"
        aria-hidden="true"></div>
    <div class="pointer-events-none absolute -right-24 bottom-0 h-96 w-96 rounded-full bg-emerald-300/15 blur-3xl"
        aria-hidden="true"></div>

    <svg width="0" height="0" class="absolute" aria-hidden="true">
        <defs>
            <symbol id="i-plus" viewBox="0 0 24 24">
                <path d="M12 5v14M5 12h14" />
            </symbol>
            <symbol id="i-mail" viewBox="0 0 24 24">
                <rect width="20" height="16" x="2" y="4" rx="2" />
                <path d="m22 7-10 6L2 7" />
            </symbol>
            <symbol id="i-lock" viewBox="0 0 24 24">
                <rect width="18" height="11" x="3" y="11" rx="2" />
                <path d="M7 11V7a5 5 0 0 1 10 0v4" />
            </symbol>
            <symbol id="i-warn" viewBox="0 0 24 24">
                <path
                    d="m21.7 18-8-14a2 2 0 0 0-3.4 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.7-3ZM12 9v4M12 17h.01" />
            </symbol>
            <symbol id="i-arrow" viewBox="0 0 24 24">
                <path d="M5 12h14M12 5l7 7-7 7" />
            </symbol>
        </defs>
    </svg>

    <main class="relative z-10 mx-auto flex min-h-screen max-w-md items-center px-5 py-10 lg:max-w-5xl">
        <div class="w-full">

            <!-- Card: left = form, right = image (4:5) -->
            <section
                class="grid overflow-hidden rounded-[28px] border border-line bg-white shadow-xl shadow-g9/10 motion-safe:animate-fadeUp lg:grid-cols-2">

                <!-- LEFT : formulaire -->
                <div class="flex flex-col">

                    <!-- En-tête : même bandeau vert que "Patients du jour" -->
                    <div
                        class="relative overflow-hidden bg-gradient-to-br from-g9 via-g9 to-g7 px-7 pb-16 pt-8 text-white sm:px-9">
                        <div
                            class="absolute -right-16 -top-24 h-64 w-64 rounded-full bg-g5/40 blur-3xl motion-safe:animate-floaty">
                        </div>
                        <div class="absolute -bottom-24 left-1/4 h-48 w-48 rounded-full bg-emerald-300/20 blur-3xl">
                        </div>
                        <svg class="absolute inset-x-0 bottom-0 h-14 w-full opacity-70" viewBox="0 0 600 80"
                            preserveAspectRatio="none" aria-hidden="true">
                            <path pathLength="600" stroke-dasharray="600" class="motion-safe:animate-ecg"
                                fill="none" stroke="#5fd6a4" stroke-width="2.5" stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M0 45H110L128 45L142 14L160 72L176 45H300L318 45L332 18L350 68L366 45H470L486 45L498 24L512 62L524 45H600" />
                        </svg>
                        <div class="relative">
                            <span class="mb-5 flex items-center gap-2.5 text-xl font-extrabold">
                                <span
                                    class="grid h-9 w-9 place-items-center rounded-xl bg-white/15 text-white ring-1 ring-white/20">
                                    <svg class="ic h-5 w-5" viewBox="0 0 24 24" style="stroke-width:3">
                                        <use href="#i-plus" />
                                    </svg>
                                </span>Klinikus
                            </span>
                            <h1 class="text-3xl font-extrabold leading-tight tracking-tight">Connexion</h1>
                            <p class="mt-2 text-emerald-100/80">Connectez-vous &agrave; votre espace.</p>
                        </div>
                    </div>

                    <div class="flex flex-1 flex-col justify-center p-7 sm:p-9">

                        <!-- Erreur -->
                        <c:if test="${not empty erreur}">
                            <div role="alert"
                                class="mb-5 flex items-start gap-3 rounded-2xl border border-red-200 bg-red-50 px-4 py-3.5 font-semibold text-red-800 motion-safe:animate-fadeUp">
                                <svg class="ic mt-0.5 h-5 w-5 flex-none">
                                    <use href="#i-warn" />
                                </svg>
                                <span>
                                    <c:out value="${erreur}" />
                                </span>
                            </div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-5">
                            <input type="hidden" name="_csrf" value="<c:out value='${sessionScope.csrfToken}'/>">

                            <div>
                                <label for="email" class="lbl">Adresse email</label>
                                <div class="relative">
                                    <svg
                                        class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted">
                                        <use href="#i-mail" />
                                    </svg>
                                    <input type="email" id="email" name="email" value="<c:out value='${email}'/>"
                                        placeholder="exemple@email.com" required autocomplete="email" class="inp">
                                </div>
                            </div>

                            <div>
                                <label for="motDePasse" class="lbl">Mot de passe</label>
                                <div class="relative">
                                    <svg
                                        class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted">
                                        <use href="#i-lock" />
                                    </svg>
                                    <input type="password" id="motDePasse" name="motDePasse"
                                        placeholder="Votre mot de passe" required autocomplete="current-password"
                                        class="inp">
                                </div>
                            </div>

                            <button type="submit"
                                class="group inline-flex w-full items-center justify-center gap-2 rounded-full bg-g9 px-6 py-3.5 font-bold text-white shadow-lg shadow-g9/20 transition hover:-translate-y-0.5 hover:bg-g7 hover:shadow-xl focus:outline-none focus-visible:ring-4 focus-visible:ring-g5/30">
                                Se connecter
                                <svg class="ic h-5 w-5 transition group-hover:translate-x-1">
                                    <use href="#i-arrow" />
                                </svg>
                            </button>
                        </form>
                    </div>
                </div>

                <!-- RIGHT : image 4:5 (desktop uniquement) -->
                <div class="relative hidden aspect-[4/5] bg-g9 lg:block">
                    <img src="${pageContext.request.contextPath}/assets/img/BADMED.png"
                        alt="Klinikus - &Eacute;quipe m&eacute;dicale" class="absolute inset-0 h-full w-full object-cover"
                        loading="eager" decoding="async">
                </div>
            </section>

            <p class="mt-6 text-center text-sm text-emerald-100/70">&copy; <%= java.time.Year.now().getValue() %>
                Klinikus. Tous droits r&eacute;serv&eacute;s.</p>
        </div>
    </main>
</body>

</html>
