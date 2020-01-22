# Babel Handbook

作者：[Jamie Kyle][6]

本手册分两部分：[用户手册][2]和[插件手册][3]。

本书的版本适用于 Babel v6- 版本，不适合 Babel v7+。v7+ 版的包名需要更新为 `@babel/*`。

## 用户手册

Babel 是一款通用的 JavaScript 编译器。

`babel-cli` 是一款命令行编译工具。首先，全局安装它：

```sh
$ npm install --global babel-cli
```

然后，就可以编译 JS 文件了：

```sh
# 默认把转译结果输出到终端
$ babel my-file.js

# 把结果输出到文件
$ babel example.js --out-file compiled.js
# 或者
$ babel example.js -o compiled.js

# 转译整个目录
$ babel src --out-dir lib
# 或者
$ babel src -d lib
```

尽管可以全局安装 Babel-Cli，局部安装依赖是更好的做法。好处有二：

1. 不同的项目可以依赖不同版本的 Babel，方便单独更新。
1. 这意味着你无需对环境有任何隐含的依赖。你的项目可移植性更好，设置更容易。

本地安装 Babel-Cli

```sh
$ npm install --save-dev babel-cli

# 建议卸载全局安装的 Babel-Cli
$ npm uninstall --global babel-cli
```

然后更新 `package.json`，增加 `scripts` 脚本：

```json
{
    "scripts": {
        "build": "babel src -d lib"
    }
}
```

### babel-register

`babel-register` 是另一个常用的使用 Babel 的方法。注意，`babel-register` 不可用于生产环境。

安装 `babel-register`:

```sh
$ npm install --save-dev node-register
```

创建 `index.js`:

```js
console.log('Hello world!');
```

创建 `register.js`:

```js
require('babel-register');
require('./index.js');
```

上述代码将 Babel 注册到 Node 模块系统，并开始编译经 `require` 导入的每个模块。然后，运行如下代码即可：

```sh
$ node register.js
```

### babel-node

`babel-node` 可以当作 `node` 的替代品。但不建议在生产环境中使用。

首先，需要安装 `babel-cli`

```sh
$ npm install --save-dev babel-cli
```

然后，用 `babel-node` 替换 `node`:

```json
{
    "scripts": {
        "script-name": "babel-node script.js"
    }
}
```

### babel-core

如果需要在代码中使用 Babel，可以使用 `babel-core` 包。

首先，安装 `babel-core`:

```sh
$ npm install babel-core
```

可以使用 `babel.transform` 转译 JavaScript 字符串代码：

```js
var babel = require('babel-core');
babel.transform('code();', options);
```

如果要处理文件，也可以使用异步 api:

```js
babel.transformFile('filename.js', options, function(err, result) {
    result // => { code, map, ast }
});
```

或者同步 api：

```js
babel.transformFileSync('filename.js', options);
// => { code, map, ast }
```

### 配置 Babel

你需要告诉 Babel 转译规则，否则默认它什么也不做。

可以通过安装 plugins 和 presets(plugins 集合)，告知 Babel 转译规则。

**.babelrc**

最简单的 Babel 配置文件：

```json
{
    "presets": [],
    "plugins": []
}
```

如果想把 ES6 语法转译为 ES5，可以使用 `babel-preset-es2015`:

```sh
$ npm install --save-dev babel-preset-es2015
```

```json
{
    "presets": [
        "es2015"
    ],
    "plugins": []
}
```

### 执行 Babel 生成的代码

**babel-polyfill**

几乎所有的新 JavaScript 语法都能被 Babel 转译，但是新 API 却不可以。

比如 `Array.from()` 不会被 Babel 转译。这将导致就平台上无法运行包含 `Array.from` 的代码。

可以用 [Polyfill][4] 解决这个问题。

> A polyfill, or polyfiller, is a piece of code (or plugin) that provides the technology that you, the developer, expect the browser to provide natively. Flattening the API landscape if you will.

Babel 使用 [`core-js`][5] 和定制化的 regenerator 运行时作为 Polyfill。

为了使用 `babel-polyfill`，需要首先安装：

```sh
$ npm install --save babel-polyfill
```

