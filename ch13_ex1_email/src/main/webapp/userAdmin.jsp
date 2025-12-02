<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="murach.email.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Admin</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        table th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        table tr:nth-child(even) {
            background-color: #fafafa;
        }
        .action-links {
            display: flex;
            gap: 10px;
        }
        .action-links a {
            color: #333;
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #333;
            border-radius: 3px;
            font-size: 0.9em;
        }
        .action-links a:hover {
            background-color: #333;
            color: white;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>User Admin</h1>
            <p>View and manage all users</p>
        </div>
    </div>
    
    <div class="container" style="max-width: 1000px;">
        <div class="nav-links">
            <a href="index.jsp">Email List</a>
            <a href="userAdmin?action=display_users">User Admin</a>
            <a href="sqlGateway">SQL Gateway</a>
        </div>
        
        <div class="content-card">
            <% if (request.getAttribute("error") != null) { %>
                <div style="color: #ff5252; margin-bottom: 20px; padding: 10px; background-color: rgba(255, 82, 82, 0.1); border-radius: 5px;">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <h2 style="margin-bottom: 20px;">All Users</h2>
            
            <% 
                List<User> users = (List<User>) request.getAttribute("users");
                if (users == null || users.isEmpty()) {
            %>
                <p>No users found.</p>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Email</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (User user : users) { %>
                            <tr>
                                <td><%= user.getEmail() %></td>
                                <td><%= user.getFirstName() %></td>
                                <td><%= user.getLastName() %></td>
                                <td>
                                    <div class="action-links">
                                        <a href="userAdmin?action=display_user&email=<%= user.getEmail() %>">Update</a>
                                        <a href="userAdmin?action=delete_user&email=<%= user.getEmail() %>" 
                                           onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </div>
</body>
</html>
