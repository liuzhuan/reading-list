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

### 技巧4 执行、重复、回退。关键是任何步骤都可以撤销。

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

### 技巧8 把撤销单元切成块

删除一个单词，可以使用 aw 文本对象，`daw (delete a word)`。

`<C-a>` (`:h ctrl-a`) 和 `<C-x>` 分别对数字执行加减运算。

Vim 把以 0 开头的数字当作八进制。

操作符 operator 很强大，和动作 motion 一起，珠联璧合。

常见的操作符可以通过 `:h operator` 查看。

## 第3章 插入模式

在插入模式下，除了使用退格键删除光标前字符外，还可以使用如下组合键：

```
<C-h>   删除前一个字符（同退格键）
<C-w>   删除前一个单词
<C-u>   删至行首
```

返回普通模式的几种方法：

```
<Esc>   切换到普通模式
<C-[>   切换到普通模式
<C-o>   切换到插入-普通模式 (`:h i_ctrl-o`)
```

插入普通模式是普通模式的一个特例，让我们执行一次普通模式的命令，执行完后，马上又返回到插入模式。

比如，当前输入行位于屏幕首行或者末行，可以执行 `<C-o>zz`，重绘屏幕，把当前行居中显示，然后继续输入。这样就能看到更多的上下文。

### 技巧15 不离开插入模式，粘贴寄存器中的文本

这个命令的一般格式是 `<C-r>{register}`，其中 `{register}` 是我们想要插入的寄存器名字。如果要使用匿名寄存器，可以使用 `<C-r>0`。

### 技巧16 随时随地做运算

表达式寄存器允许我们做一些运算，并把结果回写入文档。使用 `=` 访问表达式寄存器。

比如，我们想知道 `42 * 42` 等于多少，可以运行 `<C-r>=42*42<CR>`。

Vim 的这个特性简直让人泪流满面 😭，太好用了！

### 技巧17 用字符编码插入非常用字符

在插入模式下运行 `<C-v>{code}` 即可，其中的 `{code}` 是要插入的编码。详情请见 `:h i_ctrl-v_digit`。

如果想知道文档中光标处字符的编码，使用 `ga` 即可。

### 技巧18 使用二合字母插入非常用字符

`<C-k>{char1}{char2}` 插入，使用 `:h digraph-table` 查看二合字母列表。

## 第4章 可视模式

Vim 有三种不同的可视模式：分别用于操作字符文本、行文本和块文本。

### 技巧21 选择高亮选区

进入可视模式的按键如下：

```
v       激活面向字符的可视模式
V       激活面向行的可视模式
<C-v>   激活面向列块的可视模式
gv      重选上次的高亮选区
```

使用 `o` 就可以切换选区的活动端点。

### 技巧23 只要有可能，最好用操作符命令，而不是可视命令

因为在可视模式下，`.` 命令有时会有一些异常表现。

比如，想把下面链接文字改为大写形式，

```html
<a href="#">one</a>
<a href="#">two</a>
<a href="#">three</a>
```

可以使用 `vit` 选中标签内文字，然后使用 `U` 转换为大写。当在第三行执行 `.` 命令，会发现 `three` 被转换为 `THRee`，而非期望的 `THREE`。这是因为可视模式下，运行 `.` 命令会重复上次的选中范围(`:h visual-repeat`)。

如果用操作符命令，可以使用 `gUit` 把当前行变为大写，然后在其他行使用 `.` 重复就行了。

## 第5章 命令行模式

Vim 家族源远流长，其谱系如下：

```
ed
ex      基于行的编辑器
vi      开创了区分模式的编辑
vim
```

### 技巧27 结识Vim的命令行模式

出于历史原因，在命令行模式中执行的命令称作 Ex 命令。

TODO

## REF

1. [Tabs and Spaces][5], from vimcasts.org, explains what are `tabstop`, `softtabstop`, `shiftwidth` and `expandtab` for.

[1]: https://images-cn.ssl-images-amazon.com/images/I/41KDzTdYJWL.jpg
[2]: https://book.douban.com/subject/25869486/
[3]: https://book.douban.com/review/6725047/ "errata"
[4]: https://github.com/tpope "Tim Pope's Github"
[5]: http://vimcasts.org/transcripts/2/en/
[6]: http://vimcasts.org/episodes/tabs-and-spaces/
