<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="murach.email.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .nav-links {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-bottom: 20px;
        }
        .nav-links a {
            color: #333;
            text-decoration: none;
            padding: 8px 15px;
            border: 1px solid #333;
            border-radius: 3px;
            transition: all 0.3s;
        }
        .nav-links a:hover {
            background-color: #333;
            color: white;
        }
        .readonly-field {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>Update User</h1>
            <p>Edit user information</p>
        </div>
    </div>
    
    <div class="container">
        <div class="nav-links">
            <a href="index.jsp">Email List</a>
            <a href="userAdmin?action=display_users">User Admin</a>
            <a href="sqlGateway">SQL Gateway</a>
        </div>
        
        <div class="content-card">
            <% 
                User user = (User) request.getAttribute("user");
                if (user == null) {
            %>
                <p>User not found.</p>
                <div class="return-button">
                    <a href="userAdmin?action=display_users" class="back-link">Back to User Admin</a>
                </div>
            <% } else { %>
                <form action="userAdmin" method="post">
                    <input type="hidden" name="action" value="update_user">
                    
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" 
                               value="<%= user.getEmail() %>" 
                               readonly class="readonly-field">
                        <small style="color: #666; display: block; margin-top: 5px;">
                            Email cannot be changed
                        </small>
                    </div>
                    
                    <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" 
                               value="<%= user.getFirstName() %>" 
                               placeholder="Enter first name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" 
                               value="<%= user.getLastName() %>" 
                               placeholder="Enter last name" required>
                    </div>
                    
                    <div style="text-align: center; margin-top: 30px;">
                        <button type="submit">Update User</button>
                    </div>
                </form>
                
                <div class="return-button">
                    <a href="userAdmin?action=display_users" class="back-link">Back to User Admin</a>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
