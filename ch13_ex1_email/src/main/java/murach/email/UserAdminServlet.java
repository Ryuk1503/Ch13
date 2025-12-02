package murach.email;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserAdminServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "display_users";
        }
        
        String url = "/index.jsp";
        
        try {
            if (action.equals("display_users")) {
                List<User> users = UserDB.selectUsers();
                request.setAttribute("users", users);
                url = "/userAdmin.jsp";
                
            } else if (action.equals("display_user")) {
                String email = request.getParameter("email");
                User user = UserDB.selectUser(email);
                request.setAttribute("user", user);
                url = "/user.jsp";
                
            } else if (action.equals("update_user")) {
                String email = request.getParameter("email");
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                
                User user = UserDB.selectUser(email);
                if (user != null) {
                    user.setFirstName(firstName);
                    user.setLastName(lastName);
                    UserDB.update(user);
                }
                
                List<User> users = UserDB.selectUsers();
                request.setAttribute("users", users);
                url = "/userAdmin.jsp";
                
            } else if (action.equals("delete_user")) {
                String email = request.getParameter("email");
                User user = UserDB.selectUser(email);
                if (user != null) {
                    UserDB.delete(user);
                }
                
                List<User> users = UserDB.selectUsers();
                request.setAttribute("users", users);
                url = "/userAdmin.jsp";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
        }
        
        getServletContext().getRequestDispatcher(url).forward(request, response);
    }
}
