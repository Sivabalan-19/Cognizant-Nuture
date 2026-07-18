package com.library.aspect;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

@Aspect
public class LoggingAspect {

    @Before("execution(* com.library.service.*.*(..))")
    public void beforeMethod() {
        System.out.println("Before executing method");
    }

    @After("execution(* com.library.service.*.*(..))")
    public void afterMethod() {
        System.out.println("After executing method");
    }

}