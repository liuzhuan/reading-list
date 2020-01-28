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

### 哲学

Deno 致力于为现代开发者创造一个高效安全的脚本环境。

Deno 将一直是一个单独的可执行文件。给定一个 Deno 的程序 URL，就可以在这个 [10MB 左右的可执行文件][6]上运行。Deno 既是运行时，也是包管理器。它使用标准的兼容浏览器的协议加载模块：URL。

另外，Deno 还可以取代 Shell 和 Python，编写一些工具类脚本。

### 目标

- 只包含一个可执行文件（deno）
- 提供安全的默认选项。除非明确说明，脚本默认禁止访问文件、环境和网络
- 兼容浏览器：Deno 程序的子集，如果用纯 JavaScript 编写，并且没有使用全局的 Deno 命名空间，应当可以直接在浏览器中运行
- 提供内置工具，比如单元测试，代码格式化和代码检测等，提升开发体验
- 禁止向用户空间泄露 V8 概念
- 可以有效提供 HTTP 服务

### 同 Node.js 的比较

- Deno 不使用 npm。它的模块基于 URL 或文件路径
- Deno 的模块路径解析算法不依赖 package.json
- 所有的异步操作返回 Promise。因此，Deno 和 Node 的 API 接口不同
- Deno 需要明确开启文件、网络和环境的访问权限
- 当遇到未捕获的错误，Deno 会终止
- 使用 ES 模块，不支持 `require()`。第三方模块通过 URL 引入。

```typescript
import * as log from 'https://deno.land/std/log/mod.ts';
```

### 其他关键行为

- 远程代码初次执行时，会下载并缓存。直到使用 `--reload` 选项运行程序时，代码才会更新。（因此，在飞机上也是可以工作的）
- 从远程下载的模块或文件，应当是不变并且可缓存的

## 内置的实用工具

- `deno info`       依赖检查器
- `deno fmt`        代码格式化
- `deno bundle`     打包
- `deno types`      运行时类型信息
- `deno test`       测试运行器
- `--debug`         命令行调试器，[即将到来][7]
- `deno lint`       代码检测器，[即将到来][8]

## 设置

下载安装的 N 种方法：

```sh
# Using Shell
$ curl -fsSL https://deno.land/x/install/install.sh | sh

# Using Homebrew (mac)
$ brew install deno

# Using Cargo
$ cargo install deno
```

安装完成后，可以执行如下命令：

```sh
$ deno https://deno.land/std/examples/welcome.ts
```

如果想查看 `welcome.ts` 的源码，只需把 `deno` 替换为 `curl` 即可。

## 例子

模仿 unix `cat` 程序

```typescript
for (let i = 0; i < Deno.args.length; i++) {
    let filename: string = Deno.args[i];
    let file = await Deno.open(filename);
    await Deno.copy(Deno.stdout, file);
    file.close();
}
```

执行时，需要增加 `--allow-read` 标识位：

```sh
$ deno --allow-read cat.ts /etc/passwd
```

TCP 回显服务器

```typescript
const listener = Deno.listen({ port: 8080 });
console.log('listening on 0.0.0.0:8080');
for await (const conn of listener) {
    Deno.copy(conn, conn);
}
```

使用 `--allow-net` 标识位运行：

```sh
$ deno --allow-net https://deno.land/std/examples/echo_server.ts
```

为了测试服务器是否正常，使用 netcat 发送数据：

```sh
$ nc localhost 8080
hello world
hello world
```

## REF

1. [Deno Manual][1]

[1]: https://deno.land/std/manual.md "Deno Manual"
[2]: https://github.com/denoland/deno/issues "Bug Reports"
[3]: https://github.com/denoland/deno/issues/2473 "Major features necessary for 1.0"
[4]: https://tokio.rs/ "Tokio"
[5]: https://github.com/denoland/deno/tree/master/std "Deno Standard Modules"
[6]: https://github.com/denoland/deno/releases "Releases of Deno"
[7]: https://github.com/denoland/deno/issues/1120 "Support Chrome Devtools"
[8]: https://github.com/denoland/deno/issues/1880 "Add deno lint subcommand"