然后在页面头部引用：

```js
import 'babel-polyfill';
```

**babel-runtime**

为了实现 ECMAScript 规范的细节，Babel 使用很多的 helper 辅助函数，以便让产生的代码更简洁。

由于辅助函数可能变得很长，而且出现在每个文件的头部，可以将它们抽离到一个统一的 runtime 中。

首先，安装 `babel-plugin-transform-runtime` 和 `babel-runtime`:

```sh
$ npm install --save-dev babel-plugin-transform-runtime
$ npm install --save-dev babel-runtime
```

更新 `.babelrc`

```json
{
    "plugins": [
        "transform-runtime",
        "transform-es2015-classes"
    ]
}
```

现在，Babel 将会把如下代码：

```js
class Foo {
    method() {}
}
```

转译为：

```js
import _classCallCheck from 'babel-runtime/helpers/classCallCheck';
import _createClass from 'babel-runtime/helpers/createClass';

let Foo = function() {
    function Foo() {
        _classCallCheck(this, Foo);
    }

    _createClass(Foo, [{
        key: 'method',
        value: function method() {}
    }]);

    return Foo;
}();
```

### 配置 Babel（高级篇）

手动指定插件

Babel presets 仅仅是预置插件的集合。可以手动指定插件，来得到不一样的设置。

```sh
$ npm install --save-dev babel-plugin-transform-es2015-classes
```

**.babelrc**

```json
{
    "plugins": [
        "transform-es2015-classes"
    ]
}
```

插件选项

```json
{
    "plugins": [
        [
            "transform-es2015-classes",
            { "loose": true }
        ]
    ]
}
```

根据环境自定义 Babel

```json
{
    "presets": ["es2015"],
    "plugins": [],
    "env": {
        "development": {
            "plugins": []
        },
        "production": {
            "plugins": []
        }
    }
}
```

当前的环境使用 `process.env.BABEL_ENV` 变量，如果 `BABEL_ENV` 不存在，则使用 `NODE_ENV`。如果 `NODE_ENV` 也不存在，默认是 `development`。

在 Unix 中方法如下：

```sh
$ BABEL_ENV=production [COMMAND]
$ NODE_ENV=production [COMMAND]
```

在 Windows 中的方法如下：

```sh
$ SET BABEL_ENV=production
$ [COMMAND]
```

如果要跨平台，需要使用 `cross-env`。

制作自己的 preset

创建自定义 preset 很简单，比如你如下 `.babelrc` 文件：

```json
{
    "presets": [
        "es2015",
        "react"
    ],
    "plugins": [
        "transform-flow-strip-types"
    ]
}
```

你需要创建一个新项目，名称是 `babel-preset-*`，并创建两个文件。

首先，创建 `package.json`，包含必要的依赖：

```json
{
    "name": "babel-preset-my-awesome-preset",
    "version": "1.0.0",
    "author": "James Kyle <me@thejameskyle.com>",
    "dependencies": {
        "babel-preset-es2015": "^6.3.13",
        "babel-preset-react": "^6.3.13",
        "babel-plugin-transform-flow-strip-types": "^6.3.15"
    }
}
```

然后，创建 `index.js`，导出 `.babelrc` 的内容，将 plugin/preset 字符串替换为 `require` 调用。

```js
module.exports = {
    presets: [
        require('babel-preset-es2015'),
        require('babel-preset-react'),
    ],
    plugins: [
        require('babel-plugin-transform-flow-strip-types');
    ]
};
```

## 插件手册

TODO

## REF

1. [The Babel Handbook][1], by *James Kyle*

[1]: https://github.com/jamiebuilds/babel-handbook "The Babel Handbook"
[2]: https://github.com/jamiebuilds/babel-handbook/blob/master/translations/en/user-handbook.md "User Handbook"
[3]: https://github.com/jamiebuilds/babel-handbook/blob/master/translations/en/plugin-handbook.md "Plugin Handbook"
[4]: https://remysharp.com/2010/10/08/what-is-a-polyfill "What Is a Polyfill"
[5]: https://github.com/zloirock/core-js "zloirock/core-js"
[6]: https://github.com/jamiebuilds "Jamie Kyle"