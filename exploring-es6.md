# Notes on Exploring ES6

by Dr. Axel Rauschmayer
notes by liuz

This book not only tells us what ES6 is, but also why it is.

[4. Core ES6 features](http://exploringjs.com/es6/ch_core-features.html), 2017-03-15 14:26

## From var to const/let

* Prefer `const`. You can use it for all variables whose values never change.
* Otherwise, use let - for variables whose values do change.
* Avoid var.

## From IIFEs to blocks
## From concatenating strings to template literals
## From function expressions to arrow functions
## Handling multiple return values

In ES6, destructing makes this code simpler:

```js
const [, year, month, day] = /^(\d\d\d\d)-(\d\d)-(\d\d)$/.exec('2999-12-31');
```

## 4.6 From `for` to `forEach()` to `for-of`

```js
const arr = ['a', 'b', 'c'];
for (const elem of arr) {
    console.log(elem);
}
```

If you want both index and value of each array element, via new Array method entries() and destructuring:

```js
for (const [index, elem] of arr.entries()) {
    console.log(index + '. ' + elem);
}
```

## 4.7 Handling parameter default values

```js
function foo(x=0, y=0) { ... }
```

## 4.8 Handling named parameters

```js
function selectEntries({ start=0, end=-1, step=1  }) { ... }
```

## 4.9 From arguments to rest parameters

```js
function logAllArguments(...args) {
    for (const arg of args) {
        console.log(arg);
    }
}
```

## 4.10 From apply() to the spread operator (...)

```js
Math.max(...[-1, 5, 11, 3]);

// Array.prototype.push()
const arr1 = ['a', 'b'];
const arr2 = ['c', 'd'];
arr1.push(...arr2);
```

## 4.11 From concat() to the spread operator (...)

```
const arr1 = ['a', 'b'];
const arr2 = ['c'];
const arr3 = ['d', 'e'];
console.log([...arr1, ...arr2, ...arr3]);
```

## 4.12 From function expressions in object literals to method definitions

```js
const obj = {
    foo() {},
    bar() {
        this.foo();
    }
}
```

## 4.13 From constructors to classes

```js
class Person() {
    constructor(name) {
        this.name = name;
    }

    describe() {
        return 'Person called ' + this.name;
    }
}
```

ES6 has built-in support for subclassing, via the `extends` clause:

```js
class Employee extends Person {
    constructor(name, title) {
        super(name);
	this.title = title;
    }

    describe() {
        return super.describe() + ' (' + this.title + ')';
    }
}
```

You can see a runnable demo at [here](./Person.js).

## 4.14 From custom error constructors to subclasses of Error

```js
class MyError extends Error { // ... }
```

## 4.15 From objects to Maps

```js
const map = new Map();
function countWords(word) {
    const count = map.get(word) || 0;
    map.set(word, count + 1);
}
```

## 4.16 New string methods

* startsWith
* endsWith
* includes
* repeat

## 4.17 New Array methods

* findIndex
* from, spread operator
* fill

## 4.18 From CommonJS modules to ES6 modules

# [5. New number and Math features](http://exploringjs.com/es6/ch_numbers.html)
