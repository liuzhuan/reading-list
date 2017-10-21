# 脚手架

## `package.json`

```json
"scripts": {
  "build": "NODE_ENV=production grunt build",
},
```

## `Gruntfile.js`

```js
grunt.initConfig({
  webpack: require('./webpack.config.js')
})

// ...

grunt.registerTask('build', 'Run webpack and bundle the source', ['clean', 'webpack'])
```

可以看到，使用 webpack 打包输出文件。`webpack.config.js` 的主要内容如下：

```js
var config = {
  entry: './index.js',
}
```

入口文件就是 `index.js`。代码如下：

```js
module.exports = require('./lib/axios');
```

实际的代码从 `lib/axios` 开始。

## 参考资料

- https://github.com/axios/axios/blob/v0.16.2/package.json
- https://github.com/axios/axios/blob/v0.16.2/Gruntfile.js
- https://github.com/axios/axios/blob/v0.16.2/webpack.config.js
- https://github.com/axios/axios/blob/v0.16.2/index.js