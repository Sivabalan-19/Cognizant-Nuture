import java.util.ArrayList;
import java.util.List;

public class UserService {
    private List<User> users = new ArrayList<>();
    private int nextId = 1;
    
    public User addUser(String name, String email) {
        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Name cannot be empty");
        }
        if (email == null || !email.contains("@")) {
            throw new IllegalArgumentException("Invalid email");
        }
        
        User user = new User(nextId++, name, email);
        users.add(user);
        return user;
    }
    
    public User getUserById(int id) {
        for (User user : users) {
            if (user.getId() == id) {
                return user;
            }
        }
        return null;
    }
    
    public void deleteUser(int id) {
        users.removeIf(u -> u.getId() == id);
    }
    
    public void updateUser(int id, String name, String email) {
        User user = getUserById(id);
        if (user != null) {
            user.setName(name);
            user.setEmail(email);
        }
    }
    
    public int getTotalUsers() {
        return users.size();
    }
    
    public List<User> getAllUsers() {
        return new ArrayList<>(users);
    }
    
    public static class User {
        private int id;
        private String name;
        private String email;
        
        public User(int id, String name, String email) {
            this.id = id;
            this.name = name;
            this.email = email;
        }
        
        public int getId() {
            return id;
        }
        
        public String getName() {
            return name;
        }
        
        public void setName(String name) {
            this.name = name;
        }
        
        public String getEmail() {
            return email;
        }
        
        public void setEmail(String email) {
            this.email = email;
        }
    }
}
