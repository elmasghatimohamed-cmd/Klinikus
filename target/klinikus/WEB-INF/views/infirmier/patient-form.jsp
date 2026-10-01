<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Enregistrer un patient - Klinikus</title>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<script>
tailwind.config = { theme: { extend: {
  fontFamily: { sans: ['"Plus Jakarta Sans"', 'system-ui', 'sans-serif'] },
  colors: { g9: '#0b3d31', g7: '#12634d', g5: '#2e9e72', mint: '#e4f3ec', line: '#dbe8e1', ink: '#0f2a22', muted: '#5d726a' }
} } }
</script>
</head>
<body class="bg-[#f4f8f6] font-sans leading-normal text-ink">

<header class="border-b border-line bg-white">
  <div class="mx-auto flex h-[68px] max-w-6xl items-center justify-between px-5">
    <a href="${pageContext.request.contextPath}/infirmier/patients" class="flex items-center gap-2.5 text-xl font-extrabold text-g9">
      <span class="grid h-[34px] w-[34px] place-items-center rounded-[10px] bg-g9">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="3.2" stroke-linecap="round"><path d="M12 4v16M4 12h16"/></svg>
      </span>
      Klinikus
    </a>
    <a href="${pageContext.request.contextPath}/logout"
       class="rounded-full border-[1.5px] border-g9 px-5 py-2 text-sm font-bold text-g9 transition hover:bg-mint">Se d&eacute;connecter</a>
  </div>
</header>

<main class="mx-auto max-w-6xl px-5 pb-12">

  <section class="relative my-7 overflow-hidden rounded-[28px] bg-g9 p-7 text-white sm:p-10">
    <div class="pointer-events-none absolute -right-24 -top-28 h-96 w-96 rounded-full bg-[radial-gradient(circle,rgba(46,158,114,.55),transparent_68%)]"></div>
    <div class="relative">
      <h1 class="mb-2 text-3xl font-extrabold leading-tight tracking-tight sm:text-4xl">Enregistrer un patient</h1>
      <p class="max-w-[52ch] text-[#bfe3d3]">Saisissez l'identit&eacute; et les signes vitaux. L'heure d'arriv&eacute;e est ajout&eacute;e automatiquement.</p>
    </div>
  </section>

  <c:if test="${not empty error}">
    <div class="mb-5 rounded-2xl bg-red-50 px-4 py-3.5 font-semibold text-red-700"><c:out value="${error}"/></div>
  </c:if>

  <form method="post" action="${pageContext.request.contextPath}/infirmier/patients">
    <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">

    <div class="grid gap-5 md:grid-cols-2">

      <section class="rounded-[18px] border border-line bg-white p-7">
        <h2 class="text-xl font-bold">Identit&eacute;</h2>
        <p class="mb-5 text-sm text-muted">Informations administratives du patient.</p>
        <div class="grid gap-4 sm:grid-cols-2">
          <div>
            <label for="nom" class="mb-1.5 block text-sm font-semibold">Nom</label>
            <input id="nom" type="text" name="nom" value="<c:out value='${param.nom}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
          </div>
          <div>
            <label for="prenom" class="mb-1.5 block text-sm font-semibold">Pr&eacute;nom</label>
            <input id="prenom" type="text" name="prenom" value="<c:out value='${param.prenom}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
          </div>
          <div>
            <label for="dn" class="mb-1.5 block text-sm font-semibold">Date de naissance</label>
            <input id="dn" type="date" name="dateNaissance" value="<c:out value='${param.dateNaissance}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
          </div>
          <div>
            <label for="ns" class="mb-1.5 block text-sm font-semibold">N&deg; de s&eacute;curit&eacute; sociale</label>
            <input id="ns" type="text" name="numSecu" value="<c:out value='${param.numSecu}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
          </div>
        </div>
      </section>

      <section class="rounded-[18px] border border-line bg-white p-7">
        <h2 class="text-xl font-bold">Signes vitaux</h2>
        <p class="mb-5 text-sm text-muted">Mesures prises &agrave; l'arriv&eacute;e.</p>
        <div class="grid gap-4 sm:grid-cols-2">
          <div>
            <label for="ta" class="mb-1.5 block text-sm font-semibold">Tension art&eacute;rielle</label>
            <input id="ta" type="text" name="tension" placeholder="12/8" value="<c:out value='${param.tension}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
            <p class="mt-1 text-xs text-muted">Format : systolique/diastolique</p>
          </div>
          <div>
            <label for="fc" class="mb-1.5 block text-sm font-semibold">Fr&eacute;quence cardiaque (bpm)</label>
            <input id="fc" type="number" min="0" name="frequenceCardiaque" value="<c:out value='${param.frequenceCardiaque}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
          </div>
          <div>
            <label for="t" class="mb-1.5 block text-sm font-semibold">Temp&eacute;rature (&deg;C)</label>
            <input id="t" type="number" step="0.1" name="temperature" value="<c:out value='${param.temperature}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
          </div>
          <div>
            <label for="fr" class="mb-1.5 block text-sm font-semibold">Fr&eacute;quence respiratoire (/min)</label>
            <input id="fr" type="number" min="0" name="frequenceRespiratoire" value="<c:out value='${param.frequenceRespiratoire}'/>" required
                   class="w-full rounded-xl border-[1.5px] border-line bg-[#fbfdfc] px-3.5 py-3 outline-none transition focus:border-g5 focus:ring-4 focus:ring-g5/20">
          </div>
        </div>
      </section>
    </div>

    <div class="mt-6 flex flex-wrap justify-end gap-3">
      <a href="${pageContext.request.contextPath}/infirmier/patients"
         class="rounded-full border-[1.5px] border-g9 bg-white px-6 py-3 font-bold text-g9 transition hover:bg-mint">Annuler</a>
      <button type="submit"
              class="rounded-full bg-g9 px-6 py-3 font-bold text-white transition hover:bg-g7">Enregistrer le patient</button>
    </div>
  </form>
</main>
</body>
</html>
