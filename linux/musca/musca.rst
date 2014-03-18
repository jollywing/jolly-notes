
====================================
平铺式窗口管理器musca初体验
====================================

:作者: 吴吉庆
:email: jiqingwu@gmail.com
:mainpage: http://hi.baidu.com/jiqing0925
:version: 1.0
:release: 2009-11-04
:update:  2009-11-04

.. contents:: 目录

为什么用平铺式窗口管理器？
======================================

什么是平铺式窗口管理器（tiling window manager）？
顾名思义，就是窗口都在屏幕上平铺开，
窗口与窗口之间没有重叠。
像我们通常用的窗口管理器，如gnome中的metacity，
KDE中的kwin，以及轻量级的fvwm，openbox等，
都是浮动式窗口管理器，窗口与窗口互相重叠，
窗口管理器管理这些窗口时用一个类似堆栈的结构，
所以这类窗口管理器也叫栈式窗口管理器。

随着显示器的增大和人们对工作效率的追求，
平铺式窗口管理器越来越受到重视，
因为它不需要用户花太多精力调整窗口的大小和位置，
最主要的它可以节省用户的脑细胞，比如你在电脑上读书做笔记时，
用平铺式窗口管理器就可以左边打开电子书，
右边打开一个文本编辑器。
如果你要抄写书上的内容，你就不需要来回切换窗口。
这种平铺不需要你费力调整，自然而然地最大化利用桌面空间。

我想，能读到这里，喜欢平铺式窗口管理器的会继续读下去，
没兴趣的可以去做其它事了。

闲话少说，讲讲主角musca吧。

为什么选中musca？
==========================================

对平铺式窗口管理器有兴趣的同学肯定已经接触过一些平铺式窗口管理器了，
比如larsWm、dwm、wmii、ion、xmonad，以及最近流行的awesome。
从维基百科上看windows在1.0时也是平铺式窗口管理，
之后才一直使用浮动式的窗口管理。

这么多窗口管理器为什么偏偏选中musca呢？

要说清这个问题先要说说帧的概念，
一般平铺式窗口管理器会把整个屏幕划分成若干个矩形，
每个矩形就叫做帧（frame），在帧里放各个应用程序的窗口。

细心的用户可能会发现，有的窗口管理器会提供一个或几个基本的帧布局，
当用户启动新的应用程序时，不需要手动生成帧，
窗口管理器会自动生成一个帧存放这个应用程序，
并根据设定的布局自动地摆放帧。一般每种布局都有一个主帧，
新启动的应用程序会放在主帧中。
这种平铺式窗口管理器叫做 **动态平铺式窗口管理器** 
（dynamic tiling window manager）。
如larswm、dwm、wmii、awesome都属于这种。
xmonad我没有体验过，应该也属于这种动态的平铺式窗口管理器。
如有错误请朋友之争。

另一种平铺式窗口管理器叫做 **手动平铺式窗口管理器** (manual tiling
window manager)。
用这种平铺式窗口管理器时，窗口管理器不会自动生成帧，
用户需要手动分割现有的帧。这种手动分割其实并不麻烦，
而且使用户摆脱了布局的限制，窗口可以任意分割，
可以生成任意的帧布局，因此具有更大的灵活性。
这种窗口管理器包括ion、ratpoison（老鼠药）、musca等。

说到这，大家应该明白了，我为什么忽略awesome了，
只是因为我不喜欢dynamic tiling，而且awesome 3编译比较困难，
依赖的东西很多。
我喜欢manual tiling的那种自由，这是个见仁见智的问题，
喜欢dynamic tiling的朋友可以不再往下读了，
我写这篇文章的目的一个是自己做个笔记，另外是与同样喜欢
manual tiling的朋友分享。

以前一直用ubuntu源里的ion2的，其它方面我都很满意，
就是它对临时性窗口和对话窗口的浮动支持很差。
不知道ion3这个改进得怎么样了。我准备安装ion3时，
发现ion3有复杂的依赖，有向重量级发展的趋势，就望而却步了。
而且听说很多人因为它新的授权许可不怎么样，于是决定放弃ion。

老鼠药ratpoison我尝试了，很轻量级，但是完全不支持浮动窗口，
在它下面用gimp就扯了。
当然你可以通过tmpwm命令临时用别的窗口管理器，
但这种对别的窗口管理器的依赖让人很不爽。
所以我也放弃了ratpoison。

直到遇见了musca，才算遇到了比较中意的一个，
它支持手动分屏、多个桌面，对话窗体都是浮动的。
而且可以通过快捷键在tiling模式和stacking模式（即浮动窗口模式）之间切换。
很方便。

