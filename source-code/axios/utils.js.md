# `./lib/utils.js`

`utils.js` 有很多工具函数，大部分用来检测数据类型。简要介绍如下：

| 函数名 | 简介 |
| --- | --- |
| `isArray` | 是否数组 |
| `isArrayBuffer` | 是否 ArrayBuffer |
| `isBuffer` | ... |
| `isFormData` | 是否表单数据 |
| `isArrayBufferView` | ... |
| `isString` | ... |
| `isNumber` | ... |
| `isObject` | ... |
| `isUndefined` | ... |
| `isDate` | ... |
| `isFile` | ... |
| `isBlob` | ... |
| `isFunction` | ... |
| `isStream` | 是否数据流 |
| `isURLSearchParams` | ... |
| `isStandardBrowserEnv` | 是否标准浏览器（非 web works 或 ReactNative） |
| `forEach(obj, fn)` | 可以对 `Array` 或 `Object` 循环处理 |
| `merge([obj1, obj2, ...])` | 相当于 `Object.assign()` |
| `extend(a, b, thisArg)` | 用 `b` 的属性拓展 `a` |
| `trim(str)` | 删除首尾空格 |

## 参考资料

- https://github.com/axios/axios/blob/v0.16.2/lib/utils.js