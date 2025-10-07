// TypeScript Demo

// Variables and Types
let message: string = "Hello, TypeScript!";
const count: number = 42;
const isTrue: boolean = true;

// Arrays
const fruits: string[] = ["apple", "banana", "cherry"];

// Functions
function greet(name: string): string {
  return `Hello, ${name}!`;
}

// Objects
interface Person {
  name: string;
  age: number;
}

const person: Person = {
  name: "John",
  age: 30,
};

// Classes
class Animal {
  constructor(public name: string) {}

  speak(): void {
    console.log(`${this.name} makes a sound.`);
  }
}

const cat = new Animal("Cat");
cat.speak();

// Template Literals
const templateString = `The count is ${count}, and the message is: ${message}`;

// Conditional Statements
if (isTrue) {
  console.log("It's true!");
} else {
  console.log("It's false!");
}

// Loops
for (const fruit of fruits) {
  console.log(fruit);
}

// Arrow Functions
const add = (a: number, b: number): number => a + b;

// Type Assertions
const value: any = "123";
const numericValue: number = Number(value);

// Generics
function identity<T>(arg: T): T {
  return arg;
}

const map = new Map<number, Map<string, number>>();

const result = identity<string>("Hello, Generics!");

// Promises
async function fetchData(): Promise<string> {
  const response = await fetch("https://example.com/data");
  const data = await response.text();
  return data;
}

fetchData().then((data) => console.log(data));

// Nullish Coalescing
const defaultValue = "Default Value";
const userInput = null;
const finalValue = userInput ?? defaultValue;

console.log(finalValue);
// Private Class Fields (TypeScript 3.8)
class Example {
  #privateField: string;

  constructor() {
    this.#privateField = "Hello, Private!";
  }

  getPrivateField() {
    return this.#privateField;
  }
}
const example = new Example();
console.log(example.getPrivateField());
// Optional Chaining (TypeScript 3.7)
const user = {
  id: 123,
  info: {
    name: "John",
    address: {
      street: "123 Main St",
      city: "Anytown",
    },
  },
};

console.log(user.info?.address?.city);

// Nullish Coalescing (TypeScript 3.7)
const input = undefined;
const output = input ?? "default";
console.log(output);

// ============================================================================
// ADVANCED TYPE FEATURES
// ============================================================================

console.log("\n-- Advanced Type Features --");

// Union Types (value can be one of several types)
type StringOrNumber = string | number;
let flexible: StringOrNumber = "hello";
flexible = 42; // Also valid

// Intersection Types (combine multiple types)
interface HasName {
  name: string;
}

interface HasAge {
  age: number;
}

type PersonWithBoth = HasName & HasAge;
const personWithBoth: PersonWithBoth = {
  name: "Alice",
  age: 25,
};

// Type Guards (narrow types at runtime)
function isString(value: unknown): value is string {
  return typeof value === "string";
}

function processValue(value: string | number) {
  if (isString(value)) {
    console.log("String length:", value.length); // TypeScript knows it's a string
  } else {
    console.log("Number doubled:", value * 2); // TypeScript knows it's a number
  }
}

processValue("hello");
processValue(42);

// Discriminated Unions (tagged unions)
interface Circle {
  kind: "circle";
  radius: number;
}

interface Square {
  kind: "square";
  sideLength: number;
}

interface Triangle {
  kind: "triangle";
  base: number;
  height: number;
}

type Shape = Circle | Square | Triangle;

function getArea(shape: Shape): number {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "square":
      return shape.sideLength ** 2;
    case "triangle":
      return (shape.base * shape.height) / 2;
  }
}

const myCircle: Circle = { kind: "circle", radius: 5 };
console.log("Circle area:", getArea(myCircle));

// Literal Types
type Direction = "north" | "south" | "east" | "west";
let heading: Direction = "north";
// heading = "up"; // Error: Type '"up"' is not assignable to type 'Direction'

// Type Narrowing with typeof and instanceof
function padLeft(value: string, padding: string | number) {
  if (typeof padding === "number") {
    return " ".repeat(padding) + value;
  }
  return padding + value;
}

console.log("Padded:", padLeft("Hello", 5));

// ============================================================================
// UTILITY TYPES
// ============================================================================

console.log("\n-- Utility Types --");

interface User {
  id: number;
  name: string;
  email: string;
  age: number;
}

// Partial<T> - makes all properties optional
type PartialUser = Partial<User>;
const partialUser: PartialUser = { name: "Bob" }; // Only name is required

