# icindy/wxParse

https://github.com/icindy/wxParse

wxParse - 微信小程序富文本解析自定义组件，支持 HTML 及 markdown 解析。

本次代码解析基于 `4dc822`。

库文件入口是 `wxParse/wxParse.js`

## `wxParse/wxParse.js`

导入 `showdown.js` 和 `html2json.js`。

首先定义变量 `realWindowWidth` 和 `realWindowHeight` 并初始化，接着使用 `wx.getSystemInfo` 获取微信小程序可使用窗口的宽高尺寸。

## `wxParse/showdown.js`

`showdown.js` 来源于 [showdownjs/showdown](https://github.com/showdownjs/showdown)，是一个 `Markdown` 到 `HTML` 的转换器。`showdownjs/showdown` 是一个很庞大的代码库，需要单独阅读。

## `wxParse/html2json.js`

改造自 [Jxck/html2json](https://github.com/Jxck/html2json)，作用名副其实。`html2json` 依赖于 [blowsie/Pure-JavaScript-HTML5-Parser](https://github.com/blowsie/Pure-JavaScript-HTML5-Parser)，即 `wxParse/htmlparser.js`。

## `wxParse/wxDiscode.js`

这是一个特殊字符转义符转化工具类。可以将 HTML 支持的数学符号、希腊字母和其他实体字符转换为原始字符。

包括的函数有：`strNumDiscode`, `strGreeceDiscode`, `strcharacterDiscode`, `strOtherDiscode`, `strMoreDiscode`, 以上这些函数都为 `strDiscode` 所调用。

`urlToHttpUrl` 回判断 `url` 是否以 `//` 开头，若是，则增加 `rep` 协议头。