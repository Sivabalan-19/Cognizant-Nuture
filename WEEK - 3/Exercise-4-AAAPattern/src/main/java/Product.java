public class Product {
    private int id;
    private String name;
    private double price;
    private int stock;
    
    public Product(int id, String name, double price, int stock) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.stock = stock;
    }
    
    public int getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public double getPrice() {
        return price;
    }
    
    public int getStock() {
        return stock;
    }
    
    public void reduceStock(int quantity) throws IllegalArgumentException {
        if (quantity > stock) {
            throw new IllegalArgumentException("Not enough stock available");
        }
        stock -= quantity;
    }
    
    public void addStock(int quantity) {
        stock += quantity;
    }
    
    public double getTotalValue() {
        return price * stock;
    }
    
    public boolean isInStock() {
        return stock > 0;
    }
    
    public void updatePrice(double newPrice) {
        if (newPrice < 0) {
            throw new IllegalArgumentException("Price cannot be negative");
        }
        this.price = newPrice;
    }
}
