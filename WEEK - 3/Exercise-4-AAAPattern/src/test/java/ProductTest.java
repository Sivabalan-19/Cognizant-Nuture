import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import static org.junit.Assert.*;

public class ProductTest {
    private Product product;
    
    @Before
    public void setUp() {
        // SETUP: Prepare test data before each test
        product = new Product(1, "Laptop", 999.99, 10);
    }
    
    @After
    public void tearDown() {
        // TEARDOWN: Clean up after each test
        product = null;
    }
    
    @Test
    public void testProductInitialization() {
        // Arrange - already done in @Before
        
        // Act - test the object
        
        // Assert - verify the results
        assertEquals(1, product.getId());
        assertEquals("Laptop", product.getName());
        assertEquals(999.99, product.getPrice(), 0.01);
        assertEquals(10, product.getStock());
    }
    
    @Test
    public void testReduceStock() {
        // Arrange
        int initialStock = product.getStock();
        
        // Act
        product.reduceStock(3);
        
        // Assert
        assertEquals(initialStock - 3, product.getStock());
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testReduceStockMoreThanAvailable() {
        // Arrange - stock is 10
        
        // Act - try to reduce more than available
        product.reduceStock(15);
        
        // Assert - exception should be thrown
    }
    
    @Test
    public void testAddStock() {
        // Arrange
        int initialStock = product.getStock();
        
        // Act
        product.addStock(5);
        
        // Assert
        assertEquals(initialStock + 5, product.getStock());
    }
    
    @Test
    public void testGetTotalValue() {
        // Arrange - product with price 999.99 and stock 10
        
        // Act
        double totalValue = product.getTotalValue();
        
        // Assert
        assertEquals(9999.9, totalValue, 0.01);
    }
    
    @Test
    public void testIsInStock() {
        // Arrange - product has stock
        
        // Act & Assert
        assertTrue(product.isInStock());
        
        // Arrange - reduce stock to 0
        product.reduceStock(product.getStock());
        
        // Act & Assert
        assertFalse(product.isInStock());
    }
    
    @Test
    public void testUpdatePrice() {
        // Arrange
        
        // Act
        product.updatePrice(899.99);
        
        // Assert
        assertEquals(899.99, product.getPrice(), 0.01);
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void testUpdatePriceNegative() {
        // Arrange
        
        // Act - try to set negative price
        product.updatePrice(-100);
        
        // Assert - exception should be thrown
    }
    
    @Test
    public void testAAAPatternExample() {
        // ARRANGE - Set up test data
        Product phone = new Product(2, "iPhone", 799.99, 5);
        int purchaseQuantity = 2;
        
        // ACT - Perform the operation
        phone.reduceStock(purchaseQuantity);
        double totalValue = phone.getTotalValue();
        
        // ASSERT - Verify the results
        assertEquals(3, phone.getStock());
        assertEquals(2399.97, totalValue, 0.01);
    }
}
