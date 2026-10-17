
# Klinikus — Application Web de Gestion Médicale

Klinikus est une application web de gestion médicale développée avec Java EE, permettant de structurer les opérations d'un établissement de santé et de faciliter la gestion des patients par le personnel autorisé.

Le projet met en pratique une architecture en couches, la persistance des données avec JPA/Hibernate, la gestion des sessions et la sécurisation des requêtes web.

## Technologies utilisées

### Backend
- Java 17
- Jakarta Servlets
- JSP (JavaServer Pages)
- JPA
- Hibernate ORM 6.6
- JDBC
- Maven

### Frontend
- HTML5
- Tailwind CSS
- JavaScript
- Plus Jakarta Sans

### Base de données
- PostgreSQL

### Serveur et outils
- Apache Tomcat 10.1+
- Git & GitHub
- IntelliJ IDEA ou Eclipse
- pgAdmin ou un client PostgreSQL

## Fonctionnalités

### Gestion des patients
- Consultation de la liste des patients.
- Organisation de l'accès aux données des patients.
- Gestion des opérations liées aux patients selon les autorisations définies dans l'application.

### Authentification et autorisation
- Authentification des utilisateurs.
- Gestion des sessions utilisateur.
- Protection des routes selon les règles d'accès.
- Contrôle des requêtes à l'aide de filtres.

### Sécurité
- Filtrage des requêtes HTTP.
- Protection contre les attaques CSRF.
- Contrôle de l'accès aux ressources protégées.
- Séparation entre les responsabilités métier et la couche de présentation.

## Architecture du projet

Le projet suit une architecture en couches afin de séparer les responsabilités et de faciliter la maintenance du code.

- **Servlets / Controllers :** reçoivent les requêtes HTTP et coordonnent les traitements.
- **Services :** regroupent la logique métier.
- **DAO / Repositories :** gèrent l'accès aux données.
- **Models / Entities :** représentent les objets métier et les entités persistées.
- **JSP :** génèrent les vues côté serveur.
- **Filters :** contrôlent l'accès aux ressources et appliquent les protections de sécurité.
- **JPA / Hibernate :** assurent le mapping objet-relationnel et la persistance des données.

## Prérequis

Avant de démarrer le projet, assurez-vous d'avoir installé :

- JDK 17
- Apache Maven
- PostgreSQL
- Apache Tomcat 10.1+
- Un IDE Java

## Installation

### 1. Cloner le projet

```bash
git clone <repository-url>
cd Klinikus
```

Remplacez `<repository-url>` par l'URL réelle du dépôt Git.

### 2. Configurer PostgreSQL

Créez ou configurez la base de données utilisée par l'application.

Vérifiez ensuite les paramètres de connexion dans la configuration JPA, notamment :

- L'URL JDBC
- Le nom d'utilisateur
- Le mot de passe
- Le pilote PostgreSQL

La persistence unit utilisée par le projet est :

```text
klinikusPU
```

Adaptez la configuration à votre environnement local.

### 3. Construire le projet

À la racine du projet, exécutez :

```bash
mvn clean package
```

Si le projet est configuré avec le packaging WAR, le fichier généré sera disponible dans le dossier `target/`.

### 4. Déployer sur Tomcat

Déployez le fichier WAR sur Apache Tomcat 10.1+, puis démarrez le serveur.

Vous pouvez également configurer Tomcat directement depuis votre IDE.

### 5. Accéder à l'application

Ouvrez votre navigateur et accédez à l'URL correspondant au contexte de déploiement configuré.

Exemple :

```text
http://localhost:8080/klinikus/
```

Le chemin exact dépend du nom du WAR et de la configuration de Tomcat.

## Configuration et persistance

La persistance des données repose sur JPA et Hibernate, avec PostgreSQL comme système de gestion de base de données.

Les opérations d'accès aux données sont organisées à travers des DAO ou repositories, utilisés par la couche service.

Exemple de composants du module patients :

- `PatientDAO`
- `JdbcPatientDAO`
- `PatientService`

La configuration de la persistence unit et les paramètres de connexion doivent correspondre à l'environnement utilisé.

## Sécurité

La sécurité de l'application repose notamment sur :

- Des filtres d'authentification pour contrôler l'accès aux ressources.
- Un filtre CSRF pour protéger les requêtes contre les falsifications intersites.
- La gestion des sessions utilisateur.
- La séparation des responsabilités entre contrôleurs, services et accès aux données.

Les identifiants de base de données et autres informations sensibles ne doivent pas être publiés dans le dépôt.

## Structure générale

La structure ci-dessous illustre l'organisation logique du projet. Les noms exacts des packages peuvent varier selon l'implémentation.

```text
Klinikus/
├── src/
│   └── main/
│       ├── java/
│       │   └── ma/klinikus/
│       │       ├── controller/
│       │       ├── service/
│       │       ├── dao/
│       │       ├── repository/
│       │       ├── model/
│       │       ├── filter/
│       │       └── config/
│       ├── resources/
│       └── webapp/
│           └── WEB-INF/
│               └── web.xml
├── pom.xml
└── README.md
```

Cette arborescence est indicative et doit être adaptée à la structure réelle du dépôt.

## Tests et vérifications

Avant de considérer l'application comme opérationnelle, vérifiez les points suivants :

- [ ] Le projet compile correctement avec Java 17.
- [ ] La connexion PostgreSQL fonctionne.
- [ ] Hibernate initialise correctement la persistence unit `klinikusPU`.
- [ ] L'application se déploie correctement sur Tomcat.
- [ ] L'authentification fonctionne.
- [ ] Les routes protégées respectent les autorisations définies.
- [ ] La liste des patients est accessible aux utilisateurs autorisés.
- [ ] Les opérations de persistance fonctionnent correctement.
- [ ] Le filtre CSRF protège les requêtes concernées.
- [ ] Les erreurs sont traitées de manière appropriée.

## Objectifs pédagogiques

Ce projet permet de mettre en pratique :

- Le développement web avec Java et Jakarta Servlets.
- Le modèle MVC et l'architecture en couches.
- La persistance avec JPA/Hibernate et PostgreSQL.
- La gestion des sessions et des filtres HTTP.
- La sécurisation des formulaires et des requêtes.
- Le déploiement d'une application web Java sur Tomcat.

## Auteur

**Badr FENNI**

Full Stack Developer

Technologies : Java, Servlets, JSP, JPA/Hibernate, PostgreSQL, HTML, Tailwind CSS et JavaScript.

## Licence

Ajouter une licence appropriée si le projet est destiné à être distribué publiquement.