// Required<T> - makes all properties required
interface OptionalUser {
  id?: number;
  name?: string;
}
type RequiredUser = Required<OptionalUser>;
// const reqUser: RequiredUser = { id: 1 }; // Error: 'name' is required

// Pick<T, K> - select specific properties
type UserPreview = Pick<User, "id" | "name">;
const preview: UserPreview = { id: 1, name: "Alice" };

// Omit<T, K> - exclude specific properties
type UserWithoutEmail = Omit<User, "email">;
const userNoEmail: UserWithoutEmail = { id: 1, name: "Charlie", age: 30 };

// Record<K, T> - create object type with specific keys and value type
type Roles = "admin" | "user" | "guest";
type RolePermissions = Record<Roles, string[]>;
const permissions: RolePermissions = {
  admin: ["read", "write", "delete"],
  user: ["read", "write"],
  guest: ["read"],
};

// Readonly<T> - make all properties readonly
type ReadonlyUser = Readonly<User>;
const readonlyUser: ReadonlyUser = { id: 1, name: "Dave", email: "dave@example.com", age: 25 };
// readonlyUser.name = "David"; // Error: Cannot assign to 'name' because it is a read-only property

// ReturnType<T> - extract return type of function
function createUser() {
  return { id: 1, name: "Eve", email: "eve@example.com" };
}
type CreatedUser = ReturnType<typeof createUser>;

// Parameters<T> - extract parameter types as tuple
type GreetParams = Parameters<typeof greet>;
const params: GreetParams = ["World"];

console.log("Utility types demonstrated");

// ============================================================================
// ENUMS
// ============================================================================

console.log("\n-- Enums --");

// Numeric Enums
enum Status {
  Pending,
  InProgress,
  Completed,
  Failed,
}

let taskStatus: Status = Status.InProgress;
console.log("Task status:", taskStatus); // 1
console.log("Status name:", Status[taskStatus]); // "InProgress"

// String Enums
enum LogLevel {
  Error = "ERROR",
  Warning = "WARNING",
  Info = "INFO",
  Debug = "DEBUG",
}

function logMessage(level: LogLevel, message: string) {
  console.log(`[${level}] ${message}`);
}

logMessage(LogLevel.Info, "Application started");

// Const Enums (inlined at compile time for performance)
const enum Colors {
  Red = "#FF0000",
  Green = "#00FF00",
  Blue = "#0000FF",
}

const favoriteColor = Colors.Blue;

// ============================================================================
// MAPPED TYPES AND CONDITIONAL TYPES
// ============================================================================

console.log("\n-- Mapped Types and Conditional Types --");

// Mapped Types - transform properties of existing types
type Nullable<T> = {
  [P in keyof T]: T[P] | null;
};

type NullableUser = Nullable<User>;
const nullableUser: NullableUser = {
  id: 1,
  name: null,
  email: "test@example.com",
  age: null,
};

// Conditional Types - types that depend on conditions
type IsString<T> = T extends string ? "yes" : "no";
type Test1 = IsString<string>; // "yes"
type Test2 = IsString<number>; // "no"

// Extract non-nullable types (using built-in NonNullable)
type NotNull = NonNullable<string | null | undefined>; // string

// Conditional type with infer
type UnwrapPromise<T> = T extends Promise<infer U> ? U : T;
type PromiseString = UnwrapPromise<Promise<string>>; // string
type NotPromise = UnwrapPromise<number>; // number

// Template Literal Types (TypeScript 4.1+)
type Greeting = "hello" | "hi";
type Name = "world" | "typescript";
type GreetingMessage = `${Greeting} ${Name}`; // "hello world" | "hello typescript" | "hi world" | "hi typescript"

const greetingMsg: GreetingMessage = "hello world";

// ============================================================================
// ADVANCED CLASS FEATURES
// ============================================================================

console.log("\n-- Advanced Class Features --");

// Abstract Classes
abstract class Vehicle {
  constructor(protected brand: string) {}

  abstract move(): void; // Must be implemented by subclasses

  displayBrand(): void {
    console.log(`Brand: ${this.brand}`);
  }
}

class Car extends Vehicle {
  constructor(brand: string, private model: string) {
    super(brand);
  }

  move(): void {
    console.log(`${this.brand} ${this.model} is driving`);
  }
}

const myCar = new Car("Toyota", "Camry");
myCar.move();
myCar.displayBrand();

