<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="fr">

    <head>
      <title>Patients du jour - Klinikus</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
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
          <symbol id="i-user" viewBox="0 0 24 24">
            <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
            <circle cx="12" cy="7" r="4" />
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
            <path d="M17.7 7.7a2.5 2.5 0 1 1 1.8 4.3H2M9.6 4.6A2 2 0 1 1 11 8H2M12.6 19.4A2 2 0 1 0 14 16H2" />
          </symbol>
          <symbol id="i-out" viewBox="0 0 24 24">
            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9" />
          </symbol>
          <symbol id="i-ok" viewBox="0 0 24 24">
            <circle cx="12" cy="12" r="10" />
            <path d="m9 12 2 2 4-4" />
          </symbol>
          <symbol id="i-warn" viewBox="0 0 24 24">
            <path d="m21.7 18-8-14a2 2 0 0 0-3.4 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.7-3ZM12 9v4M12 17h.01" />
          </symbol>
          <symbol id="i-arrow" viewBox="0 0 24 24">
            <path d="M5 12h14M12 5l7 7-7 7" />
          </symbol>
        </defs>
      </svg>
      <header class="sticky top-0 z-20 border-b border-line bg-white/80 backdrop-blur">
        <div class="mx-auto flex h-[68px] max-w-6xl items-center justify-between px-5">
          <a href="${pageContext.request.contextPath}/infirmier/patients"
            class="group flex items-center gap-2.5 text-xl font-extrabold text-g9">
            <span
              class="grid h-9 w-9 place-items-center rounded-xl bg-gradient-to-br from-g5 to-g9 text-white shadow-lg shadow-g5/30 transition group-hover:rotate-12">
              <svg class="ic h-5 w-5" viewBox="0 0 24 24" style="stroke-width:3">
                <use href="#i-plus" />
              </svg>
            </span>Klinikus
          </a>
          <div class="flex items-center gap-2">
            <a href="${pageContext.request.contextPath}/infirmier/patients"
              class="hidden items-center gap-2 rounded-full bg-mint px-4 py-2 text-sm font-bold text-g7 sm:inline-flex">
              <svg class="ic h-4 w-4">
                <use href="#i-users" />
              </svg>Patients du jour</a>
            <a href="${pageContext.request.contextPath}/logout"
              class="inline-flex items-center gap-2 rounded-full border-[1.5px] border-g9 px-4 py-2 text-sm font-bold text-g9 transition hover:bg-g9 hover:text-white">
              <svg class="ic h-4 w-4">
                <use href="#i-out" />
              </svg>D&eacute;connexion</a>
          </div>
        </div>
      </header>

      <main class="mx-auto max-w-6xl px-5 pb-14">

        <section
          class="relative my-7 overflow-hidden rounded-[28px] bg-gradient-to-br from-g9 via-g9 to-g7 p-7 text-white shadow-xl shadow-g9/20 motion-safe:animate-fadeUp sm:p-10">
          <div class="absolute -right-16 -top-24 h-80 w-80 rounded-full bg-g5/40 blur-3xl motion-safe:animate-floaty">
          </div>
          <div class="absolute -bottom-24 left-1/3 h-64 w-64 rounded-full bg-emerald-300/20 blur-3xl"></div>
          <svg class="absolute inset-x-0 bottom-0 h-20 w-full opacity-70" viewBox="0 0 600 80"
            preserveAspectRatio="none" aria-hidden="true">
            <path pathLength="600" stroke-dasharray="600" class="motion-safe:animate-ecg" fill="none" stroke="#5fd6a4"
              stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
              d="M0 45H110L128 45L142 14L160 72L176 45H300L318 45L332 18L350 68L366 45H470L486 45L498 24L512 62L524 45H600" />
          </svg>
          <div class="relative flex flex-wrap items-center justify-between gap-6 pb-10">
            <div>
              <span
                class="mb-3 inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 text-sm font-semibold text-emerald-200">
                <span class="relative flex h-2.5 w-2.5"><span
                    class="absolute inline-flex h-full w-full animate-ping rounded-full bg-emerald-300 opacity-75"></span><span
                    class="relative inline-flex h-2.5 w-2.5 rounded-full bg-emerald-300"></span></span>
                Accueil en cours
              </span>
              <h1 class="text-3xl font-extrabold leading-tight tracking-tight sm:text-4xl">Patients du jour</h1>
              <p class="mt-2 max-w-[48ch] text-emerald-100/80">Du plus ancien au plus r&eacute;cent, avec leurs signes
                vitaux.</p>
            </div>
            <a href="${pageContext.request.contextPath}/infirmier/patients?action=nouveau"
              class="group inline-flex items-center gap-2 rounded-full bg-white px-6 py-3.5 font-bold text-g9 shadow-lg transition hover:-translate-y-0.5 hover:shadow-2xl">
              <svg class="ic h-5 w-5 transition group-hover:rotate-90" viewBox="0 0 24 24">
                <use href="#i-plus" />
              </svg>Nouveau patient</a>
          </div>
        </section>

        <c:if test="${param.success == 1}">
          <div
            class="mb-5 flex items-center gap-3 rounded-2xl border border-emerald-200 bg-emerald-50 px-4 py-3.5 font-semibold text-emerald-800 motion-safe:animate-fadeUp">
            <svg class="ic h-5 w-5">
              <use href="#i-ok" />
            </svg>Patient enregistr&eacute; : il est en attente de consultation.
          </div>
        </c:if>

        <div class="mb-6 grid gap-4 sm:grid-cols-3">
          <div
            class="flex items-center gap-4 rounded-2xl border border-line bg-white p-5 transition hover:-translate-y-1 hover:shadow-lg motion-safe:animate-fadeUp"
            style="animation-delay:.1s">
            <span class="grid h-12 w-12 place-items-center rounded-xl bg-emerald-100 text-emerald-700"><svg
                class="ic h-6 w-6">
                <use href="#i-users" />
              </svg></span>
            <div><b id="statTotal" data-count="${patients.size()}"
                class="block text-3xl font-extrabold leading-none">0</b><span class="text-sm text-muted">patients
                aujourd'hui</span></div>
          </div>
          <div
            class="flex items-center gap-4 rounded-2xl border border-line bg-white p-5 transition hover:-translate-y-1 hover:shadow-lg motion-safe:animate-fadeUp"
            style="animation-delay:.18s">
            <span class="grid h-12 w-12 place-items-center rounded-xl bg-sky-100 text-sky-700"><svg class="ic h-6 w-6">
                <use href="#i-clock" />
              </svg></span>
            <div><b id="statLast" class="block text-3xl font-extrabold leading-none">--:--</b><span
                class="text-sm text-muted">derni&egrave;re arriv&eacute;e</span></div>
          </div>
          <div
            class="flex items-center gap-4 rounded-2xl border border-line bg-white p-5 transition hover:-translate-y-1 hover:shadow-lg motion-safe:animate-fadeUp"
            style="animation-delay:.26s">
            <span class="grid h-12 w-12 place-items-center rounded-xl bg-amber-100 text-amber-700"><svg
                class="ic h-6 w-6">
                <use href="#i-temp" />
              </svg></span>
            <div><b id="statFever" class="block text-3xl font-extrabold leading-none">0</b><span
                class="text-sm text-muted">avec fi&egrave;vre (38 &deg;C et +)</span></div>
          </div>
        </div>

        <section class="rounded-[22px] border border-line bg-white p-3 shadow-sm motion-safe:animate-fadeUp"
          style="animation-delay:.3s">
          <c:choose>
            <c:when test="${empty patients}">
              <div class="px-5 py-16 text-center">
                <span
                  class="mx-auto mb-4 grid h-20 w-20 place-items-center rounded-full bg-mint text-g5 motion-safe:animate-beat"><svg
                    class="ic h-10 w-10">
                    <use href="#i-heart" />
                  </svg></span>
                <h2 class="mb-1.5 text-xl font-bold">Aucun patient pour le moment</h2>
                <p class="mb-6 text-muted">Enregistrez le premier patient de la journ&eacute;e pour d&eacute;marrer
                  l'accueil.</p>
                <a href="${pageContext.request.contextPath}/infirmier/patients?action=nouveau"
                  class="inline-flex items-center gap-2 rounded-full bg-g9 px-6 py-3 font-bold text-white transition hover:bg-g7">
                  <svg class="ic h-5 w-5">
                    <use href="#i-plus" />
                  </svg>Enregistrer un patient</a>
              </div>
            </c:when>
            <c:otherwise>
              <div class="overflow-x-auto px-2 pt-2">
                <table class="w-full min-w-[800px] border-collapse">
                  <thead>
                    <tr class="text-left text-[13px] font-semibold text-muted">
                      <th class="border-b border-line px-4 py-3.5">Patient</th>
                      <th class="border-b border-line px-4 py-3.5">N&deg; s&eacute;curit&eacute; sociale</th>
                      <th class="border-b border-line px-4 py-3.5">Arriv&eacute;e</th>
                      <th class="border-b border-line px-4 py-3.5">Signes vitaux</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="p" items="${patients}" varStatus="s">
                      <tr data-row data-time="<c:out value='${p.dateArrivee.toLocalTime().toString().substring(0,5)}'/>"
                        data-fever="${p.temperature >= 38 ? 1 : 0}"
                        class="group transition hover:bg-mint/50 motion-safe:animate-fadeUp"
                        style="animation-delay:${0.35 + s.index * 0.06}s">
                        <td class="border-b border-line px-4 py-4">
                          <div class="flex items-center gap-3 font-bold">
                            <span
                              class="grid h-11 w-11 flex-none place-items-center rounded-full bg-gradient-to-br from-g5 to-g9 text-sm font-extrabold text-white shadow-md shadow-g5/30 transition group-hover:scale-110">
                              <c:out value="${p.prenom.substring(0,1)}" />
                              <c:out value="${p.nom.substring(0,1)}" />
                            </span>
                            <span>
                              <c:out value="${p.prenom}" />
                              <c:out value="${p.nom}" />
                            </span>
                          </div>
                        </td>
                        <td class="border-b border-line px-4 py-4 text-muted"><span
                            class="inline-flex items-center gap-2"><svg class="ic h-4 w-4">
                              <use href="#i-card" />
                            </svg>
                            <c:out value="${p.numSecu}" />
                          </span></td>
                        <td class="border-b border-line px-4 py-4"><span
                            class="inline-flex items-center gap-1.5 rounded-lg bg-sky-50 px-2.5 py-1 text-sm font-bold tabular-nums text-sky-700"><svg
                              class="ic h-4 w-4">
                              <use href="#i-clock" />
                            </svg>
                            <c:out value="${p.dateArrivee.toLocalTime().toString().substring(0,5)}" />
                          </span></td>
                        <td class="border-b border-line px-4 py-4">
                          <div class="flex flex-wrap gap-1.5 text-[13px] font-semibold">
                            <span
                              class="inline-flex items-center gap-1.5 rounded-full bg-violet-100 px-2.5 py-1 text-violet-700"
                              title="Tension art&eacute;rielle"><svg class="ic h-3.5 w-3.5">
                                <use href="#i-act" />
                              </svg>
                              <c:out value="${p.tension}" />
                            </span>
                            <span
                              class="inline-flex items-center gap-1.5 rounded-full bg-rose-100 px-2.5 py-1 text-rose-700"
                              title="Fr&eacute;quence cardiaque"><svg class="ic h-3.5 w-3.5 motion-safe:animate-beat">
                                <use href="#i-heart" />
                              </svg>${p.frequenceCardiaque} bpm</span>
                            <span
                              class="inline-flex items-center gap-1.5 rounded-full px-2.5 py-1 ${p.temperature >= 38 ? 'bg-red-500 text-white motion-safe:animate-pulse' : 'bg-amber-100 text-amber-700'}"
                              title="Temp&eacute;rature"><svg class="ic h-3.5 w-3.5">
                                <use href="#i-temp" />
                              </svg>${p.temperature} &deg;C</span>
                            <span
                              class="inline-flex items-center gap-1.5 rounded-full bg-sky-100 px-2.5 py-1 text-sky-700"
                              title="Fr&eacute;quence respiratoire"><svg class="ic h-3.5 w-3.5">
                                <use href="#i-wind" />
                              </svg>${p.frequenceRespiratoire} /min</span>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:otherwise>
          </c:choose>
        </section>
      </main>

      <script>
        (function () {
          var rows = document.querySelectorAll('[data-row]');
          if (rows.length) {
            document.getElementById('statLast').textContent = rows[rows.length - 1].getAttribute('data-time');
            document.getElementById('statFever').textContent = document.querySelectorAll('[data-fever="1"]').length;
          }
          var el = document.getElementById('statTotal');
          var to = parseInt(el.getAttribute('data-count'), 10) || 0;
          if (window.matchMedia('(prefers-reduced-motion: reduce)').matches || to === 0) { el.textContent = to; return; }
          var n = 0;
          (function step() { n += Math.max(1, Math.ceil(to / 25)); el.textContent = Math.min(n, to); if (n < to) requestAnimationFrame(step); })();
        })();
      </script>
    </body>

    </html>