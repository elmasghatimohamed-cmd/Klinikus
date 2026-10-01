<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <title>Consultation - Klinikus</title>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
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
                class="min-h-screen bg-[#f2f7f4] bg-[radial-gradient(60rem_30rem_at_90%_-10%,#d3eee1,transparent)] font-sans text-ink">
                <svg width="0" height="0" class="absolute" aria-hidden="true">
                    <defs>
                        <symbol id="i-plus" viewBox="0 0 24 24">
                            <path d="M12 5v14M5 12h14" />
                        </symbol>
                        <symbol id="i-users" viewBox="0 0 24 24">
                            <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" />
                            <circle cx="9" cy="7" r="4" />
                            <path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75" />
                        </symbol>
                        <symbol id="i-clock" viewBox="0 0 24 24">
                            <circle cx="12" cy="12" r="10" />
                            <path d="M12 6v6l4 2" />
                        </symbol>
                        <symbol id="i-card" viewBox="0 0 24 24">
                            <rect width="18" height="14" x="3" y="5" rx="2" />
                            <path d="M7 9h4M7 15h4M15 9h2" />
                        </symbol>
                        <symbol id="i-cal" viewBox="0 0 24 24">
                            <rect width="18" height="18" x="3" y="4" rx="2" />
                            <path d="M16 2v4M8 2v4M3 10h18" />
                        </symbol>
                        <symbol id="i-act" viewBox="0 0 24 24">
                            <path d="M22 12h-4l-3 9L9 3l-3 9H2" />
                        </symbol>
                        <symbol id="i-heart" viewBox="0 0 24 24">
                            <path
                                d="M19 14c1.5-1.5 3-3.2 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.8 0-3 .5-4.5 2-1.5-1.5-2.7-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4 3 5.5l7 7Z" />
                            <path d="M3.2 12h6.3l.5-1 2 4.5 2-7 1.5 3.5h5.3" />
                        </symbol>
                        <symbol id="i-temp" viewBox="0 0 24 24">
                            <path d="M14 4v10.5a4 4 0 1 1-4 0V4a2 2 0 0 1 4 0Z" />
                        </symbol>
                        <symbol id="i-wind" viewBox="0 0 24 24">
                            <path
                                d="M17.7 7.7a2.5 2.5 0 1 1 1.8 4.3H2M9.6 4.6A2 2 0 1 1 11 8H2M12.6 19.4A2 2 0 1 0 14 16H2" />
                        </symbol>
                        <symbol id="i-out" viewBox="0 0 24 24">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9" />
                        </symbol>
                        <symbol id="i-ok" viewBox="0 0 24 24">
                            <circle cx="12" cy="12" r="10" />
                            <path d="m9 12 2 2 4-4" />
                        </symbol>
                        <symbol id="i-warn" viewBox="0 0 24 24">
                            <path
                                d="m21.7 18-8-14a2 2 0 0 0-3.4 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.7-3ZM12 9v4M12 17h.01" />
                        </symbol>
                        <symbol id="i-steth" viewBox="0 0 24 24">
                            <path
                                d="M4.8 2.3A.3.3 0 1 0 5 2H4a2 2 0 0 0-2 2v5a6 6 0 0 0 6 6 6 6 0 0 0 6-6V4a2 2 0 0 0-2-2h-1a.2.2 0 1 0 .3.3" />
                            <path d="M8 15v1a6 6 0 0 0 6 6 6 6 0 0 0 6-6v-4" />
                            <circle cx="20" cy="10" r="2" />
                        </symbol>
                        <symbol id="i-clip" viewBox="0 0 24 24">
                            <rect width="8" height="4" x="8" y="2" rx="1" />
                            <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2" />
                        </symbol>
                        <symbol id="i-eye" viewBox="0 0 24 24">
                            <path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12Z" />
                            <circle cx="12" cy="12" r="3" />
                        </symbol>
                        <symbol id="i-pill" viewBox="0 0 24 24">
                            <path d="m10.5 20.5 10-10a4.95 4.95 0 1 0-7-7l-10 10a4.95 4.95 0 1 0 7 7Z" />
                            <path d="m8.5 8.5 7 7" />
                        </symbol>
                        <symbol id="i-back" viewBox="0 0 24 24">
                            <path d="M19 12H5M12 19l-7-7 7-7" />
                        </symbol>
                    </defs>
                </svg>

                <header class="sticky top-0 z-20 border-b border-line bg-white/80 backdrop-blur">
                    <div class="mx-auto flex h-[68px] max-w-6xl items-center justify-between px-5">
                        <a href="${pageContext.request.contextPath}/generaliste/attente"
                            class="group flex items-center gap-2.5 text-xl font-extrabold text-g9">
                            <span
                                class="grid h-9 w-9 place-items-center rounded-xl bg-gradient-to-br from-g5 to-g9 text-white shadow-lg shadow-g5/30 transition group-hover:rotate-12">
                                <svg class="ic h-5 w-5" viewBox="0 0 24 24" style="stroke-width:3">
                                    <use href="#i-plus" />
                                </svg>
                            </span>Klinikus
                        </a>
                        <div class="flex items-center gap-2">
                            <a href="${pageContext.request.contextPath}/generaliste/attente"
                                class="hidden items-center gap-2 rounded-full bg-mint px-4 py-2 text-sm font-bold text-g7 sm:inline-flex">
                                <svg class="ic h-4 w-4">
                                    <use href="#i-users" />
                                </svg>Salle d'attente</a>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="inline-flex items-center gap-2 rounded-full border-[1.5px] border-g9 px-4 py-2 text-sm font-bold text-g9 transition hover:bg-g9 hover:text-white">
                                <svg class="ic h-4 w-4">
                                    <use href="#i-out" />
                                </svg>D&eacute;connexion</a>
                        </div>
                    </div>
                </header>

                <main class="mx-auto max-w-4xl px-5 pb-14">

                    <section
                        class="relative my-7 overflow-hidden rounded-[28px] bg-gradient-to-br from-g9 via-g9 to-g7 p-7 text-white shadow-xl shadow-g9/20 motion-safe:animate-fadeUp sm:p-10">
                        <div
                            class="absolute -right-16 -top-24 h-80 w-80 rounded-full bg-g5/40 blur-3xl motion-safe:animate-floaty">
                        </div>
                        <div class="absolute -bottom-24 left-1/3 h-64 w-64 rounded-full bg-emerald-300/20 blur-3xl">
                        </div>
                        <svg class="absolute inset-x-0 bottom-0 h-20 w-full opacity-70" viewBox="0 0 600 80"
                            preserveAspectRatio="none" aria-hidden="true">
                            <path pathLength="600" stroke-dasharray="600" class="motion-safe:animate-ecg" fill="none"
                                stroke="#5fd6a4" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
                                d="M0 45H110L128 45L142 14L160 72L176 45H300L318 45L332 18L350 68L366 45H470L486 45L498 24L512 62L524 45H600" />
                        </svg>
                        <div class="relative pb-10">
                            <a href="${pageContext.request.contextPath}/generaliste/attente"
                                class="mb-4 inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 text-sm font-semibold text-emerald-200 transition hover:bg-white/20">
                                <svg class="ic h-4 w-4">
                                    <use href="#i-back" />
                                </svg>Salle d'attente</a>
                            <h1 class="text-3xl font-extrabold leading-tight tracking-tight sm:text-4xl">Nouvelle
                                consultation</h1>
                            <p class="mt-2 max-w-[52ch] text-emerald-100/80">Renseignez le motif et le diagnostic pour
                                cl&ocirc;turer la
                                consultation de ce patient.</p>
                        </div>
                    </section>

                    <!-- Récapitulatif patient -->
                    <section
                        class="mb-6 rounded-[22px] border border-line bg-white p-5 shadow-sm motion-safe:animate-fadeUp"
                        style="animation-delay:.1s">
                        <div class="flex flex-wrap items-center gap-4">
                            <span
                                class="grid h-14 w-14 flex-none place-items-center rounded-full bg-gradient-to-br from-g5 to-g9 text-lg font-extrabold text-white shadow-md shadow-g5/30">
                                <c:out value="${patient.prenom.substring(0,1)}" />
                                <c:out value="${patient.nom.substring(0,1)}" />
                            </span>
                            <div class="min-w-0 flex-1">
                                <h2 class="text-xl font-extrabold">
                                    <c:out value="${patient.prenom}" />
                                    <c:out value="${patient.nom}" />
                                </h2>
                                <div class="mt-1 flex flex-wrap gap-x-5 gap-y-1 text-sm text-muted">
                                    <span class="inline-flex items-center gap-1.5"><svg class="ic h-4 w-4">
                                            <use href="#i-card" />
                                        </svg>
                                        <c:out value="${patient.numSecu}" />
                                    </span>
                                    <span class="inline-flex items-center gap-1.5"><svg class="ic h-4 w-4">
                                            <use href="#i-cal" />
                                        </svg>N&eacute;(e) le
                                        <c:out value="${patient.dateNaissance}" />
                                    </span>
                                    <span class="inline-flex items-center gap-1.5"><svg class="ic h-4 w-4">
                                            <use href="#i-clock" />
                                        </svg>Arriv&eacute;e &agrave;
                                        <c:out value="${patient.dateArrivee.toLocalTime().toString().substring(0,5)}" />
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 flex flex-wrap gap-1.5 border-t border-line pt-4 text-[13px] font-semibold">
                            <span
                                class="inline-flex items-center gap-1.5 rounded-full bg-violet-100 px-2.5 py-1 text-violet-700"
                                title="Tension art&eacute;rielle"><svg class="ic h-3.5 w-3.5">
                                    <use href="#i-act" />
                                </svg>
                                <c:out value="${patient.tension}" />
                            </span>
                            <span
                                class="inline-flex items-center gap-1.5 rounded-full bg-rose-100 px-2.5 py-1 text-rose-700"
                                title="Fr&eacute;quence cardiaque"><svg class="ic h-3.5 w-3.5 motion-safe:animate-beat">
                                    <use href="#i-heart" />
                                </svg>${patient.frequenceCardiaque} bpm</span>
                            <span
                                class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 ${patient.temperature >= 38 ? 'bg-red-500 text-white motion-safe:animate-pulse' : 'bg-amber-100 text-amber-700'}"
                                title="Temp&eacute;rature"><svg class="ic h-3.5 w-3.5">
                                    <use href="#i-temp" />
                                </svg>${patient.temperature} &deg;C</span>
                            <span
                                class="inline-flex items-center gap-1.5 rounded-full bg-sky-100 px-2.5 py-1 text-sky-700"
                                title="Fr&eacute;quence respiratoire"><svg class="ic h-3.5 w-3.5">
                                    <use href="#i-wind" />
                                </svg>${patient.frequenceRespiratoire} /min</span>
                        </div>
                    </section>

                    <!-- Formulaire -->
                    <section
                        class="rounded-[22px] border border-line bg-white p-6 shadow-sm motion-safe:animate-fadeUp sm:p-8"
                        style="animation-delay:.2s">

                        <c:if test="${not empty erreur}">
                            <div role="alert"
                                class="mb-6 flex items-start gap-3 rounded-2xl border border-red-200 bg-red-50 px-4 py-3.5 font-semibold text-red-800 motion-safe:animate-fadeUp">
                                <svg class="ic mt-0.5 h-5 w-5 flex-none">
                                    <use href="#i-warn" />
                                </svg>
                                <span>
                                    <c:out value="${erreur}" />
                                </span>
                            </div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/generaliste/consultation"
                            class="space-y-5">
                            <input type="hidden" name="patientId" value="<c:out value='${patient.id}'/>">
                            <input type="hidden" name="_csrf" value="<c:out value='${sessionScope.csrfToken}'/>">

                            <div>
                                <label for="motif" class="lbl">Motif de consultation <span
                                        class="text-red-500">*</span></label>
                                <div class="relative">
                                    <svg
                                        class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted">
                                        <use href="#i-clip" />
                                    </svg>
                                    <input type="text" id="motif" name="motif" value="<c:out value='${motif}'/>"
                                        required maxlength="255" placeholder="Ex. : toux persistante depuis 3 jours"
                                        class="inp">
                                </div>
                            </div>

                            <div>
                                <label for="observations" class="lbl">Observations</label>
                                <div class="relative">
                                    <svg class="ic pointer-events-none absolute left-3.5 top-3.5 h-5 w-5 text-muted">
                                        <use href="#i-eye" />
                                    </svg>
                                    <textarea id="observations" name="observations" rows="4"
                                        placeholder="Examen clinique, constatations..."
                                        class="inp min-h-[110px] resize-y"><c:out value="${observations}" /></textarea>
                                </div>
                            </div>

                            <div>
                                <label for="diagnostic" class="lbl">Diagnostic <span
                                        class="text-red-500">*</span></label>
                                <div class="relative">
                                    <svg class="ic pointer-events-none absolute left-3.5 top-3.5 h-5 w-5 text-muted">
                                        <use href="#i-steth" />
                                    </svg>
                                    <textarea id="diagnostic" name="diagnostic" rows="3" required
                                        placeholder="Diagnostic retenu"
                                        class="inp min-h-[96px] resize-y"><c:out value="${diagnostic}" /></textarea>
                                </div>
                            </div>

                            <div>
                                <label for="traitement" class="lbl">Traitement prescrit</label>
                                <div class="relative">
                                    <svg class="ic pointer-events-none absolute left-3.5 top-3.5 h-5 w-5 text-muted">
                                        <use href="#i-pill" />
                                    </svg>
                                    <textarea id="traitement" name="traitement" rows="3"
                                        placeholder="M&eacute;dicaments, posologie, conseils..."
                                        class="inp min-h-[96px] resize-y"><c:out value="${traitement}" /></textarea>
                                </div>
                            </div>

                            <div class="flex items-center justify-between gap-3 rounded-2xl bg-mint px-5 py-4 text-g7">
                                <span class="inline-flex items-center gap-2 font-semibold"><svg class="ic h-5 w-5">
                                        <use href="#i-card" />
                                    </svg>Tarif de la consultation</span>
                                <b class="text-xl font-extrabold">
                                    <fmt:formatNumber value="${cout}" maxFractionDigits="0" /> DH
                                </b>
                            </div>

                            <div class="flex flex-wrap items-center justify-end gap-3 pt-2">
                                <a href="${pageContext.request.contextPath}/generaliste/attente"
                                    class="inline-flex items-center gap-2 rounded-full border-[1.5px] border-g9 px-5 py-3 font-bold text-g9 transition hover:bg-g9 hover:text-white">
                                    Annuler</a>
                                <button type="submit"
                                    class="group inline-flex items-center gap-2 rounded-full bg-g9 px-6 py-3 font-bold text-white shadow-lg shadow-g9/20 transition hover:-translate-y-0.5 hover:bg-g7 hover:shadow-xl focus:outline-none focus-visible:ring-4 focus-visible:ring-g5/30">
                                    <svg class="ic h-5 w-5">
                                        <use href="#i-ok" />
                                    </svg>Cl&ocirc;turer la consultation
                                </button>
                            </div>
                        </form>
                    </section>
                </main>
            </body>

            </html>