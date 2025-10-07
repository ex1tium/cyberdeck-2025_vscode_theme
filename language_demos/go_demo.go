// Go Demo
// This file demonstrates various Go language features and idioms
package main

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"strings"
	"sync"
	"time"
)

// ============================================================================
// VARIABLES AND BASIC TYPES
// ============================================================================

var message string = "Hello, Go!"
var count int = 42
var isTrue bool = true

// ============================================================================
// ARRAYS AND SLICES
// ============================================================================

// Arrays have fixed size
var fixedArray [3]string = [3]string{"apple", "banana", "cherry"}

// Slices are dynamic (more commonly used)
var fruits = []string{"apple", "banana", "cherry"}

// ============================================================================
// FUNCTIONS
// ============================================================================

func greet(name string) string {
	return "Hello, " + name + "!"
}

// Multiple return values
func divideWithRemainder(a, b int) (quotient int, remainder int) {
	quotient = a / b
	remainder = a % b
	return // Named returns can use naked return
}

// ============================================================================
// STRUCTS AND METHODS
// ============================================================================

type Person struct {
	Name string
	Age  int
}

var person = Person{
	Name: "John",
	Age:  30,
}

type Animal struct {
	Name string
}

// Value receiver - receives a copy
func (a Animal) Speak() {
	fmt.Printf("%s makes a sound.\n", a.Name)
}

// Pointer receiver - can modify the original
func (a *Animal) Rename(newName string) {
	a.Name = newName
}

var cat = Animal{"Cat"}

// String formatting
var templateString = fmt.Sprintf("The count is %d, and the message is: %s", count, message)

// ============================================================================
// LOOPS AND ITERATION
// ============================================================================

func printFruits() {
	for _, fruit := range fruits {
		fmt.Println(fruit)
	}
}

// ============================================================================
// BASIC FUNCTIONS
// ============================================================================

func add(a, b int) int {
	return a + b
}

// ============================================================================
// INTERFACES AND TYPE ASSERTIONS
// ============================================================================

type Identity interface {
	identity() string
}

type StringIdentity string

func (s StringIdentity) identity() string {
	return string(s)
}

// Type Assertion with interface{}
func typeAssertion(value interface{}) int {
	if val, ok := value.(int); ok {
		return val
	}
	return 0
}

// ============================================================================
// BASIC GOROUTINES
// ============================================================================

func printNumbers() {
	for i := 1; i <= 5; i++ {
		fmt.Printf("%d ", i)
	}
}

func printLetters() {
	for letter := 'a'; letter <= 'e'; letter++ {
		fmt.Printf("%c ", letter)
	}
}

// ============================================================================
// ERROR HANDLING
// ============================================================================

func divide(a, b int) (int, error) {
	if b == 0 {
		return 0, fmt.Errorf("cannot divide by zero")
	}
	return a / b, nil
}

// ============================================================================
// POINTERS
// ============================================================================

func increment(x *int) {
	*x++
}

// ============================================================================
// MAPS
// ============================================================================

var fruitColors = map[string]string{
	"apple":  "green",
	"banana": "yellow",
	"cherry": "red",
}

// ============================================================================
// SWITCH STATEMENTS
// ============================================================================

func evaluateNumber(num int) string {
	switch {
	case num < 0:
		return "negative"
	case num > 0:
		return "positive"
	default:
		return "zero"
	}
}

// ============================================================================
// DEFER, PANIC, AND RECOVER
// ============================================================================

func safeDivide(a, b int) (result int) {
	defer func() {
		if err := recover(); err != nil {
			fmt.Println("Recovered from panic:", err)
			result = 0
		}
	}()

	if b == 0 {
		panic("cannot divide by zero")
	}
	return a / b
}

// ============================================================================
// NEW ADVANCED FEATURES
// ============================================================================

// Constants with iota (enumeration patterns)
const (
	Sunday = iota // 0
	Monday        // 1
	Tuesday       // 2
	Wednesday     // 3
	Thursday      // 4
	Friday        // 5
	Saturday      // 6
)

// iota with bit shifting for flags
const (
	Read = 1 << iota // 1 << 0 = 1
	Write            // 1 << 1 = 2
	Execute          // 1 << 2 = 4
)

// Custom error type
type ValidationError struct {
	Field   string
	Message string
}

