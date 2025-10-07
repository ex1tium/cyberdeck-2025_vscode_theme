// Zig Demo
// This file demonstrates various Zig language features and idioms

const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;
const ArrayList = std.ArrayList;
const HashMap = std.HashMap;
const Allocator = std.mem.Allocator;

// ============================================================================
// VARIABLES AND BASIC TYPES
// ============================================================================

fn demonstrateVariablesAndTypes() void {
    print("-- Variables and Types --\n");
    
    // Variables (mutable by default, const for compile-time constants)
    var message: []const u8 = "Hello, Zig!";
    var count: i32 = 42;
    const pi: f64 = 3.14159;
    var is_true: bool = true;
    
    // Type inference
    var inferred = @as(i32, 100); // Explicit type cast
    var auto_inferred: i32 = 200; // Type annotation
    
    // Unsigned and signed integers of various sizes
    var small_int: i8 = 127;
    var big_int: i64 = 9223372036854775807;
    var unsigned: u32 = 4294967295;
    
    // Floating point types
    var float32: f32 = 3.14;
    var float64: f64 = 2.718281828;
    
    print("Message: {s}\n", .{message});
    print("Count: {}\n", .{count});
    print("Pi: {d:.5}\n", .{pi});
    print("Is true: {}\n", .{is_true});
    print("Inferred: {}\n", .{inferred});
    
    // Compile-time constants
    const GRAVITY: f64 = 9.81;
    print("Gravity: {d}\n", .{GRAVITY});
    
    // Character and string literals
    const char: u8 = 'A';
    const unicode_char: u21 = '🦎'; // Zig's lizard emoji
    print("Character: {c}, Unicode: {u}\n", .{ char, unicode_char });
    
    // Arrays (compile-time known size)
    const fixed_array = [_]i32{ 1, 2, 3, 4, 5 };
    print("Array length: {}\n", .{fixed_array.len});
    
    print("\n");
}

// ============================================================================
// POINTERS AND OPTIONAL TYPES
// ============================================================================

fn demonstratePointersAndOptionals() void {
    print("-- Pointers and Optional Types --\n");
    
    // Single-item pointers
    var number: i32 = 42;
    var number_ptr: *i32 = &number;
    print("Value: {}, Pointer value: {}\n", .{ number, number_ptr.* });
    
    // Modifying through pointer
    number_ptr.* = 100;
    print("Modified value: {}\n", .{number});
    
    // Optional types (nullable)
    var maybe_number: ?i32 = 42;
    var null_number: ?i32 = null;
    
    // Unwrapping optionals
    if (maybe_number) |value| {
        print("Maybe number has value: {}\n", .{value});
    }
    
    if (null_number) |value| {
        print("Null number has value: {}\n", .{value});
    } else {
        print("Null number is null\n");
    }
    
    // Optional pointer
    var maybe_ptr: ?*i32 = &number;
    if (maybe_ptr) |ptr| {
        print("Optional pointer value: {}\n", .{ptr.*});
    }
    
    // Many-item pointers (slices)
    const array = [_]i32{ 1, 2, 3, 4, 5 };
    const slice: []const i32 = array[1..4]; // Elements 1, 2, 3
    print("Slice: ");
    for (slice) |item| {
        print("{} ", .{item});
    }
    print("\n");
    
    print("\n");
}

// ============================================================================
// FUNCTIONS AND CONTROL FLOW
// ============================================================================

fn greet(name: []const u8) []const u8 {
    // Note: In real code, you'd want to use an allocator for dynamic strings
    return "Hello, World!"; // Simplified for demo
}

fn add(a: i32, b: i32) i32 {
    return a + b;
}

fn multiply(a: i32, b: i32) i32 {
    return a * b;
}

// Function with multiple return values (tuple)
fn divideWithRemainder(a: i32, b: i32) struct { quotient: i32, remainder: i32 } {
    return .{ .quotient = @divTrunc(a, b), .remainder = @rem(a, b) };
}

