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
em      editor for mortals
en
ex      基于行的编辑器
vi      开创了区分模式的编辑
vim     vi improved
```

### 技巧27 结识Vim的命令行模式

出于历史原因，在命令行模式中执行的命令称作 Ex 命令。

可以用 Ex 命令读写文件（`:edit`, `:write`），创建新标签页（`:tabnew`）及分割窗口（`:split`），或是操作参数列表（`:prev/:next`）及缓冲区列表（`:bprev/:bnext`）。

一般来说，Ex 命令影响范围广且距离远。

### 技巧28 在一行或多个连续行上执行命令

```
:1      跳到第1行
:$      跳到最后1行
:'m     跳到包含位置标记 m 的行
:3p     打印第3行
:13d    删除第13行
:.p     打印当前行
:.,$p   打印当前行至末尾
:%p     打印当前文件所有行
```

Vim 还支持用模式指定范围：

```
:/<html>/,/<\/html>/p
```

模式可以指定偏移量：

```
:/<html>/+1,/<\/html>/-1p
```

### 技巧29 使用 `:t` 和 `:m` 命令复制和移动行

`:copy` 命令（`:t`）用于复制行，`:move` 用于移动行。

使用 `:h :copy` 查看复制的帮助文档。copy 命令的格式如下：

```
:[range]copy{address}

# example
:6copy. # 复制第6行，置于当前行之下
```

`:move` 命令看上去和 `:copy` 命令很相似：

```
:[range]move{address}
```

### 技巧30 在指定范围上执行普通命令

需使用 `:normal` 命令。配合 `.` 将十分强大。它的格式如下：

```
[range]normal{command}
```

### 技巧31 重复上一次的 Ex 命令

使用 `@:` 重复上一次的 Ex 命令。`:h @:`

### 技巧32 自动补全 Ex 命令

`<C-d>` 自动补全 Ex 命令。`:h c_ctrl-d`

### 技巧33 把当前单词插入到命令行

`<C-r><C-w>`

如果要查找替换，先用 `*` 查找指定的单词，然后使用 `cw{target}<Esc>`。然后输入替换命令：

```
:%s//<C-r><C-w>/g
```

### 技巧34 回溯历史命令

Vim 默认记录最后 20 条命令。可以修改 `history` 选项，提高其保存的上限。

```
:set history=200
```

命令历史不仅是为当前的编辑会话记录的，这些历史即使在退出 Vim 再重启后依然存在。`:h viminfo`。

除了 `<Up>` 和 `<Down>` 键外，也可以使用 `<C-p>` 和 `<C-n>` 组合键来反向或正向遍历历史命令。

输入 `q:`，结识命令行窗口。`:h cmdwin`

当处于命令行模式下，可以用 `<C-f>` 映射项切换到命令行窗口中。

### 技巧35 运行 Shell 命令

给命令增加一个叹号前缀（`:h :!`）就可以调用外部程序。

在 Vim 的命令行中，符号 `%` 代表当前的文件名（`:h cmdline-special`）。

Vim 也提供了一组文件名修饰符，可以从当前文件名中提取诸如文件路径或扩展名之类的信息（`:h filename-modifiers`）。

`!{cmd}` 这种语法适用于执行一次性命令。使用 `:shell` 命令可以启动一个交互的 shell 会话。用 `exit` 可以退出此 shell 并返回 Vim 。

使用 `:read !{cmd}` 把 `{cmd}` 的输出读入当前缓冲区中。（`:h read!`）

`:write !{cmd}` 做相反的事，它把缓冲区的内容作为指定 `{cmd}` 的标准输入（`:h :write_c`）。

叹号位置不同，含义也不同：

```
:write !sh      # 把缓冲区内容传给外部 sh 命令作为标准输入
:write ! sh     # 把缓冲区内容传给外部 sh 命令作为标准输入
:write! sh      # 写入名为 sh 的文件，若文件已存在，则强制覆盖
```

`:write !sh` 命令的作用是在 shell 中执行当前缓冲区的每行内容，查阅 `:h rename-files` 可看到该命令的一个绝佳示例。

TODO

## REF

1. [Tabs and Spaces][5], from vimcasts.org, explains what are `tabstop`, `softtabstop`, `shiftwidth` and `expandtab` for.

[1]: https://images-cn.ssl-images-amazon.com/images/I/41KDzTdYJWL.jpg
[2]: https://book.douban.com/subject/25869486/
[3]: https://book.douban.com/review/6725047/ "errata"
[4]: https://github.com/tpope "Tim Pope's Github"
[5]: http://vimcasts.org/transcripts/2/en/
[6]: http://vimcasts.org/episodes/tabs-and-spaces/
