# ustbhuangyi/picker

https://github.com/ustbhuangyi/picker

> 本次源代码分析基于 dd03fb 提交。

picker 是一个类似于 iOS 原生下拉列表的前端组件。

picker 构建工具基于 [webpack](https://webpack.js.org)，模板引擎使用了 [handlebars](https://github.com/wycats/handlebars.js/)，CSS 预编译工具使用了 [stylus](http://stylus-lang.com/).

除此之外，picker 还依赖于作者的另一个库 [better-scroll](https://github.com/ustbhuangyi/better-scroll).

## package.json

熟悉一个项目，首先从 `package.json` 开始。

`scripts` 字段定义如下：

```js
"dev": "webpack-dev-server --port 9090 --inline --hot --content-base ./demo --host 0.0.0.0",
"build": "webpack --config webpack.prod.conf.js"
```

因此，通过 `npm run dev` 即可在本地 9090 端口 唤起`webpack-dev-server`。通过 `npm run build` 构建输出文件。这两个 `scripts` 字段在开源项目中应该算是潜规则了。

当前使用的 `webpack` 版本 `1.12.11`，`webpack-dev-server` 版本 1.14.1。

`--content-base` 用来改变静态资源路径，默认是当前路径。查看 [--content-base 的用法](https://webpack.github.io/docs/webpack-dev-server.html#content-base)。

[`--inline` 模式](https://webpack.github.io/docs/webpack-dev-server.html#inline-mode) 自动在 webpack 配置文件中自动添加客户端入口。

## src/

`src/index.js` 是入口文件，从 package.json 中获取 version 版本号，注入到 `Picker`：

```js
Picker.verison = __VERSION__;
```

其中的 `__VERSION__` 是在 `webpack.config.js` 中通过 `webpack.DefinePlugin` 读取的：

```js
var version = require('./package.json').version;

module.exports = {
    // ...
    plugins: [
        new webpack.DefinePlugin({
            __VERSION__: JSON.stringify(version)
        })
    ]
    // ...
};
```

[DefinePlugin](http://webpack.github.io/docs/list-of-plugins.html#defineplugin) 可以在 webpack 编译过程中定义全局常量。

> Node.js 中可以直接 require JSON 格式。