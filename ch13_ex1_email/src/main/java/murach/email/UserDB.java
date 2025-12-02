package murach.email;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class UserDB {
    
    // Insert a new user
    public static void insert(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    // Update an existing user
    public static void update(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    // Delete a user
    public static void delete(User user) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.remove(em.merge(user));
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    
    // Find a user by email
    public static User findByEmail(String email) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            List<User> users = query.getResultList();
            if (users.isEmpty()) {
                return null;
            }
            return users.get(0);
        } finally {
            em.close();
        }
    }
    
    // Get all users
    public static List<User> findAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u ORDER BY u.lastName, u.firstName", User.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // Alias methods for compatibility
    public static User selectUser(String email) {
        return findByEmail(email);
    }
    
    public static List<User> selectUsers() {
        return findAll();
    }
}