musca是什么意思？好像是一种苍蝇。我更喜欢叫它 `莫斯科` 。
下面是一个我在使用musca的截图，大家也可以在网上找更漂亮的。

.. image:: 091104-musca.jpg


下表是各种平铺式窗口管理器的比较（参考了 archwiki_ ）：

=============  ==========  =============== ========== ===========  ===========================  ================
窗口管理器      开发语言    配置语言        平铺方式   系统托盘     使用中重新载入配置          信息栏
=============  ==========  =============== ========== ===========  ===========================  ================
awesome         c           lua             dynamic    内置         是                          内置，支持
dwm             c           c，需重新编译   dynamic    无           可选                        内置
scrotwm         c           text            dynamic    无           是                          内置
wmii            c           anything?       dynamic    无           是                          内置
xmonad          haskell     haskell         dynamic    无           是                          无
musca           c           c和musca命令    manual     无           否，但能通过musca命令配置   无
ion3            c           lua             manual     trayion      是                          可配置
ratpoison       c           text            manual     无           是                          是，需要时显示
stumpwm         lisp        lisp            manual     无           是                          是
subtle          c           ruby            manual     内置         是                          内置(ruby)
=============  ==========  =============== ========== ===========  ===========================  ================

.. _archwiki: http://wiki.archlinux.org/index.php/Comparison_of_Tiling_Window_Managers


安装Musca
======================================

我一直在用Ubuntu 8.04，所以源里没有Musca，
于是我到 musca的主页_ 下载了musca的源码编译安装，
目前稳定的版本是 0.9.24。

除了运行时依赖dmenu，Musca几乎没有什么依赖，所以编译安装非常简单，
解压源代码后，可以发现源码文件数量也很少。
Makefile有现成的，所以直接make即可。
应该100%成功。
然后将生成的执行文件放入/usr/local/bin。

这样就可以使用musca了。
在你的.xinitrc中加入 ``exec musca`` 。
然后startx就进入了musca。


Musca基本使用
=====================================

在讲述使用之前，先讲一点musca的窗口组织概念。


musca中的窗口组织概念
----------------------------------

- 在屏幕中分割出的矩形叫帧。
- 一个虚拟桌面中的程序窗口叫做 **窗口组** 。
- 一个窗口组中的窗口可以多于这个虚拟桌面的帧数。
- 通过按快捷键一个窗口组中隐藏的窗口可以轮流在选定的帧中显示。


musca中默认键绑定
-----------------------------------

Musca默认的键绑定使用起来比较舒服。默认的Mod键是Mod4，也就是左窗口键。
（我的右窗口键也可以）。

在下表中，M代表Mod键，S代表Shift，C代表Control。


========== =================   ============================================================================
Keys        Command              Action
========== =================   ============================================================================
M+m         command             通过dmenu运行musca命令
M+h         hsplit 1/2          将选定帧纵剖成两个垂直帧
M+v         vsplit 1/2          将选定帧横切成两个水平帧
M+r         remove              移除当前帧   
M+o         only                移除其他帧，当前帧最大化
M+u         undo                还原为刚才的帧布局
M+d         dedicate flip       (toggle)选定帧给当前的应用程序专用
M+a         catchall flip       (toggle)设定选定帧为catchall，所有新打开的应用窗口都出现在该帧
M+Left      focus left          聚焦左侧的帧
M+Right     focus right         聚焦右侧的帧
M+Up        focus up            聚焦上面的帧
M+Down      focus down          聚焦下面的帧
M+C+Left    resize left         调整当前帧的水平大小
M+C+Right   resize right        调整当前帧的水平大小
M+C+Up      resize up           调整当前帧的垂直大小
M+C+Down    resize down         调整当前帧的垂直大小
M+t         exec xterm          启动一个xterm，你可以把别的终端链接为xterm
M+x         shell               通过dmenu启动应用程序
M+w         switch window       通过dmenu切换当前组中的窗口
M+k         kill                按一次礼貌的关闭应用，按两次强制关闭
M+c         cycle               在当前帧中循环显示隐藏的窗口
M+S+Left    swap left           将当前帧中的窗口与左侧帧中的窗口交换
M+S+Right   swap right          将当前帧中的窗口与右侧帧中的窗口交换
M+S+Up      swap up             将当前帧中的窗口与上面帧中的窗口交换
M+S+Down    swap down           将当前帧中的窗口与下面帧中的窗口交换
M+g         switch group        通过dmenu切换窗口组（类似于虚拟桌面）
M+PageUp    use (prev)            切换到上一个窗口组
M+PageDn    use (next)            切换到下一个窗口组
M+s         stack flip          (toggle)将当前组在tiling和stacking模式间切换
M+Tab       screen (next)         切换到下一个可用的屏幕
========== =================   ============================================================================

