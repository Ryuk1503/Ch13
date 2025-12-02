package murach.email;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EmailListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang đăng ký email
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        
        // Validate input
        if (email == null || email.trim().isEmpty() ||
            firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty()) {
            // Nếu thiếu thông tin, quay lại form
            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }
        
        // Tạo User object
        User user = new User(firstName, lastName, email);
        
        try {
            // Lưu user vào database bằng JPA
            UserDB.insert(user);
            
            // Set thông tin vào request attribute để hiển thị trên trang thanks
            request.setAttribute("user", user);
            
            // Forward đến trang thanks
            request.getRequestDispatcher("/thanks.jsp").forward(request, response);
        } catch (Exception e) {
            // Xử lý lỗi
            e.printStackTrace();
            String errorMessage = e.getMessage();
            if (errorMessage != null && (errorMessage.contains("unique") || errorMessage.contains("duplicate") || errorMessage.contains("Email"))) {
                request.setAttribute("error", "This email address is already registered.");
            } else {
                request.setAttribute("error", "Error saving user to database: " + errorMessage);
            }
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
    
    @Override
    public void destroy() {
        // Đóng EntityManagerFactory khi servlet bị hủy
        DBUtil.close();
        super.destroy();
    }
}