// Access Modifiers (public, private, protected, readonly)
class BankAccount {
  public accountNumber: string;
  private balance: number;
  protected accountType: string;
  readonly createdAt: Date;

  constructor(accountNumber: string, initialBalance: number) {
    this.accountNumber = accountNumber;
    this.balance = initialBalance;
    this.accountType = "savings";
    this.createdAt = new Date();
  }

  public deposit(amount: number): void {
    this.balance += amount;
    console.log(`Deposited ${amount}. New balance: ${this.balance}`);
  }

  public getBalance(): number {
    return this.balance;
  }
}

const account = new BankAccount("123456", 1000);
account.deposit(500);
console.log("Balance:", account.getBalance());
// console.log(account.balance); // Error: 'balance' is private

// Static Members
class MathUtils {
  static PI: number = 3.14159;
  static readonly E: number = 2.71828;

  static circleArea(radius: number): number {
    return this.PI * radius * radius;
  }

  static square(x: number): number {
    return x * x;
  }
}

console.log("Circle area:", MathUtils.circleArea(5));
console.log("Square:", MathUtils.square(4));
console.log("PI:", MathUtils.PI);

// Getters and Setters
class Temperature {
  private _celsius: number = 0;

  get celsius(): number {
    return this._celsius;
  }

  set celsius(value: number) {
    if (value < -273.15) {
      throw new Error("Temperature below absolute zero!");
    }
    this._celsius = value;
  }

  get fahrenheit(): number {
    return (this._celsius * 9) / 5 + 32;
  }

  set fahrenheit(value: number) {
    this.celsius = ((value - 32) * 5) / 9;
  }
}

const temp = new Temperature();
temp.celsius = 25;
console.log(`${temp.celsius}°C = ${temp.fahrenheit}°F`);

// ============================================================================
// DECORATORS (Experimental - requires experimentalDecorators in tsconfig)
// ============================================================================

console.log("\n-- Decorators (Conceptual Examples) --");

// Note: Decorators require experimentalDecorators flag in tsconfig.json
// These are conceptual examples showing decorator patterns

// Class Decorator Example
function sealedClass(constructor: Function) {
  Object.seal(constructor);
  Object.seal(constructor.prototype);
  console.log("Class sealed:", constructor.name);
}

// Method Decorator Example
function logMethod(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;
  descriptor.value = function (...args: any[]) {
    console.log(`Calling ${propertyKey} with args:`, args);
    const result = originalMethod.apply(this, args);
    console.log(`Result:`, result);
    return result;
  };
  return descriptor;
}

// Property Decorator Example
function readonlyProperty(target: any, propertyKey: string) {
  console.log(`Making ${propertyKey} readonly`);
}

// Decorator usage would look like:
// @sealedClass
// class Calculator {
//   @readonlyProperty
//   version: string = "1.0.0";
//
//   @logMethod
//   add(a: number, b: number): number {
//     return a + b;
//   }
// }

// Manual demonstration without decorators
class Calculator {
  version: string = "1.0.0";

  add(a: number, b: number): number {
    console.log(`Calling add with args: [${a}, ${b}]`);
    const result = a + b;
    console.log(`Result: ${result}`);
    return result;
  }

  multiply(a: number, b: number): number {
    return a * b;
  }
}

const calc = new Calculator();
calc.add(5, 3);
console.log("Multiply result:", calc.multiply(4, 7));

// ============================================================================
// INDEX SIGNATURES AND KEYOF OPERATOR
// ============================================================================

console.log("\n-- Index Signatures and keyof --");

// Index Signatures - for dynamic property names
interface StringDictionary {
  [key: string]: string;
}

const translations: StringDictionary = {
  hello: "hola",
  goodbye: "adiós",
  thanks: "gracias",
};

console.log("Translation:", translations["hello"]);

// Numeric index signatures
interface NumberArray {
  [index: number]: string;
}

const names: NumberArray = ["Alice", "Bob", "Charlie"];
console.log("Name at index 1:", names[1]);

// keyof operator - get union of all property names
type UserKeys = keyof User; // "id" | "name" | "email" | "age"

function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

const testUser: User = { id: 1, name: "Test", email: "test@example.com", age: 25 };
const userName = getProperty(testUser, "name"); // Type is string
const userAge = getProperty(testUser, "age"); // Type is number
console.log("User name:", userName, "Age:", userAge);

// ============================================================================
// TYPE INFERENCE AND CONST ASSERTIONS
// ============================================================================

