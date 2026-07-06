import Model.Book;
import Search.BookSearch;

public class Main {
    public static void main(String[] args) {
        Book[] books = new Book[4];
        books[0] = new Book("B001", "1984", "George Orwell");
        books[1] = new Book("B002", "To Kill a Mockingbird", "Harper Lee");
        books[2] = new Book("B003", "The Great Gatsby", "F. Scott Fitzgerald");
        books[3] = new Book("B004", "Pride and Prejudice", "Jane Austen");

        String title = "1984";

        Book b1 = BookSearch.linearSearch(books, title);
        if (b1 != null) {
            System.out.println("Linear search: " + b1);
        }

        Book[] sorted = new Book[books.length];
        for (int i = 0; i < books.length; i++) {
            sorted[i] = books[i];
        }
        BookSearch.sortByTitle(sorted);

        Book b2 = BookSearch.binarySearch(sorted, title);
        if (b2 != null) {
            System.out.println("Binary search: " + b2);
        }
    }
}