func (e *ValidationError) Error() string {
	return fmt.Sprintf("validation error on field '%s': %s", e.Field, e.Message)
}

func validateAge(age int) error {
	if age < 0 {
		return &ValidationError{Field: "age", Message: "cannot be negative"}
	}
	if age > 150 {
		return &ValidationError{Field: "age", Message: "unrealistic value"}
	}
	return nil
}

// Variadic functions
func sum(numbers ...int) int {
	total := 0
	for _, num := range numbers {
		total += num
	}
	return total
}

func printAll(prefix string, values ...interface{}) {
	fmt.Print(prefix)
	for _, v := range values {
		fmt.Printf(" %v", v)
	}
	fmt.Println()
}

// Closures - functions that capture variables
func makeCounter() func() int {
	count := 0
	return func() int {
		count++
		return count
	}
}

func makeMultiplier(factor int) func(int) int {
	return func(x int) int {
		return x * factor
	}
}

// Type switches
func describeType(i interface{}) string {
	switch v := i.(type) {
	case int:
		return fmt.Sprintf("Integer: %d", v)
	case string:
		return fmt.Sprintf("String: %s", v)
	case bool:
		return fmt.Sprintf("Boolean: %t", v)
	case []int:
		return fmt.Sprintf("Integer slice with %d elements", len(v))
	default:
		return fmt.Sprintf("Unknown type: %T", v)
	}
}

// Struct embedding (composition)
type Engine struct {
	Horsepower int
	Type       string
}

func (e Engine) Start() {
	fmt.Printf("Starting %s engine with %d HP\n", e.Type, e.Horsepower)
}

type Car struct {
	Engine // Embedded struct - methods are promoted
	Brand  string
	Model  string
}

// Struct tags (for JSON, validation, etc.)
type User struct {
	ID       int    `json:"id"`
	Username string `json:"username"`
	Email    string `json:"email,omitempty"`
	Password string `json:"-"` // Never serialize
}

// JSON encoding/decoding
func demonstrateJSON() {
	user := User{
		ID:       1,
		Username: "johndoe",
		Email:    "john@example.com",
		Password: "secret123",
	}

	// Marshal to JSON
	jsonData, err := json.Marshal(user)
	if err != nil {
		fmt.Println("Error marshaling:", err)
		return
	}
	fmt.Println("JSON:", string(jsonData))

	// Unmarshal from JSON
	var decoded User
	err = json.Unmarshal(jsonData, &decoded)
	if err != nil {
		fmt.Println("Error unmarshaling:", err)
		return
	}
	fmt.Printf("Decoded: %+v\n", decoded)
}

// Channels - unbuffered
func demonstrateChannels() {
	ch := make(chan string)

	go func() {
		ch <- "Hello from goroutine!"
	}()

	msg := <-ch
	fmt.Println("Received:", msg)
}

// Buffered channels
func demonstrateBufferedChannels() {
	ch := make(chan int, 3) // Buffer size 3

	ch <- 1
	ch <- 2
	ch <- 3

	fmt.Println("Buffered channel:", <-ch, <-ch, <-ch)
}

// Channel closing and range
func demonstrateChannelRange() {
	ch := make(chan int, 5)

	go func() {
		for i := 1; i <= 5; i++ {
			ch <- i
		}
		close(ch) // Close when done sending
	}()

	for num := range ch {
		fmt.Printf("%d ", num)
	}
	fmt.Println()
}

// ============================================================================
// DEMONSTRATION FUNCTIONS FOR ADVANCED FEATURES
// ============================================================================

// Select statement - channel multiplexing
func demonstrateSelect() {
	ch1 := make(chan string)
	ch2 := make(chan string)

	go func() {
		time.Sleep(100 * time.Millisecond)
		ch1 <- "from channel 1"
	}()

	go func() {
		time.Sleep(50 * time.Millisecond)
		ch2 <- "from channel 2"
	}()

	// Select waits on multiple channels
	for i := 0; i < 2; i++ {
		select {
		case msg1 := <-ch1:
			fmt.Println("Received:", msg1)
		case msg2 := <-ch2:
			fmt.Println("Received:", msg2)
		case <-time.After(200 * time.Millisecond):
			fmt.Println("Timeout!")
		}
	}

	// Select with default (non-blocking)
	select {
	case msg := <-ch1:
		fmt.Println("Got:", msg)
	default:
		fmt.Println("No message available")
	}
}

