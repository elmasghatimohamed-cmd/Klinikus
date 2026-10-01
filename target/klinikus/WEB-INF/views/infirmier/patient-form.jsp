<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<body>
<h2>Enregistrer un patient</h2>

<c:if test="${not empty error}">
  <p style="color:red"><c:out value="${error}"/></p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/infirmier/patients">
  <input type="hidden" name="_csrf" value="${sessionScope.csrfToken}">

  <p>Nom : <input type="text" name="nom" required></p>
  <p>Prenom : <input type="text" name="prenom" required></p>
  <p>Date de naissance : <input type="date" name="dateNaissance" required></p>
  <p>N° securite sociale : <input type="text" name="numSecu" required></p>

  <h3>Signes vitaux</h3>
  <p>Tension arterielle : <input type="text" name="tension" placeholder="12/8" required></p>
  <p>Frequence cardiaque : <input type="number" name="frequenceCardiaque" required></p>
  <p>Temperature : <input type="number" step="0.1" name="temperature" required></p>
  <p>Frequence respiratoire : <input type="number" name="frequenceRespiratoire" required></p>

  <button type="submit">Enregistrer</button>
  <a href="${pageContext.request.contextPath}/infirmier/patients">Retour a la liste</a>
</form>
</body>
</html>