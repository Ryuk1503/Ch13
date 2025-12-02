package murach.email;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.HashMap;
import java.util.Map;

public class DBUtil {
    
    private static final EntityManagerFactory emf;
    
    static {
        try {
            // Read database configuration from system properties (for Docker deployment)
            String dbHost = System.getProperty("DB_HOST", "localhost");
            String dbPort = System.getProperty("DB_PORT", "5432");
            String dbName = System.getProperty("DB_NAME", "Murach_DB");
            String dbUser = System.getProperty("DB_USER", "emailuser");
            String dbPassword = System.getProperty("DB_PASSWORD", "123456");
            
            // Build JDBC URL
            String jdbcUrl = String.format("jdbc:postgresql://%s:%s/%s", dbHost, dbPort, dbName);
            
            // Override persistence.xml properties
            Map<String, String> properties = new HashMap<>();
            properties.put("jakarta.persistence.jdbc.url", jdbcUrl);
            properties.put("jakarta.persistence.jdbc.user", dbUser);
            properties.put("jakarta.persistence.jdbc.password", dbPassword);
            
            System.out.println("Initializing DBUtil with:");
            System.out.println("  JDBC URL: " + jdbcUrl);
            System.out.println("  User: " + dbUser);
            
            emf = Persistence.createEntityManagerFactory("emailListPU", properties);
        } catch (Exception e) {
            System.err.println("Error initializing EntityManagerFactory:");
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }
    }
    
    public static EntityManagerFactory getEmFactory() {
        return emf;
    }
    
    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