fn demonstrateFunctions() void {
    print("-- Functions and Control Flow --\n");
    
    // Basic function calls
    const greeting = greet("World");
    print("{s}\n", .{greeting});
    
    const sum = add(5, 3);
    const product = multiply(4, 7);
    print("5 + 3 = {}, 4 * 7 = {}\n", .{ sum, product });
    
    // Multiple return values
    const result = divideWithRemainder(17, 5);
    print("17 / 5 = {} remainder {}\n", .{ result.quotient, result.remainder });
    
    // If-else expressions
    const number = 10;
    const description = if (number > 5) "greater than 5" else "less than or equal to 5";
    print("Number is {s}\n", .{description});
    
    // Switch expressions
    const day = 3;
    const day_name = switch (day) {
        1 => "Monday",
        2 => "Tuesday",
        3 => "Wednesday",
        4 => "Thursday",
        5 => "Friday",
        6, 7 => "Weekend",
        else => "Invalid day",
    };
    print("Day {}: {s}\n", .{ day, day_name });
    
    // For loops
    print("For loop: ");
    for (0..5) |i| {
        print("{} ", .{i});
    }
    print("\n");
    
    // While loops
    var counter: i32 = 0;
    print("While loop: ");
    while (counter < 5) {
        print("{} ", .{counter});
        counter += 1;
    }
    print("\n");
    
    // Loop with break and continue
    var i: i32 = 0;
    print("Loop with break: ");
    while (i < 10) : (i += 1) {
        if (i == 3) continue;
        if (i == 7) break;
        print("{} ", .{i});
    }
    print("\n");
    
    print("\n");
}

// ============================================================================
// STRUCTS AND METHODS
// ============================================================================

const Person = struct {
    name: []const u8,
    age: u32,
    
    // Method (function with implicit self parameter)
    fn greet(self: Person) void {
        print("Hello, my name is {s} and I'm {} years old\n", .{ self.name, self.age });
    }
    
    // Method that modifies the struct
    fn haveBirthday(self: *Person) void {
        self.age += 1;
        print("{s} is now {} years old!\n", .{ self.name, self.age });
    }
    
    // Associated function (no self parameter)
    fn create(name: []const u8, age: u32) Person {
        return Person{ .name = name, .age = age };
    }
};

fn demonstrateStructs() void {
    print("-- Structs and Methods --\n");
    
    // Creating structs
    var person = Person{ .name = "Alice", .age = 30 };
    person.greet();
    person.haveBirthday();
    
    // Using associated function
    const person2 = Person.create("Bob", 25);
    person2.greet();
    
    // Anonymous struct
    const point = .{ .x = 10, .y = 20 };
    print("Point: ({}, {})\n", .{ point.x, point.y });
    
    print("\n");
}

// ============================================================================
// ERROR HANDLING
// ============================================================================

// Error sets
const MathError = error{
    DivisionByZero,
    NegativeSquareRoot,
    Overflow,
};

const FileError = error{
    FileNotFound,
    PermissionDenied,
    OutOfMemory,
};

// Error union types
fn safeDivide(a: f64, b: f64) MathError!f64 {
    if (b == 0.0) {
        return MathError.DivisionByZero;
    }
    return a / b;
}

fn safeSquareRoot(x: f64) MathError!f64 {
    if (x < 0.0) {
        return MathError.NegativeSquareRoot;
    }
    return @sqrt(x);
}

// Function that can return multiple error types
fn complexOperation(a: f64, b: f64) (MathError || FileError)!f64 {
    const result = try safeDivide(a, b);
    if (result > 1000000) {
        return MathError.Overflow;
    }
    // Simulate file operation that might fail
    if (result < 0) {
        return FileError.FileNotFound;
    }
    return result;
}

fn demonstrateErrorHandling() void {
    print("-- Error Handling --\n");

    // Using try to propagate errors
    const result1 = safeDivide(10.0, 2.0) catch |err| {
        print("Error: {}\n", .{err});
        return;
    };
    print("10.0 / 2.0 = {d:.2}\n", .{result1});

    // Handling specific errors
    const result2 = safeDivide(10.0, 0.0) catch |err| switch (err) {
        MathError.DivisionByZero => {
            print("Cannot divide by zero!\n");
            0.0;
        },
        else => {
            print("Unexpected error: {}\n", .{err});
            0.0;
        },
    };
    print("Division with error handling: {d}\n", .{result2});

    // Using if to check for errors
    if (safeSquareRoot(16.0)) |value| {
        print("Square root of 16: {d:.2}\n", .{value});
    } else |err| {
        print("Error calculating square root: {}\n", .{err});
    }

    if (safeSquareRoot(-4.0)) |value| {
        print("Square root of -4: {d:.2}\n", .{value});
    } else |err| {
        print("Error calculating square root: {}\n", .{err});
    }

    // Error union with multiple error types
    if (complexOperation(100.0, 2.0)) |value| {
        print("Complex operation result: {d:.2}\n", .{value});
    } else |err| {
        print("Complex operation failed: {}\n", .{err});
    }

    print("\n");
}

