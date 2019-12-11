# Practical Vim 

![Book Cover][1]

中文名称《Vim 实用技巧》，作者 *Drew Neil*，在网站 http://vimcasts.org/about 中，他这么介绍自己：

> Drew Neil (aka @nelstrom) is an independent programmer, writer, and trainer. He runs workshops around the world, speaks regularly at conferences, and specializes in making educational screencasts.

本书的[豆瓣链接][2]。本书的英文 Slogan 是：

> Edit Text at the Speed of Thought

本书的译者杨源也在豆瓣，他给出了第一版和第二版的[勘误表][3]。本书的序作者 Tim Pope 是一个精力旺盛的程序员，他的 Github [在此][4]。

## 第1章 Vim 解决问题的方法

理想的编辑模式在于，**用一键移动，另一键执行**。

Vim 有很多单字符的操作命令，需勤加练习，形成肌肉记忆。

`f` 行内查找，`;` 重复上一次的行内查找, `s` 删除当前字符，并进入插入模式。最重要的是 `.` 重复上一次的修改动作。

技巧4 执行、重复、回退。关键是任何步骤都可以撤销。

除 `.` 可以重复上一次的修改命令，`@:` 还可以重复任意的 Ex 命令，`&` 来重复上次的 `:substitute` 命令。

以下是重复命令以及它相对的撤销命令：

```
.   u
;   ,
n   N
&   u
```

`*` 命令可以查找当前光标下的单词。`:set hls` 用来设置高亮显示。

## 第2章 普通模式 normal mode

技巧8 把撤销单元切成块

删除一个单词，可以使用 aw 文本对象，`daw (delete a word)`。

`<C-a>` (`:h ctrl-a`) 和 `<C-x>` 分别对数字执行加减运算。

Vim 把以 0 开头的数字当作八进制。

操作符 operator 很强大，和动作 motion 一起，珠联璧合。

常见的操作符可以通过 `:h operator` 查看。

## 第3章 插入模式

TODO

[1]: https://images-cn.ssl-images-amazon.com/images/I/41KDzTdYJWL.jpg
[2]: https://book.douban.com/subject/25869486/
[3]: https://book.douban.com/review/6725047/ "errata"
[4]: https://github.com/tpope "Tim Pope's Github"
