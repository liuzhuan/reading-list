# JavaScript 测试驱动开发

![Test-Driving JavaScript Applications][2]

以下是《JavaScript 测试驱动开发》的阅读笔记。

## 前言

本书涵盖的工具

- Karma
- Mocha
- Chai
- Istanbul
- Sinon
- Protractor

## 第1章 自动化测试让你重获自由

自动化测试让我们尽早发现故障，促使我们编写模块化、高内聚、低耦合的代码。

### 1.1 变更的挑战

良好的设计应当是灵活的、易于扩展的、维护成本低的。

### 1.2 测试与验证

testing vs. verification

通过手动测试来洞察应用，通过自动验证来修改设计和确认代码始终符合预期。

### 1.3 采用自动化验证

将自动化测试极端地集中在UI层会导致蛋筒冰激凌反模式（ice-cream cone）。

集中在UI层的测试有很多缺点：

1. 非常脆弱
1. 过多的活动部分
1. 非常缓慢
1. 难以编写
1. 无法隔离问题域
1. 无法防止在UI层中包含业务逻辑
1. 无法改进设计

Mike Cohn 提出了测试金字塔的理念，即底层测试最多，高层次的端到端测试最少。

理想的测试层级是，单元测试最多，功能测试其次，端到端UI测试最少。

### 1.4 为什么难以验证

自动化测试是否可行，与代码设计密切相关。

### 1.5 如何实现自动化测试

1. 细化测试
1. 分而治之
1. 采用spike解决方案

## 第2章 测试驱动设计

### 2.1 开始

编写一个华氏温度转换为摄氏温度的计算函数。

设置项目

```sh
$ npm init -y
$ npm install mocha chai --save-dev 
$ mkdir -p {src,test}
```

创建测试套件和金丝雀测试

金丝雀测试（[canary test][4]）可以验证开发环境是否正确安装。

在 `test/` 目录下新建 `util_test.js`:

```js
var expect = require('chai').expect;

describe('util test', () => {
    it('should pass this canary test', () => {
        expect(true).to.eql(true);
    })
})
```

`describe` 是 Mocha 定义测试套件的一个关键词。`it` 用来定义一个独立的测试用例。

`beforeEach` 和 `afterEach` 是**三明治函数**。即，测试套件中的所有测试都在这两个函数之间执行。

一般来说，测试遵循 [Arrange-Act-Assert][5] (准备-行动-断言)模式。

编写测试的原则：

1. 测试和测试套件应该职责单一。
1. 测试应当与代码相关，并验证代码的正确行为。

### 2.2 正向测试、反向测试和异常测试

关注行为而非状态。不要为获取设置状态的函数编写测试。从有趣的、有用的行为开始编写。在这个过程中对那些必要的状态进行设置和获取。

有三种测试类型：

1. 正向测试：当前置条件满足时，验证代码的结果确实符合预期。
1. 反向测试：当前置条件或者输入不符合要求时，代码能优雅的进行处理。
1. 异常测试：代码在应该抛出异常的地方正确地抛出了异常。

要让测试保持 FAIR，即快速（fast）、自动化（automated）、独立（isolated）和可重复（repeatable）。

### 2.3 设计服务端代码

安装 istanbul，它用于评估代码覆盖率。

```sh
$ npm install istanbul --sav-dev
```

修改 `package.json` 的 `scripts` 字段：

```json
{
    "scripts": {
        "test": "istanbul cover node_modules/mocha/bin/_mocha"
    }
}
```

测试是文档的一种形式。测试是鲜活的文档，用于验证代码的每一次修改。

### 2.4 评估服务器端代码覆盖率

Istanbul 是一个非常出色的 JavaScript 代码覆盖率工具。它能监测到是否每行代码都执行了，以及执行了多少次。

打开 `coverage/lcov-report/index.html` 可以查看详尽的测试报告。

### 2.5 为测试客户端代码做准备

要想将代码和测试自动加载到浏览器上，那么就要使用 Karma 了。

Karma 是一个轻量级的服务器，用于在不同的浏览器上管理测试的加载和运行。

这次有一堆依赖：

```sh
$ npm install chai istanbul karma karma-chai karma-chrome-launcher karma-clear-screen-reporter karma-cli karma-coverage karma-mocha mocha --save-dev
```

