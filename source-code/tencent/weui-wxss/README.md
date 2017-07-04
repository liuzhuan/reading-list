# Tencent/weui-wxss

https://github.com/Tencent/weui-wxss

weui-wxss 是腾讯推出的微信小程序样式文件。

## 构建脚手架

该库使用 gulp 构建工具，一共有 `watch`, `build:style`, `build:example` 和 `default` 四个任务。主要任务是 `build:style` 和 `build:example`。

```js
gulp
    .src(['src/style/**/*.wxss', 'src/example/*.wxss'], { base: 'src' })
```

其中的 [`options.base`](https://github.com/gulpjs/gulp/blob/master/docs/API.md#optionsbase) 可以改变输出文件的根目录。