// ============================================================================
// MEMORY MANAGEMENT AND ALLOCATORS
// ============================================================================

fn demonstrateMemoryManagement(allocator: Allocator) !void {
    print("-- Memory Management and Allocators --\n");

    // Dynamic allocation
    const numbers = try allocator.alloc(i32, 5);
    defer allocator.free(numbers); // Cleanup when function exits

    // Initialize allocated memory
    for (numbers, 0..) |*num, i| {
        num.* = @intCast(i * 2);
    }

    print("Allocated numbers: ");
    for (numbers) |num| {
        print("{} ", .{num});
    }
    print("\n");

    // ArrayList (dynamic array)
    var list = ArrayList(i32).init(allocator);
    defer list.deinit(); // Cleanup

    // Add elements
    try list.append(1);
    try list.append(2);
    try list.append(3);
    try list.appendSlice(&[_]i32{ 4, 5, 6 });

    print("ArrayList: ");
    for (list.items) |item| {
        print("{} ", .{item});
    }
    print("\n");

    // Remove elements
    _ = list.pop(); // Remove last element
    print("After pop: ");
    for (list.items) |item| {
        print("{} ", .{item});
    }
    print("\n");

    // Create and free individual items
    const single_number = try allocator.create(i32);
    defer allocator.destroy(single_number);
    single_number.* = 42;
    print("Single allocated number: {}\n", .{single_number.*});

    print("\n");
}

// ============================================================================
// DEFER AND ERRDEFER
// ============================================================================

fn demonstrateDefer(allocator: Allocator) !void {
    print("-- Defer and Errdefer --\n");

    print("Starting function\n");
    defer print("Function ending (defer)\n");

    // Multiple defers execute in reverse order (LIFO)
    defer print("Third defer\n");
    defer print("Second defer\n");
    defer print("First defer\n");

    // errdefer only executes if function returns an error
    const memory = try allocator.alloc(u8, 100);
    errdefer allocator.free(memory); // Only free if error occurs
    defer allocator.free(memory); // Always free on normal exit

    // Simulate some work
    for (memory, 0..) |*byte, i| {
        byte.* = @intCast(i % 256);
    }

    print("Memory allocated and initialized\n");

    // Conditional error to demonstrate errdefer
    const should_error = false;
    if (should_error) {
        return error.SimulatedError; // errdefer would execute here
    }

    print("Function completed successfully\n");

    print("\n");
}

// ============================================================================
// COMPTIME (COMPILE-TIME EXECUTION)
// ============================================================================

