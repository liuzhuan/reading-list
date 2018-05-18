# `./lib/helpers/*.js`

这个库下面对文件都是一些通用函数，与 `axios` 的领域非强相关。按照功能可以将其分为三类：

- 浏览器腻子脚本
- 管理 cookie
- 解析 HTTP 请求头

基本上每个文件输出一个函数，下面是对其中函数的简要介绍：

| 函数所在文件 | 简介 |
| --- | --- |
| `bind(fn, thisArg)` | 相当于 `Function.prototype.bind` |
| `btoa(input)` | ... |
| `buildURL(url, params, paramsSerializer)` | ... |
| `combineURLs(baseURL, relativeURL)` | ... |
| **cookie.js** | ... |
| `deprecatedMethod(method, instead, docs)` | ... |
| `isAbsoluteURL(url)` | ... |
| **isURLSameOrigin.js** | ... |
| `normalizeHeaderName(headers, normalizedName)` | ... |
| `parseHeaders(headers)` | ... |
| `spread(callback)` | ... |

## 参考资料

- https://github.com/axios/axios/tree/v0.16.2/lib/helpers
- https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/btoa