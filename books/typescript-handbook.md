# TypeScript Handbook

目录

- [基本类型](#基本类型)
- [变量声明](#变量声明)
- [接口](#接口)
- [类](#类)
- [函数](#函数)
- [泛型](#泛型)
- [类型推断](#类型推断)
- [Symbols](#Symbols)
- [迭代器和生成器](#迭代器和生成器)

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

一个简单的 class 例子：

```typescript
class Greeter {
    greeting: string;
    constructor(message: string) {
        this.greeting = message;
    }
    greet() {
        return `Hello, ${this.greeting}`;
    }
}

let greeter = new Greeter('world');
```

### 继承

来看一个简单的继承：

```typescript
class Animal {
    move(distanceInMeters: number = 0) {
        console.log(`Animal moved ${distanceInMeters}m.`);
    }
}

class Dog extends Animal {
    bark() {
        console.log('Woof! Woof!');
    }
}

const dog = new Dog();
dog.bark();
dog.move(10);
dog.bark();
```

下面是一个复杂的继承：

```typescript
class Animal {
    name: string;
    constructor(theName: string) {
        this.name = theName;
    }
    move(distanceInMeters: number = 0) {
        console.log(`${this.name} moved ${distanceInMeters}m.`);
    }
}

class Snake extends Animal {
    constructor(name: string) { super(name); }
    move(distanceInMeters = 5) {
        console.log('Slithering...');
        super.move(distanceInMeters);
    }
}

class Horse extends Animal {
    constructor(name: string) { super(name); }
    move(distanceInMeters = 45) {
        console.log('Galloping...');
        super.move(distanceInMeters);
    }
}

let sam = new Snake('Sammy the Python');
let tom: Animal = new Horse('Tommy the Palomino');
sam.move();
tom.move(34);
```

### Public, private 和 protected 修饰符

在 TypeScript 中，每个成员默认都是 `public` 的。

可以用 `private` 标示私有成员变量。

```typescript
class Animal {
    private name: string;
    constructor(theName: string) {
        this.name = theName;
    }
}

new Animal('Cat').name;     // Error: 'name' is private;
```

TypeScript 是一种结构类型系统。当比较不同的类型时，如果所有成员的类型都兼容，无论它们来自哪里，都可以认为这些类型都兼容。

但是，当比较的类型包含 `private` 或 `protected` 的成员变量时，比较法则会有所变化。如果一个类型包含 `private` 变量，那么其他的类型只有来自同一祖先类型时，才认为是兼容的。否则，即使结构形状一样，也不能看作是兼容的类型。

比如：

```typescript
class Animal {
    private name: string;
    constructor(theName: string) {
        this.name = theName;
    }
}

class Rhino extends Animal {
    constructor() { super('Rhino'); }
}

class Employee {
    private name: string;
    constructor(theName: string) { this.name = theName; }
}

let animal = new Animal('Goat');
let rhino = new Rhino();
let employee = new Employee('Bob');

animal = rhino;
animal = employee;  // Error: Type 'Employee' is not assignable to type 'Animal'.
```

### 理解 protected

`protected` 同 `private` 类似，唯一的不同在于，`protected` 变量可以被子类实例访问。

```typescript
class Person {
    protected name: string;
    constructor(name: string) { this.name = name; }
}

class Employee extends Person {
    private department: string;

    constructor(name: string, department: string) {
        super(name);
        this.department = department;
    }

    public getElevatorPitch() {
        return `Hello, my name is ${this.name} and I work in ${this.department}`;
    }
}

let howard = new Employee('Howard', 'Sales');
console.log(howard.getElevatorPitch());
console.log(howard.name);   // Error
```

构造函数也可以指定为 `protected`，这意味着该类不能在包含类外实例化，但是可以扩展。

```typescript
class Person {
    protected name: string;
    protected constructor(theName: string) { this.name = theName; }
}

class Employee extends Person {
    private department: string;

    constructor(name: string, department: string) {
        super(name);
        this.department = department;
    }

    public getElevatorPitch() {
        return `Hello, my name is ${this.name} and I work in ${this.department}`;
    }
}

let howard = new Employee('Howard', 'Sales');
let john = new Person('John');  // Error: The 'Person' constructor is protected
```

### Readonly 修饰符

只读属性只能在属性声明时，或构造函数中初始化。

```typescript
class Octopus {
    readonly name: string;
    readonly numberOfLegs: number = 8;

    constructor(theName: string) {
        this.name = theName;
    }
}

let dad = new Octopus('Man with the 8 strong legs');
dad.name = 'Man with the 3-piece suit'; // Error: name is readonly
```

### 参数属性

参数属性（*parameter properties*）允许在同一地方对属性创建并初始化。

```typescript
class Octopus {
    readonly numberOfLegs: number = 8;
    constructor(readonly name: string) {}
}
```

除 `readonly` 外，还可以使用 `private`, `public`, `protected` 等。

### 存取器

TypeScript 支持 getter/setter 存取器。

```typescript
const fullNameMaxLength = 10;

class Employee {
    private _fullName: string;

    get fullName(): string {
        return this._fullName;
    }

    set fullName(newName: string) {
        if (newName && newName.length > fullNameMaxLength) {
            throw new Error(`fullName has a max length of ${fullNameMaxLength}`);
        }

        this._fullName = newName;
    }
}

let employee = new Employee();
employee.fullName = 'Bob Smith';
if (employee.fullName) {
    console.log(employee.fullName);
}
```

注意：使用存取器时，需要将 TypeScript 编译器的输出设为 ECMAScript 5 或更高版本。

### 静态属性

```typescript
class Grid {
    static origin = { x: 0, y: 0 };
    calculateDistanceFromOrigin(point: {x: number; y: number;}) {
        let xDist = point.x - Grid.origin.x;
        let yDist = point.y - Grid.origin.y;
        return Math.sqrt(xDist * xDist + yDist * yDist) / this.scale;
    }

    constructor(public scale: number) {}
}

let grid1 = new Grid(1.0);
let grid2 = new Grid(5.0);

console.log(grid1.calculateDistanceFromOrigin({ x: 10, y: 10 }));
console.log(grid2.calculateDistanceFromOrigin({ x: 10, y: 10 }));
```

### 抽象类

抽象类指哪些可以被继承，但是本身无法实例化的类。使用 `abstract` 标识。

```typescript
abstract class Animal {
    abstract makeSound(): void;

    move(): void {
        console.log('roaming the earth...');
    }
}

let dog = new Animal(); // Error: Cannot create an instance of an abstract class
```

被标示为 `abstract` 的函数，必须在子类中实现。

```typescript
abstract class Department {
    constructor(public name: string) {}

    printName(): void {
        console.log(`Department name: ${this.name}`);
    }

    abstract printMeeting(): void;
}

class AccountingDepartment extends Department {

    constructor() {
        super('Accounting and Auditing');
    }

    printMeeting(): void {
        console.log('The Accounting Department meets each Monday at 10am.');
    }

    generateReports(): void {
        console.log('Generating accounting reports...');
    }
}

let department: Department;
department = new Department();  // Error: 不可实例化抽象类
department = new AccountingDepartment();
department.printName();
department.printMeeting();
department.generateReports();   // Error: Department 抽象类不包含 generateReports 方法
```

### 高级技巧

构造函数 Constructor Functions

```typescript
class Greeter {
  static standardGreeting = 'Hello, there';
  greeting: string;
  
  greet() {
    if (this.greeting) {
      return `Hello, ${this.greeting}`;
    }

    return Greeter.standardGreeting;
  }
}

let greeter1: Greeter;
greeter1 = new Greeter();
console.log(greeter1.greet());

let greeterMaker: typeof Greeter = Greeter;
greeterMaker.standardGreeting = 'Hey there!';

let greeter2: Greeter = new greeterMaker();
console.log(greeter2.greet());
```

把 Class 当作接口

```typescript
class Point {
  x: number;
  y: number;
}

interface Point3d extends Point {
  z: number;
}

let point3d: Point3d = { x: 1, y: 2, z: 3 };
```

## [函数][5]

可选参数

```typescript
function buildName(firstName: string, lastName?: string) {
    if (lastName)
        return `${firstName} ${lastName}`;
    return firstName;
}

let result1 = buildName('Bob');
```

设定默认值

```ts
function buildName(firstName: string, lastName = 'Smith') {
    return `${firstName} ${lastName}`;
}

console.log(buildName("Tony"));             // => Tony Smith
console.log(buildName("Tony", "Stark"));    // => Tony Stark
```

### 收集参数

```ts
function buildName(firstName: string, ...restOfName: string[]) {
    return `${firstName} ${restOfName.join(' ')}`;
}

let employeeName = buildName('Joseph', 'Samuel', 'Lucas', 'MacKinzie');
console.log(employeeName);
```

在函数类型中也可以使用省略号

```ts
function buildName(firstName: string, ...restOfName: string[]) {
    return `${firstName} ${restOfName.join(' ')}`;
}

let buildNameFun: (fname: string, ...rest: string[]) => string = buildName;
```

### this

掌握如何使用 `this` 算是学习 JavaScript 路上的成人礼。

this 和箭头函数

```typescript
let deck = {
    suits: ['hearts', 'spades', 'clubs', 'diamonds'],
    cards: Array(52),
    createCardPicker: function() {
        return function() {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);
            return {
                suit: this.suits[pickedSuit],
                card: pickedCard % 13,
            };
        }
    }
}

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();
console.log(`card: ${pickedCard.card} of ${pickedCard.suit}`);
// => Uncaught TypeError: Cannot read property 'suits' of undefined
```

> Arrow functions capture the `this` where the function is created rather than where it is invoked.

对于箭头函数，this 的指向在定义时绑定，而不是在调用时绑定。

```typescript
let deck = {
    suits: ['hearts', 'spades', 'clubs', 'diamonds'],
    cards: Array(52),
    createCardPicker: function() {
        return () => {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);
            return {
                suit: this.suits[pickedSuit],
                card: pickedCard % 13,
            };
        }
    }
}

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();
console.log(`card: ${pickedCard.card} of ${pickedCard.suit}`);
// => card: 10 of hearts
```

`this` 参数

```ts
interface Card {
    suit: string;
    card: number;
}

interface Deck {
    suits: string[];
    cards: number[];
    createCardPicker(this: Deck): () => Card;
}

let deck: Deck = {
    suits: ['hearts', 'spades', 'clubs', 'diamonds'],
    cards: Array(52),
    createCardPicker: function(this: Deck) {
        return () => {
            let pickedCard = Math.floor(Math.random() * 52);
            let pickedSuit = Math.floor(pickedCard / 13);

            return {
                suit: this.suits[pickedSuit],
                card: pickedCard % 13
            }
        }
    }
}

let cardPicker = deck.createCardPicker();
let pickedCard = cardPicker();

console.log(`card: ${pickedCard.card} of ${pickedCard.suit}`);
```

## [泛型][6]

可复用性在软件工程中很重要。泛型是实现代码复用的重要手段之一。

泛型的最基本用法就是恒等函数（identity function）

```ts
function identity<T>(arg: T): T {
    return arg;
}
```

在此，使用了类型变量（type variable）`T`。

泛型的使用方法有两种，一种是提供类型变量：

```ts
let output = identity<string>('myString');
```

第二种方法更常用，即**类型参数推断**（type argument inference），让编译器根据实参类型，自动设置 `T` 的类型：

```ts
let output = identity('myString');
```

编译器会把泛型当作 any 类型对待，可以和数组结合使用。

```ts
function loggingIdentity<T>(arg: T[]): T[] {
    console.log(arg.length);
    return arg;
}
```

泛型函数和接口同普通函数并没有什么不同：

```ts
interface GenericIdentityFn {
    <T>(arg: T): T;
}

function identity<T>(arg: T): T {
    return arg;
}

let myIdentity: GenericIdentityFn = identity;
```

也可以把泛型参数当作接口的一个参数，这样让调用者更明确：

```ts
interface GenericIdentityFn<T> {
    (arg: T): T;
}

function identity<T>(arg: T): T {
    return arg;
}

let myIdentity: GenericIdentityFn<number> = identity;
```

除泛型接口（generic interfaces）外，还可以定义泛型类（generic classes）。

```ts
class GenericNumber<T> {
    zeroValue: T;
    add: (x: T, y: T) => T;
}

let myGenericNumber = new GenericNumber<number>();
myGenericNumber.zeroValue = 0;
myGenericNumber.add = function(x, y) { return x + y; };
```

注意，泛型类的静态成员不受泛型的影响。

如果想对泛型类型做一些约束，可以使用接口定义约束条件，然后 `extends` 该接口即可。

```ts
interface Lengthwise {
    length: number;
}

function loggingIdentity<T extends Lengthwise>(arg: T): T {
    console.log(arg.length);
    return arg;
}

loggingIdentity('abc');
```

可以声明一个受其他类型参数约束的类型参数

```ts
function getProperty<T, K extends keyof T>(obj: T, key: K) {
    return obj[key];
}

let x = {
    a: 1,
    b: 2,
    c: 3,
    d: 4,
}

getProperty(x, 'a');
```

其中，用到了 [`typeof`][7] 关键字，这是 TypeScript 2.1 引入的特性，用来获取某类型的所有键名。

在工厂函数中使用泛型时，如下所示：

```ts
class BeeKeeper {
    hasMask: boolean;
}

class ZooKeeper {
    nametag: string;
}

class Animal {
    numLegs: number;
}

class Bee extends Animal {
    keeper: BeeKeeper;
}

class Lion extends Animal {
    keeper: ZooKeeper;
}

function createInstance<A extends Animal>(c: new () => A): A {
    return new c();
}

createInstance(Lion).keeper.nametag;
createInstance(Bee).keeper.hasMask;
```

## [枚举][8]

枚举用来定义命名的常量。

Too much details, Read It Later.

## [类型推断][9]

类型推断包括以下几种：

1. 普通推断，在变量声明、函数默认值等情况下执行
1. 上下文类型推断（contextual typing），依据类型的位置推断变量类型。

## [Symbols][10]

`symbol` 是 ES2015 新增的基本类型。通过调用 `Symbol` 构造函数创建。每个 Symbol 都是独一无二的。

```js
let sym1 = Symbol();
let sym2 = Symbol('hello');     //  可选的字符串键值

let sym3 = Symbol('hello');
console.log(sym2 == sym3);      // => false
console.log(sym2 === sym3);     // => false
```

symbols 和字符串一样，都可以当作对象的键值。

```js
const sym = Symbol();

let obj = {
    [sym]: 'value'
}

console.log(obj[sym]);  // => value
```

还可以在类中充当成员变量名：

```js
const getClassNameSymbol = Symbol();

class C {
    [getClassNameSymbol]() {
        return 'C';
    }
}

let c = new C();
let className = c[getClassNameSymbol]();
console.log(className);     // => C
```

除了用户自定义的 symbol，ES 还内置了许多知名 Symbol。比如 `Symbol.hasInstance`，`Symbol.isConcatSpreadable` 等。

## [迭代器和生成器][11]

TODO

[1]: http://www.typescriptlang.org/docs/handbook/basic-types.html "Basic Types"
[2]: http://www.typescriptlang.org/docs/handbook/variable-declarations.html "Variable Declarations"
[3]: http://www.typescriptlang.org/docs/handbook/interfaces.html "Interfaces"
[4]: http://www.typescriptlang.org/docs/handbook/classes.html "Classes"
[5]: http://www.typescriptlang.org/docs/handbook/functions.html "Functions"
[6]: http://www.typescriptlang.org/docs/handbook/generics.html "Generics"
[7]: http://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-1.html#keyof-and-lookup-types "keyof and Lookup Types"
[8]: http://www.typescriptlang.org/docs/handbook/enums.html "Enums"
[9]: http://www.typescriptlang.org/docs/handbook/type-inference.html "Type Inference"
[10]: https://www.typescriptlang.org/docs/handbook/symbols.html "Symbols"
[11]: https://www.typescriptlang.org/docs/handbook/iterators-and-generators.html "Iterators and Generators"