// Comptime function - executed at compile time
fn fibonacci(comptime n: u32) u32 {
    if (n <= 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// Generic function using comptime
fn genericMax(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

// Comptime type generation
fn Vector(comptime T: type, comptime size: u32) type {
    return struct {
        data: [size]T,

        const Self = @This();

        fn init() Self {
            return Self{ .data = [_]T{0} ** size };
        }

        fn set(self: *Self, index: u32, value: T) void {
            self.data[index] = value;
        }

        fn get(self: Self, index: u32) T {
            return self.data[index];
        }

        fn length(self: Self) u32 {
            _ = self;
            return size;
        }
    };
}

fn demonstrateComptime() void {
    print("-- Comptime (Compile-time Execution) --\n");

    // Comptime constants
    const fib_10 = comptime fibonacci(10); // Calculated at compile time
    print("Fibonacci(10) = {} (calculated at compile time)\n", .{fib_10});

    // Generic functions
    const max_int = genericMax(i32, 10, 20);
    const max_float = genericMax(f64, 3.14, 2.71);
    print("Max integers: {}, Max floats: {d:.2}\n", .{ max_int, max_float });

    // Comptime type generation
    const Vec3f = Vector(f32, 3);
    var vector = Vec3f.init();
    vector.set(0, 1.0);
    vector.set(1, 2.0);
    vector.set(2, 3.0);

    print("Vector length: {}\n", .{vector.length()});
    print("Vector elements: {d:.1} {d:.1} {d:.1}\n", .{ vector.get(0), vector.get(1), vector.get(2) });

    // Comptime string manipulation
    const message = "Hello, Zig!";
    const message_length = comptime message.len;
    print("Message length (comptime): {}\n", .{message_length});

    // Comptime loops and conditionals
    comptime var sum: u32 = 0;
    comptime {
        var i: u32 = 1;
        while (i <= 10) : (i += 1) {
            sum += i;
        }
    }
    print("Sum 1-10 (comptime): {}\n", .{sum});

    print("\n");
}

// ============================================================================
// UNIONS AND TAGGED UNIONS
// ============================================================================

// Regular union (untagged)
const Value = union {
    integer: i32,
    float: f64,
    boolean: bool,
};

// Tagged union (enum union)
const Shape = union(enum) {
    circle: struct { radius: f64 },
    rectangle: struct { width: f64, height: f64 },
    triangle: struct { base: f64, height: f64 },

    fn area(self: Shape) f64 {
        return switch (self) {
            .circle => |circle| std.math.pi * circle.radius * circle.radius,
            .rectangle => |rect| rect.width * rect.height,
            .triangle => |tri| 0.5 * tri.base * tri.height,
        };
    }
};

// Enum
const Color = enum {
    red,
    green,
    blue,

    fn toRgb(self: Color) struct { r: u8, g: u8, b: u8 } {
        return switch (self) {
            .red => .{ .r = 255, .g = 0, .b = 0 },
            .green => .{ .r = 0, .g = 255, .b = 0 },
            .blue => .{ .r = 0, .g = 0, .b = 255 },
        };
    }
};

fn demonstrateUnionsAndEnums() void {
    print("-- Unions and Tagged Unions --\n");

    // Tagged union usage
    const shapes = [_]Shape{
        Shape{ .circle = .{ .radius = 5.0 } },
        Shape{ .rectangle = .{ .width = 4.0, .height = 6.0 } },
        Shape{ .triangle = .{ .base = 3.0, .height = 4.0 } },
    };

    for (shapes) |shape| {
        const area_value = shape.area();
        switch (shape) {
            .circle => |circle| print("Circle (radius {d:.1}): area = {d:.2}\n", .{ circle.radius, area_value }),
            .rectangle => |rect| print("Rectangle ({d:.1}x{d:.1}): area = {d:.2}\n", .{ rect.width, rect.height, area_value }),
            .triangle => |tri| print("Triangle (base {d:.1}, height {d:.1}): area = {d:.2}\n", .{ tri.base, tri.height, area_value }),
        }
    }

    // Enum usage
    const colors = [_]Color{ .red, .green, .blue };
    for (colors) |color| {
        const rgb = color.toRgb();
        print("Color {s}: RGB({}, {}, {})\n", .{ @tagName(color), rgb.r, rgb.g, rgb.b });
    }

    // Regular union (must be used carefully)
    var value = Value{ .integer = 42 };
    print("Union integer value: {}\n", .{value.integer});

    // Change union type
    value = Value{ .float = 3.14 };
    print("Union float value: {d:.2}\n", .{value.float});

    print("\n");
}

// ============================================================================
// PACKED STRUCTS AND BIT MANIPULATION
// ============================================================================

// Packed struct for precise memory layout
const Flags = packed struct {
    read: bool,
    write: bool,
    execute: bool,
    _padding: u5 = 0, // Explicit padding
};

// Bit manipulation helpers
fn setBit(value: *u8, bit: u3) void {
    value.* |= (@as(u8, 1) << bit);
}

fn clearBit(value: *u8, bit: u3) void {
    value.* &= ~(@as(u8, 1) << bit);
}

fn testBit(value: u8, bit: u3) bool {
    return (value & (@as(u8, 1) << bit)) != 0;
}

fn demonstrateBitManipulation() void {
    print("-- Packed Structs and Bit Manipulation --\n");

    // Packed struct
    var flags = Flags{ .read = true, .write = false, .execute = true };
    print("Flags: read={}, write={}, execute={}\n", .{ flags.read, flags.write, flags.execute });
    print("Flags size: {} bytes\n", .{@sizeOf(Flags)});

    // Bit manipulation
    var bits: u8 = 0b00000000;
    print("Initial bits: 0b{b:0>8}\n", .{bits});

    setBit(&bits, 0);
    setBit(&bits, 2);
    setBit(&bits, 7);
    print("After setting bits 0, 2, 7: 0b{b:0>8}\n", .{bits});

    print("Bit 2 is set: {}\n", .{testBit(bits, 2)});
    print("Bit 3 is set: {}\n", .{testBit(bits, 3)});

    clearBit(&bits, 2);
    print("After clearing bit 2: 0b{b:0>8}\n", .{bits});

    // Bitwise operations
    const a: u8 = 0b11110000;
    const b: u8 = 0b10101010;
    print("a = 0b{b:0>8}, b = 0b{b:0>8}\n", .{ a, b });
    print("a & b = 0b{b:0>8}\n", .{a & b});
    print("a | b = 0b{b:0>8}\n", .{a | b});
    print("a ^ b = 0b{b:0>8}\n", .{a ^ b});
    print("~a = 0b{b:0>8}\n", .{~a});

    print("\n");
}

// ============================================================================
// ARRAYS AND SLICES
// ============================================================================

fn demonstrateArraysAndSlices() void {
    print("-- Arrays and Slices --\n");

    // Arrays (compile-time known size)
    const fixed_array = [_]i32{ 1, 2, 3, 4, 5 };
    print("Fixed array: ");
    for (fixed_array) |item| {
        print("{} ", .{item});
    }
    print("\n");

    // Array with explicit size
    var mutable_array: [5]i32 = [_]i32{ 10, 20, 30, 40, 50 };
    mutable_array[2] = 99;
    print("Modified array: ");
    for (mutable_array) |item| {
        print("{} ", .{item});
    }
    print("\n");

    // Slices (runtime-known size)
    const slice: []const i32 = fixed_array[1..4]; // Elements 1, 2, 3
    print("Slice [1..4]: ");
    for (slice) |item| {
        print("{} ", .{item});
    }
    print("\n");

    // Slice operations
    const full_slice: []const i32 = fixed_array[0..];
    print("Full slice: ");
    for (full_slice) |item| {
        print("{} ", .{item});
    }
    print("\n");

    // Multi-dimensional arrays
    const matrix = [_][3]i32{
        [_]i32{ 1, 2, 3 },
        [_]i32{ 4, 5, 6 },
        [_]i32{ 7, 8, 9 },
    };

    print("Matrix:\n");
    for (matrix) |row| {
        for (row) |cell| {
            print("{} ", .{cell});
        }
        print("\n");
    }

    // String literals are arrays
    const string_literal = "Hello, Zig!";
    print("String as array: ");
    for (string_literal) |char| {
        print("{c}", .{char});
    }
    print("\n");

    print("\n");
}

// ============================================================================
// TESTING FEATURES
// ============================================================================

// Test functions (run with `zig test`)
test "basic arithmetic" {
    try expect(add(2, 3) == 5);
    try expect(multiply(4, 5) == 20);
}

test "error handling" {
    const result = safeDivide(10.0, 2.0);
    try expect(result != MathError.DivisionByZero);

    const error_result = safeDivide(10.0, 0.0);
    try expect(error_result == MathError.DivisionByZero);
}

test "comptime fibonacci" {
    const fib_5 = comptime fibonacci(5);
    try expect(fib_5 == 5);

    const fib_7 = comptime fibonacci(7);
    try expect(fib_7 == 13);
}

test "shape areas" {
    const circle = Shape{ .circle = .{ .radius = 2.0 } };
    const area = circle.area();
    try expect(area > 12.0 and area < 13.0); // Approximately π * 4
}

fn demonstrateTesting() void {
    print("-- Testing Features --\n");
    print("Tests are defined with 'test' keyword\n");
    print("Run tests with: zig test zig_demo.zig\n");
    print("Tests use std.testing.expect for assertions\n");
    print("Tests can be run at compile time\n");
    print("\n");
}

// ============================================================================
// ADVANCED FEATURES
// ============================================================================

// Inline functions
inline fn square(x: i32) i32 {
    return x * x;
}

// Function pointers
const MathOperation = *const fn (i32, i32) i32;

fn applyOperation(a: i32, b: i32, operation: MathOperation) i32 {
    return operation(a, b);
}

// Variadic functions (using anytype)
fn printValues(values: anytype) void {
    inline for (values) |value| {
        print("{} ", .{value});
    }
    print("\n");
}

fn demonstrateAdvancedFeatures() void {
    print("-- Advanced Features --\n");

    // Inline functions
    const result = square(5);
    print("Square of 5: {}\n", .{result});

    // Function pointers
    const add_result = applyOperation(10, 5, add);
    const multiply_result = applyOperation(10, 5, multiply);
    print("10 + 5 = {}, 10 * 5 = {}\n", .{ add_result, multiply_result });

    // Variadic function with tuple
    print("Mixed values: ");
    printValues(.{ 42, 3.14, true, "hello" });

    // Type reflection
    const T = i32;
    print("Type info for {s}:\n", .{@typeName(T)});
    print("  Size: {} bytes\n", .{@sizeOf(T)});
    print("  Alignment: {} bytes\n", .{@alignOf(T)});

    // Compile-time type checking
    const is_integer = @typeInfo(T) == .Int;
    print("  Is integer: {}\n", .{is_integer});

    print("\n");
}

// ============================================================================
// STRING MANIPULATION
// ============================================================================

fn demonstrateStrings(allocator: Allocator) !void {
    print("-- String Manipulation --\n");

    // String literals
    const string_literal = "Hello, Zig!";
    print("String literal: {s}\n", .{string_literal});
    print("Length: {}\n", .{string_literal.len});

    // String slicing
    const slice = string_literal[0..5];
    print("Slice [0..5]: {s}\n", .{slice});

    // Dynamic strings with ArrayList
    var string_builder = ArrayList(u8).init(allocator);
    defer string_builder.deinit();

    try string_builder.appendSlice("Hello");
    try string_builder.appendSlice(", ");
    try string_builder.appendSlice("World!");

    print("Built string: {s}\n", .{string_builder.items});

    // String formatting
    var buffer: [100]u8 = undefined;
    const formatted = try std.fmt.bufPrint(buffer[0..], "Number: {}, Float: {d:.2}", .{ 42, 3.14159 });
    print("Formatted: {s}\n", .{formatted});

    // String comparison
    const str1 = "apple";
    const str2 = "banana";
    const comparison = std.mem.order(u8, str1, str2);
    print("Comparing '{s}' and '{s}': {}\n", .{ str1, str2, comparison });

    // String searching
    const haystack = "The quick brown fox jumps over the lazy dog";
    const needle = "fox";
    if (std.mem.indexOf(u8, haystack, needle)) |index| {
        print("Found '{s}' at index {}\n", .{ needle, index });
    }

    print("\n");
}

// ============================================================================
// MAIN FUNCTION - DEMONSTRATION RUNNER
// ============================================================================

pub fn main() !void {
    print("=== Zig Language Demonstration ===\n\n");

    // Initialize allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // ========================================================================
    // BASIC FEATURES
    // ========================================================================

    demonstrateVariablesAndTypes();
    demonstratePointersAndOptionals();
    demonstrateFunctions();
    demonstrateStructs();
    demonstrateArraysAndSlices();

    // ========================================================================
    // INTERMEDIATE FEATURES
    // ========================================================================

    demonstrateErrorHandling();
    try demonstrateMemoryManagement(allocator);
    try demonstrateDefer(allocator);
    demonstrateUnionsAndEnums();

    // ========================================================================
    // ADVANCED FEATURES
    // ========================================================================

    demonstrateComptime();
    demonstrateBitManipulation();
    demonstrateTesting();
    demonstrateAdvancedFeatures();
    try demonstrateStrings(allocator);

    print("=== End of Zig Demonstration ===\n");
}
