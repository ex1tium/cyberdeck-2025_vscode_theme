// Java Demo
// This file demonstrates various Java language features and idioms

import java.util.*;
import java.util.stream.*;
import java.util.function.*;
import java.util.concurrent.*;

// ============================================================================
// MAIN CLASS (must match filename)
// ============================================================================

public class java_demo {
    
    public static void main(String[] args) {
        System.out.println("=== Java Language Demonstration ===\n");
        
        // Call demonstration methods
        demonstrateVariablesAndTypes();
        demonstrateCollections();
        demonstrateFunctions();
        demonstrateOOP();
        demonstrateInterfaces();
        demonstrateGenerics();
        demonstrateControlStructures();
        demonstrateExceptionHandling();
        demonstrateLambdasAndStreams();
        demonstrateOptionals();
        demonstrateStringManipulation();
        demonstrateFunctionalInterfaces();
        
        System.out.println("\n=== End of Java Demonstration ===");
    }
    
    // ========================================================================
    // VARIABLES AND BASIC TYPES
    // ========================================================================
    
    static void demonstrateVariablesAndTypes() {
        System.out.println("-- Variables and Types --");
        
        // Primitive types
        int count = 42;
        double pi = 3.14159;
        boolean isTrue = true;
        char letter = 'A';
        long bigNumber = 1234567890L;
        
        // Reference types
        String message = "Hello, Java!";
        Integer boxedInt = 100;  // Autoboxing
        
        System.out.println("Message: " + message);
        System.out.println("Count: " + count);
        System.out.println("Type of count: " + ((Object)count).getClass().getSimpleName());
        
        // Constants (final keyword)
        final double GRAVITY = 9.81;
        System.out.println("Gravity: " + GRAVITY);
        
        // Type inference (Java 10+)
        var inferredString = "Type inferred!";
        var inferredNumber = 42;
        System.out.println("Inferred: " + inferredString + ", " + inferredNumber);
        
        System.out.println();
    }
    
    // ========================================================================
    // COLLECTIONS FRAMEWORK
    // ========================================================================
    
    static void demonstrateCollections() {
        System.out.println("-- Collections Framework --");
        
        // ArrayList (dynamic array)
        List<String> fruits = new ArrayList<>();
        fruits.add("apple");
        fruits.add("banana");
        fruits.add("cherry");
        System.out.println("Fruits: " + fruits);
        System.out.println("First fruit: " + fruits.get(0));
        System.out.println("Size: " + fruits.size());
        
        // Iterating over lists
        for (String fruit : fruits) {
            System.out.println("  " + fruit);
        }
        
        // HashMap (key-value pairs)
        Map<String, String> fruitColors = new HashMap<>();
        fruitColors.put("apple", "red");
        fruitColors.put("banana", "yellow");
        fruitColors.put("cherry", "red");
        
        System.out.println("Apple color: " + fruitColors.get("apple"));
        
        // Iterating over maps
        for (Map.Entry<String, String> entry : fruitColors.entrySet()) {
            System.out.println(entry.getKey() + " is " + entry.getValue());
        }
        
        // HashSet (unique elements)
        Set<Integer> numbers = new HashSet<>(Arrays.asList(1, 2, 3, 3, 4, 5));
        System.out.println("Set (duplicates removed): " + numbers);
        
        System.out.println();
    }
    
    // ========================================================================
    // METHODS AND FUNCTIONS
    // ========================================================================
    
    static void demonstrateFunctions() {
        System.out.println("-- Methods and Functions --");
        
        // Basic method
        String greeting = greet("World");
        System.out.println(greeting);
        
        // Method overloading
        System.out.println("Sum of 2 numbers: " + sum(5, 10));
        System.out.println("Sum of 3 numbers: " + sum(5, 10, 15));
        
        // Varargs (variable arguments)
        System.out.println("Sum of many: " + sumAll(1, 2, 3, 4, 5));
        
        System.out.println();
    }
    
    static String greet(String name) {
        return "Hello, " + name + "!";
    }
    
    // Method overloading
    static int sum(int a, int b) {
        return a + b;
    }
    
    static int sum(int a, int b, int c) {
        return a + b + c;
    }
    
    // Varargs
    static int sumAll(int... numbers) {
        int total = 0;
        for (int num : numbers) {
            total += num;
        }
        return total;
    }
    
    // ========================================================================
    // OBJECT-ORIENTED PROGRAMMING
    // ========================================================================
    
    static void demonstrateOOP() {
        System.out.println("-- Object-Oriented Programming --");
        
        // Creating objects
        Animal dog = new Animal("Dog", 5);
        dog.speak();
        dog.displayInfo();
        
        // Inheritance
        Cat whiskers = new Cat("Whiskers", 3, "orange");
        whiskers.speak();  // Overridden method
        whiskers.displayInfo();
        whiskers.purr();  // Cat-specific method
        
        System.out.println();
    }
    
