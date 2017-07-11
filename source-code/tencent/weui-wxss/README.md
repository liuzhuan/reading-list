# Tencent/weui-wxss

https://github.com/Tencent/weui-wxss

weui-wxss 是腾讯推出的微信小程序样式文件。

## 构建脚手架

该库使用 gulp 构建工具，一共有 `watch`, `build:style`, `build:example` 和 `default` 四个任务。主要任务是 `build:style` 和 `build:example`。

### `build:style` 任务

`build:style` 用于转译合并压缩样式文档，具体分析如下。

首先读取 `src/style` 和 `src/example` 目录下的所有 `wxss` 文件:

```js
gulp.src(['src/style/**/*.wxss', 'src/example/*.wxss'], { base: 'src' })
```

其中的 [`options.base`](https://github.com/gulpjs/gulp/blob/master/docs/API.md#optionsbase) 用来设定输出文件的根目录。

接下来，经过 `less` 和 `postcss` 的编译和增补厂商前缀。

然后，[`cssnano`](http://cssnano.co/) 处理一番：

```js
cssnano({
    zindex: false,
    autoprefixer: false,
    discardComments: { removeAll: true }
})
```

[`zindex`](http://cssnano.co/optimisations/zindex/), [`autoprefixer`](http://cssnano.co/optimisations/autoprefixer/), [`discardComments`](http://cssnano.co/optimisations/discardcomments/) 是 cssnano 的三个压缩选项。

然后经过 [`gulp-header`](https://github.com/tracker1/gulp-header) 处理，将版权信息注入文件头部。

最终将文件输出到 `dist` 目录。

### `build:example` 任务

读取除 `src/example/*.wxss` 外的其它文件（包括 `.wxml` 和 `.wxss`），移动到 `dist` 目录。

## wxss 分析