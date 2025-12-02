# Chapter 13 - Email List with JPA

Jakarta EE web application using JPA/Hibernate with PostgreSQL database.

## Features
- Email List subscription (Exercise 13-1)
- User Admin with CRUD operations (Exercise 13-2)
- SQL Gateway for database testing
- JPA with Hibernate
- PostgreSQL database

## Tech Stack
- Java 17
- Jakarta EE 9+
- JPA 3.1.0 / Hibernate 6.2.5
- PostgreSQL 18
- Apache Tomcat 10.1
- Maven

## Quick Start

### Using Docker (Recommended)
```bash
docker-compose up -d
```
Access at: http://localhost:8080

### Manual Setup
1. Install PostgreSQL and create database:
```sql
CREATE DATABASE "Murach_DB";
CREATE USER emailuser WITH PASSWORD '123456';
GRANT ALL PRIVILEGES ON DATABASE "Murach_DB" TO emailuser;
```

2. Build and run:
```bash
cd ch13_ex1_email
mvn clean package
# Deploy target/ch13_ex1_email.war to Tomcat
```

## Deploy to Render

1. Create new Web Service
2. Connect this GitHub repository
3. Use Docker deployment
4. Add PostgreSQL database
5. Set environment variables:
   - `DB_HOST`: Your Render PostgreSQL hostname
   - `DB_PORT`: 5432
   - `DB_NAME`: Murach_DB
   - `DB_USER`: emailuser
   - `DB_PASSWORD`: your_password

## Project Structure
```
ch13_ex1_email/
├── src/main/java/murach/email/
│   ├── User.java (JPA Entity)
│   ├── UserDB.java (DAO)
│   ├── EmailListServlet.java
│   ├── UserAdminServlet.java
│   └── SQLGatewayServlet.java
├── src/main/resources/META-INF/
│   └── persistence.xml
└── src/main/webapp/
    ├── index.jsp
    ├── userAdmin.jsp
    ├── user.jsp
    ├── sqlGateway.jsp
    └── thanks.jsp
```

## Database Schema
```sql
CREATE TABLE "User" (
    "UserID" SERIAL PRIMARY KEY,
    "Email" VARCHAR(255) UNIQUE NOT NULL,
    "FirstName" VARCHAR(255),
    "LastName" VARCHAR(255)
);
```

## License
Educational project for learning JPA/Hibernate.