console.log("\n-- Type Inference and Const Assertions --");

// Type inference
let inferredNum = 42; // Type inferred as number
let inferredStr = "hello"; // Type inferred as string

// Const assertions - create readonly, literal types
const config = {
  apiUrl: "https://api.example.com",
  timeout: 5000,
} as const;

// config.apiUrl = "new url"; // Error: Cannot assign to 'apiUrl' because it is a read-only property
type Config = typeof config; // { readonly apiUrl: "https://api.example.com"; readonly timeout: 5000; }

// Const assertion with arrays
const colors = ["red", "green", "blue"] as const;
type Color = typeof colors[number]; // "red" | "green" | "blue"

// Tuple with const assertion
const point = [10, 20] as const; // Type is readonly [10, 20]

console.log("Config:", config);
console.log("Colors:", colors);

// ============================================================================
// NAMESPACES AND MODULES
// ============================================================================

console.log("\n-- Namespaces --");

// Namespaces (for organizing code)
namespace Geometry {
  export interface Point {
    x: number;
    y: number;
  }

  export class Circle {
    constructor(public center: Point, public radius: number) {}

    area(): number {
      return Math.PI * this.radius ** 2;
    }
  }

  export function distance(p1: Point, p2: Point): number {
    return Math.sqrt((p2.x - p1.x) ** 2 + (p2.y - p1.y) ** 2);
  }
}

const point1: Geometry.Point = { x: 0, y: 0 };
const point2: Geometry.Point = { x: 3, y: 4 };
console.log("Distance:", Geometry.distance(point1, point2));

const circle = new Geometry.Circle(point1, 5);
console.log("Circle area:", circle.area());

// ============================================================================
// ADVANCED ASYNC/AWAIT PATTERNS
// ============================================================================

console.log("\n-- Advanced Async/Await Patterns --");

// Async function with error handling
async function fetchUserData(userId: number): Promise<User | null> {
  try {
    // Simulated async operation
    await new Promise((resolve) => setTimeout(resolve, 100));
    return { id: userId, name: "User" + userId, email: "user@example.com", age: 25 };
  } catch (error) {
    console.error("Error fetching user:", error);
    return null;
  }
}

// Parallel async operations with Promise.all
async function fetchMultipleUsers(userIds: number[]): Promise<(User | null)[]> {
  const promises = userIds.map((id) => fetchUserData(id));
  return Promise.all(promises);
}

// Async IIFE (Immediately Invoked Function Expression)
(async () => {
  const user = await fetchUserData(1);
  console.log("Fetched user:", user);

  const users = await fetchMultipleUsers([1, 2, 3]);
  console.log("Fetched multiple users:", users.length);
})();

// Promise with timeout
function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  const timeout = new Promise<never>((_, reject) =>
    setTimeout(() => reject(new Error("Timeout")), ms)
  );
  return Promise.race([promise, timeout]);
}

// ============================================================================
// TYPE PREDICATES AND NARROWING
// ============================================================================

console.log("\n-- Type Predicates and Narrowing --");

// Type predicate function
function isUser(obj: any): obj is User {
  return (
    typeof obj === "object" &&
    obj !== null &&
    typeof obj.id === "number" &&
    typeof obj.name === "string" &&
    typeof obj.email === "string" &&
    typeof obj.age === "number"
  );
}

function processData(data: unknown) {
  if (isUser(data)) {
    // TypeScript knows data is User here
    console.log("User name:", data.name);
    console.log("User email:", data.email);
  } else {
    console.log("Not a valid user");
  }
}

processData({ id: 1, name: "Alice", email: "alice@example.com", age: 30 });
processData({ invalid: "data" });

// Truthiness narrowing
function printLength(str: string | null | undefined) {
  if (str) {
    // str is narrowed to string
    console.log("Length:", str.length);
  } else {
    console.log("No string provided");
  }
}

printLength("hello");
printLength(null);

// Equality narrowing
function compareValues(x: string | number, y: string | boolean) {
  if (x === y) {
    // x and y are both narrowed to string
    console.log("Both are strings:", x.toUpperCase(), y.toUpperCase());
  }
}

// in operator narrowing
type Fish = { swim: () => void };
type Bird = { fly: () => void };

function move(animal: Fish | Bird) {
  if ("swim" in animal) {
    animal.swim();
  } else {
    animal.fly();
  }
}

console.log("\n=== End of TypeScript Demonstration ===");
