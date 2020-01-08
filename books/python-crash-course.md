# Python编程：从入门到实践

![Book Cover][3]

## 第1章 起步

Python 是一门高级解释型语言。目前有 v2 和 v3 两个版本，但是 [CPython 核心开发小组已计划在 2020 年 4 月发布 v2.7 版本后停止更新 v2 系列][5]，v3 将成为唯一的推荐版本。这意味着以后将不用纠结使用哪个版本。

```py
print("Hello World!")
```

如果要获取 Python 解释器的完整路径：

```sh
$ type -a python3
```

## 第2章 变量和简单数据类型

变量是数据的容器。

变量名的使用规则：

1. 只能包含字母、数字和下划线。且不能以数字开头
1. 不能包含空格
1. 不能使用关键字
1. 应当简短且描述性强

字符串

```py
# 大小写转换
name = 'aDa lOVelace'
name.lower()
name.upper()
name.title()

# 字符串拼接
first = 'ada'
last = 'lovelace'
full = first + ' ' + last
message = 'Hello, ' + full.title() + '!'
print(message)      # => Hello, Ada Lovelace!

# 制表符和换行符
print('hello\tworld\n\tfoo\n\tbar')

# 剔除空格
foo = '  python  '
foo.lstrip()        # => 'python  '
foo.rstrip()        # => '  python'
foo.strip()         # => 'python'
foo                 # => '  python  '
```

数字类型

```py
# 整数乘方运算
3 ** 2      # => 9

# 浮点数
0.1 + 0.1   # => 0.2
0.1 + 0.2   # => 0.30000000000000004

# 除法
3/2         # => 1.5

# 使用 str() 把数字转换为字符串
age = 32
message = "Happy " + str(age) + "rd Birthday!"
print(message)
# => Happy 32rd Birthday!
```

注释使用 `#` 标示

```py
# This is a comment
```

Python 之禅，作者 *Tim Peters*

```py
import this

The Zen of Python, by Tim Peters

Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!
```

## 第3章 列表简介

TODO

## REF

1. [Python Crash Course][2], by *Eric Matthes*
1. [Python.org][4]

[1]: https://ehmatthes.github.io/pcc_2e/ "Home - Python Crash Course, 2nd Edition"
[2]: https://ehmatthes.github.io/pcc/ "Python Crash Course by ehmatthes"
[3]: https://ehmatthes.github.io/pcc/images/cover.jpg "Book Cover"
[4]: https://www.python.org/ "Welcome to Python.org"
[5]: https://www.python.org/psf/press-release/pr20191220/ "Python 2 Series To Be Retired By April 2020"
