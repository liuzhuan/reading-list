# Babel Handbook

本手册分两部分：[用户手册][2]和[插件手册][3]。

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

## 插件手册

TODO

## REF

1. [The Babel Handbook][1], by *James Kyle*

[1]: https://github.com/jamiebuilds/babel-handbook "The Babel Handbook"
[2]: https://github.com/jamiebuilds/babel-handbook/blob/master/translations/en/user-handbook.md "User Handbook"
[3]: https://github.com/jamiebuilds/babel-handbook/blob/master/translations/en/plugin-handbook.md "Plugin Handbook"