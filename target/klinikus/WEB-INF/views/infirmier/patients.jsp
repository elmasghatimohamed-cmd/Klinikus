<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Patients du jour - Klinikus</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/klinikus.css">
</head>
<body>
<header class="nav"><div class="wrap">
  <a class="brand" href="${pageContext.request.contextPath}/infirmier/patients">
    <span class="logo"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="3.2" stroke-linecap="round"><path d="M12 4v16M4 12h16"/></svg></span>
    Klinikus<span>.</span>
  </a>
  <nav class="nav-links">
    <a class="on" href="${pageContext.request.contextPath}/infirmier/patients">Patients du jour</a>
    <a class="btn ghost sm" href="${pageContext.request.contextPath}/logout">Se d&eacute;connecter</a>
  </nav>
</div></header>
<main class="wrap">
  <section class="hero">
    <div>
      <h1>Patients du jour</h1>
      <p>Les patients enregistr&eacute;s aujourd'hui, du plus ancien au plus r&eacute;cent, avec leurs signes vitaux.</p>
      <div class="count"><b>${patients.size()}</b><small>patient(s) accueilli(s) aujourd'hui</small></div>
    </div>
    <a class="btn mint" href="${pageContext.request.contextPath}/infirmier/patients?action=nouveau">+ Nouveau patient</a>
  </section>

  <c:if test="${param.success == 1}">
    <div class="alert ok">Patient enregistr&eacute; : il est en attente de consultation.</div>
  </c:if>

  <section class="card" style="padding:12px">
    <c:choose>
      <c:when test="${empty patients}">
        <div class="empty">
          <h2>Aucun patient pour le moment</h2>
          <p>Enregistrez le premier patient de la journ&eacute;e pour d&eacute;marrer l'accueil.</p>
          <a class="btn" href="${pageContext.request.contextPath}/infirmier/patients?action=nouveau">Enregistrer un patient</a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="tablewrap">
          <table>
            <thead>
              <tr><th>Patient</th><th>N&deg; s&eacute;curit&eacute; sociale</th><th>Arriv&eacute;e</th><th>Signes vitaux</th></tr>
            </thead>
            <tbody>
              <c:forEach var="p" items="${patients}">
                <tr>
                  <td>
                    <div class="who">
                      <span class="av"><c:out value="${p.prenom.substring(0,1)}"/><c:out value="${p.nom.substring(0,1)}"/></span>
                      <span><c:out value="${p.prenom}"/> <c:out value="${p.nom}"/></span>
                    </div>
                  </td>
                  <td class="muted"><c:out value="${p.numSecu}"/></td>
                  <td class="time"><c:out value="${p.dateArrivee.toLocalTime().toString().substring(0,5)}"/></td>
                  <td>
                    <div class="chips">
                      <span class="chip" title="Tension art&eacute;rielle"><i>TA</i><c:out value="${p.tension}"/></span>
                      <span class="chip" title="Fr&eacute;quence cardiaque"><i>FC</i>${p.frequenceCardiaque} bpm</span>
                      <span class="chip ${p.temperature >= 38 ? 'warn' : ''}" title="Temp&eacute;rature"><i>T&deg;</i>${p.temperature} &deg;C</span>
                      <span class="chip" title="Fr&eacute;quence respiratoire"><i>FR</i>${p.frequenceRespiratoire} /min</span>
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