.. _musca的主页: http://aerosuidae.net/musca/Musca_Window_Manager

Java程序的bug
-----------------------------------

一些java的图形程序可能运行有些不正常。其实这和musca没有关系，
是Sun java在1.5之后违反了ICCCM兼容协议，
所以一些使用XToolkit/XAWT的程序可能运行异常。
这个问题的解决方法是设定环境变量AWT_TOOLKIT=MToolkit，
即让它使用较老的motif风格。

我在我的.bashrc中加入了这一行：

::
 
  AWT_TOOLKIT=MToolkit

我知道不少awesome的用户也为一些java程序苦恼，
试试这个方法能不能解决你们的问题。


更熟练地玩Musca
====================================

下面的内容主要是参考了 musca的主页的文档_ 。

.. _musca的主页的文档: http://aerosuidae.net/musca/Documentation


我们不仅可以通过快捷键控制musca，更可以通过musca的命令控制musca。
把命令传递给musca的一种方式是Mod + m，可以通过dmenu输入musca命令让
musca执行。

另一种方式是直接在终端中输入
``musca -c 'xxx'`` ，让musca执行xxx，其中xxx就是musca命令。

我们为什么要了解musca命令，因为我们可以在musca启动时让musca执行一些命
令，从而定制musca。

Musca的命令一览
---------------------------------

==========================================   ======================================================================================
command                                          用途
==========================================   ======================================================================================
add <name>                                      增加一个窗口组，并切换到它
alias <name> <command>                          产生一个musca命令别名
bind <on|off> <Modifier>+<Key> <command>        添加(on)或清除(off)键绑定，只有on需要command参数。 bind off all将清除所有键绑定
border <on|off>                                 当前帧是否显示边。
catchall                                        当前帧是否为catchall
client hints <on|off>                           对于当前应用窗口是否遵从X尺寸提示。
command                                         启动dmenu等待musca命令输入
cycle <local> <next|prev>                       循环显示隐藏窗口于当前帧，所有选项可选
dedicate <on|off>                               (toggle)是否把当前帧给当前应用程序专用。
drop <name|number>                              通过名称或编号删除一个窗口组
dump <file>                                     把描述（当前组名和帧布局）导出到指定文件
exec <command>                                  执行一个shell命令
focus <left|right|up|down>                      聚焦左/右/上/下面的帧
lfocus|rfocus|ufocus|dfocus                     聚焦左/右/上/下面的帧
height <relative|pixel>                         指定当前帧的高度，可以是像素或xx%
hook <on|off> <pattern> <command>               绑定一个musca命令到任何匹配模式的musca命令
hsplit <relative|pixel>                         水平分割。
kill <number|name>                              如果给出number或name，会关闭对应的应用，否则关闭当前帧
load <file>                                     导入一个描述文件到当前窗口组
manage <on|off> <name>                          对应名称的窗口类是否被musca管理
move <name|number>                              移动当前窗口到指定编号或名称的窗口组中。
name <name>                                     重新命名当前的窗口组中
only                                            移除其它帧，当前帧最大化
pad <left> <right> <top> <bottom>               设定当前组使用的屏幕范围
quit                                            退出musca
raise <number|title>                            提升并聚焦指定编号或标题的窗口
refresh                                         刷新当前帧
remove                                          移除当前帧
resize <left|right|up|down>                     向指定方向重新设定帧的大小
run <file>                                      运行一个包含musca命令的文件，每行一个命令
say <text>                                      用'notify'中设定的方法显示文本
screen <number>                                 切换到指定编号的屏幕。
set <setting> <value>                           设定musca变量的值
shell                                           启动dmenu等待musca命令输入
show <settings>                                 显示musca变量的值，在后台show时，最好加silent，如silent show xxx
show <bindings>                                 显示键绑定
show <unmanaged>                                显示不受管理的窗口类
show <hooks>                                    显示命令触发器
show <groups>                                   显示窗口组
show <frames>                                   显示所有帧
show <windows>                                  显示所有窗口
show <aliases>                                  显示命令别名
shrink <name|id>                                最小化一个窗口，用raise <name|id>可以恢复该窗口
slide <left|right|up|down>                      将当前窗口移动到指定方向的帧
lslide|rslide|uslide|dslide                     将当前窗口移动到指定方向的帧
stack <on|off|flip>                             将当前组在tiling和stacking模式间切换
swap <left|right|up|down>                       将当前窗口与指定方向帧中的窗口交换
lswap|rswap|uswap|dswap                         将当前窗口与指定方向帧中的窗口交换
switch <window|group>                           启动dmenu的窗口切换或组切换
undo                                            还原为上一个帧布局
use <name|number|(other)|(prev)|(next)>         通过名称或编号切换组。
vsplit <relative|pixel>                         垂直分割当前帧。
width <relative|pixel>                          设定当前帧的宽度。
==========================================   ======================================================================================

