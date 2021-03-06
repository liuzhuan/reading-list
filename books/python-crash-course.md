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

列表由一系列按顺序排列的元素组成。

```py
bicycles = ['trek', 'cannondale', 'redline', 'specialized']
```

使用索引值访问列表元素。注意，索引值从 0 开始。

```py
# 访问第一个元素
bicycles[0]         # => 'trek'

# 访问第三个元素
bicycles[2]         # => 'redline'

# 访问最后一个元素
bicycles[-1]        # => 'specialized'

# 访问倒数第二个元素
bicycles[-2]        # => 'redline'
```

修改、添加和删除元素

```py
motors = ['honda', 'yamaha', 'suzuki']
motors[0] = 'ducati'
motors
# => ['ducati', 'yamaha', 'suzuki']

# 添加元素 append
motors = ['honda', 'yamaha', 'suzuki']
motors.append('ducati')
motors
# => ['honda', 'yamaha', 'suzuki', 'ducati']

# 插入元素 insert
motors = ['honda', 'yamaha', 'suzuki']
motors.insert(0, 'ducati')
motors
# => ['ducati', 'honda', 'yamaha', 'suzuki']

# 如果知道索引值，使用 del 删除列表元素
del motors[0]

# 如果删除的索引值超出合理范围，则报错
del motors[100]

Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: list assignment index out of range

# 如果要使用删除的值，使用 pop() 删除元素
motors = ['honda', 'yamaha', 'suzuki']
result = motors.pop()
print(result)       # => suzuki
print(motors)       # => ['honda', 'yamaha']

# 可以使用 pop 弹出任意位置的元素
motors = ['honda', 'yamaha', 'suzuki']
result = motors.pop(1)
print(result)       # => yamaha
print(motors)       # => ['honda', 'suzuki']

# 如果知道待删除的值，可以使用 remove() 方法
motors = ['honda', 'yamaha', 'suzuki', 'ducati']
print(motors)
motors.remove('ducati')
print(motors)
# => ['honda', 'yamaha', 'suzuki', 'ducati']
# => ['honda', 'yamaha', 'suzuki']

# remove() 只删除第一个值
motors = ['honda', 'yamaha', 'suzuki', 'honda']
print(motors)
motors.remove('honda')
print(motors)

# => ['honda', 'yamaha', 'suzuki', 'honda']
# => ['yamaha', 'suzuki', 'honda']
```

### 3.3 组织列表

TODO

## 第8章 函数

函数是带名字的代码块，可以反复调用。

```py
def greet_user():
    """Print simple greeting words"""
    print('Hello!')
```

紧随函数名之后，三个引号扩起来的文本叫做文档字符串（docstring），用来描述函数是做什么的。

向函数传递参数

```py
def greet_user(username):
    print('Hello, ' + username.title() + '!')
```

位置实参

```def
def pet(animal, name):
    print('I have a ' + animal + '.')
    print('My ' + animal + '\'s name is ' + name.title() + '.')

pet('hamster', 'harry')
```

TODO

## 第11章 测试代码

unittest 模块可用于测试代码。

**name_function.py**

```py
def get_formatted_name(first, last):
    full_name = first + ' ' + last
    return full_name.title()
```

**test_name_function.py**

```py
import unittest
from name_function import get_formatted_name

class NamesTestCase(unittest.TestCase):
    def test_first_last_name(self):
        formatted_name = get_formatted_name('janis', 'joplin')
        self.assertEqual(formatted_name, 'Janis Joplin')

unittest.main()
```

运行 `test_name_function` 时，所有以 `test` 开头的方法都将自动执行。

`assertEqual` 是一个断言方法，用来核实实际结果和期望值一致。

### 11.2 测试类

unittest 常用的断言方法：

- `assertEqual(a, b)`
- `assertNotEqual(a, b)`
- `assertTrue(x)`
- `assertFalse(x)`
- `assertIn(item, list)`
- `assertNotIn(item, list)`

**survey.py**

```py
class AnonymousSurvey():
    def __init__(self, question):
        self.question = question
        self.responses = []

    def show_question(self):
        print(self.question)

    def store_response(self, new_response):
        self.responses.append(new_response)

    def show_results(self):
        print('Survey results:')
        for response in self.responses:
            print('- ' + response)
```

## REF

1. [Python Crash Course][2], by *Eric Matthes*
1. [Python.org][4]

[1]: https://ehmatthes.github.io/pcc_2e/ "Home - Python Crash Course, 2nd Edition"
[2]: https://ehmatthes.github.io/pcc/ "Python Crash Course by ehmatthes"
[3]: https://ehmatthes.github.io/pcc/images/cover.jpg "Book Cover"
[4]: https://www.python.org/ "Welcome to Python.org"
[5]: https://www.python.org/psf/press-release/pr20191220/ "Python 2 Series To Be Retired By April 2020"
