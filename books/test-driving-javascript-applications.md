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
```

TODO

## REF

1. [Test-Driving JavaScript Applications][1], by *Venkat Subramaniam*, 2016/10, The Pragmatic Bookshelf

[1]: https://pragprog.com/book/vsjavas/test-driving-javascript-applications "Test-Driving JavaScript Applications"
[2]: https://imagery.pragprog.com/products/472/vsjavas_xlargecover.jpg "Book Cover"
[3]: https://www.ituring.com.cn/book/1920 "JavaScript 测试驱动开发"
