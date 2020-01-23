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

**类型断言**

当你对类型的理解比编译器更多时，可以使用类型断言（*Type Assertions*），指引编译器做更细致的类型判断。

类型断言和其他语言的类型转换（*Type Cast*）类似，但不会对数据做校验或数据重建，对运行时也没有任何影响，只对编译器有效。

类型断言分两种方式，一种是“尖括号”：

```typescript
let someValue: any = 'this is a string';
let strLength: number = (<string>someValue).length;
```

另一种是 `as` 语法：

```typescript
let someValue: any = 'this is a string';
let strLength: number = (someValue as string).length;
```

两者是等价的，选择哪一个依个人喜好而定。但是，如果在 TypeScript 使用 JSX 时，只能使用 `as` 语法。

## [变量声明][2]

`let` 比 `var` 有更多优点，比如块级作用域，防止多次重复等。

能用 `const`，尽量用 `const`，否则，使用 `let`。尽量不使用 `var`。

## [接口][3]

TypeScript 的一个核心原则是，类型检查的重点在于检查类型的数据形状。这种方式有时也称作“鸭子🦆类型”或“结构子类型化（*structural subtyping*）”。

接口是 TypeScript 定义代码之间调用接口的有效方式。

最简单的例子：

```typescript
function printLabel(labelObj: { label: string }) {
    console.log(labelObj.label);
}

let myObj = { size: 10, label: 'Size 10 Object' };
printLabel(myObj);
```

尽管对象的属性多于函数参数的属性，但编译器仅检查必要的属性是否存在，因此不报错。

如果使用接口重写一遍，代码如下：

```typescript
interface LabeledValue {
    label: string;
}

function printLabel(labelObj: LabeledValue) {
    console.log(labelObj.label);
}

let myObj = { size: 10, label: 'Size 10 Object' };
printLabel(myObj);
```

### 可选属性

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
}

function createSquare(config: SquareConfig): { color: string, area: number } {
    let newSquare = { color: 'white', area: 100 };

    if (config.color) {
        newSquare.color = config.color;
    }

    if (config.width) {
        newSquare.area = config.width * config.width;
    }

    return newSquare;
}

let mySquare = createSquare({ color: 'black' });
```

可选属性的好处在于，可以防止不隶属于该接口的其他属性名，避免误操作。

### 只读属性

有些属性只有在创建时才能写入，可以使用 `readonly` 修饰符。

```typescript
interface Point {
    readonly x: number;
    readonly y: number;
}

let p1: Point = { x: 10, y: 20 };
p1.x = 4;   // Error, x is readonly property
```

TypeScript 自带 `ReadonlyArray<T>` 类型，它的行为如 `Array<T>` 一般，但是移除了所有的可变方法。你可以确信该数组一经创建，无法改变。

```typescript
let a: number[] = [1, 2, 3, 4];
let ro: ReadonlyArray<number> = a;
ro[0] = 12;         // Error
ro.push(15);        // Error
ro.length = 100;    // Error
a = ro;             // Error
a = ro as number[]; // OK
```

`readonly` 和 `const` 的区别在于：变量使用 `const`，而属性使用 `readonly`。

### 多余属性检测

```typescript
interface SquareConfig {
    color?: string;
    width?: number;
    [propName: string]: any;
}

function createSquare(config: SquareConfig): { color: string; area: number } {
    // ...
}

let mySquare = createSquare({ coluor: 'red', width: 100 });
```

### 函数类型

```typescript
interface SearchFunc {
    (source: string, subString: string): boolean;
}

let mySearch: SearchFunc;

mySearch = function(src: string, sub: string): boolean {
    let result = src.search(sub);
    return result > -1;
}
```

### 可索引类型

可索引类型（*Indexable Types*）的索引签名（*Index Signature*）用于表示索引值类型和返回值类型。

```typescript
interface StringArray {
    [index: number]: string;
}

let myArray: StringArray;
myArray = ['Bob', 'Fred'];

let myStr: string = myArray[0];
```

索引签名可以是 `number` 类型，也可以是 `string` 类型。要保证 `number` 类型索引签名对应的返回值，是 `string` 索引签名的子类型。

可以用 `readonly` 修饰索引签名，表明该索引只读：

```typescript
interface ReadonlyStringArray {
    readonly [index: number]: string;
}

let myArray: ReadonlyStringArray = ['Alice', 'Bob'];
myArray[2] = 'Mallory';     // Error
```

### Class 类型

可以使用 `implements` 实现严格的接口实现。

```typescript
interface ClockInterface {
    currentTime: Date;
    setTime(d: Date): void;
}

class Clock implements ClockInterface {
    currentTime: Date = new Date();
    setTime(d: Date) {
        this.currentTime = d;
    }
    constructor(h: number, m: number) {}
}
```

interface 定义了类的公共部分。

#### 类的 static 和 instance 的区别

类有两种类型：static 和 instance。当类实现一个接口时，只有 instance 部分会被检测。构造函数属于 static 部分，如果要对其检测，可以使用如下方法：

```typescript
interface ClockConstructor {
    new (hour: number, minute: number): ClockInterface;
}

interface ClockInterface {
    tick(): void;
}

function createClock(ctor: ClockConstructor, hour: number, minute: number): ClockInterface {
    return new ctor(hour, minute);
}

class DigitalClock implements ClockInterface {
    constructor(h: number, m: number) {}
    tick() {
        console.log('beep beep');
    }
}

class AnalogClock implements ClockInterface {
    constructor(h: number, m: number) {}

    tick() {
        console.log('tick tock');
    }
}

let digital = createClock(DigitalClock, 12, 17);
let analog = createClock(AnalogClock, 7, 32);
```

### 扩展接口

接口也可以继承。

```typescript
interface Shape {
    color: string;
}

interface Square extends Shape {
    sideLength: number;
}

let square = {} as Square;
square.color = 'blue';
square.sideLength = 10;
```

接口可以扩展多个其他接口。

```typescript
interface Shape {
    color: string;
}

interface PenStroke {
    penWidth: number;
}

interface Square extends Shape, PenStroke {
    sideLength: number;
}

let square = {} as Square;
square.color = 'blue';
square.sideLength = 10;
square.penWidth = 5.0;
```

### 混合类型

```typescript
interface Counter {
    (start: number): string;
    interval: number;
    reset(): void;
}

function getCounter(): Counter {
    let counter = (function (start: number) {}) as Counter;
    counter.interval = 123;
    counter.reset = function() {};
    return counter;
}

let c = getCounter();
c(10);
c.reset();
c.interval = 5.0;
```

### 扩展 Class 的接口

当接口继承 class 类型时，接口会继承 class 的所有成员。甚至会继承私有和保护成员。这意味着，当接口继承了含有私有成员的类，这个接口只能被该类或该类的子类实现。

## [类][4]



[1]: http://www.typescriptlang.org/docs/handbook/basic-types.html "Basic Types"
[2]: http://www.typescriptlang.org/docs/handbook/variable-declarations.html "Variable Declarations"
[3]: http://www.typescriptlang.org/docs/handbook/interfaces.html "Interfaces"
[4]: http://www.typescriptlang.org/docs/handbook/classes.html "Classes"