// WaitGroups for goroutine synchronization
func demonstrateWaitGroup() {
	var wg sync.WaitGroup

	for i := 1; i <= 3; i++ {
		wg.Add(1) // Increment counter
		go func(id int) {
			defer wg.Done() // Decrement counter when done
			fmt.Printf("Worker %d starting\n", id)
			time.Sleep(time.Duration(id*50) * time.Millisecond)
			fmt.Printf("Worker %d done\n", id)
		}(i)
	}

	wg.Wait() // Wait for all goroutines to finish
	fmt.Println("All workers completed")
}

// Generics (Go 1.18+)
func demonstrateGenerics() {
	// Generic function
	intSlice := []int{1, 2, 3, 4, 5}
	fmt.Println("Sum of ints:", sumGeneric(intSlice))

	floatSlice := []float64{1.1, 2.2, 3.3}
	fmt.Println("Sum of floats:", sumGeneric(floatSlice))

	// Generic type
	intStack := &Stack[int]{}
	intStack.Push(10)
	intStack.Push(20)
	intStack.Push(30)
	fmt.Println("Stack pop:", intStack.Pop())
	fmt.Println("Stack pop:", intStack.Pop())

	stringStack := &Stack[string]{}
	stringStack.Push("hello")
	stringStack.Push("world")
	fmt.Println("Stack pop:", stringStack.Pop())
}

// Generic function with type constraint
func sumGeneric[T int | float64](numbers []T) T {
	var total T
	for _, num := range numbers {
		total += num
	}
	return total
}

// Generic stack type
type Stack[T any] struct {
	items []T
}

func (s *Stack[T]) Push(item T) {
	s.items = append(s.items, item)
}

func (s *Stack[T]) Pop() T {
	if len(s.items) == 0 {
		var zero T
		return zero
	}
	item := s.items[len(s.items)-1]
	s.items = s.items[:len(s.items)-1]
	return item
}

// Mutex for thread-safe operations
func demonstrateMutex() {
	counter := &SafeCounter{count: 0}
	var wg sync.WaitGroup

	// Start 10 goroutines that increment the counter
	for i := 0; i < 10; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for j := 0; j < 100; j++ {
				counter.Increment()
			}
		}()
	}

	wg.Wait()
	fmt.Println("Final counter value:", counter.Value())
}

type SafeCounter struct {
	mu    sync.Mutex
	count int
}

func (c *SafeCounter) Increment() {
	c.mu.Lock()
	defer c.mu.Unlock()
	c.count++
}

func (c *SafeCounter) Value() int {
	c.mu.Lock()
	defer c.mu.Unlock()
	return c.count
}

// Context for cancellation and timeouts
func demonstrateContext() {
	// Context with timeout
	ctx, cancel := context.WithTimeout(context.Background(), 100*time.Millisecond)
	defer cancel()

	select {
	case <-time.After(200 * time.Millisecond):
		fmt.Println("Operation completed")
	case <-ctx.Done():
		fmt.Println("Context timeout:", ctx.Err())
	}

	// Context with cancellation
	ctx2, cancel2 := context.WithCancel(context.Background())

	go func() {
		time.Sleep(50 * time.Millisecond)
		cancel2() // Cancel the context
	}()

	select {
	case <-time.After(200 * time.Millisecond):
		fmt.Println("Operation completed")
	case <-ctx2.Done():
		fmt.Println("Context cancelled:", ctx2.Err())
	}
}

// String manipulation
func demonstrateStrings() {
	str := "Hello, Go!"

	fmt.Println("Original:", str)
	fmt.Println("Length:", len(str))
	fmt.Println("Uppercase:", strings.ToUpper(str))
	fmt.Println("Lowercase:", strings.ToLower(str))
	fmt.Println("Contains 'Go':", strings.Contains(str, "Go"))
	fmt.Println("Index of 'Go':", strings.Index(str, "Go"))
	fmt.Println("Replace:", strings.Replace(str, "Go", "World", 1))

	// String splitting and joining
	words := strings.Split("apple,banana,cherry", ",")
	fmt.Println("Split:", words)
	joined := strings.Join(words, " - ")
	fmt.Println("Joined:", joined)

	// String trimming
	padded := "   spaces   "
	fmt.Println("Trimmed:", strings.TrimSpace(padded))

	// String prefix/suffix
	fmt.Println("Has prefix 'Hello':", strings.HasPrefix(str, "Hello"))
	fmt.Println("Has suffix '!':", strings.HasSuffix(str, "!"))
}

