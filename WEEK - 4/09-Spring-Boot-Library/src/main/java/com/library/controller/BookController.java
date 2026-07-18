package com.library.controller;
import com.library.entity.Book;
import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/books")
public class BookController {

    @Autowired
    private BookRepository repository;

    @PostMapping
    public Book addBook(@RequestBody Book book) {
        return repository.save(book);
    }

    @GetMapping
    public List<Book> getAllBooks() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public Book getBook(@PathVariable int id) {
        Optional<Book> book = repository.findById(id);

        if (book.isPresent()) {
            return book.get();
        }

        return null;
    }

    @PutMapping("/{id}")
    public Book updateBook(@PathVariable int id, @RequestBody Book newBook) {

        Optional<Book> book = repository.findById(id);

        if (book.isPresent()) {

            Book oldBook = book.get();

            oldBook.setTitle(newBook.getTitle());
            oldBook.setAuthor(newBook.getAuthor());

            return repository.save(oldBook);
        }

        return null;
    }

    @DeleteMapping("/{id}")
    public String deleteBook(@PathVariable int id) {

        if (repository.existsById(id)) {
            repository.deleteById(id);
            return "Book deleted successfully";
        }

        return "Book not found";
    }
}