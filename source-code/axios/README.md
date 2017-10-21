# axios 源码解读

axios 是一个基于 Promise 的 HTTP 客户端，可运行在浏览器和 node.js 中。

主要开发者是 mzabriskie(Matt Zabriskie)。

此次研究的版本是 v0.16.2，2017年6月4日发布。

## API

```js
axios(config)
axios(url[, config])

axios.request(config)
axios.get(url[, config])
axios.delete(url[, config])
axios.head(url[, config])
axios.options(url[, config])
axios.post(url[, data[, config]])
axios.put(url[, data[, config]])
axios.patch(url[, data[, config]])

/** 并发请求 */
axios.all(iterable)
axios.spread(callback)

/** 创建实例 */
axios.create([config])
/** 实例方法 */
axios#request(config)
axios#get(url[, config])
axios#delete(url[, config])
axios#head(url[, config])
axios#options(url[, config])
axios#post(url[, data[, config]])
axios#put(url[, data[, config]])
axios#patch(url[, data[, config]])

/** 全局 axios 默认值 */
axios.defaults.baseURL = 'https://api.example.com'
axios.defaults.headers.common['Authorization'] = AUTH_TOKEN
axios.defautls.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'


/** 实例自定义默认值 */
instance.defaults.headers.common['Authorization'] = AUTH_TOKEN

/** 拦截器 */
axios.interceptors.request.use(function(config){}, function(error){})
axios.interceptors.response.use(function(response){}, function(error){})
/** 删除拦截器 */
axios.interceptors.request.eject(myInterceptor)
```

## 请求参数

常用参数如下

```js
{
    url,
    method: 'get|post|...|patch',
    baseURL,
    transformRequest,
    transformResponse,
    headers,
    params: { ... },
    paramsSerializer: function(params) {},
    data: { ... },
    timeout: 1000,
    withCredentials: false,
    adapter: function(config) {},
    auth: {
        username: 'aname',
        password: 'password'
    },
    responseType: 'json|arraybuffer|...|text',
    xsrfCookieName: 'XSRF-TOKEN',
    xsrfHeaderName: 'X-XSRF-TOKEN',
    onUploadProgress: function(progressEvent){},
    onDownloadProgress: function(progressEvent){},
    maxContentLength: 2000,
    validateStatus: function(status) {},
    maxRedirects: 5,
    httpAgent: new http.Agent({ keepAlive: true }),
    httspAgent: new https.Agent({ keepAlive: true }),
    proxy: {
        host: 127.0.0.1,
        port: 9000,
        auth: {
            username: 'proxy-name',
            password: 'password'
        }
    }
}
```

## 响应模式

```js
{
    data: {},
    status: 200,
    statusText: 'OK',
    headers: {},
    config: {},
    request: {}
}
```

## 错误对象

```js
error: {
    response: {
        data,
        status,
        headers
    },
    request,
    message,
    config,
}
```

## 继续研究

- [构建脚本](./scaffold.md)
- [utils.js](./utils.js.md)
- [helpers/*.js](./helpers.js.md)
- [axios.js](./axios.js.md)

## 参考资料

- https://github.com/axios/axios
  - https://github.com/axios/axios/tree/v0.16.2
- https://github.com/mzabriskie