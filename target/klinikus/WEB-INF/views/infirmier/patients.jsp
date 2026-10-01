<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<body>
<h2>Patients du jour</h2>

<c:if test="${param.success == 1}">
  <p style="color:green">Patient enregistre, il est en attente de consultation.</p>
</c:if>

<a href="${pageContext.request.contextPath}/infirmier/patients?action=nouveau">Nouveau patient</a>

<c:choose>
  <c:when test="${empty patients}">
    <p>Aucun patient aujourd'hui.</p>
  </c:when>
  <c:otherwise>
    <table border="1">
      <tr>
        <th>Nom</th><th>Prenom</th><th>N° secu</th><th>Arrivee</th>
        <th>Tension</th><th>FC</th><th>Temp.</th><th>FR</th>
      </tr>
      <c:forEach var="p" items="${patients}">
        <tr>
          <td><c:out value="${p.nom}"/></td>
          <td><c:out value="${p.prenom}"/></td>
          <td><c:out value="${p.numSecu}"/></td>
          <td>${p.dateArrivee.hour}h${p.dateArrivee.minute}</td>
          <td><c:out value="${p.tension}"/></td>
          <td>${p.frequenceCardiaque}</td>
          <td>${p.temperature}</td>
          <td>${p.frequenceRespiratoire}</td>
        </tr>
      </c:forEach>
    </table>
  </c:otherwise>
</c:choose>
</body>
</html>