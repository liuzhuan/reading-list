# node-http-proxy

`node-http-proxy` 是一个 HTTP 可编程的代理框架，支持 websockets。适合创建反向代理和负载均衡等组件。

## 核心概念

通过 `createProxyServer` 创建新的代理服务器。

```js
var httpProxy = require('http-proxy');
var proxy = httpProxy.createProxyServer(options);
```

返回的对象包含如下四个方法：

- `web(req, res, [options])` 用来代理普通的 HTTP(S) 请求
- `ws(req, socket, head, [options])` 用来代理 WS(S) 请求
- `listen(port)` 将对象封装为一个 web 服务器，方便调用
- `close([callback])` 关闭内部服务器，停止监听给定端口

用法如下：

```js
http.createServer((req, res) => {
  proxy.web(req, res, {
    target: 'http://mytarget.com:8080'
  });
});

// 使用 Event Emitter API 监听错误事件
proxy.on('error', function(e) {
  // do something awesome
});

// OR
// TODO: make more note
proxy.web()
```

## REF

- [http-party/node-http-proxy](https://github.com/http-party/node-http-proxy)