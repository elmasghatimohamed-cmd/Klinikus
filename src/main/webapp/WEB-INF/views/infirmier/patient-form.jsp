<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<title>Enregistrer un patient - Klinikus</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
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
<body class="min-h-screen bg-[#f2f7f4] bg-[radial-gradient(60rem_30rem_at_90%_-10%,#d3eee1,transparent)] font-sans text-ink">
<svg width="0" height="0" class="absolute" aria-hidden="true"><defs>
<symbol id="i-plus" viewBox="0 0 24 24"><path d="M12 5v14M5 12h14"/></symbol>
<symbol id="i-users" viewBox="0 0 24 24"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87M16 3.13a4 4 0 0 1 0 7.75"/></symbol>
<symbol id="i-user" viewBox="0 0 24 24"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></symbol>
<symbol id="i-clock" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></symbol>
<symbol id="i-card" viewBox="0 0 24 24"><rect width="18" height="14" x="3" y="5" rx="2"/><path d="M7 9h4M7 15h4M15 9h2"/></symbol>
<symbol id="i-cal" viewBox="0 0 24 24"><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></symbol>
<symbol id="i-act" viewBox="0 0 24 24"><path d="M22 12h-4l-3 9L9 3l-3 9H2"/></symbol>
<symbol id="i-heart" viewBox="0 0 24 24"><path d="M19 14c1.5-1.5 3-3.2 3-5.5A5.5 5.5 0 0 0 16.5 3c-1.8 0-3 .5-4.5 2-1.5-1.5-2.7-2-4.5-2A5.5 5.5 0 0 0 2 8.5c0 2.3 1.5 4 3 5.5l7 7Z"/><path d="M3.2 12h6.3l.5-1 2 4.5 2-7 1.5 3.5h5.3"/></symbol>
<symbol id="i-temp" viewBox="0 0 24 24"><path d="M14 4v10.5a4 4 0 1 1-4 0V4a2 2 0 0 1 4 0Z"/></symbol>
<symbol id="i-wind" viewBox="0 0 24 24"><path d="M17.7 7.7a2.5 2.5 0 1 1 1.8 4.3H2M9.6 4.6A2 2 0 1 1 11 8H2M12.6 19.4A2 2 0 1 0 14 16H2"/></symbol>
<symbol id="i-out" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4M16 17l5-5-5-5M21 12H9"/></symbol>
<symbol id="i-ok" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></symbol>
<symbol id="i-warn" viewBox="0 0 24 24"><path d="m21.7 18-8-14a2 2 0 0 0-3.4 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.7-3ZM12 9v4M12 17h.01"/></symbol>
<symbol id="i-arrow" viewBox="0 0 24 24"><path d="M5 12h14M12 5l7 7-7 7"/></symbol>
</defs></svg>
<header class="sticky top-0 z-20 border-b border-line bg-white/80 backdrop-blur">
  <div class="mx-auto flex h-[68px] max-w-6xl items-center justify-between px-5">
    <a href="${pageContext.request.contextPath}/infirmier/patients" class="group flex items-center gap-2.5 text-xl font-extrabold text-g9">
      <span class="grid h-9 w-9 place-items-center rounded-xl bg-gradient-to-br from-g5 to-g9 text-white shadow-lg shadow-g5/30 transition group-hover:rotate-12">
        <svg class="ic h-5 w-5" viewBox="0 0 24 24" style="stroke-width:3"><use href="#i-plus"/></svg>
      </span>Klinikus
    </a>
    <div class="flex items-center gap-2">
      <a href="${pageContext.request.contextPath}/infirmier/patients" class="hidden items-center gap-2 rounded-full bg-mint px-4 py-2 text-sm font-bold text-g7 sm:inline-flex">
        <svg class="ic h-4 w-4"><use href="#i-users"/></svg>Patients du jour</a>
      <a href="${pageContext.request.contextPath}/logout" class="inline-flex items-center gap-2 rounded-full border-[1.5px] border-g9 px-4 py-2 text-sm font-bold text-g9 transition hover:bg-g9 hover:text-white">
        <svg class="ic h-4 w-4"><use href="#i-out"/></svg>D&eacute;connexion</a>
    </div>
  </div>
</header>

<main class="mx-auto max-w-6xl px-5 pb-14">

  <section class="relative my-7 overflow-hidden rounded-[28px] bg-gradient-to-br from-g9 via-g9 to-g7 p-7 text-white shadow-xl shadow-g9/20 motion-safe:animate-fadeUp sm:p-10">
    <div class="absolute -right-16 -top-24 h-80 w-80 rounded-full bg-g5/40 blur-3xl motion-safe:animate-floaty"></div>
    <svg class="absolute inset-x-0 bottom-0 h-20 w-full opacity-70" viewBox="0 0 600 80" preserveAspectRatio="none" aria-hidden="true">
  <path pathLength="600" stroke-dasharray="600" class="motion-safe:animate-ecg" fill="none" stroke="#5fd6a4" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"
        d="M0 45H110L128 45L142 14L160 72L176 45H300L318 45L332 18L350 68L366 45H470L486 45L498 24L512 62L524 45H600"/>
