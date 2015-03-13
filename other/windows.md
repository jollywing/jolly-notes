
1. The better IME: QQ输入法纯净版

# 新的玩具：Windows上的awesome #

## 平铺式窗口管理器 ##

基于xwindow(Linux/Unix采用的图形系统)有成千上百种窗口管理器。其中有一类窗口管理器很古怪，所有应用程序的窗口没有互相遮挡，而是平铺到屏幕上，这类窗口管理器叫 平铺式窗口管理器。

比如我一直在用的 [Musca](http://www.baidu.com/link?url=Mvgiv9ayeg9J6IznonDXfXDLcWYp1Lej3x6-nkKQmUs0OddIYn_QZzfG2UnaYAxYM54cy4rMqdk9nYXGYe2PQK)，就是一个手动平铺的窗口管理器。

另外，awesome是Xwindows上中很受欢迎的动态平铺窗口管理器。其界面见下图。

http://a3.qpic.cn/psb?/d6b50afd-436a-40a2-83e1-44770cd906ec/x65771MRX8*GJ4c88qJE8C1iOe0KQ2i.hk9jzZs93Og!/b/dCfhHXDpDwAA&bo=AASAAgAAAAADAKM!&rf=viewer_4

左上角是一个打开的PDF文档，左下角是火狐浏览器，右边是vim编辑器。
三个应用程序互不遮挡，但把屏幕的所有空间都利用了。不禁让人想起麦肯锡的MECE原则，既互相独立，又完全穷尽。

Awesome不支持手动平铺，但Awesome有丰富的布局，多个虚拟桌面加不同布局也足够满足要求。

今天要介绍的主角 bug.n ，就是在windows上平铺窗口的软件，使用体验和awesome很像。

## bug.n ##

我在 [github](https://github.com) 上搜索 `tiling window manager for windows` ，发现了 [bug.n](https://github.com/fuhsjr00/bug.n).

把程序打包下载下来，双击bugn.exe，就进入了平铺窗口的模式。

先看一下我的窗口截图：

![](http://a3.qpic.cn/psb?/d6b50afd-436a-40a2-83e1-44770cd906ec/xe0aKAj3J6cQ6mcx2XnKYtjnT2jaVsmoCUUd1OER42k!/b/dDZHQHe5FQAA&bo=cgSAAgAAAAADB9Y!&rf=viewer_4)


值得一提的是，窗口顶端还有一个banner，显示的信息包括：

- 有几个虚拟桌面
- 当前虚拟桌面使用什么布局
- 活动窗口的标题
- 日期时间
- 如果是笔记本，还会显示电池状态
- 通过配置还可以监视CPU，内存的利用率以及网卡工作负载等。

这个banner使得bug.n更像是awesome.

和Xwindow上的窗口管理器类似，bug.n支持虚拟桌面。Windows系统只有一个桌面，但通过bug.n可以虚拟出很多桌面。如果你正在一个桌面上玩游戏或看碟，看到老板来了，你可以迅速切换到新的桌面。老板在任务栏上不会发现你娱乐过的蛛丝马迹。

通过按窗口键加数字，可以切换到第n个桌面。用鼠标直接点击banner上的虚拟桌面按钮也可以。
另外用鼠标右键点击某个虚拟桌面，会把当前的活动窗口送到那个虚拟桌面去。

每个桌面支持三种布局模式：

- 平铺模式(tiling): 所有窗口平铺，左边是主窗口，右边是窗口队列。按 Win+t 可以切换到tiling模式。
- 浮动模式(floating): 所有窗口浮动，可以互相遮盖，就是我们平常用的模式。按 win+f可以切换到floating模式。
- 全屏模式(monocle): 所有窗口最大化，一次只显示一个。按 Win+m 可以切换到 monocle 模式。

用鼠标右键点击banner上的布局按钮可以在这三种布局间切换。

bug.n 和同类的windows上的tiling wm相比，就是文档很全。

刚才我们下载的项目中有个 `doc` 目录，里面包括了全部markdown格式的文档。

可以看到默认的配置，默认的快捷键，也告诉你如何进行自己的配置。

我在win7上用bug.n，自己的配置写在 `C:\Users\Administrator\AppData\Roaming\bug.n\Config.ini` 中。
这里我也顺便把我的配置备份一下。

    Config_fontsize=12
    Config_readinCpu=1
    Config_readinMemoryUsage=1
    Config_readinInterval=10000
    Config_selBorderColor=0x000000ff

    Config_viewNames=Writing;Painting;Other
    Config_layoutMFactor=0.55
    Config_maintenanceInterval=300000

    Config_hotkey=!BackSpace::
    Config_backColor_#1=333333;;<COLOR_MENU>;;;;;;;;

    Config_rule=WebChat*;.*;;1;0;0;0;0;0;

2015-03-03 周二

# 虚拟桌面 #
虚拟桌面工具 mDesktop, dexpot