修改 `scripts` 字段：

```json
{
    "scripts": {
        "test": "karma start --reporters clear-screen,dots,coverage"
    }
}
```

配置 Karma

如果没有指定文件名，Karma 就会读取 `karma.config.js` 配置文件。使用如下命令创建该文件：

```sh
$ node node_modules/karma/bin/karma init
```

在回答问题时，选择如下答案：

1. 测试框架：选择 Mocha
1. 是否使用 Require.js：no
1. 想要捕获的浏览器：chrome
1. 其他问题选择默认值

添加 `chai` 和源码文件的路径：

```diff
+ frameworks: ['mocha', 'chai'],
+ files: [
+     './test/**/*.js',
+     './src/**/*.js'
+ ]
```

### 2.7 评估客户端代码覆盖率

修改 `karma.config.js`：

```js
preprocessors: {
    'src/**/*.js': 'coverage'
},

reporters: ['progress', 'coverage']
```

## 第3章 异步测试

### 3.1 服务器端回调

在测试用例的函数中添加 done 参数，异步完成后调用该函数即可。

### 3.3 测试 promise

可以用 `done` 和 promise 两种风格来测试 promise。但是，使用后者时，必须返回 Promise 对象。

```js
it('should pass', function() {
    const callback = function(data) {
        expect(data).to.be.true;
    }

    return getInfo()
        .then(callback);
})
```

[`chai-as-promised`][6] 库扩展了 Chai 的 API，提供了一些函数来验证 promise 的响应。 

```js
require('chai').use(require('chai-as-promised'));

it('should return correct lines count - using eventually', function() {
    return expect(linesCount('foo.js')).to.eventually.equal(15);
})
```

## 第4章 巧妙处理依赖

### 4.1 问题以及 spike 解决方案

代码是否具有可测试性是个设计问题，设计糟糕的代码是难以测试的。

### 4.2 模块化设计

承担了大量工作的函数通常违背了单一职责原则（single responsibility principle）。

### 4.3 尽量分离依赖

编写自动化测试的第一步就是确定一个或多个不具有内部依赖的函数。

### 4.4 使用测试替身

测试替身是代替真正依赖的对象，从而让自动化测试可以进行。

测试中用来代替依赖的测试替身有集中不同的类型。

1. `fake` 适用于测试但不能用于生产环境的实现。比如，测试环境中的信用卡处理服务。
1. `stub` 它并不是真正的实现，但被调用时可以快速返回预设数据。可以验证状态。
1. `mock` 与 stub 类似，但它对交互进行跟踪，如调用的次数、调用的顺序。可以验证行为。
1. `spy` 可以代理真实的依赖。

