package Inventory;

import Model.Product;
import java.util.HashMap;

public class InventoryManager {
    HashMap<String, Product> products = new HashMap<>();

    public void addProduct(Product p) {
        products.put(p.getProductId(), p);
        System.out.println("Product added");
    }

    public void updateProduct(String id, String name, int qty, double price) {
        Product p = products.get(id);
        if (p != null) {
            p.setProductName(name);
            p.setQuantity(qty);
            p.setPrice(price);
            System.out.println("Product updated");
        } else {
            System.out.println("Product not found");
        }
    }

    public void deleteProduct(String id) {
        if (products.remove(id) != null) {
            System.out.println("Product deleted");
        } else {
            System.out.println("Product not found");
        }
    }

    public void showAll() {
        for (Product p : products.values()) {
            System.out.println(p);
        }
    }
}
