
# Klinikus — Medical Management Web Application

## Overview

Klinikus is a medical management web application designed to facilitate healthcare operations through a structured, secure, and user-friendly interface. It focuses on patient management, authentication, and controlled access to medical information.

The application follows the MVC pattern and a layered architecture, separating presentation, business logic, and data access to improve maintainability and code organization.

## Features

- **Patient Management:** Access and manage patient information through a dedicated interface.
- **Authentication:** Authenticate users and manage access to protected resources.
- **Access Control:** Restrict application features according to authorization rules.
- **Session Management:** Maintain user sessions and control access to protected pages.
- **CSRF Protection:** Protect supported requests against Cross-Site Request Forgery attacks.
- **Database Persistence:** Store and retrieve application data through an ORM-based persistence layer.
- **Dynamic Web Pages:** Generate server-side views using JSP.
- **Responsive Interface:** Provide a clean interface using Tailwind CSS and JavaScript.

## Technologies

### Backend
- Java 17
- Jakarta Servlets
- JavaServer Pages (JSP)
- JDBC

### Persistence and Database
- JPA (Java Persistence API)
- Hibernate ORM 6.6
- PostgreSQL

### Frontend
- HTML5
- Tailwind CSS
- JavaScript
- Plus Jakarta Sans

### Security
- Authentication Filters
- Session Management
- CSRF Protection
- Role-Based Access Control

### Build and Deployment
- Apache Maven
- Apache Tomcat 10.1+

## Project Structure

```text
Klinikus/
├── src/
│   └── main/
│       ├── java/
│       │   └── ma/
│       │       └── klinikus/
│       │           ├── controller/
│       │           ├── service/
│       │           ├── dao/
│       │           ├── repository/
│       │           ├── model/
│       │           ├── filter/
│       │           └── config/
│       ├── resources/
│       │   └── META-INF/
│       │       └── persistence.xml
│       └── webapp/
│           ├── assets/
│           ├── css/
│           ├── js/
│           └── WEB-INF/
│               ├── views/
│               └── web.xml
├── pom.xml
└── README.md
```

*Note: This structure represents the logical organization of the application. Directory and package names should match the actual project implementation.*

## Architecture

The application uses a layered architecture to separate responsibilities.

- **Controller Layer:** Handles HTTP requests and coordinates application workflows through Servlets.
- **Service Layer:** Contains business logic and coordinates operations between controllers and data access components.
- **DAO / Repository Layer:** Encapsulates database queries and persistence operations.
- **Model Layer:** Represents application entities and domain objects.
- **Presentation Layer:** Uses JSP to render dynamic HTML pages, styled with Tailwind CSS.
- **Security Layer:** Uses filters to handle authentication, access restrictions, and CSRF protection.
- **Persistence Layer:** Uses JPA and Hibernate to map Java objects to PostgreSQL tables.

## Database and Persistence

Klinikus uses PostgreSQL as its relational database and JPA/Hibernate for object-relational mapping.

The persistence layer manages interactions between Java entities and database records, while DAO or repository components organize data access operations.

The application uses a dedicated persistence unit named `klinikusPU`.

## Security

Security mechanisms are integrated into the request-processing workflow to protect application resources.

- Authentication and session validation.
- Access restrictions for protected routes.
- Request filtering and authorization checks.
- CSRF protection for applicable state-changing requests.
- Separation of security concerns from business logic.

## Project Objectives

- Apply MVC and layered architecture principles.
- Develop a Java web application using Servlets and JSP.
- Implement persistence with JPA, Hibernate, and PostgreSQL.
- Organize business logic and database access into separate layers.
- Integrate authentication and request security.
- Build a clean, maintainable, and responsive web interface.
```
