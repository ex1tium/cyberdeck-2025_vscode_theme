// Rust Demo
// This file demonstrates various Rust language features and idioms

use std::collections::HashMap;
use std::fmt;
use std::error::Error;
use std::sync::{Arc, Mutex};
use std::thread;
use std::rc::Rc;
use std::cell::RefCell;

// ============================================================================
// VARIABLES AND BASIC TYPES
// ============================================================================

fn demonstrate_variables_and_types() {
    println!("-- Variables and Types --");
    
    // Immutable by default
    let message = "Hello, Rust!";
    let count = 42i32;
    let pi = 3.14159f64;
    let is_true = true;
    
    // Mutable variables need explicit mut keyword
    let mut mutable_count = 10;
    mutable_count += 5;
    
    println!("Message: {}", message);
    println!("Count: {}", count);
    println!("Mutable count: {}", mutable_count);
    
    // Type inference and explicit types
    let inferred = 42; // i32 by default
    let explicit: u64 = 42;
    
    // Constants (compile-time evaluated)
    const GRAVITY: f64 = 9.81;
    println!("Gravity: {}", GRAVITY);
    
    // Shadowing (redeclaring variables)
    let x = 5;
    let x = x + 1; // Shadows previous x
    let x = x * 2; // Shadows again
    println!("Shadowed x: {}", x);
    
    println!();
}

// ============================================================================
// OWNERSHIP AND BORROWING
// ============================================================================

fn demonstrate_ownership() {
    println!("-- Ownership and Borrowing --");
    
    // Ownership transfer (move)
    let s1 = String::from("hello");
    let s2 = s1; // s1 is moved to s2, s1 is no longer valid
    // println!("{}", s1); // This would cause a compile error
    println!("Moved string: {}", s2);
    
    // Cloning to avoid move
    let s3 = String::from("world");
    let s4 = s3.clone(); // Explicit clone
    println!("Original: {}, Clone: {}", s3, s4);
    
    // References and borrowing
    let s5 = String::from("borrow me");
    let len = calculate_length(&s5); // Borrow s5
    println!("Length of '{}' is {}", s5, len); // s5 still valid
    
    // Mutable references
    let mut s6 = String::from("hello");
    change_string(&mut s6);
    println!("Changed string: {}", s6);
    
    println!();
}

fn calculate_length(s: &String) -> usize {
    s.len()
} // s goes out of scope, but since it's a reference, nothing happens

fn change_string(s: &mut String) {
    s.push_str(", world!");
}

// ============================================================================
// DATA STRUCTURES
// ============================================================================

fn demonstrate_data_structures() {
    println!("-- Data Structures --");
    
    // Arrays (fixed size, stack allocated)
    let fruits: [&str; 3] = ["apple", "banana", "cherry"];
    println!("First fruit: {}", fruits[0]);
    println!("Array length: {}", fruits.len());
    
    // Vectors (dynamic arrays, heap allocated)
    let mut numbers = vec![1, 2, 3, 4, 5];
    numbers.push(6);
    println!("Numbers: {:?}", numbers);
    
    // Iterating over vectors
    for (index, number) in numbers.iter().enumerate() {
        println!("Index {}: {}", index, number);
    }
    
    // HashMap (key-value pairs)
    let mut fruit_colors = HashMap::new();
    fruit_colors.insert("apple", "red");
    fruit_colors.insert("banana", "yellow");
    fruit_colors.insert("cherry", "red");
    
    println!("Apple color: {:?}", fruit_colors.get("apple"));
    
    // Iterating over HashMap
    for (fruit, color) in &fruit_colors {
        println!("{} is {}", fruit, color);
    }
    
    println!();
}

// ============================================================================
// FUNCTIONS AND CLOSURES
// ============================================================================

fn demonstrate_functions() {
    println!("-- Functions and Closures --");
    
    // Basic function
    let greeting = greet("World");
    println!("{}", greeting);
    
    // Function with multiple return values (tuple)
    let (quotient, remainder) = divide_with_remainder(17, 5);
    println!("17 / 5 = {} remainder {}", quotient, remainder);
    
    // Closures (anonymous functions)
    let add_one = |x| x + 1;
    println!("5 + 1 = {}", add_one(5));
    
    // Closure capturing environment
    let multiplier = 3;
    let multiply_by_three = |x| x * multiplier;
    println!("4 * 3 = {}", multiply_by_three(4));
    
    // Higher-order functions
    let numbers = vec![1, 2, 3, 4, 5];
    let doubled: Vec<i32> = numbers.iter().map(|x| x * 2).collect();
    println!("Doubled: {:?}", doubled);
    
    let sum: i32 = numbers.iter().sum();
    println!("Sum: {}", sum);
    
    println!();
}

