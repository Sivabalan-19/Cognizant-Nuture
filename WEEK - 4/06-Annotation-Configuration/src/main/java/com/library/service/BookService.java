package com.library.service;

import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    public void displayBook() {

        System.out.println("Book Service Started");

        bookRepository.getBook();

        System.out.println("Book Service Completed");
    }

}