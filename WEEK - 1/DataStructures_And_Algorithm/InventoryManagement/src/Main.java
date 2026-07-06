import Inventory.InventoryManager;
import Model.Product;

public class Main {
    public static void main(String[] args) {
        InventoryManager inv = new InventoryManager();

        inv.addProduct(new Product("P001", "Laptop", 50, 999.99));
        inv.addProduct(new Product("P002", "Mouse", 200, 29.99));
        inv.addProduct(new Product("P003", "Keyboard", 150, 79.99));

        System.out.println("\nInventory List:");
        inv.showAll();

        inv.updateProduct("P002", "Wireless Mouse", 180, 34.99);

        System.out.println("\nAfter update:");
        inv.showAll();

        inv.deleteProduct("P001");

        System.out.println("\nAfter delete:");
        inv.showAll();
    }
}