// Slice operations
func demonstrateSlices() {
	// Creating slices
	slice1 := []int{1, 2, 3}
	fmt.Println("Original slice:", slice1)

	// Append
	slice1 = append(slice1, 4, 5, 6)
	fmt.Println("After append:", slice1)

	// Slicing
	slice2 := slice1[1:4] // Elements at index 1, 2, 3
	fmt.Println("Slice [1:4]:", slice2)

	slice3 := slice1[:3] // First 3 elements
	fmt.Println("Slice [:3]:", slice3)

	slice4 := slice1[3:] // From index 3 to end
	fmt.Println("Slice [3:]:", slice4)

	// Copy
	slice5 := make([]int, len(slice1))
	copy(slice5, slice1)
	fmt.Println("Copied slice:", slice5)

	// Capacity and length
	fmt.Printf("Length: %d, Capacity: %d\n", len(slice1), cap(slice1))

	// Make with capacity
	slice6 := make([]int, 3, 10) // length 3, capacity 10
	fmt.Printf("Made slice - Length: %d, Capacity: %d\n", len(slice6), cap(slice6))

	// Append another slice
	slice7 := []int{7, 8, 9}
	slice1 = append(slice1, slice7...) // ... unpacks the slice
	fmt.Println("After appending slice:", slice1)
}

// Array vs Slice distinction
func demonstrateArrayVsSlice() {
	// Arrays - fixed size, value type
	var arr1 [3]int = [3]int{1, 2, 3}
	arr2 := arr1 // This copies the array
	arr2[0] = 100
	fmt.Println("Array 1:", arr1) // [1 2 3] - unchanged
	fmt.Println("Array 2:", arr2) // [100 2 3] - modified

	// Slices - dynamic size, reference type
	slice1 := []int{1, 2, 3}
	slice2 := slice1 // This shares the underlying array
	slice2[0] = 100
	fmt.Println("Slice 1:", slice1) // [100 2 3] - changed!
	fmt.Println("Slice 2:", slice2) // [100 2 3] - changed!

	// Array size is part of the type
	// var arr3 [4]int = arr1 // Error: cannot use arr1 (type [3]int) as type [4]int

	// Slices can grow
	slice3 := []int{1, 2, 3}
	slice3 = append(slice3, 4, 5, 6)
	fmt.Println("Grown slice:", slice3)

	// Arrays cannot grow (fixed size)
	fmt.Printf("Array type: %T, Slice type: %T\n", arr1, slice1)
}