    // ========================================================================
    // INTERFACES AND ABSTRACT CLASSES
    // ========================================================================
    
    static void demonstrateInterfaces() {
        System.out.println("-- Interfaces and Polymorphism --");
        
        // Polymorphism with interfaces
        List<Shape> shapes = new ArrayList<>();
        shapes.add(new Circle(5.0));
        shapes.add(new Rectangle(4.0, 6.0));
        
        for (Shape shape : shapes) {
            shape.draw();
            System.out.println("Area: " + shape.area());
        }
        
        System.out.println();
    }
    
    // ========================================================================
    // GENERICS
    // ========================================================================
    
    static void demonstrateGenerics() {
        System.out.println("-- Generics --");
        
        // Generic class
        Box<String> stringBox = new Box<>("Hello, Generics!");
        System.out.println("String box: " + stringBox.get());
        
        Box<Integer> intBox = new Box<>(42);
        System.out.println("Integer box: " + intBox.get());
        
        // Generic method
        String[] words = {"apple", "banana", "cherry"};
        Integer[] nums = {1, 2, 3, 4, 5};
        
        System.out.println("First word: " + getFirst(words));
        System.out.println("First number: " + getFirst(nums));
        
        System.out.println();
    }
    
    // Generic method
    static <T> T getFirst(T[] array) {
        return array.length > 0 ? array[0] : null;
    }
    
    // ========================================================================
    // CONTROL STRUCTURES
    // ========================================================================
    
    static void demonstrateControlStructures() {
        System.out.println("-- Control Structures --");
        
        // If-else
        int number = 10;
        if (number > 10) {
            System.out.println("Greater than 10");
        } else if (number == 10) {
            System.out.println("Equal to 10");
        } else {
            System.out.println("Less than 10");
        }
        
        // Switch statement (traditional)
        String day = "Monday";
        switch (day) {
            case "Monday":
                System.out.println("Start of the week");
                break;
            case "Friday":
                System.out.println("End of the work week");
                break;
            default:
                System.out.println("Midweek");
        }
        
        // For loop
        for (int i = 0; i < 5; i++) {
            System.out.print(i + " ");
        }
        System.out.println();
        
        // While loop
        int j = 0;
        while (j < 3) {
            System.out.print("While: " + j + " ");
            j++;
        }
        System.out.println();
        
        // Do-while loop
        int k = 0;
        do {
            System.out.print("Do-while: " + k + " ");
            k++;
        } while (k < 3);
        System.out.println("\n");
    }
    
    // ========================================================================
    // EXCEPTION HANDLING
    // ========================================================================
    
    static void demonstrateExceptionHandling() {
        System.out.println("-- Exception Handling --");
        
        // Try-catch
        try {
            int result = divide(10, 2);
            System.out.println("10 / 2 = " + result);
        } catch (ArithmeticException e) {
            System.out.println("Error: " + e.getMessage());
        }
        
        try {
            int result = divide(10, 0);
            System.out.println("10 / 0 = " + result);
        } catch (ArithmeticException e) {
            System.out.println("Caught exception: " + e.getMessage());
        } finally {
            System.out.println("Finally block always executes");
        }
        
        // Try-with-resources (automatic resource management)
        try (Scanner scanner = new Scanner("Hello from scanner")) {
            System.out.println("Scanner input: " + scanner.nextLine());
        } // Scanner automatically closed
        
        System.out.println();
    }
    
    static int divide(int a, int b) {
        if (b == 0) {
            throw new ArithmeticException("Cannot divide by zero!");
        }
        return a / b;
    }

    // ========================================================================
    // LAMBDA EXPRESSIONS AND STREAMS
    // ========================================================================

    static void demonstrateLambdasAndStreams() {
        System.out.println("-- Lambda Expressions and Streams --");

        // Lambda expressions
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

        // Filter even numbers
        List<Integer> evenNumbers = numbers.stream()
            .filter(n -> n % 2 == 0)
            .collect(Collectors.toList());
        System.out.println("Even numbers: " + evenNumbers);

        // Map (transform) elements
        List<Integer> squared = numbers.stream()
            .map(n -> n * n)
            .collect(Collectors.toList());
        System.out.println("Squared: " + squared);

        // Reduce (aggregate)
        int sum = numbers.stream()
            .reduce(0, (a, b) -> a + b);
        System.out.println("Sum: " + sum);

        // Method references
        List<String> words = Arrays.asList("hello", "world", "java");
        words.stream()
            .map(String::toUpperCase)  // Method reference
            .forEach(System.out::println);  // Method reference

        // Parallel streams
        long count = numbers.parallelStream()
            .filter(n -> n > 5)
            .count();
        System.out.println("Count > 5: " + count);

        System.out.println();
    }

