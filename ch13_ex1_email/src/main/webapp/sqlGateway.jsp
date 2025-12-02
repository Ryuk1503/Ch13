<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SQL Gateway</title>
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
        .result-area {
            margin-top: 20px;
            padding: 15px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-family: 'Courier New', monospace;
            white-space: pre-wrap;
            word-wrap: break-word;
            max-height: 400px;
            overflow-y: auto;
        }
        .message {
            padding: 10px;
            margin: 15px 0;
            border-radius: 3px;
            background-color: #e8f5e9;
            border: 1px solid #4caf50;
            color: #2e7d32;
        }
        .error {
            background-color: #ffebee;
            border: 1px solid #f44336;
            color: #c62828;
        }
        textarea {
            font-family: 'Courier New', monospace;
            min-height: 120px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        table th {
            background-color: #f5f5f5;
            font-weight: bold;
        }
        table tr:nth-child(even) {
            background-color: #fafafa;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <h1>SQL Gateway</h1>
            <p>Execute SQL statements directly on PostgreSQL database</p>
        </div>
    </div>
    
    <div class="container" style="max-width: 900px;">
        <div class="nav-links">
            <a href="index.jsp">Email List</a>
            <a href="userAdmin?action=display_users">User Admin</a>
            <a href="sqlGateway">SQL Gateway</a>
        </div>
        
        <div class="content-card">
            <% if (request.getAttribute("message") != null) { 
                String message = (String) request.getAttribute("message");
                boolean isError = message.toLowerCase().contains("error");
            %>
                <div class="message <%= isError ? "error" : "" %>">
                    <%= message %>
                </div>
            <% } %>
            
            <form action="sqlGateway" method="post">
                <div class="form-group">
                    <label for="sqlStatement">Enter SQL Statement:</label>
                    <textarea id="sqlStatement" name="sqlStatement" 
                              placeholder="Example: SELECT * FROM &quot;User&quot;" 
                              required><%= request.getAttribute("sqlStatement") != null ? request.getAttribute("sqlStatement") : "" %></textarea>
                    <small style="color: #666; display: block; margin-top: 5px;">
                        Note: Use double quotes for table/column names: SELECT * FROM "User"
                    </small>
                </div>
                
                <div style="text-align: center; margin-top: 20px;">
                    <button type="submit">Execute SQL</button>
                </div>
            </form>
            
            <% if (request.getAttribute("sqlResult") != null) { 
                List<?> results = (List<?>) request.getAttribute("sqlResult");
            %>
                <div class="result-area">
                    <strong>Query Results:</strong>
                    <% if (results.isEmpty()) { %>
                        <p>No results returned.</p>
                    <% } else { %>
                        <table>
                            <% for (int i = 0; i < results.size(); i++) { 
                                Object row = results.get(i);
                                if (row instanceof Object[]) {
                                    Object[] columns = (Object[]) row;
                                    if (i == 0) { %>
                                        <tr>
                                            <th>#</th>
                                            <% for (int j = 0; j < columns.length; j++) { %>
                                                <th>Column <%= j + 1 %></th>
                                            <% } %>
                                        </tr>
                                    <% } %>
                                    <tr>
                                        <td><%= i + 1 %></td>
                                        <% for (Object col : columns) { %>
                                            <td><%= col != null ? col : "NULL" %></td>
                                        <% } %>
                                    </tr>
                                <% } else { %>
                                    <% if (i == 0) { %>
                                        <tr><th>#</th><th>Value</th></tr>
                                    <% } %>
                                    <tr>
                                        <td><%= i + 1 %></td>
                                        <td><%= row != null ? row : "NULL" %></td>
                                    </tr>
                                <% } %>
                            <% } %>
                        </table>
                    <% } %>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
