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

// Any
let notSure: any = 4;
notSure = 'maybe a string instead';
notSure = false;

let notSure: any = 4;
notSure.ifItExists();   // OK
notSure.toFixed();      // OK

let prettySure: Object = 4;
prettySure.toFixed();   // Error: Property 'toFixed' doesn't exist on type 'Object'

let list: any[] = [1, true, 'free'];
list[1] = 100;

// Void
function warnUser(): void {
    console.log('This is my warning message');
}

let unusable: void = undefined;
unusable = null;    // OK if `--strictNullChecks` is not given

// Null and Undefined
let u: undefined = undefined;
let n: null = null;
```

默认情况下，`null` 和 `undefined` 是所有其他类型的子类型。这意味着可以把 `null` 和 `undefined` 赋值给 `number`。

但是，当设定 `--strictNullChecks` 时，`null` 和 `undefined` 只能给 `any` 和各自类型赋值（唯一例外是，`undefined` 可以给 `void` 类型赋值）。

如果想传入 `string` 或 `null` 或 `undefined`，可以使用联合类型：`string | null | undefined`。

**Never**

`never` 类型表示永远不会出现的值。比如，如果一个函数总是抛出异常，或者永远不返回任何值，它的返回类型就是 `never`。

`never` 是每个类型的子类型。但其他类型不可以给 `never` 类型的变量赋值。

```typescript
function error(message: string): never {
    throw new Error(message);
}

function fail() {
    return error('Something failed');
}

function infiniteLoop(): never {
    while (true) {
        // do something awesome
    }
}
```

**Object**

`object` 代表非基本类型。`Object.create` 可以借助 `object` 类型更好的表达：

```typescript
declare function create(o: object | null): void;

create({ prop: 0 });    // OK
create(null);           // OK

create(42);             // Error
create('string');       // Error
create(false);          // Error
create(undefined);      // Error
```

[1]: http://www.typescriptlang.org/docs/handbook/basic-types.html "Basic Types"