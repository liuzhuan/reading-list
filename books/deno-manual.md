# Deno Manual

## 项目状态/免责声明

Deno 目前正处于原型开发阶段，不能用于正式项目。(2020-01-28)

API 可能随时会变，发现 Bug 可以[提交 issue][2]。[v1.0][3] 正在紧锣密鼓的进行中，但尚未确定上线时间。

## 介绍

Deno 是一个 JavaScript/TypeScript 运行时，默认开启安全选项，并且有很棒的开发体验。

它基于 V8, Rust 和 [Tokio][4] 构建。

> Tokio is the asynchronous run-time for the Rust programming language.

### 亮点

- 默认开启安全选项。不可以访问文件、网络或环境变量（除非明确开启）
- 直接支持 TypeScript
- 搭载一个独立的可执行文件（deno）
- 内置实用工具。比如依赖查看（`deno info`）和代码格式化（`deno fmt`）
- 有大量经过审核的[标准模块][5]（受 Golang 的影响较大）
- 脚本可以打包为一个独立 JavaScript 文件

## REF

1. [Deno Manual][1]

[1]: https://deno.land/std/manual.md "Deno Manual"
[2]: https://github.com/denoland/deno/issues "Bug Reports"
[3]: https://github.com/denoland/deno/issues/2473 "Major features necessary for 1.0"
[4]: https://tokio.rs/ "Tokio"
[5]: https://github.com/denoland/deno/tree/master/std "Deno Standard Modules"