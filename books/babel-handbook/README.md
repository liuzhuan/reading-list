# Babel Handbook

本手册分两部分：[用户手册][2]和[插件手册][3]。

## 用户手册

Babel 是一款通用的 JavaScript 编译器。

`babel-cli` 是一款命令行编译工具。首先，全局安装它：

```sh
$ npm install --global babel-cli
```

然后，就可以编译 JS 文件了：

```sh
# 默认把转译结果输出到终端
$ babel my-file.js

# 把结果输出到文件
$ babel example.js --out-file compiled.js
# 或者
$ babel example.js -o compiled.js

# 转译整个目录
$ babel src --out-dir lib
# 或者
$ babel src -d lib
```

TODO: Running Babel CLI from within a project

## 插件手册

TODO

## REF

1. [The Babel Handbook][1], by *James Kyle*

[1]: https://github.com/jamiebuilds/babel-handbook "The Babel Handbook"
[2]: https://github.com/jamiebuilds/babel-handbook/blob/master/translations/en/user-handbook.md "User Handbook"
[3]: https://github.com/jamiebuilds/babel-handbook/blob/master/translations/en/plugin-handbook.md "Plugin Handbook"