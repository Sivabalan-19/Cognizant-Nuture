package Search;

import Model.Product;

public class SearchService {

    public static Product linearSearch(Product[] arr, String name) {
        for (int i = 0; i < arr.length; i++) {
            if (arr[i].getProductName().equalsIgnoreCase(name)) {
                return arr[i];
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] arr, String name) {
        int low = 0;
        int high = arr.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            String midName = arr[mid].getProductName();

            if (midName.equalsIgnoreCase(name)) {
                return arr[mid];
            } else if (midName.compareToIgnoreCase(name) < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null;
    }

    public static void sortProducts(Product[] arr) {
        for (int i = 0; i < arr.length - 1; i++) {
            for (int j = 0; j < arr.length - 1 - i; j++) {
                if (arr[j].getProductName().compareToIgnoreCase(arr[j + 1].getProductName()) > 0) {
                    Product temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }
}