fn greet(name: &str) -> String {
    format!("Hello, {}!", name)
}

fn divide_with_remainder(a: i32, b: i32) -> (i32, i32) {
    (a / b, a % b)
}

// ============================================================================
// STRUCTS AND IMPLEMENTATIONS
// ============================================================================

#[derive(Debug, Clone)] // Derive common traits
struct Person {
    name: String,
    age: u32,
}

impl Person {
    // Associated function (like static method)
    fn new(name: String, age: u32) -> Person {
        Person { name, age }
    }
    
    // Method (takes &self)
    fn greet(&self) {
        println!("Hello, my name is {} and I'm {} years old", self.name, self.age);
    }
    
    // Mutable method (takes &mut self)
    fn have_birthday(&mut self) {
        self.age += 1;
        println!("{} is now {} years old!", self.name, self.age);
    }
}

fn demonstrate_structs() {
    println!("-- Structs and Implementations --");
    
    let mut person = Person::new("Alice".to_string(), 30);
    person.greet();
    person.have_birthday();
    
    // Struct update syntax
    let person2 = Person {
        name: "Bob".to_string(),
        ..person.clone() // Copy other fields from person
    };
    println!("Person2: {:?}", person2);
    
    println!();
}

// ============================================================================
// ENUMS AND PATTERN MATCHING
// ============================================================================

#[derive(Debug)]
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

impl Message {
    fn process(&self) {
        match self {
            Message::Quit => println!("Quit message received"),
            Message::Move { x, y } => println!("Move to ({}, {})", x, y),
            Message::Write(text) => println!("Write: {}", text),
            Message::ChangeColor(r, g, b) => println!("Change color to RGB({}, {}, {})", r, g, b),
        }
    }
}

fn demonstrate_enums() {
    println!("-- Enums and Pattern Matching --");
    
    let messages = vec![
        Message::Quit,
        Message::Move { x: 10, y: 20 },
        Message::Write("Hello".to_string()),
        Message::ChangeColor(255, 0, 0),
    ];
    
    for message in messages {
        message.process();
    }
    
    // Option enum (Rust's null safety)
    let some_number = Some(5);
    let no_number: Option<i32> = None;
    
    match some_number {
        Some(value) => println!("Got a value: {}", value),
        None => println!("No value"),
    }
    
    // Using if let for simpler pattern matching
    if let Some(value) = some_number {
        println!("Value using if let: {}", value);
    }
    
    println!();
}

// ============================================================================
// RESULT TYPE AND ERROR HANDLING
// ============================================================================

#[derive(Debug)]
enum MathError {
    DivisionByZero,
    NegativeSquareRoot,
}

impl fmt::Display for MathError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            MathError::DivisionByZero => write!(f, "Cannot divide by zero"),
            MathError::NegativeSquareRoot => write!(f, "Cannot take square root of negative number"),
        }
    }
}

impl Error for MathError {}

fn safe_divide(a: f64, b: f64) -> Result<f64, MathError> {
    if b == 0.0 {
        Err(MathError::DivisionByZero)
    } else {
        Ok(a / b)
    }
}

fn safe_sqrt(x: f64) -> Result<f64, MathError> {
    if x < 0.0 {
        Err(MathError::NegativeSquareRoot)
    } else {
        Ok(x.sqrt())
    }
}

