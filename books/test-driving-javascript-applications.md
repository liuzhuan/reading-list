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



TODO

## REF

1. [Test-Driving JavaScript Applications][1], by *Venkat Subramaniam*, 2016/10, The Pragmatic Bookshelf

[1]: https://pragprog.com/book/vsjavas/test-driving-javascript-applications "Test-Driving JavaScript Applications"
[2]: https://imagery.pragprog.com/products/472/vsjavas_xlargecover.jpg "Book Cover"
[3]: https://www.ituring.com.cn/book/1920 "JavaScript 测试驱动开发"
[4]: https://dzone.com/articles/canary-tests "canary tests"
[5]: http://wiki.c2.com/?ArrangeActAssert "Arrange Act Assert"
