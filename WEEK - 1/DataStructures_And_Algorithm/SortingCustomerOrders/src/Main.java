import Model.Order;
import Sort.SortService;

public class Main {
    public static void main(String[] args) {
        Order[] orders = {
            new Order("O001", "Alice", 250.00),
            new Order("O002", "Bob", 1200.50),
            new Order("O003", "Charlie", 89.99),
            new Order("O004", "Diana", 540.00)
        };

        Order[] bubbleArr = new Order[orders.length];
        for (int i = 0; i < orders.length; i++) {
            bubbleArr[i] = orders[i];
        }

        SortService.bubbleSort(bubbleArr);
        System.out.println("Bubble Sort Result:");
        for (Order o : bubbleArr) {
            System.out.println(o);
        }

        Order[] quickArr = new Order[orders.length];
        for (int i = 0; i < orders.length; i++) {
            quickArr[i] = orders[i];
        }

        SortService.quickSort(quickArr, 0, quickArr.length - 1);
        System.out.println("\nQuick Sort Result:");
        for (Order o : quickArr) {
            System.out.println(o);
        }
    }
}