fn demonstrate_error_handling() {
    println!("-- Error Handling with Result --");

    // Handling Results with match
    match safe_divide(10.0, 2.0) {
        Ok(result) => println!("10.0 / 2.0 = {}", result),
        Err(e) => println!("Error: {}", e),
    }

    match safe_divide(10.0, 0.0) {
        Ok(result) => println!("10.0 / 0.0 = {}", result),
        Err(e) => println!("Error: {}", e),
    }

    // Using unwrap_or for default values
    let result = safe_divide(10.0, 0.0).unwrap_or(0.0);
    println!("Division with default: {}", result);

    // Using ? operator for error propagation
    fn calculate_hypotenuse(a: f64, b: f64) -> Result<f64, MathError> {
        let a_squared = a * a;
        let b_squared = b * b;
        safe_sqrt(a_squared + b_squared)
    }

    match calculate_hypotenuse(3.0, 4.0) {
        Ok(result) => println!("Hypotenuse: {}", result),
        Err(e) => println!("Error calculating hypotenuse: {}", e),
    }

    println!();
}

// ============================================================================
// TRAITS (INTERFACES)
// ============================================================================

trait Animal {
    fn name(&self) -> &str;
    fn speak(&self) -> String;

    // Default implementation
    fn introduce(&self) {
        println!("{} says: {}", self.name(), self.speak());
    }
}

struct Dog {
    name: String,
}

struct Cat {
    name: String,
}

impl Animal for Dog {
    fn name(&self) -> &str {
        &self.name
    }

    fn speak(&self) -> String {
        "Woof!".to_string()
    }
}

impl Animal for Cat {
    fn name(&self) -> &str {
        &self.name
    }

    fn speak(&self) -> String {
        "Meow!".to_string()
    }

    // Override default implementation
    fn introduce(&self) {
        println!("{} purrs and says: {}", self.name(), self.speak());
    }
}

fn demonstrate_traits() {
    println!("-- Traits (Interfaces) --");

    let dog = Dog { name: "Buddy".to_string() };
    let cat = Cat { name: "Whiskers".to_string() };

    dog.introduce();
    cat.introduce();

    // Trait objects for polymorphism
    let animals: Vec<Box<dyn Animal>> = vec![
        Box::new(Dog { name: "Rex".to_string() }),
        Box::new(Cat { name: "Mittens".to_string() }),
    ];

    for animal in animals {
        animal.introduce();
    }

    println!();
}

// ============================================================================
// GENERICS
// ============================================================================

// Generic function
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
    let mut largest = list[0];
    for &item in list {
        if item > largest {
            largest = item;
        }
    }
    largest
}

// Generic struct
#[derive(Debug)]
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn new(x: T, y: T) -> Point<T> {
        Point { x, y }
    }
}

impl<T: std::ops::Add<Output = T> + Copy> Point<T> {
    fn add(&self, other: &Point<T>) -> Point<T> {
        Point {
            x: self.x + other.x,
            y: self.y + other.y,
        }
    }
}

fn demonstrate_generics() {
    println!("-- Generics --");

    // Generic function usage
    let numbers = vec![34, 50, 25, 100, 65];
    let largest_num = largest(&numbers);
    println!("Largest number: {}", largest_num);

    let chars = vec!['y', 'm', 'a', 'q'];
    let largest_char = largest(&chars);
    println!("Largest char: {}", largest_char);

    // Generic struct usage
    let int_point = Point::new(5, 10);
    let float_point = Point::new(1.0, 4.0);
    println!("Int point: {:?}", int_point);
    println!("Float point: {:?}", float_point);

    let point1 = Point::new(1, 2);
    let point2 = Point::new(3, 4);
    let sum = point1.add(&point2);
    println!("Point sum: {:?}", sum);

    println!();
}

// ============================================================================
// LIFETIMES
// ============================================================================

// Function with lifetime annotations
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Struct with lifetime
#[derive(Debug)]
struct ImportantExcerpt<'a> {
    part: &'a str,
}

impl<'a> ImportantExcerpt<'a> {
    fn level(&self) -> i32 {
        3
    }

    fn announce_and_return_part(&self, announcement: &str) -> &str {
        println!("Attention please: {}", announcement);
        self.part
    }
}

fn demonstrate_lifetimes() {
    println!("-- Lifetimes --");

    let string1 = String::from("abcd");
    let string2 = "xyz";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);

    // Struct with lifetime
    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.').next().expect("Could not find a '.'");
    let excerpt = ImportantExcerpt { part: first_sentence };
    println!("Excerpt: {:?}", excerpt);
    println!("Level: {}", excerpt.level());

    println!();
}

// ============================================================================
// CONTROL STRUCTURES
// ============================================================================

