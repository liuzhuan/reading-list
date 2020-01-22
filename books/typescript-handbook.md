# TypeScript Handbook

## [基本类型][1]

```ts
// Boolean
let isDone: boolean = true;

// Number
let decimal: number = 6;
let hex: number = 0xf00d;
let binary: number = 0b1010;
let octal: number = 0o744;

// String
let color: string = 'blue';
color = "red";

// Template String
let fullName: string = `Bob Bobbington`;
let age: number = 37;
let sentence: string = `Hello, my name is ${ fullName }.
I'll be ${ age + 1 } years old next month.`;

// Array
let list: number[] = [1, 2, 3];
let list: Array<number> = [1, 2, 3];

// Tuple
let x: [string, number];
x = ['hello', 10];
x = [10, 'hello'];  // Error!

x[0].substring(1);  // OK
x[1].substring(1);  // Error, 'number' does not have 'substring'

x[3] = 'world';     // Error
console.log(x[5]);  // Error

// Enum
enum Color { Red, Green, Blue };
let c: Color = Color.Green;

enum Color { Red = 1, Green, Blue };
let c: Color = Color.Green;

enum Color { Red = 1, Green, Blue };
let colorName: string = Color[2];
console.log(colorName); // Green
```

[1]: http://www.typescriptlang.org/docs/handbook/basic-types.html "Basic Types"