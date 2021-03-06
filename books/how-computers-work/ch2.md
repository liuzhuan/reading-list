# 试着制造一台计算机吧

## 制作微型计算机所必需的元件

1. CPU Z80 8比特
1. 内存 TC5517 2KB
1. I/O Z80 PIO 8比特 2个并口
1. 时钟发生器 2.5MHz
1. 指拨开关（DIP Switch） 输入 8比特
1. 按键开关 Push Switch
1. 快动开关 Snap Switch
1. LED 输出
1. 74367 三态总线缓冲器
1. 7404 六反相器
1. 开关式稳压电源 将220V 交流电变为 5V 直流电

## 电路图的读法

1. 判断电路交叉时，是否构成通路
1. 电源的表示方法
1. 如何数 IC 的引脚序号

## 连接电源、数据和地址总线

Vcc 和 GND 这一对儿引脚为 IC 供电。

为了指定输入输出数据时的源头或目的地，CPU上备有“地址总线引脚”。Z80 CPU 的**地址总线引脚**共有 16 个，用代号 A0～A15 表示。Z80 CPU 的**数据总线引脚**共有 8 个，用代号 D0～D7 表示。

## 连接 I/O

寄存器是位于 CPU 和 I/O 中的数据存储器。Z80 PIO 上共有 4 个寄存器。2 个用于设定 PIO 本身的功能，2 个用于存储与外部设备进行输入输出的数据。

这4个寄存器分别叫作端口 A 控制、端口 A 数据、端口 B 控制和端口 B 数据。

Z80 CPU 的 A8～A15 地址总线引脚尚未使用，所以什么都不连接。在电路图中可以用代号 NC（No Connection，未连接）表示引脚什么都不连接。

## 连接时钟信号

为了传输时钟信号，就需要把时钟发生器的  8号引脚和 Z80 CPU 的 CLK （CLK即Clock，时钟）引脚、Z80 PIO 的 CLK 引脚分别连接起来。时钟发生器的 8 号引脚与 +5V 之间的电阻用于清理时钟信号。

## 连接用于区分读写对象是内存还是 I/O 的引脚

为了区分 CPU 的读写对象是内存还是 I/O，需要使用 Z80 CPU 上的 MREQ（即 Memory Request，内存请求）引脚和 IORQ （即 I/O Request, I/O 请求）。当 Z80 CPU 和内存之间有数据输入输出时，MREQ 引脚上的值是 0，反之则是 1。当 Z80 CPU 和 I/O 之间有数据输入输出时，IORQ 引脚上的值是 0，反之则是 1。

若把 TC5517 的 CE（即Chip Enable，选通芯片）引脚设成 0，则 TC5517 在电路中被激活，若设成 1 则从电路中隔离，因为此时 TC5517 进入了高阻抗状态。

在 Z80 PIO 中，则是通过将 CE 引脚和 IORQ 引脚同时设为 0 或 1，来达到与 TC5517 的 CE 引脚相同的效果。

对内存和 I/O 而言，还必须要分清 CPU 是要输入数据还是输出数据。为此就要用到 Z80 CPU 的 RD 引脚（即Read，表示输入，为0时执行输入操作）和 WR 引脚（即Write，表示输出，为0时执行输出操作）了。

## 连接剩余的控制引脚

把 Z80 CPU 的 M1 引脚（即Machine Cycle 1，机器周期1）和 INT 引脚（即Interrupt，中断）与 Z80 PIO 上标有相同代号的引脚连接起来。M1 是用于同步的引脚，INT 引脚是用于从 Z80 PIO 向 Z80 CPU 发出中断请求的引脚。

一旦把 Z80 CPU 的 RESET 引脚（即Reset，重置）上的值先设成 0 再还原成 1, CPU 就会被重置，重新从内存 0 号地址上的指令开始顺序往下执行。

如何用开关输入 0 或 1。

总线是连接到CPU中数据引脚、地址引脚、控制引脚上的电路的统称。

若将 BUSRQ 引脚（即 Bus Request，总线请求）的值设为 0，则 Z80 CPU 从电路中隔离。当处于这种隔离状态时，就可以不通过 CPU，手动地向内存写入程序了。像这样不经过 CPU 而直接从外部设备读写内存的行为叫作 DMA（Direct Memory Access，直接存储器访问）。

当 Z80 CPU 从电路中隔离后，BUSAK 引脚（即Bus Acknowledge，响应总线请求）上的值就会变成0。也就是说，把 BUSRQ 引脚上的值设成0以后，还要确认 BUSAK 引脚上的值已经变成了0，然后才能进行DMA。

把 BUSAK 引脚分别连接到 4 个 74367 的 G1 和 G2 引脚上。

上拉（Pull-up），指的就是通过加入电阻把元件的引脚和 +5V 连接起来。

Z80 PIO 的 PA0～PA7（PA表示Port A）以及 PB0～PB7（PB表示PortB）用于与外部设备进行输入输出，所以稍后要把它们分别连接到指拨开关和 LED 上。

## 连接外部设备，通过 DMA 输入程序

74367 是一种叫作“三态总线缓冲器”的 IC。在这个 IC 的电路图符号中，有用三角形标志代表的缓冲器，表示使电信号从右向左直接通过。但是，只有在 74367 的 G1 引脚和 G2 引脚同时为 0 的时候，电信号才能通过。而当 G1 引脚和 G2 引脚同时为 1 时，74367 就会与电路隔离。

## 连接用于输入输出的外部设备

LED 要通过 7404 这样的 IC 连接到 Z80 PIO 的 PB0～PB7 引脚上。在 7404 的电路图符号中，末端带有一个小圆圈的三角形符号表示反相器，作用是将左侧输入的电信号反转后（即0变1、1变0）输出到右侧。通过这样的设计，当 Z80 PIO 的 PB0～PB7 引脚上的值为 0 时 LED 就会熄灭，为 1 时 LED 就会点亮。

点亮 LED 的方法。

## 输入测试程序并进行调试

作为计算机大脑的 CPU 只能解释执行一种编程语言，那就是靠罗列二进制数构成的机器语言（原生代码）。

接通了微型计算机的电源后，请按下 Z80 CPU 上的 DMA 请求开关。在这个状态下，拨动用于输入内存程序和指定内存输入地址的两个指拨开关，把代码程序一行接一行地输入内存。

所有的指令都输入完成后，按下用于重置 CPU 的按键开关，控制 DMA 请求的快动开关就会还原成关闭状态，与此同时程序也就运行起来了。