    // ========================================================================
    // OPTIONALS (Null Safety)
    // ========================================================================

    static void demonstrateOptionals() {
        System.out.println("-- Optionals (Null Safety) --");

        // Creating optionals
        Optional<String> present = Optional.of("Hello");
        Optional<String> empty = Optional.empty();
        Optional<String> nullable = Optional.ofNullable(null);

        // Checking presence
        System.out.println("Present: " + present.isPresent());
        System.out.println("Empty: " + empty.isPresent());

        // Getting values safely
        System.out.println("Value: " + present.orElse("Default"));
        System.out.println("Empty value: " + empty.orElse("Default"));

        // Using ifPresent
        present.ifPresent(value -> System.out.println("Found: " + value));

        // Chaining operations
        String result = present
            .map(String::toUpperCase)
            .orElse("NOTHING");
        System.out.println("Mapped: " + result);

        System.out.println();
    }

    // ========================================================================
    // STRING MANIPULATION
    // ========================================================================

    static void demonstrateStringManipulation() {
        System.out.println("-- String Manipulation --");

        String str = "Hello, Java!";
        System.out.println("Length: " + str.length());
        System.out.println("Uppercase: " + str.toUpperCase());
        System.out.println("Lowercase: " + str.toLowerCase());
        System.out.println("Substring: " + str.substring(0, 5));
        System.out.println("Contains 'Java': " + str.contains("Java"));
        System.out.println("Index of 'Java': " + str.indexOf("Java"));

        // String splitting
        String[] parts = str.split(", ");
        System.out.println("Split: " + Arrays.toString(parts));

        // String joining
        String joined = String.join(" - ", "apple", "banana", "cherry");
        System.out.println("Joined: " + joined);

        // String formatting
        String formatted = String.format("Pi is approximately %.2f", 3.14159);
        System.out.println(formatted);

        // StringBuilder (mutable strings)
        StringBuilder sb = new StringBuilder();
        sb.append("Hello").append(" ").append("World");
        System.out.println("StringBuilder: " + sb.toString());

        System.out.println();
    }

    // ========================================================================
    // FUNCTIONAL INTERFACES
    // ========================================================================

    static void demonstrateFunctionalInterfaces() {
        System.out.println("-- Functional Interfaces --");

        // Predicate (boolean test)
        Predicate<Integer> isEven = n -> n % 2 == 0;
        System.out.println("Is 4 even? " + isEven.test(4));
        System.out.println("Is 5 even? " + isEven.test(5));

        // Function (transformation)
        Function<String, Integer> stringLength = String::length;
        System.out.println("Length of 'Hello': " + stringLength.apply("Hello"));

        // Consumer (side effect)
        Consumer<String> printer = s -> System.out.println("Consuming: " + s);
        printer.accept("Hello, Consumer!");

        // Supplier (value provider)
        Supplier<Double> randomSupplier = Math::random;
        System.out.println("Random value: " + randomSupplier.get());

        // BiFunction (two arguments)
        BiFunction<Integer, Integer, Integer> multiply = (a, b) -> a * b;
        System.out.println("5 * 3 = " + multiply.apply(5, 3));

        System.out.println();
    }
}

// ============================================================================
// SUPPORTING CLASSES AND INTERFACES
// ============================================================================

// Basic class with constructor and methods
class Animal {
    private String name;
    private int age;

    // Constructor
    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // Method
    public void speak() {
        System.out.println(name + " makes a sound.");
    }

    public void displayInfo() {
        System.out.println(name + " is " + age + " years old.");
    }

    // Getters
    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }
}

// Inheritance - Cat extends Animal
class Cat extends Animal {
    private String color;

    public Cat(String name, int age, String color) {
        super(name, age);  // Call parent constructor
        this.color = color;
    }

    // Override parent method
    @Override
    public void speak() {
        System.out.println(getName() + " meows! (Color: " + color + ")");
    }

    // Cat-specific method
    public void purr() {
        System.out.println(getName() + " purrs contentedly.");
    }
}

// Interface definition
interface Shape {
    void draw();
    double area();
}

// Implementing interface - Circle
class Circle implements Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public void draw() {
        System.out.println("Drawing a Circle with radius " + radius);
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}

// Implementing interface - Rectangle
class Rectangle implements Shape {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    @Override
    public void draw() {
        System.out.println("Drawing a Rectangle " + width + "x" + height);
    }

    @Override
    public double area() {
        return width * height;
    }
}

// Generic class
class Box<T> {
    private T content;

    public Box(T content) {
        this.content = content;
    }

    public T get() {
        return content;
    }

    public void set(T content) {
        this.content = content;
    }
}

