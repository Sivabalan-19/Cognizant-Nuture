import Model.Product;
import Search.SearchService;

public class Main {
    public static void main(String[] args) {
        Product[] products = new Product[4];
        products[0] = new Product("P001", "Laptop", "Electronics");
        products[1] = new Product("P002", "Mouse", "Electronics");
        products[2] = new Product("P003", "Keyboard", "Electronics");
        products[3] = new Product("P004", "Desk Chair", "Furniture");

        String searchName = "Mouse";

        Product result1 = SearchService.linearSearch(products, searchName);
        if (result1 != null) {
            System.out.println("Linear search found: " + result1);
        } else {
            System.out.println("Not found in linear search");
        }

        Product[] sorted = new Product[products.length];
        for (int i = 0; i < products.length; i++) {
            sorted[i] = products[i];
        }
        SearchService.sortProducts(sorted);

        Product result2 = SearchService.binarySearch(sorted, searchName);
        if (result2 != null) {
            System.out.println("Binary search found: " + result2);
        } else {
            System.out.println("Not found in binary search");
        }
    }
}
