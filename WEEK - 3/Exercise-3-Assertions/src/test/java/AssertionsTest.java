import org.junit.Test;
import static org.junit.Assert.*;

public class AssertionsTest {
    
    @Test
    public void testAssertEquals() {
        assertEquals(5, 2 + 3);
        assertEquals("Hello", "Hello");
        assertEquals(10.5, 5.2 + 5.3, 0.01);
    }
    
    @Test
    public void testAssertTrue() {
        assertTrue(5 > 3);
        assertTrue("Test".startsWith("T"));
    }
    
    @Test
    public void testAssertFalse() {
        assertFalse(5 < 3);
        assertFalse("Test".startsWith("X"));
    }
    
    @Test
    public void testAssertNull() {
        String str = null;
        assertNull(str);
    }
    
    @Test
    public void testAssertNotNull() {
        Object obj = new Object();
        assertNotNull(obj);
    }
    
    @Test
    public void testAssertSame() {
        String str = "test";
        String str2 = str;
        assertSame(str, str2);
    }
    
    @Test
    public void testAssertNotSame() {
        String str1 = new String("test");
        String str2 = new String("test");
        assertNotSame(str1, str2);
    }
    
    @Test
    public void testAssertArrayEquals() {
        int[] arr1 = {1, 2, 3};
        int[] arr2 = {1, 2, 3};
        assertArrayEquals(arr1, arr2);
    }
    
    @Test
    public void testFail() {
        try {
            int result = 10 / 2;
            assertEquals(5, result);
        } catch (Exception e) {
            fail("Exception should not be thrown");
        }
    }
}
