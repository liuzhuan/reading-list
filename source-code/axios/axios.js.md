# `./lib/axios.js`

主要内容：

```js
var Axios = require('./core/Axios')
var defaults = require('./defaults')

function createInstance(defaultConfig){...}
var axios = createInstance(defaults)
axios.Axios = Axios
axios.create = function create(instanceConfig) {
  return createInstance(utils.merge(defaults, instanceConfig))
}

// cancel etc.

axios.all = function all(promise) {
  return Promise.all(promises)
}
axios.spread = require('./helpers/spread')

module.exports = axios
module.exports.default = axios
```

`axios.all` 和 `axios.spread` 只是一种语法糖，完全可以使用原生的 `Promise.all` 代替。

## Axios.js 构造函数

`./lib/core/Axios.js` 是构造函数，用语生成一个 axios 实例，主要结构如下：

```js
function Axios(instanceConfig) {
  this.defaults = instanceConfig
  this.interceptors = {
    request: new InterceptorManager(),
    response: new InterceptorManager()
  }
}

Axios.prototype.request = function request(config) {}

utils.forEach(['delete', 'get', 'head', 'options'], function (method){
  Axios.prototype[method] = function(url, config) { ... }
})
utils.forEach(['post', 'put', 'patch'], function (method){
  Axios.prototype[method] = function(url, data, config) { ... }
})
```

Axios 构造函数给 `defaults` 赋值，并初始化拦截器对象。`request` 是唯一的请求函数，后面会仔细拆分它的功能。

下面分两批添加别名，相当于建立了指向 `request` 方法的快捷方式。其中 `get` 等无请求数据的一组，`post` 等有请求数据的一组，两者函数签名不同。

## 参考资料

- https://github.com/axios/axios/blob/v0.16.2/lib/axios.js
- https://github.com/axios/axios/blob/v0.16.2/lib/core/Axios.js