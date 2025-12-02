# Exercise 13-1: Email List Application with JPA (PostgreSQL)

This is the Email List application from Chapter 13, Exercise 1. It demonstrates the use of JPA (Java Persistence API) to store and retrieve user data from a **PostgreSQL database**.

## Project Structure

```
ch13_ex1_email/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── murach/
│   │   │       └── email/
│   │   │           ├── User.java              # Entity class with JPA annotations
│   │   │           ├── DBUtil.java            # EntityManagerFactory utility
│   │   │           ├── UserDB.java            # Database operations for User
│   │   │           └── EmailListServlet.java  # Servlet controller
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml            # JPA configuration
│   │   └── webapp/
│   │       ├── css/
│   │       │   └── style.css
│   │       ├── META-INF/
│   │       │   └── context.xml
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── index.jsp                      # Email subscription form
│   │       └── thanks.jsp                     # Thank you page
└── pom.xml
```

## Features Implemented

1. ✅ **User Entity Class** - Contains JPA annotations:
   - `@Entity` to identify it as an entity
   - `@Id` on getUserID() method for primary key
   - `@GeneratedValue` for auto-increment
   - `@Column` annotations on getter methods (not fields)

2. ✅ **persistence.xml** - JPA configuration file:
   - Connects to `murach_jpa` database
   - Uses user `root` with empty password
   - Auto-creates tables if they don't exist

3. ✅ **DBUtil Class** - Manages EntityManagerFactory

4. ✅ **UserDB Class** - Provides CRUD operations:
   - insert()
   - update()
   - delete()
   - findByEmail()
   - findAll()

5. ✅ **EmailListServlet** - Modified to use JPA:
   - Saves user data to database via UserDB.insert()
   - Displays saved data on thank you page

## Database Setup

Before running the application, ensure you have PostgreSQL installed and configured:

### Quick Setup (Recommended)

Run the provided setup script:

**PowerShell:**
```powershell
cd "d:\STUDY\Web\Ch13\ch13_ex1_email"
.\setup_database.ps1
```

**Command Prompt:**
```cmd
cd "d:\STUDY\Web\Ch13\ch13_ex1_email"
setup_database.bat
```

### Manual Setup

1. **Create the database** (the application will create tables automatically):
   
   **Using psql command line:**
   ```sql
   -- Connect to PostgreSQL
   psql -U postgres
   
   -- Create database
   CREATE DATABASE murach_jpa;
   
   -- Connect to database
   \c murach_jpa
   
   -- Verify
   SELECT 'Database ready!' AS status;
   
   -- Exit
   \q
   ```
   
   **Or using pgAdmin:**
   - Right-click on "Databases"
   - Select "Create" → "Database..."
   - Enter name: `murach_jpa`
   - Click "Save"

2. **Update persistence.xml** if needed:
   - Located at: `src/main/resources/META-INF/persistence.xml`
   - Default connection:
     - Database: `murach_jpa`
     - User: `postgres`
     - Password: `postgres`
     - Port: 5432
   
   **Important:** If your PostgreSQL password is different, update this line:
   ```xml
   <property name="jakarta.persistence.jdbc.password" value="YOUR_PASSWORD"/>
   ```

3. **Verify PostgreSQL is running:**
   ```powershell
   # Check service status
   Get-Service -Name postgresql*
   
   # Or test connection
   psql -U postgres -c "SELECT version();"
   ```

For detailed setup instructions, see [POSTGRESQL_SETUP.md](POSTGRESQL_SETUP.md)

## How to Run

### Option 1: Using Maven Cargo Plugin

```powershell
cd "d:\STUDY\Web\Ch13\ch13_ex1_email"
mvn clean package cargo:run
```

The application will be available at: http://localhost:8080/ch13_ex1_email/

### Option 2: Using NetBeans

1. Open the project in NetBeans
2. Right-click on the project
3. Select "Run" or "Debug"

### Option 3: Deploy to Tomcat manually

```powershell
mvn clean package
# Copy target/ch13_ex1_email.war to Tomcat's webapps directory
```

## Testing the Application

1. **Open the application** in your browser: http://localhost:8080/ch13_ex1_email/

2. **Fill in the form** with:
   - First Name
   - Last Name
   - Email Address

3. **Click "Join Now"** - The user will be saved to the database

4. **Verify in database** using pgAdmin or psql:
   ```sql
   \c murach_jpa
   SELECT * FROM "User";
   ```

   You should see a table with columns:
   - userid (auto-generated, lowercase in PostgreSQL)
   - firstname
   - lastname
   - email

5. **Check the sequence**:
   ```sql
   SELECT * FROM "User_SEQ";
   ```
   This sequence tracks the auto-generated user IDs.

## Exercise Steps Completed

- ✅ Step 1: Opened project ch13_ex1_email
- ✅ Step 2: Reviewed persistence.xml - connects to murach_jpa database
- ✅ Step 3: Reviewed User class - has @Entity and @Id annotations
- ✅ Step 4: Reviewed DBUtil and UserDB classes - use JPA for data access
- ✅ Step 5: Run the application and add a user
- ✅ Step 6: Use MySQL Workbench to view the tables
- ✅ Step 7: Modified User class to use getter annotations instead of field annotations
- ✅ Step 8: Run the application again to verify it still works

## Key Differences from Chapter 12

**Chapter 12 (without JPA):**
- No database persistence
- Data only stored in request/session
- No entity classes

**Chapter 13 (with JPA):**
- Data persisted to PostgreSQL database
- User class is a JPA entity
- DBUtil manages EntityManagerFactory
- UserDB provides database operations
- Automatic table creation
- Auto-generated primary keys

## Dependencies

The project uses:
- Jakarta Servlet API 6.0.0
- Jakarta Persistence API 3.1.0
- Hibernate 6.2.5 (JPA implementation)
- PostgreSQL JDBC Driver 42.7.1
- Jakarta JSTL 3.0.0

## Troubleshooting

**Problem**: Connection refused to PostgreSQL
- **Solution**: Make sure PostgreSQL is running and accessible on port 5432

**Problem**: Access denied for user 'postgres'
- **Solution**: Update the password in persistence.xml to match your PostgreSQL password

**Problem**: Tables not created
- **Solution**: Check that `hibernate.hbm2ddl.auto` is set to `update` in persistence.xml

**Problem**: ClassNotFoundException for JDBC driver
- **Solution**: Ensure postgresql dependency is in pom.xml

## Author

Created for Chapter 13, Exercise 1 - Murach's Java Servlets and JSP
