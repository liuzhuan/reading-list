# acron

> A small, fast, JavaScript-based JavaScript parser

代码仓库包含三个包：

1. acorn: 主要的 parser
1. acorn-loose: 容错性较好的 parser
1. acorn-walk: 语法树的 walker

Acorn 支持插件来扩展功能。

## acorn

安装

```sh
$ npm install acorn
```

接口

```js
parse(input, options);

let acorn = require('acorn');
console.log(acorn.parse('1 + 1'));
```

返回值是符合 [ESTree 规范][3]的抽象语法树 AST。如果遇到语法错误，parser 将抛出 `SyntaxError`，包含相关信息，错误信息包含 `pos` 和 `loc` 两个位置参数。

Options 应当包含如下参数：

- emcaVersion: 指定 ECMAScript 版本号。可选值为 3, 5, 6(2015), 7(2016), 8(2017), 9(2018), 10(2019) 或 11(2020)。默认是 10。
- sourceType: 指定解析模式。可选值为 `"script"` 和 `"module"`。
- onInsertedSemicolon: 提供自动插入分号的回调函数。
- onTrailingComman: 提供剔除尾部逗号是的回调函数。
- allowReserved: 指定是否可以使用保留字。
- allowReturnOutsideFunction
- allowImportExportEverywhere
- allowAwaitOutsideFunction: `await` 表达式默认只能在 `async` 函数中出现。当设为 `true` 时，可以在顶部作用域出现 `await`。但是非 `async` 函数内，任何情况下，都无法使用 `await` 表达式。
- allowHashBang
- locations: 默认为 false。如果设为 true，则每个节点都会拥有 loc 属性。
- onToken
- onComment
- ranges
- program
- sourceFile
- directSourceFile
- preserveParans

**parseExpressionAt(input, offset, options)** 解析单条语句

### 源码解析

入口文件：https://github.com/acornjs/acorn/blob/master/acorn/src/index.js

```js
import { Parser } from './state';

export const version = '7.1.0';

export {
    Parser,
    // ...
    nonASCIIwhitespace,
}

Parser.acorn = {
    Parser,
    // ...
    nonASCIIwhitespace,
}

export function parse(input, options) {
    return Parser.parse(input, options);
}

export function parseExpressionAt(input, pos, options) {
    return Parser.parseExpressionAt(input, pos, options);
}

export function tokenizer(input, options) {
    return Parser.tokenizer(input, options);
}
```

可以看出，核心代码是 `state.js` 中的 Parser 类。

```js
export class Parser {
    constructor(options, input, startPos) {

    }

    parse() {
        let node = this.options.program || this.startNode();
        this.nextToken();
        return this.parseTopLevel(node);
    }

    static parse(input, options) {
        return new this(options, input).parse();
    }
}
```

> 先暂时看到这里，太难懂了。后会有期。2020-01-20 22:02

## acorn-loose

TODO

## acorn-walk

TODO

## REF

1. [acornjs/acorn][1] on Github
1. [ESTree Spec][3]

[1]: https://github.com/acornjs/acorn
[2]: https://github.com/acornjs/acorn/tree/master/acorn "acornjs/acorn"
[3]: https://github.com/estree/estree "ESTree Spec"