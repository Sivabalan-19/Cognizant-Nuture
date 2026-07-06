import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;

public class UserServiceTest {
    private UserService userService;
    
    @Before
    public void setup() {
        userService = new UserService();
    }
    
    @Test
    public void testAddUser() {
        UserService.User user = userService.addUser("John", "john@test.com");
        assertNotNull(user);
        assertEquals("John", user.getName());
        assertEquals("john@test.com", user.getEmail());
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testAddUserWithEmptyName() {
        userService.addUser("", "test@test.com");
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testAddUserWithInvalidEmail() {
        userService.addUser("John", "invalid-email");
    }
    
    @Test
    public void testGetUserById() {
        userService.addUser("John", "john@test.com");
        UserService.User user = userService.getUserById(1);
        assertNotNull(user);
        assertEquals("John", user.getName());
    }
    
    @Test
    public void testGetUserByIdNotFound() {
        UserService.User user = userService.getUserById(999);
        assertNull(user);
    }
    
    @Test
    public void testDeleteUser() {
        userService.addUser("John", "john@test.com");
        assertEquals(1, userService.getTotalUsers());
        userService.deleteUser(1);
        assertEquals(0, userService.getTotalUsers());
    }
    
    @Test
    public void testUpdateUser() {
        userService.addUser("John", "john@test.com");
        userService.updateUser(1, "Jane", "jane@test.com");
        UserService.User user = userService.getUserById(1);
        assertEquals("Jane", user.getName());
        assertEquals("jane@test.com", user.getEmail());
    }
    
    @Test
    public void testGetTotalUsers() {
        assertEquals(0, userService.getTotalUsers());
        userService.addUser("John", "john@test.com");
        userService.addUser("Jane", "jane@test.com");
        assertEquals(2, userService.getTotalUsers());
    }
}