这四者的详细解释可以参考 Martin Fowler 的文章 [Mocks Aren't Stubs][7]。

### 4.5 依赖注入

依赖注入是用测试替身代替依赖的一种流行、通用的技术。依赖注入就是，依赖在调用时作为参数传递。

### 4.6 交互测试

前面的测试都可以称作经验测试（`empirical test`）。

交互测试更适合有依赖的代码。函数的测试关注的是函数的行为，而不是该函数的依赖对象是否正确。代码真的无需在测试过程中访问真正的依赖对象。

如何在经验测试和交互测试之间选择？

1. 如果结果是确定的、可预测的，而且很容易断定，那么就使用经验测试。
1. 如果代码有很复杂的依赖关系，而且依赖让代码不确定、难以预测、脆弱或耗时，那么就使用交互测试。

### 4.7 使用 Sinon 清理测试代码

Sinon 提供了一些函数来创建不同类型的测试替身。`Sinon-Chai` 模块使得原本就很快速的 Chai 库得以用更直观的方式来验证测试替身的调用。

使用 Sinon 需要用到4个包：`sinon`, `sinon-chai`, `karma-sinon` 和 `karma-sinon-chai`。

安装 Sinon

```sh
$ npm install sinon sinon-chai karma-sinon karma-sinon-chai
```

你还要告诉 Karma 使用它们。配置 `karma.config.js`

```diff
+ frameworks: ['mocha', 'chai', 'sinon', 'sinon-chai']
```

Sinon 可以让测试替身的创建非常简洁快速。如果我们用测试替身替换原有的函数，Sinon 的 `sandbox` 可以简化恢复函数的过程。

> 目前最新的 Sinon.jS 版本是 v8.0.1。自 `Sinon@5.0.0` 起，[sinon 对象本身就是一个 sandbox][8]。除非你有特殊需求或高级设定，通常你不再需要创建新的 sandbox。

使用 Sinon 的第一步就是创建和恢复 sandbox。

```js
var sandbox;

beforeEach(function() {
    sandbox = sinon.sandbox.create();
});

afterEach(function() {
    sandbox.restore();
});
```

创建 spy

```js
var aSpy = sandbox.spy(existingFunction);

// 验证函数是否被调用
expect(aSpy.called).to.be.true;

// Sinon-Chai 语法简化验证方式
expect(aSpy).called;

// 验证函数是否以特定参数调用
expect(aSpy).to.have.been.calledWith('magic');
```

创建 Stub

```js
var aStub = sandbox.stub(util, 'alias')
    .withArgs('Robert')
    .returns('Bob');
```

创建 Mock

```js
var aMock = sandbox.mock(util)
    .expects('alias')
    .withArgs('Robert');

// 检测被测函数与 mock 代替的依赖是否进行了交互
aMock.verify();
```

stub 测试状态，mock 更适合测试交互或行为。

使用 spy 测试 onSuccess 函数

```js
var createURLSpy = sandbox.spy(window, 'createURL');
var position = {
    coords: {
        latitude: 40.41,
        longitude: -105.55,
    }
};
onSuccess(position);
expect(createURLSpy).to.have.been.calledWith(40.41, -105.55);
```

自动化测试有助于创造良好的设计，良好的设计让代码更易于测试。

## 第5章 Node.js 测试驱动开发

### 5.1 从策略设计开始 - 适度即可

策略设计（strategic design）是高层次的设计，可以帮助我们只通过有限的细节来评估所要处理的整个问题。

在改进代码的过程中，测试将引导我们不断剖析设计细节。

### 5.2 深入战略设计 - 测试优先

战略设计（tactical design）是更细致的设计决策，并实现代码。

首先，将想到的测试写在一张纸上，无需担心是否正确。

在编程过程中，会不断想到新的测试，把它们添加到测试列表中。每完成一个测试，就给它标上记号。

### 5.3 继续设计

测试可以对设计决策进行文档化。

### 5.4 创建 spike 以获得启发

通过创建 spike 进行学习，然后丢弃它，继续使用测试驱动开发。

### 5.5 模块化以易于测试

### 5.6 分离关注点

### 5.7 集成测试

集成测试，需要真实的文件。

如果想查看真实的程序运行效果，可以编写一个驱动程序。

### 5.8 回顾代码覆盖率和设计

package.json 中的 test 命令：

```json
{
    "scripts": {
        "test": "istanbul cover node_modules/mocha/bin/_mocha"
    }
}
```

### 5.9 提供 HTTP 访问

## 第6章 Express 测试驱动开发

### 6.1 为可测试性设计

为了方便对模型对自动化测试，避免模型和数据库紧密耦合，解决方法是依赖注入。

### 6.2 创建 Express 应用并运行金丝雀测试

[Express 生成器][9]可以快速创建项目目录结构。

mocha 的 `--watch` 选项，可以监控文件的改动。

```sh
$ mocha --watch --recursive test/server
```

### 6.3 设计数据库连接

`db.connect();`

### 6.4 设计模型

只有模型相关的函数才会与数据库进行交互。为了避免多次操作造成的不良影响，需要使用测试固件（test fixture）。在 `beforeEach` 和 `afterEach` 中增加设置和清理函数。`before()` 可以在测试套件前运行一次。

```js
describe('test', function() {
    before(function(done) {
        db.connect('mongodb://localhost/todotest', done);
    });

    after(function() {
        db.close();
    });
});
```

### 6.6 评估代码覆盖率

```json
{
    "scripts": {
        "cover": "istanbul cover node_modules/mocha/bin/_mocha -- --recursive test/server"
    }
}
```

双破折号表明，后面的选项是用于 Mocha 而非 Istanbul。

### 6.7 运行应用

测试服务端代码有两种方法。如下：

使用 curl

```sh
$ curl -w "\n" -X GET http://localhost:3000/tasks
$ curl -w "\n" -X POST -H "Content-Type: application/json" \
http://localhost:3000/tasks
$ curl -w "\n" -X GET http://localhost:3000/tasks
$ curl -w "\n" -X DELETE http://localhost:3000/tasks/abcdefg
```

使用 Chrome 扩展程序

Advanced REST 浏览器插件或 Postman。

## 第7章 与 DOM 和 jQuery 协作

### 7.1 创建策略设计

在编写和测试任务前，我们不需要 HTML 文件，也不需要运行服务器。

### 7.2 通过测试创建战略设计

Karma 配置文件 `karma.config.js` 中有以下内容：

```js
{
    // 告诉 karma 加载列出的插件
    frameworks: ['mocha', 'chai', 'sinon', 'sinon-chai'],

    // 在运行测试之前，应该加载到浏览器的 JavaScript 文件
    files: [
        'public/javascript/jquery-2.1.4.js',
        './test/client/**/*.js',
        './public/javascripts/**/*.js',
    ],
}
```

### 7.3 增量开发

测试 DOM 更新的时候，不需要真正的创建 DOM 元素，可以创建 stub

```js
var domElements;

beforeEach(function() {
    sandbox = sinon.sandbox.create();

    domElements = {};
    sandbox.stub(document, 'getElementById', function(id) {
        if (!domElements[id]) domElements[id] = {};
        return domElements[id];
    });
});
```

为客户端编写自动化测试时，不应该启动和运行服务器端。否则，测试将变得脆弱、不确定、难以运行。

Sinon 的 FakeXMLHttpRequest 可以解决这个问题。

```js
var xhr;

beforeEach(function() {
    xhr = sinon.useFakeXMLHttpRequest();
    xhr.requests = [];
    xhr.onCreate = function(req) {
        xhr.requests.push(req);
    };
});

afterEach(function() {
    xhr.restore();
});
```

## 第8章 使用 AngularJS

AngularJS 十分重视自动化测试，它使用依赖注入组合代码，让代码真正可以测试。

### 8.1 测试 AngularJS 的方式

AngularJS 使用 `angular-mocks` 优雅的简化了自动化测试时的依赖和服务。

测试执行显示的依赖注入的例子如下：

```html
<html ng-app="sample">
<div ng-controller="SampleController as controller">
```

这种格式在测试套件中会转换为注入请求。比如：

```js
// 等同于 ng-app='sample'
beforeEach(module('sample'));

beforeEach(inject(function($controller){
    controller = $controller('SampleController');
}));
```

### 8.5 分离关注点，减少mock

关注点分离（Separation of concerns, SOC）是指将整体看成部分的组合体，对各部分单独处理的一种原则。模块化是其中最有代表性的具体设计原则之一。

如果排序代码在 HTML 文件中，就不能使用控制器的测试对其验证。不得不依赖 UI 层的测试，耗时且脆弱。

因此，要避免使用会导致测试困难的库或者框架的特性。寻找能够支持自动化验证的方法。

## REF

1. [Test-Driving JavaScript Applications][1], by *Venkat Subramaniam*, 2016/10, The Pragmatic Bookshelf
1. [Mocks Aren't Stubs][7], by *Martin Fowler*, 2007/01/02

[1]: https://pragprog.com/book/vsjavas/test-driving-javascript-applications "Test-Driving JavaScript Applications"
[2]: https://imagery.pragprog.com/products/472/vsjavas_xlargecover.jpg "Book Cover"
[3]: https://www.ituring.com.cn/book/1920 "JavaScript 测试驱动开发"
[4]: https://dzone.com/articles/canary-tests "canary tests"
[5]: http://wiki.c2.com/?ArrangeActAssert "Arrange Act Assert"
[6]: https://www.npmjs.com/package/chai-as-promised "chai-as-promised"
[7]: https://www.martinfowler.com/articles/mocksArentStubs.html "Mocks Aren't Stubs"
[8]: https://sinonjs.org/releases/v8.0.1/sandbox/ "Sandboxes - Sinon.JS"
[9]: https://expressjs.com/en/starter/generator.html "Express application generator"
