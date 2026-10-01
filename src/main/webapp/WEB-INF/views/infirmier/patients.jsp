<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patients du jour - Klinikus</title>
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

  <section class="relative my-7 flex flex-wrap items-center justify-between gap-6 overflow-hidden rounded-[28px] bg-g9 p-7 text-white sm:p-10">
    <div class="pointer-events-none absolute -right-24 -top-28 h-96 w-96 rounded-full bg-[radial-gradient(circle,rgba(46,158,114,.55),transparent_68%)]"></div>
    <div class="relative">
      <h1 class="mb-2 text-3xl font-extrabold leading-tight tracking-tight sm:text-4xl">Patients du jour</h1>
      <p class="max-w-[46ch] text-[#bfe3d3]">Les patients enregistr&eacute;s aujourd'hui, du plus ancien au plus r&eacute;cent, avec leurs signes vitaux.</p>
      <div class="mt-5 inline-block rounded-[18px] border border-white/20 bg-white/10 px-6 py-4">
        <b class="block text-3xl leading-tight">${patients.size()}</b>
        <small class="text-[#bfe3d3]">patient(s) accueilli(s) aujourd'hui</small>
      </div>
    </div>
    <a href="${pageContext.request.contextPath}/infirmier/patients?action=nouveau"
       class="relative rounded-full bg-g5 px-6 py-3 font-bold text-white transition hover:bg-[#38b283]">+ Nouveau patient</a>
  </section>

  <c:if test="${param.success == 1}">
    <div class="mb-5 rounded-2xl bg-mint px-4 py-3.5 font-semibold text-g7">Patient enregistr&eacute; : il est en attente de consultation.</div>
  </c:if>

  <section class="rounded-[18px] border border-line bg-white p-3">
    <c:choose>
      <c:when test="${empty patients}">
        <div class="px-5 py-14 text-center">
          <h2 class="mb-1.5 text-xl font-bold">Aucun patient pour le moment</h2>
          <p class="mb-5 text-muted">Enregistrez le premier patient de la journ&eacute;e pour d&eacute;marrer l'accueil.</p>
          <a href="${pageContext.request.contextPath}/infirmier/patients?action=nouveau"
             class="inline-flex rounded-full bg-g9 px-6 py-3 font-bold text-white transition hover:bg-g7">Enregistrer un patient</a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="overflow-x-auto px-2 pt-2">
          <table class="w-full min-w-[760px] border-collapse">
            <thead>
              <tr class="text-left text-[13px] font-semibold text-muted">
                <th class="border-b border-line px-4 py-3.5">Patient</th>
                <th class="border-b border-line px-4 py-3.5">N&deg; s&eacute;curit&eacute; sociale</th>
                <th class="border-b border-line px-4 py-3.5">Arriv&eacute;e</th>
                <th class="border-b border-line px-4 py-3.5">Signes vitaux</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="p" items="${patients}">
                <tr class="transition hover:bg-[#f7fbf9]">
                  <td class="border-b border-line px-4 py-4">
                    <div class="flex items-center gap-3 font-bold">
                      <span class="grid h-10 w-10 flex-none place-items-center rounded-full bg-mint text-sm font-extrabold text-g7"><c:out value="${p.prenom.substring(0,1)}"/><c:out value="${p.nom.substring(0,1)}"/></span>
                      <span><c:out value="${p.prenom}"/> <c:out value="${p.nom}"/></span>
                    </div>
                  </td>
                  <td class="border-b border-line px-4 py-4 text-muted"><c:out value="${p.numSecu}"/></td>
                  <td class="border-b border-line px-4 py-4 font-bold tabular-nums"><c:out value="${p.dateArrivee.toLocalTime().toString().substring(0,5)}"/></td>
                  <td class="border-b border-line px-4 py-4">
                    <div class="flex flex-wrap gap-1.5 text-[13px]">
                      <span class="rounded-full bg-mint px-3 py-1 text-g9" title="Tension art&eacute;rielle"><span class="mr-1 text-muted">TA</span><c:out value="${p.tension}"/></span>
                      <span class="rounded-full bg-mint px-3 py-1 text-g9" title="Fr&eacute;quence cardiaque"><span class="mr-1 text-muted">FC</span>${p.frequenceCardiaque} bpm</span>
                      <span class="rounded-full px-3 py-1 ${p.temperature >= 38 ? 'bg-amber-100 text-amber-800' : 'bg-mint text-g9'}" title="Temp&eacute;rature"><span class="mr-1 text-muted">T&deg;</span>${p.temperature} &deg;C</span>
                      <span class="rounded-full bg-mint px-3 py-1 text-g9" title="Fr&eacute;quence respiratoire"><span class="mr-1 text-muted">FR</span>${p.frequenceRespiratoire} /min</span>
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
</body>
</html>
