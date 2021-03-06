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

## webpack.config.js

`webpack.config.js` 是默认的配置文件，提供了开发时的运行参数。

### `__dirname` 和 `path` 是什么作用？

```js
module.exports = {
    output: {
        path: path.resolve(__dirname, 'dist')
    },
    resolve: {
        extensions: ['', '.js'],
        fallback: [path.join(__dirname, '../node_modules')]
    }
}
```

[`__dirname`](https://nodejs.org/api/globals.html#globals_dirname) 是 Node.js 内置变量，表示当前模块所在目录的绝对路径。与此相关的还有 [`__filename`](https://nodejs.org/api/globals.html#globals_filename)，表示当前模块的文件绝对路径。

`path` 是内置的 node.js 模块。[`path.resolve`](https://nodejs.org/api/path.html#path_path_resolve_paths) 会将传入的路径参数，从右至左依次串联，若得到一个绝对路径，返回之；否则，返回当前目录的绝对路径与相对路径构成的字符串。[`path.join`](https://nodejs.org/api/path.html#path_path_join_paths) 会按照所在操作系统的路径分隔符，将传入的路径拼接，返回一个完整路径。

`path.resolve` 返回的一定是绝对路径，`path.join` 可能返回相对路径或者绝对路径。

### `output.library` 和 `output.libraryTarget` 是什么意思？

[output.library](https://webpack.github.io/docs/configuration.html#output-library) 用来设置发布的库文件名称，[output.libraryTarget](https://webpack.github.io/docs/configuration.html#output-librarytarget) 设置发布的库格式，可选值包括：`var`, `this`, `commonjs`, `commonjs2`, `amd`, `umd`。

### `devtool: '#eval-source-map'` 是什么用法？

[`devtool`](https://webpack.js.org/configuration/devtool/) 用来控制 `source maps` 的产生方式。

### `preLoaders` 是什么？

[preLoaders 和 postLoaders](https://webpack.github.io/docs/configuration.html#module-preloaders-module-postloaders) 与 `loaders` 一样，可以对输入文件进行转换，分别作用于 `loaders` 之前和之后。

### `loader: 'style-loader!css-loader!stylus-loader'` 的处理顺序是怎样的？

[module.loaders](https://webpack.github.io/docs/configuration.html#module-loaders) 是一系列数组，其中每个元素都包含 `test`, `exclude`, `loader` 等属性。`loader` 属性是用 `!` 分隔的 `loader`。

帮助文档 [using loaders](https://webpack.github.io/docs/using-loaders.html) 中说，当级联使用多个 loader，按照从右向左的顺序依次对原始文件处理。

### `style-loader`, `url-loader` 和 `css-loader` 分别是什么作用？

[`file-loader`](https://github.com/webpack-contrib/file-loader) 指导 webpack 输出指定的对象作为文件，并且返回公共 url。

The [`url-loader`](https://github.com/webpack-contrib/url-loader) 工作方式与 `file-loader` 相似，但是如果文件小于设定的字节限制 `limit`，会返回一个 `DataURL`。

[css-loader](https://github.com/webpack-contrib/css-loader) 把 `@import` 和 `url()` 翻译为 `import/require()` ，然后解析这些资源。

[style-loader](https://github.com/webpack-contrib/style-loader) 把 CSS 注入到 DOM 的  `<script>` 中。

### `resolve` 和 `resolveLoader` 分别代表什么意思？

[`resolve`](https://webpack.github.io/docs/configuration.html#resolve) 影响模块的解析。

[`resolve.fallback`](https://webpack.github.io/docs/configuration.html#resolve-fallback) 当 Webpack 在 `resolve.root` 和 `resolve.moduleDirectories` 中找不到时的替代查找文件夹。

[`resolve.extensions`](https://webpack.github.io/docs/configuration.html#resolve-extensions) 用来解析模块的扩展名列表。一般需要在列表中增加 `''`，以保留模块的原始扩展名。

[`resolveLoader`](https://webpack.github.io/docs/configuration.html#resolveloader) 与 `resolve` 类似，但是适用于解析 `loader`。

### `webpack.prod.config.js`

`webpack.prod.config.js` 用于生产环境配置参数，增加了 `UglifyJsPlugin` 压缩 js 体积。

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

> Node.js 中可以直接 require JSON 格式。但是小程序不行，因为微信小程序会自动“智能”补全后缀，变成 `package.json.js` 样式。

### `src/util/eventEmitter.js` 

定义了事件基类。除构造函数外，还包括 `on`, `once`, `off`, `trigger` 四个函数。

`once` 定义了一次性事件，通过创建闭包 `magic`，在成功一次之后便卸载该事件。

`off` 方法用于删除监听事件。通过倒序循环，将 `_events[count][0]` 置为 `undefined`。

> 为什么不在 `off` 中直接删除匹配的数组项呢？是因为怕影响其他待执行函数吗？

`trigger` 事件中有个很有意思的细节：

```js
let eventsCopy = [...events];
```

为什么要复制一份新的事件？

### `src/util/dom.js`

`dom.js` 定义了操作 DOM 的工具类。

`createDom` 将传入的字符串，通过 [`childNodes`](https://developer.mozilla.org/en-US/docs/Web/API/Node/childNodes) 转换为 DOM 对象。

`addEvent` 和 `removeEvent` 是对原生事件 API 的简单封装。

`hasClass` 用来检测元素的 [`className`](https://developer.mozilla.org/en-US/docs/Web/API/Element/className)，判断是否包含特定的类名，通过正则表达式验证。

`addClass` 用于新增 class 类名，如果类名已经存在，则不做任何处理。这里先将 `className` 拆分为数组，然后将新类名放入数组，然后将数组链接为一个字符串。

> 为什么不直接在 `className` 上直接使用字符串拼接的方法，将新类名增加到原类名尾部呢？

> 除 `className` 外，[`classList`](https://developer.mozilla.org/en-US/docs/Web/API/Element/classList) 也可以实现类名的增删改查，但是兼容性不太乐观。

`removeClass` 通过构造一个包含待删除类名正则表达式，使用 `String.prototype.replace` 将其替换为空字符串。

### `src/util/lang.js`

定义了 `extend` 函数，使用源数据扩充目标数据。

### `src/util/mixin.styl`

这是一个 Stylus 文件，定义了很多 minxins 和函数。

### `src/picker/picker.js`

核心文件，导入 `better-scroll`, `picker.handlebars` 模板, `picker.style` 样式文件和一些工具类。

其中定义并导出 `Picker` 类，而 `Picker` 类继承自 `EventEmitter` 类。

`Picker` 内的方法包括：`constructor`, `_init`, `_bindEvent`, `_createWheel`, `show`, `hide`, `refillColumn`, `refill`, `scrollColumn` 。

构造函数 `constructor` 接收参数，创建 picker 的 DOM 结构，并将 picker 的各个组件作为成员变量存储到实例中。

> `xx-hook` 的类名应该是专门供 JS 调用的，没有 `-hook` 后缀的类名应该是添加样式的。

其中，`pickerEl` 是整个 picker 示例。`maskEl` 是遮罩层。`wheelEl` 是每个列的实例。`panelEl` 相当于 `pickerEl - maskEl`。`confirmEl` 和 `cancelEl` 分别表示确定按钮和取消按钮。`scrollEl` 是 `wheelEl` 的子元素，两者都是类数组变量，其他元素都是标量。

构造函数末尾，会调用 `_init` 函数。

`_init` 函数初始化 `this.selectedIndex` 变量后，调用 `_bindEvent` 函数。

`_bindEvent` 添加了三个事件处理函数。

第一个用于阻止 `pickerEl` 的触摸滑动。

第二个监听 `confirmEl` 的点击事件，并抛出 `picker.select` 事件。如果选择的数值发生改变，还要抛出 `picker.valuechange` 事件。

第三个监听到 `cancelEL` 的点击事件后，隐藏 `picker` 控件，并抛出 `picker.cancel` 事件。

`_createWheel(wheelEl, i)` 用于动态生成滑动轮。`this.wheels` 是一个数组，每个元素都是一个 `BScroll` 对象。`BScroll` 对象的 `wheel` 和 `selectedIndex` options 属性是专门为 `picker` 组件设立的。`BScroll` 实例通过监听 `scrollEnd` 事件，当探测到当前选中的索引值与上次索引值不同时，抛出 `picker.change` 事件，同时带有 `index` 和 `currentIndex` 两个参数。最后返回新生成的 `BScroll` 实例。

`show()` 方法会显示 `pickerEl`，并在 0 秒后给 `maskEl` 和 `panelEl` 增加 `show` 类。如果 `this.wheels` 不存在，则创建新的 `this.wheels`，否则使 `this.wheels` 可用，并滑动到选中索引。

`hide()` 函数会隐藏 `picker` 组件。

`refillColumn(index, data)` 方法会用 `data` 数据重新填充索引值为 `index` 的数据轮。

`refill(datas)` 是对 `refillColumn(index, data)` 的一个简单封装。

`scrollColumn(index, dist)` 将索引值为 `index` 的数据轮滚动至 `dist` 的位置。

至此，`picker` 核心代码分析基本完毕。