Musca的启动定制
----------------------------------

Musca启动时可以读取一个存放musca命令的文件，并执行这些命令。
每条命令一行，允许空行，注释行以 `#` 开头。

musca启动时默认读取启动目录下的.musca_start文件，一般启动目录为$HOME，
所以我在 ``~/.musca_start`` 中放入我要musca执行的命令。

下面是我的.musca_start文件的内容：

::

  # musca startup file.
  # musca is a light weight tiling window manager.
  # This file list the commands that you want musca to execute.
  
  # make Trayer and Conky not managed by musca.
  manage off trayer
  manage off Conky
  
  # set background
  exec feh --bg-scale ~/images/wallpapers/1440x900-injunctions.jpg
  # startup conky
  exec conky
  # startup trayer
  exec trayer --edge top --align right --widthtype request --height 20 --SetDockType true --transparent true --alpha 255 --tint 0x00ff00
  
  border off
  # set active range, leave 20 pixels in top for conky and trayer
  pad 0 0 20 0
  # set active range after a new group is added.
  hook on ^add pad 0 0 20 0
  # add a new group named geek
  add geek
  # switch back to group 0 (default)
  use 0


Musca变量
-------------------------------

你也可以通过musca命令 ``set musca_variable some_value`` 来设定musca的
外观和行为，因此了解一下musca变量也是有用的。

======================= ================================ ==============================================================================
变量名                  默认值                              含义
======================= ================================ ==============================================================================
border_focus             Blue                               聚焦时的边框颜色
border_unfocus           Dim Gray                           失去焦点时的边框颜色
border_dedicate_focus    Red                                专用帧聚焦时的颜色
border_dedicate_unfocus  Dark Red                           专用帧失去焦点时的颜色
border_catchall_focus    Green                              catchall帧聚焦时的颜色
border_catchall_unfocus  Dark Green                         catchall帧失去焦点时的颜色
border_width             1                                  边框宽度，最小为0
frame_min_wh             100                                帧和受管窗口的最小宽度和高度
frame_resize             20                                 帧调整大小时的步长
startup                 .musca_start                        启动时执行的启动目录下的文件名
dmenu                    dmenu -i -b                        启动dmenu时的命令行
switch_window            sed 's/^/raise/' | $MUSCA -i       在dmenu中选中窗口时执行的命令
switch_group             sed 's/^/use/' | $MUSCA -i         在dmenu中选中一个窗口组时执行的命令
run_musca_command        $MUSCA -i                          当用户通过dmenu输入一个命令时的处理方法
run_shell_command        sed 's/^/ exec /' | $MUSCA -i      当用户通过dmenu输入一个shell命令时的处理方法
notify                   echo `cat`                         向用户显示消息的方法，默认是显示在标准输出
stack_mouse_modifier     Mod4                               stacking模式的修改键，配合鼠标左右键移动窗口和调整窗口大小
focus_follow_mouse       0                                  是否鼠标移动聚焦，设为1则是
window_open_frame        current                            如果是 current，新窗口在聚焦帧打开，如果是empty，试图找一个空帧打开新窗口
window_open_focus        1                                  新窗口获得焦点，设为0则阻止
window_size_hints        1                                  设为0则忽略X 尺寸提示
command_buffer_size      4096                               传递给musca -c或musca -i的命令缓冲区大小
notify_buffer_size       4096                               用户消息缓冲大小
frame_display_hidden     1                                  0：空帧保持空；1：自动显示可用的隐藏窗口；2：自动显示在该帧显示过的窗口
frame_split_focus        current                            分割帧后， current：焦点保持在原帧；new：聚焦于新帧
group_close_empty        0                                  当一个空组失去焦点，1:改组自动关闭；0：依然保持。
======================= ================================ ==============================================================================


对Musca的期望
==========================================

虽然Musca可以快速方便地由tiling模式变为stacking模式，
但是我还是希望能继续在tiling模式工作的同时使用pidgin这类程序，
而这些程序最好是浮动的。
因此我希望musca能提供函数设定一些程序始终是浮动的。
就像larsWm和 *awesome* 中那样可以在配置文件中设定哪些程序始终是浮动的。
我将给 musca 开发团队写信，希望他们考虑这个功能。

