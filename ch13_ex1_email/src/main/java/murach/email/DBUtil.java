package murach.email;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class DBUtil {
    
    private static final EntityManagerFactory emf = 
            Persistence.createEntityManagerFactory("emailListPU");
    
    public static EntityManagerFactory getEmFactory() {
        return emf;
    }
    
    public static void close() {
        emf.close();
    }
}
