# 网络知识笔记 #

通信中产生和发送信息的一端叫做信源，接收信息的一端叫做信宿，信源和信宿之间的通信线路称为信道。

模拟信道的带宽是指信道能够传输的最高带宽减去信道能够传输的最小带宽。

数字信道的带宽是指能不失真地传输的脉冲序列的最高速率。

信道延迟就是指信号从源端到宿端需要的时间。

网络中交换节点转发信息的方式分为电路交换、报文交换和分组交换。电路交换的特点是一旦在一条通道上建立了连接，其他的通信就不能在占用这条通道，直到当前通信结束信道才能重新分配。电话交换系统就是这种方式。报文交换不要求建立专用通路，这种网络叫做存储转发网络；由于要转发的报文长短不一，交换节点需要维护较大的缓冲区。电子邮件系统可以使用报文交换。分组交换类似于报文交换，但是分组交换中对信息进行打包分组，加上分组号（用以恢复乱序接收到的报文的顺序），报文大小是固定的，因此交换节点只需要很小的缓冲区。另外分组交换有数据报和虚连接两种方式，数据报类似于udp的传输方式，虚连接是在通信前要在节点之间建立逻辑连接，类似于tcp的通信方式。广域网通信多使用分组交换。

环形网络是由一系列首尾相接的中继器组成，每个中继器连接一个工作站。中继器是个简单的设备，它能从一端接收数据，从另一端发送数据。整个环路是单向传输的。

星形拓扑是所有的节点连接到一个集线器上，集线器(hub)的工作原理是从一个站信息，然后向其它站广播信息。

网络互联设备从概念上可以分为：中继器，网桥，路由器和网关。 中继器用于延长网络传输距离，对接收到的信号进行再生和转发，工作在物理层。可以连接不同的介质，只要物理层之上的协议相同。
网桥用于连接两个网段的子网，工作于数据链路层。它通过分析帧的源地址和目标地址把不同网段的帧转发到另一个子网上。网桥实际上就是工作在mac层，mac层之上协议相同的子网都可以通过网桥互联。
路由器工作在网络层。
网关用于连接网络层之上执行不同协议的子网，它负责对互不兼容的上层协议进行转换。

## 网络延迟 ##

> # William Stallings. Computer Networking with Internet Protocols and Technology. Prentice Hall.

将数据从一个系统通过网络传输到另一个系统的延迟有四个组成部分：

- 传输延迟（transmission delay）：发送方发出数据包所有位需要的时间。 等于数据大小除以链路速率。
- 传播延迟（propagation delay）：1位数据从源到目标需要的时间， 等于距离除以信号传播速度。
- 处理延迟（processing delay）：源、目标、中间系统（路由器等） 处理数据包所需的时间。
- 排队延迟（queuing delay）：在路由过程中任何一处的队列中等待所花费的时间。

如果传输的数据很小，传播延迟就是延迟的主要组成部分；否则可以忽略。 中间系统（路由器等）的负载较高时，排队延迟会有比较明显的上升。

## 计算网络地址和广播地址 ##

一台主机ip为202.112.14.137， 子网掩码：255.255.255.224/27，计算其网络地址和广播地址。

解析：
子网掩码255.255.255.224/27表示有27个1。因为224的二进制表示是1110 0000。
由此可知，该网络可以容纳32个IP地址。
看二进制是一种方法，用256 - 224也可以得知该网络可以容纳32个IP。

根据224的二进制表示主机位为5位（5个0）。主机位全0时为网络地址，网络地址即网络的开始地址。
137的二进制表示是1000 1001，其后5位全0为1000 0000，即128为网络地址。

广播地址：TCP/IP协议规定，主机号各位全为“1”的IP地址用于广播。
广播地址是子网的最后一个IP。主机位全1。把137的后5位全变成1，得到10011111。
广播地址为202.112.14.159。

答案：网络地址为202.112.14.128, 广播地址为202.112.14.159。

## 可用IP问题 ##
一个子网掩码为255.255.255.240。有几个IP可分配给子网内的主机。

解析：
256 - 240 = 16。所以该子网有16个IP可用。
但最小的IP要用作网络地址，最大的IP要用作广播地址，还有一个地址要分配给网关。
网关地址通常用第二个或倒数第二个。
所以该子网共有 16 - 1 - 1 - 1 = 13个IP可以分配给主机。

## 计算子网掩码 ##

一个子网有14台主机，子网掩码应设为多少？

解析：
除了14台主机，另外需要3个IP（一个网络地址，一个广播地址，一个网关地址）。
共需要17个地址。主机位至少需要5。二进制 1110 0000 是224。
所以子网掩码应该是 255.255.255.224。
