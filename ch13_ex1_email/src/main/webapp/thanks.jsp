<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email List - Thank You</title>
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
            <h1>Thanks for joining our email list</h1>
            <p>You have been successfully added to our email list</p>
        </div>
    </div>
    
    <div class="container">
        <div class="nav-links">
            <a href="index.jsp">Email List</a>
            <a href="userAdmin?action=display_users">User Admin</a>
            <a href="sqlGateway">SQL Gateway</a>
        </div>
        
        <div class="content-card">
            <div style="text-align: center; margin-bottom: 30px;">
                <span style="font-size: 64px; color: #64ffda;">✓</span>
                <h2 style="color: #64ffda; margin-top: 20px;">Subscription Successful!</h2>
            </div>
            
            <p style="text-align: center; margin-bottom: 30px;">
                Here is the information you entered:
            </p>
            
            <ul class="info-list">
                <li><strong>First Name:</strong> ${user.firstName}</li>
                <li><strong>Last Name:</strong> ${user.lastName}</li>
                <li><strong>Email:</strong> ${user.email}</li>
            </ul>
            
            <p style="text-align: center; margin-top: 30px; color: #b0bec5;">
                This data has been saved to the murach_jpa database.
            </p>
            
            <div class="return-button">
                <a href="emailList" class="back-link">Return to Email List</a>
            </div>
        </div>
    </div>
</body>
</html>
