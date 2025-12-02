package murach.email;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.io.IOException;
import java.util.List;

public class SQLGatewayServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/sqlGateway.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String sqlStatement = request.getParameter("sqlStatement");
        
        if (sqlStatement == null || sqlStatement.trim().isEmpty()) {
            request.setAttribute("message", "Please enter a SQL statement.");
            request.getRequestDispatcher("/sqlGateway.jsp").forward(request, response);
            return;
        }
        
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // Determine if it's a query or update
            String sql = sqlStatement.trim().toUpperCase();
            
            if (sql.startsWith("SELECT")) {
                // Execute query
                Query query = em.createNativeQuery(sqlStatement);
                List<?> results = query.getResultList();
                
                request.setAttribute("sqlStatement", sqlStatement);
                request.setAttribute("sqlResult", results);
                request.setAttribute("message", "Query executed successfully. Rows returned: " + results.size());
            } else {
                // Execute update (INSERT, UPDATE, DELETE, CREATE, etc.)
                Query query = em.createNativeQuery(sqlStatement);
                int rowsAffected = query.executeUpdate();
                
                request.setAttribute("sqlStatement", sqlStatement);
                request.setAttribute("message", "Command executed successfully. Rows affected: " + rowsAffected);
            }
            
            em.getTransaction().commit();
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            request.setAttribute("sqlStatement", sqlStatement);
            request.setAttribute("message", "Error executing SQL: " + e.getMessage());
            e.printStackTrace();
        } finally {
            em.close();
        }
        
        request.getRequestDispatcher("/sqlGateway.jsp").forward(request, response);
    }
}
