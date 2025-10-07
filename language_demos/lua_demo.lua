-- Lua Demo
-- This file demonstrates various Lua language features and idioms

print("=== Lua Language Demonstration ===\n")

-- ============================================================================
-- VARIABLES AND BASIC TYPES
-- ============================================================================

-- Variables (dynamically typed, no type declarations needed)
local message = "Hello, Lua!"
local count = 42
local pi = 3.14159
local isTrue = true
local nothing = nil  -- nil is Lua's null/undefined value

print("-- Variables and Types --")
print("Message:", message)
print("Count:", count)
print("Type of count:", type(count))
print("Type of message:", type(message))
print()

-- Multiple assignment
local x, y, z = 1, 2, 3
local a, b = 10, 20
a, b = b, a  -- Swap values
print("Swapped values: a =", a, "b =", b)
print()

-- ============================================================================
-- TABLES (Lua's primary data structure)
-- ============================================================================

print("-- Tables (Arrays and Dictionaries) --")

-- Tables as arrays (1-indexed in Lua!)
local fruits = {"apple", "banana", "cherry"}
print("First fruit:", fruits[1])  -- Note: 1-indexed, not 0-indexed!
print("Number of fruits:", #fruits)  -- # operator gets length

-- Iterating over array-like tables
for i, fruit in ipairs(fruits) do
    print(i, fruit)
end
print()

-- Tables as dictionaries/hash maps
local fruitColors = {
    apple = "red",
    banana = "yellow",
    cherry = "red"
}
print("Apple color:", fruitColors.apple)
print("Banana color:", fruitColors["banana"])  -- Alternative syntax

-- Iterating over dictionary-like tables
for fruit, color in pairs(fruitColors) do
    print(fruit .. " is " .. color)
end
print()

-- Mixed tables (both array and dictionary parts)
local mixed = {
    "first",
    "second",
    name = "Mixed Table",
    count = 42
}
print("Array part:", mixed[1], mixed[2])
print("Dictionary part:", mixed.name, mixed.count)
print()

-- ============================================================================
-- FUNCTIONS
-- ============================================================================

print("-- Functions --")

-- Basic function
local function greet(name)
    return "Hello, " .. name .. "!"
end
print(greet("World"))

-- Multiple return values
local function minMax(a, b, c)
    local min = math.min(a, b, c)
    local max = math.max(a, b, c)
    return min, max
end

local minimum, maximum = minMax(5, 2, 8)
print("Min:", minimum, "Max:", maximum)

-- Variable number of arguments (varargs)
local function sum(...)
    local args = {...}  -- Pack varargs into a table
    local total = 0
    for _, v in ipairs(args) do
        total = total + v
    end
    return total
end
print("Sum of 1,2,3,4,5:", sum(1, 2, 3, 4, 5))

-- Functions are first-class values
local function applyOperation(a, b, operation)
    return operation(a, b)
end

local add = function(x, y) return x + y end
local multiply = function(x, y) return x * y end

print("10 + 5 =", applyOperation(10, 5, add))
print("10 * 5 =", applyOperation(10, 5, multiply))
print()

-- ============================================================================
-- CLOSURES
-- ============================================================================

print("-- Closures --")

local function makeCounter()
    local count = 0  -- Upvalue captured by closure
    return function()
        count = count + 1
        return count
    end
end

local counter1 = makeCounter()
local counter2 = makeCounter()
print("Counter1:", counter1(), counter1(), counter1())  -- 1, 2, 3
print("Counter2:", counter2(), counter2())  -- 1, 2
print()

-- ============================================================================
-- TABLES AS OBJECTS (Object-Oriented Programming)
-- ============================================================================

print("-- Object-Oriented Programming --")

-- Simple object with methods
local Animal = {}

function Animal:new(name)
    local obj = {name = name}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Animal:speak()
    print(self.name .. " makes a sound.")
end

local dog = Animal:new("Dog")
dog:speak()

-- Inheritance using metatables
local Cat = {}
setmetatable(Cat, {__index = Animal})  -- Cat inherits from Animal

function Cat:new(name, color)
    local obj = Animal.new(self, name)
    obj.color = color
    return obj
end

function Cat:speak()
    print(self.name .. " meows! (Color: " .. self.color .. ")")
end

local whiskers = Cat:new("Whiskers", "orange")
whiskers:speak()
print()

-- ============================================================================
-- METATABLES (Operator Overloading and More)
-- ============================================================================

print("-- Metatables and Metamethods --")

-- Vector class with operator overloading
local Vector = {}
Vector.__index = Vector

function Vector.new(x, y)
    local v = {x = x, y = y}
    setmetatable(v, Vector)
    return v
end

-- Overload addition operator
function Vector.__add(v1, v2)
    return Vector.new(v1.x + v2.x, v1.y + v2.y)
end

-- Overload tostring for printing
function Vector.__tostring(v)
    return "Vector(" .. v.x .. ", " .. v.y .. ")"
end

local v1 = Vector.new(1, 2)
local v2 = Vector.new(3, 4)
local v3 = v1 + v2  -- Uses __add metamethod
print("v1 + v2 =", v3)
print()

-- ============================================================================
-- CONTROL STRUCTURES
-- ============================================================================

print("-- Control Structures --")

-- If-elseif-else
local number = 10
if number > 10 then
    print("Greater than 10")
elseif number == 10 then
    print("Equal to 10")
else
    print("Less than 10")
end

-- While loop
local i = 1
while i <= 3 do
    print("While loop:", i)
    i = i + 1
end

-- Repeat-until loop (like do-while)
local j = 1
repeat
    print("Repeat-until loop:", j)
    j = j + 1
until j > 3

-- For loop (numeric)
for k = 1, 5 do
    print("For loop:", k)
end

-- For loop with step
for k = 10, 1, -2 do
    print("For loop with step:", k)
end
print()

-- ============================================================================
-- ERROR HANDLING
-- ============================================================================

print("-- Error Handling --")

local function divide(a, b)
    if b == 0 then
        error("Cannot divide by zero!")
    end
    return a / b
end

-- Protected call (pcall)
local success, result = pcall(divide, 10, 2)
if success then
    print("10 / 2 =", result)
else
    print("Error:", result)
end

local success, result = pcall(divide, 10, 0)
if success then
    print("10 / 0 =", result)
else
    print("Caught error:", result)
end
print()

-- ============================================================================
-- COROUTINES (Cooperative Multitasking)
-- ============================================================================

print("-- Coroutines --")

local function producer()
    for i = 1, 5 do
        print("Producing:", i)
        coroutine.yield(i)  -- Suspend and return value
    end
end

local co = coroutine.create(producer)

while coroutine.status(co) ~= "dead" do
    local success, value = coroutine.resume(co)
    if success and value then
        print("Consumed:", value)
    end
end
print()

-- ============================================================================
-- STRING MANIPULATION
-- ============================================================================

print("-- String Manipulation --")

local str = "Hello, Lua!"
print("Length:", #str)
print("Uppercase:", string.upper(str))
print("Lowercase:", string.lower(str))
print("Substring:", string.sub(str, 1, 5))
print("Find 'Lua':", string.find(str, "Lua"))

-- Pattern matching (Lua's regex-like feature)
local text = "The year is 2025"
local year = string.match(text, "%d+")  -- %d+ matches one or more digits
print("Extracted year:", year)

-- String formatting
local formatted = string.format("Pi is approximately %.2f", pi)
print(formatted)
print()

-- ============================================================================
-- MODULES AND SCOPE
-- ============================================================================

print("-- Modules and Scope --")

-- Creating a simple module
local MathUtils = {}

function MathUtils.square(x)
    return x * x
end

function MathUtils.cube(x)
    return x * x * x
end

print("Square of 5:", MathUtils.square(5))
print("Cube of 3:", MathUtils.cube(3))
print()

-- ============================================================================
-- ITERATORS
-- ============================================================================

print("-- Custom Iterators --")

-- Custom iterator function
local function range(from, to, step)
    step = step or 1
    return function(_, current)
        current = current + step
        if current <= to then
            return current
        end
    end, nil, from - step
end

print("Custom range iterator:")
for i in range(1, 10, 2) do
    print(i)
end
print()

print("=== End of Lua Demonstration ===")

