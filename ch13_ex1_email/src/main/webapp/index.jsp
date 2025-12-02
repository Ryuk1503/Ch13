<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email List - Join Our List</title>
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
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>Join our email list</h1>
            <p>To join our email list, enter your name and email address below</p>
        </div>
    </div>
    
    <div class="container">
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
            
            <form action="emailList" method="post">
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" 
                           placeholder="Enter your first name" required>
                </div>
                
                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" 
                           placeholder="Enter your last name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" 
                           placeholder="your.email@example.com" required>
                </div>
                
                <div style="text-align: center; margin-top: 30px;">
                    <button type="submit">Join Now</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