func main() {
	fmt.Println("=== Go Language Demonstration ===\n")

	// ========================================================================
	// BASIC FEATURES
	// ========================================================================

	fmt.Println("-- Basic Features --")

	// Conditional Statements
	if isTrue {
		fmt.Println("It's true!")
	} else {
		fmt.Println("It's false!")
	}

	// Call identity function
	result := StringIdentity("Hello, Interfaces!").identity()
	fmt.Println(result)

	// Start goroutines
	go printNumbers()
	go printLetters()

	// Sleep to allow goroutines to finish
	time.Sleep(time.Second)
	fmt.Println()

	// Error Handling
	_, err := divide(10, 0)
	if err != nil {
		fmt.Println(err)
	}

	// Pointers
	num := 10
	increment(&num)
	fmt.Println("After increment:", num) // Should print 11

	const test = "test"
	fmt.Println("Constant:", test)

	// Maps
	fmt.Println("Fruit colors:", fruitColors)

	// Switch Statement
	fmt.Println("Evaluate 10:", evaluateNumber(10)) // Should print "positive"

	// Defer, Panic, and Recover
	fmt.Println("Safe divide result:", safeDivide(10, 0))

	// Multiple return values
	q, r := divideWithRemainder(17, 5)
	fmt.Printf("17 / 5 = %d remainder %d\n", q, r)

	fmt.Println()

	// ========================================================================
	// CONSTANTS AND IOTA
	// ========================================================================

	fmt.Println("-- Constants and iota --")
	fmt.Println("Monday:", Monday)
	fmt.Println("Friday:", Friday)
	fmt.Println("Read permission:", Read)
	fmt.Println("Write permission:", Write)
	fmt.Println("Execute permission:", Execute)
	fmt.Println()

	// ========================================================================
	// CUSTOM ERROR TYPES
	// ========================================================================

	fmt.Println("-- Custom Error Types --")
	if err := validateAge(-5); err != nil {
		fmt.Println("Validation error:", err)
		// Type assertion to access custom fields
		if ve, ok := err.(*ValidationError); ok {
			fmt.Printf("Field: %s, Message: %s\n", ve.Field, ve.Message)
		}
	}
	fmt.Println()

	// ========================================================================
	// VARIADIC FUNCTIONS
	// ========================================================================

	fmt.Println("-- Variadic Functions --")
	fmt.Println("Sum of 1,2,3,4,5:", sum(1, 2, 3, 4, 5))
	fmt.Println("Sum of 10,20:", sum(10, 20))
	printAll("Values:", 1, "hello", true, 3.14)
	fmt.Println()

	// ========================================================================
	// CLOSURES
	// ========================================================================

	fmt.Println("-- Closures --")
	counter1 := makeCounter()
	counter2 := makeCounter()
	fmt.Println("Counter1:", counter1(), counter1(), counter1()) // 1, 2, 3
	fmt.Println("Counter2:", counter2(), counter2())             // 1, 2

	double := makeMultiplier(2)
	triple := makeMultiplier(3)
	fmt.Println("Double 5:", double(5)) // 10
	fmt.Println("Triple 5:", triple(5)) // 15
	fmt.Println()

	// ========================================================================
	// TYPE SWITCHES
	// ========================================================================

	fmt.Println("-- Type Switches --")
	fmt.Println(describeType(42))
	fmt.Println(describeType("hello"))
	fmt.Println(describeType(true))
	fmt.Println(describeType([]int{1, 2, 3}))
	fmt.Println()

	// ========================================================================
	// STRUCT EMBEDDING
	// ========================================================================

	fmt.Println("-- Struct Embedding --")
	myCar := Car{
		Engine: Engine{Horsepower: 300, Type: "V8"},
		Brand:  "Ford",
		Model:  "Mustang",
	}
	myCar.Start() // Method promoted from embedded Engine
	fmt.Printf("Car: %s %s\n", myCar.Brand, myCar.Model)
	fmt.Println()

	// ========================================================================
	// JSON ENCODING/DECODING
	// ========================================================================

	fmt.Println("-- JSON Encoding/Decoding --")
	demonstrateJSON()
	fmt.Println()

	// ========================================================================
	// CHANNELS
	// ========================================================================

	fmt.Println("-- Channels --")
	demonstrateChannels()
	demonstrateBufferedChannels()
	fmt.Print("Channel range: ")
	demonstrateChannelRange()
	fmt.Println()

	// ========================================================================
	// SELECT STATEMENT
	// ========================================================================

	fmt.Println("-- Select Statement --")
	demonstrateSelect()
	fmt.Println()

	// ========================================================================
	// WAITGROUPS
	// ========================================================================

	fmt.Println("-- WaitGroups --")
	demonstrateWaitGroup()
	fmt.Println()

	// ========================================================================
	// GENERICS (Go 1.18+)
	// ========================================================================

	fmt.Println("-- Generics --")
	demonstrateGenerics()
	fmt.Println()

	// ========================================================================
	// MUTEX AND SYNCHRONIZATION
	// ========================================================================

	fmt.Println("-- Mutex and Synchronization --")
	demonstrateMutex()
	fmt.Println()

	// ========================================================================
	// CONTEXT
	// ========================================================================

	fmt.Println("-- Context --")
	demonstrateContext()
	fmt.Println()

	// ========================================================================
	// STRING MANIPULATION
	// ========================================================================

	fmt.Println("-- String Manipulation --")
	demonstrateStrings()
	fmt.Println()

	// ========================================================================
	// SLICE OPERATIONS
	// ========================================================================

	fmt.Println("-- Slice Operations --")
	demonstrateSlices()
	fmt.Println()

	// ========================================================================
	// ARRAY VS SLICE
	// ========================================================================

	fmt.Println("-- Array vs Slice --")
	demonstrateArrayVsSlice()
	fmt.Println()

	fmt.Println("=== End of Go Demonstration ===")
}