fn demonstrate_control_structures() {
    println!("-- Control Structures --");

    // If-else expressions
    let number = 10;
    let result = if number > 5 {
        "greater than 5"
    } else {
        "less than or equal to 5"
    };
    println!("Number is {}", result);

    // Match expressions (like switch but more powerful)
    let value = 3;
    match value {
        1 => println!("One"),
        2 | 3 => println!("Two or Three"),
        4..=10 => println!("Four through Ten"),
        _ => println!("Something else"),
    }

    // Loop with break and continue
    let mut counter = 0;
    let result = loop {
        counter += 1;
        if counter == 5 {
            continue;
        }
        if counter == 10 {
            break counter * 2;
        }
    };
    println!("Loop result: {}", result);

    // While loop
    let mut number = 3;
    while number != 0 {
        println!("{}!", number);
        number -= 1;
    }
    println!("LIFTOFF!!!");

    // For loop with ranges
    for i in 1..=5 {
        println!("For loop: {}", i);
    }

    // For loop with iterators
    let collection = vec![1, 2, 3, 4, 5];
    for item in collection.iter() {
        println!("Item: {}", item);
    }

    println!();
}

// ============================================================================
// MACROS
// ============================================================================

// Simple macro
macro_rules! say_hello {
    () => {
        println!("Hello from macro!");
    };
}

// Macro with parameters
macro_rules! create_function {
    ($func_name:ident) => {
        fn $func_name() {
            println!("You called {:?}()", stringify!($func_name));
        }
    };
}

// Variadic macro
macro_rules! find_min {
    ($x:expr) => ($x);
    ($x:expr, $($y:expr),+) => (
        std::cmp::min($x, find_min!($($y),+))
    );
}

create_function!(foo);
create_function!(bar);

fn demonstrate_macros() {
    println!("-- Macros --");

    say_hello!();

    foo();
    bar();

    let min = find_min!(1, 2, 3, 4, 5);
    println!("Minimum: {}", min);

    // Built-in macros
    println!("File: {}, Line: {}", file!(), line!());

    println!();
}

// ============================================================================
// MODULES AND VISIBILITY
// ============================================================================

mod math_utils {
    pub fn add(a: i32, b: i32) -> i32 {
        a + b
    }

    pub fn multiply(a: i32, b: i32) -> i32 {
        a * b
    }

    // Private function (not accessible outside module)
    fn private_function() {
        println!("This is private");
    }

    pub mod advanced {
        pub fn power(base: i32, exp: u32) -> i32 {
            base.pow(exp)
        }
    }
}

fn demonstrate_modules() {
    println!("-- Modules and Visibility --");

    let sum = math_utils::add(5, 3);
    let product = math_utils::multiply(4, 7);
    let power = math_utils::advanced::power(2, 3);

    println!("5 + 3 = {}", sum);
    println!("4 * 7 = {}", product);
    println!("2^3 = {}", power);

    // math_utils::private_function(); // This would cause a compile error

    println!();
}

// ============================================================================
// CONCURRENCY AND THREADING
// ============================================================================

fn demonstrate_concurrency() {
    println!("-- Concurrency and Threading --");

    // Basic threading
    let handle = thread::spawn(|| {
        for i in 1..10 {
            println!("Thread: {}", i);
            thread::sleep(std::time::Duration::from_millis(1));
        }
    });

    for i in 1..5 {
        println!("Main: {}", i);
        thread::sleep(std::time::Duration::from_millis(1));
    }

    handle.join().unwrap();

    // Shared state with Arc and Mutex
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];

    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            let mut num = counter.lock().unwrap();
            *num += 1;
        });
        handles.push(handle);
    }

    for handle in handles {
        handle.join().unwrap();
    }

    println!("Counter result: {}", *counter.lock().unwrap());

    println!();
}

// ============================================================================
// STRING MANIPULATION
// ============================================================================

