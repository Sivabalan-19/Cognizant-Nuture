import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;

public class CalculatorTest {
    private Calculator calc;
    
    @Before
    public void setup() {
        calc = new Calculator();
    }
    
    @Test
    public void testAdd() {
        int result = calc.add(5, 3);
        assertEquals(8, result);
    }
    
    @Test
    public void testAddNegativeNumbers() {
        int result = calc.add(-5, -3);
        assertEquals(-8, result);
    }
    
    @Test
    public void testSubtract() {
        int result = calc.subtract(10, 4);
        assertEquals(6, result);
    }
    
    @Test
    public void testMultiply() {
        int result = calc.multiply(6, 7);
        assertEquals(42, result);
    }
    
    @Test
    public void testDivide() {
        double result = calc.divide(10, 2);
        assertEquals(5.0, result, 0.01);
    }
    
    @Test(expected = ArithmeticException.class)
    public void testDivideByZero() {
        calc.divide(10, 0);
    }
    
    @Test
    public void testIsEven() {
        assertTrue(calc.isEven(4));
        assertFalse(calc.isEven(5));
    }
    
    @Test
    public void testIsPositive() {
        assertTrue(calc.isPositive(5));
        assertFalse(calc.isPositive(-5));
    }
}