</svg>
    <div class="relative pb-8">
      <a href="${pageContext.request.contextPath}/infirmier/patients" class="mb-3 inline-flex items-center gap-2 text-sm font-semibold text-emerald-200 hover:text-white"><svg class="ic h-4 w-4 rotate-180"><use href="#i-arrow"/></svg>Retour &agrave; la liste</a>
      <h1 class="text-3xl font-extrabold leading-tight tracking-tight sm:text-4xl">Enregistrer un patient</h1>
      <p class="mt-2 max-w-[52ch] text-emerald-100/80">Identit&eacute; et signes vitaux. L'heure d'arriv&eacute;e est ajout&eacute;e automatiquement.</p>
    </div>
  </section>

  <c:if test="${not empty error}">
    <div class="mb-5 flex items-center gap-3 rounded-2xl border border-red-200 bg-red-50 px-4 py-3.5 font-semibold text-red-700 motion-safe:animate-fadeUp">
      <svg class="ic h-5 w-5"><use href="#i-warn"/></svg><c:out value="${error}"/></div>
  </c:if>

  <form id="patientForm" method="post" action="${pageContext.request.contextPath}/infirmier/patients">
    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">

    <div class="grid gap-5 md:grid-cols-2">

      <section class="rounded-[22px] border border-line bg-white p-7 shadow-sm transition hover:shadow-lg motion-safe:animate-fadeUp" style="animation-delay:.1s">
        <div class="mb-6 flex items-center gap-3">
          <span class="grid h-12 w-12 place-items-center rounded-xl bg-emerald-100 text-emerald-700"><svg class="ic h-6 w-6"><use href="#i-user"/></svg></span>
          <div><h2 class="text-xl font-bold leading-tight">Identit&eacute;</h2><p class="text-sm text-muted">Informations administratives</p></div>
        </div>
        <div class="grid gap-4 sm:grid-cols-2">
          <div>
            <label for="nom" class="lbl">Nom</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-user"/></svg>
              <input id="nom" name="nom" type="text"  value="<c:out value='${param.nom}'/>" required class="inp">
            </div>
          </div>
          <div>
            <label for="prenom" class="lbl">Pr&eacute;nom</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-user"/></svg>
              <input id="prenom" name="prenom" type="text"  value="<c:out value='${param.prenom}'/>" required class="inp">
            </div>
          </div>
          <div>
            <label for="dn" class="lbl">Date de naissance</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-cal"/></svg>
              <input id="dn" name="dateNaissance" type="date"  value="<c:out value='${param.dateNaissance}'/>" required class="inp">
            </div>
          </div>
          <div>
            <label for="ns" class="lbl">N&deg; de s&eacute;curit&eacute; sociale</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-card"/></svg>
              <input id="ns" name="numSecu" type="text"  value="<c:out value='${param.numSecu}'/>" required class="inp">
            </div>
          </div>
        </div>
      </section>

      <section class="rounded-[22px] border border-line bg-white p-7 shadow-sm transition hover:shadow-lg motion-safe:animate-fadeUp" style="animation-delay:.2s">
        <div class="mb-6 flex items-center gap-3">
          <span class="grid h-12 w-12 place-items-center rounded-xl bg-rose-100 text-rose-600"><svg class="ic h-6 w-6 motion-safe:animate-beat"><use href="#i-heart"/></svg></span>
          <div><h2 class="text-xl font-bold leading-tight">Signes vitaux</h2><p class="text-sm text-muted">Mesures prises &agrave; l'arriv&eacute;e</p></div>
        </div>
        <div class="grid gap-4 sm:grid-cols-2">
          <div>
            <label for="ta" class="lbl">Tension (ex. 12/8)</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-act"/></svg>
              <input id="ta" name="tension" type="text" placeholder="12/8" value="<c:out value='${param.tension}'/>" required class="inp">
            </div>
          </div>
          <div>
            <label for="fc" class="lbl">Fr&eacute;quence cardiaque (bpm)</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-heart"/></svg>
              <input id="fc" name="frequenceCardiaque" type="number" min="0" value="<c:out value='${param.frequenceCardiaque}'/>" required class="inp">
            </div>
          </div>
          <div>
            <label for="t" class="lbl">Temp&eacute;rature (&deg;C)</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-temp"/></svg>
              <input id="t" name="temperature" type="number" step="0.1" value="<c:out value='${param.temperature}'/>" required class="inp">
            </div>
          </div>
          <div>
            <label for="fr" class="lbl">Fr&eacute;quence respiratoire (/min)</label>
            <div class="group relative">
              <svg class="ic pointer-events-none absolute left-3.5 top-1/2 h-5 w-5 -translate-y-1/2 text-muted transition group-focus-within:text-g5"><use href="#i-wind"/></svg>
              <input id="fr" name="frequenceRespiratoire" type="number" min="0" value="<c:out value='${param.frequenceRespiratoire}'/>" required class="inp">
            </div>
          </div>
        </div>
      </section>
    </div>

    <div class="mt-6 flex flex-wrap justify-end gap-3 motion-safe:animate-fadeUp" style="animation-delay:.3s">
      <a href="${pageContext.request.contextPath}/infirmier/patients" class="rounded-full border-[1.5px] border-g9 bg-white px-6 py-3 font-bold text-g9 transition hover:bg-mint">Annuler</a>
      <button id="submitBtn" type="submit" class="group inline-flex items-center gap-2 rounded-full bg-gradient-to-r from-g7 to-g5 px-7 py-3 font-bold text-white shadow-lg shadow-g5/30 transition hover:-translate-y-0.5 hover:shadow-xl disabled:opacity-70">
        <span id="submitTxt">Enregistrer le patient</span>
        <svg class="ic h-5 w-5 transition group-hover:translate-x-1"><use href="#i-arrow"/></svg>
      </button>
    </div>
  </form>
</main>

<script>
document.getElementById('patientForm').addEventListener('submit', function () {
  var b = document.getElementById('submitBtn');
  b.disabled = true;
  document.getElementById('submitTxt').textContent = 'Enregistrement...';
});
</script>
</body>
</html>
