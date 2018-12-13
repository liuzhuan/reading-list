# How Browsers Work: Behind the scenes of modern web browsers 笔记

[online reading](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/), by *Tali Garsiel* and *Paul Irish*, 2011/08/05

[original site](http://taligarsiel.com/Projects/howbrowserswork1.htm)

以色列程序员 *Tali Garsiel* 详细描述了 WebKit 和 Gecko 的浏览器内部运行机制。[这里](https://vimeo.com/44182484)有她的演讲视频。

浏览器的主要作用是获取并显示资源。解析和展示规则由 HTML 和 CSS 规范说明，这些规范由 W3C 制定。

## 浏览器的高层结构

1. 用户界面
2. 浏览器引擎：协调用户界面和渲染引擎
3. 渲染引擎：用于展示请求的内容
4. 网络层
5. UI后端：用来绘制基本组件和窗口，与操作系统相关
6. JavaScript 解释器
7. 数据存储，包含 cookies, localStorage, indexedDB, WebSQL 和文件系统等

![browser high level structure](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/layers.png)

在 Chrome 中，每个标签页运行一个渲染引擎，各自独立进程。

## 渲染引擎

不同的浏览器使用不同的渲染引擎：

- IE：Trident
- Firefox: Gecko，译为壁虎
- Safari: Webkit，源自 Linux 平台，经苹果公司修改，支持 Mac 和 Windows
- Chrome & Opera(v15+): Blink, 一个 Webkit 分支

渲染引擎首先从网络层获取请求内容，基本上是 8kB 的数据块。然后，基本流程如下：

![rendering engine basic flow](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/flow.png)

渲染引擎开始解析 HTML 文档，转换为包含 DOM 节点的“内容树（*content tree*）”。引擎接着解析样式数据，包括外部 CSS 文件和內联样式。样式信息和 HTML 的结构指令，创建另一个树：渲染树（*render tree*）。

渲染树包含矩形，矩形拥有颜色、尺寸等视觉属性。渲染树构建完毕，进入布局（*layout*）流程，此时会赋予每个节点精确的屏幕位置。下一步就是绘制，遍历渲染树，使用 UI 后端绘制每个节点。

为了更好的用户体验，渲染引擎会尽早渲染页面。

以下是 Webkit 和 Gecko 的渲染引擎主流程示意图：

![Webkit main flow](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/webkitflow.png)

![Mozilla's Gecko rendering engine main flow](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image008.jpg)

Gecko 和 Webkit 流程大同小异，但术语有些差别。比如，Gecko 将视觉格式化的树称为“帧树（*frame tree*）”，元素就是帧。在 Webkit 中称为“渲染树”，由“渲染对象”组成。以下是两个引擎的术语对照表：

| Gecko        | Webkit        | 备注                                      |
| ------------ | ------------- | ----------------------------------------- |
| frame tree   | render tree   | 视觉格式化的元素树                        |
| frame        | render object | 树的单个节点                              |
| reflow       | layout        | 放置元素的过程                            |
| content sink | attachment    | 结合 DOM 节点和视觉信息，创建渲染树的过程 |

## 解析

解析是把代码解析为语法树的过程。解析基于语法规则，语法包含词汇和句法规则，名为上下文无关语法（*context free grammer*）。

解析可细分为两个步骤：

1. 词法分析：lexical analysis，将输入拆解为 token，由 lexer 执行
2. 句法分析：syntax analysis，语言句法规则的应用，由 parser 执行。

![from source document to parse trees](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image011.png)

很多时候，解析树并不是最终产品，解析经常是用于翻译。比如，编译就是将源代码翻译成机器码。

## 词汇和句法的正式定义

词汇通常用正则表达式定义：

```
INTEGER: 0|[1-9][0-9]*
PLUS: +
MINUS: -
```

句法通常使用 [BNF](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form) 定义。

> BNF: Backus normal form，一种标记 context-free grammers 的技术

```
expression := term operation term
operation := PLUS | MINUS
term := INTEGER | expression
```

有些工具可以自动生成解析器。Webkit 使用两个著名的解析器生成器：Flex 和 Bison。

## HTML 解析器

HTML 解析器的作用是将 HTML 标记语言解析为解析树。

HTML 不是一个 context-free grammer，因为它允许用户犯错。它使用 HTML DTD 定义语法规范。

解析器的输出是一棵 DOM 树，它是 HTML 文档对象的表示，也是外界操控 HTML 文档的界面。树的根节点是 Document 对象。

HTML 的解析算法在 [HTML5 规范](https://www.whatwg.org/specs/web-apps/current-work/multipage/parsing.html)中定义。大致流程如下：

![HTML parsing flow (taken from HTML5 spec)](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image017.png)

tokeniser 使用了状态机算法。

当解析结束后，浏览器会将文档标记为 interactive，开始解析标记为 `deferred` 模式的脚本。文档状态设定为 `complete` 并且抛出 `load` 事件。

完整算法可以查看[相应的 HTML5 规范](https://www.w3.org/TR/html5/syntax.html#html-parser)。

Webkit 纠错功能超强，代码注释会出现错误网站的例子。如果不想让你的网站出现在 Webkit 注释中，最好老老实实写格式正确的 HTML。

## CSS 解析

与 HTML 不同，CSS 是一个 context free grammar，其详细规范定义[在此](https://www.w3.org/TR/CSS2/grammar.html)。

Webkit 使用 Flex 和 Bison 自动产生 CSS 解析器。CSS 文件会被解析为一个 StyleSheet 对象，每个对象包含多条 CSS rules，CSS rule 包含选择器和声明对象，和其他相应的对象。

![parsing CSS](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image023.png)

## 脚本和样式的执行顺序

脚本会堵塞 HTML 的解析，除非指定了 `defer` 或 `async` 属性。

![async vs defer](http://www.thatjsdude.com/images/asyncVsDefer.jpg)

Webkit 和 Firefox 都有一种优化技术：*speculative parsing*。就是在执行脚本期间，另一线程会解析剩余文档，搜寻其中待下载资源，并下载。这样，可以并行下载资源，总体时间变短。注意：只解析外部资源，而不会修改 DOM 树。

## 构建渲染树

DOM 树构建完毕后，浏览器马上创建渲染树。这是文档的视觉表现。

渲染树的每个节点，Firefox 称作 frame，Webkit 称作 renderer 或 render object。

Webkit 的 RenderObject ，是所有 renderer 的基类，定义如下：

```c++
class RenderObject {
    virtual void layout();
    virtual void paint(PaintInfo);
    virtual void rect repaintRect();
    Node* node; // the DOM node
    RenderStyle* style; // the computed style
    RenderLayer* containgLayer; // the containing z-index layer
}
```

每个 renderer 对应相应节点的 CSS 盒。它通常包括 width, height, position 等几何信息。

盒类型受 `display` 类型影响。以下 Webkit 代码用来决定使用哪种 renderer：

```c++
RenderObject* RenderObject::createObject(Node* node, RenderStyle* style) {
    Document* doc = node->document();
    RenderArena* arena = doc-> renderArena();
    // ...
    RenderObject* o = 0;
    
    switch(style->display()) {
        case NONE:
            break;
        case INLINE:
            o = new (arena) RenderInline(node);
            break;
        case BLOCK:
            o = new (arena) RenderBlock(node);
            break;
        case INLINE_BLOCK:
            o = new (arena) RenderBlock(node);
            break;
        case LIST_ITEM:
            o = new (arena) RenderListItem(node);
            break;
            // ...
    }
    
    return o;
}
```

DOM Tree 和 Render Tree 的节点有对应关系，但并非一一对应。

![The render tree and the corresponding DOM tree](https://www.html5rocks.com/en/tutorials/internals/howbrowserswork/image025.png)

由于数据量大，数据结构复杂，嵌套层级很深，样式计算是个很复杂的过程。浏览器是如何解决这些问题的呢？

TODO