fn demonstrate_strings() {
    println!("-- String Manipulation --");

    // String literals and String type
    let string_literal = "Hello"; // &str
    let mut owned_string = String::from("Hello"); // String

    // String operations
    owned_string.push_str(", World!");
    owned_string.push('!');
    println!("Owned string: {}", owned_string);

    // String slicing
    let slice = &owned_string[0..5];
    println!("Slice: {}", slice);

    // String methods
    println!("Length: {}", owned_string.len());
    println!("Is empty: {}", owned_string.is_empty());
    println!("Contains 'World': {}", owned_string.contains("World"));

    // String formatting
    let formatted = format!("Number: {}, Float: {:.2}", 42, 3.14159);
    println!("Formatted: {}", formatted);

    // String splitting and collecting
    let words: Vec<&str> = owned_string.split_whitespace().collect();
    println!("Words: {:?}", words);

    // String replacement
    let replaced = owned_string.replace("World", "Rust");
    println!("Replaced: {}", replaced);

    println!();
}

// ============================================================================
// ITERATORS AND FUNCTIONAL PROGRAMMING
// ============================================================================

fn demonstrate_iterators() {
    println!("-- Iterators and Functional Programming --");

    let numbers = vec![1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    // Filter, map, and collect
    let even_squares: Vec<i32> = numbers
        .iter()
        .filter(|&x| x % 2 == 0)
        .map(|x| x * x)
        .collect();
    println!("Even squares: {:?}", even_squares);

    // Reduce operations
    let sum: i32 = numbers.iter().sum();
    let product: i32 = numbers.iter().product();
    println!("Sum: {}, Product: {}", sum, product);

    // Find and any/all
    let found = numbers.iter().find(|&&x| x > 5);
    println!("First number > 5: {:?}", found);

    let all_positive = numbers.iter().all(|&x| x > 0);
    let any_negative = numbers.iter().any(|&x| x < 0);
    println!("All positive: {}, Any negative: {}", all_positive, any_negative);

    // Enumerate and zip
    for (index, value) in numbers.iter().enumerate() {
        if index < 3 {
            println!("Index {}: {}", index, value);
        }
    }

    let letters = vec!['a', 'b', 'c'];
    let zipped: Vec<(i32, char)> = numbers.iter().take(3).cloned().zip(letters).collect();
    println!("Zipped: {:?}", zipped);

    println!();
}

// ============================================================================
// SMART POINTERS
// ============================================================================

fn demonstrate_smart_pointers() {
    println!("-- Smart Pointers --");

    // Box<T> - heap allocation
    let boxed_value = Box::new(5);
    println!("Boxed value: {}", boxed_value);

    // Rc<T> - reference counting for shared ownership
    let shared_value = Rc::new(String::from("shared"));
    let shared_clone1 = Rc::clone(&shared_value);
    let shared_clone2 = Rc::clone(&shared_value);

    println!("Shared value: {}", shared_value);
    println!("Reference count: {}", Rc::strong_count(&shared_value));

    // RefCell<T> - interior mutability
    let mutable_in_immutable = RefCell::new(5);
    *mutable_in_immutable.borrow_mut() += 10;
    println!("RefCell value: {}", mutable_in_immutable.borrow());

    // Combining Rc and RefCell
    let shared_mutable = Rc::new(RefCell::new(vec![1, 2, 3]));
    let clone1 = Rc::clone(&shared_mutable);
    let clone2 = Rc::clone(&shared_mutable);

    clone1.borrow_mut().push(4);
    clone2.borrow_mut().push(5);

    println!("Shared mutable vector: {:?}", shared_mutable.borrow());

    println!();
}

// ============================================================================
// MAIN FUNCTION - DEMONSTRATION RUNNER
// ============================================================================

fn main() {
    println!("=== Rust Language Demonstration ===\n");

    // ========================================================================
    // BASIC FEATURES
    // ========================================================================

    demonstrate_variables_and_types();
    demonstrate_ownership();
    demonstrate_data_structures();
    demonstrate_functions();
    demonstrate_structs();
    demonstrate_enums();

    // ========================================================================
    // INTERMEDIATE FEATURES
    // ========================================================================

    demonstrate_error_handling();
    demonstrate_traits();
    demonstrate_generics();
    demonstrate_lifetimes();
    demonstrate_control_structures();

    // ========================================================================
    // ADVANCED FEATURES
    // ========================================================================

    demonstrate_macros();
    demonstrate_modules();
    demonstrate_concurrency();
    demonstrate_strings();
    demonstrate_iterators();
    demonstrate_smart_pointers();

    println!("=== End of Rust Demonstration ===");
}
