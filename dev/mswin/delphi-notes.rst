==============================
delphi笔记
==============================

:author: jiqing
:email: jiqingwu@gmail.com
:create: 2011-12-19
:update: |date|

.. |date| date::

.. contents:: 目录

dephi工程中各种文件的作用
==============================

- .dpr 项目文件，也是主程序文件，程序从这里开始执行。
- .pas 单元文件，pascal源文件。创建窗体时会自动创建对应的单元文
  件，也可以自己创建单元。
- .dfm 窗体文件，记录着窗体的位置、尺寸、风格等信息以及窗体上控件
  的信息。创建窗体时，会同时生成.pas和.dfm文件。
- .res 资源文件，二进制文件。生成应用程序时，会把资源文件中定义的资源链接到应用程序中。
- .dcu delphi compiled units. 被编译过的单元文件，相当于目标代码。
  可删除。
- .doc 项目配置文件，保存特定delphi项目的配置，可删除。
- .dsk 桌面设置文件，保存delphi环境的配置，可删除。
- .ddp 二进制文件，好像是纪录工程关系的文件，不要随便删。
- .~dp, .~pa, .~df 备份文件，分别对应.dpr, .pas, .dfm，可删除。可
  以设置环境不生成备份。
- .dpk 包文件。包类似于动态链接库，delphi独有。
- .dcp delphi compiled packets. dpk编译后生成dcp。可删除。
- .bpl 包.dpk被编译后生成.bpl，.bpl由多个.dcu组成。

基本语法
==============================

1. cardinal: unsigned int.
2. 使用#1。。#255分别代表255个ASCII字符。
3. interface表示该单元对外提供的接口。

指示字
==============================

在声明过程或函数时，可以在附属块使用指示字以进一步指定过程或函数的
产生方式。Delphi过程或函数分别提供了Block，External，Asm，Forward。
指定调用方式的语法示例如下：

其中Block是缺省方式，表示过程或函数的语句部分是 Pascal程序快，下面
对External，Assembler，Forward进行介绍。

1. External

该指示字表示过程或函数是外部的，通常用于从动态链接库中引入过程或函
数。External后可以动态链接库名或表示动态链接库的有序数，也可以指定
引入的过程或函数名。例如：::

    function MessageBox(HWnd: Integer; 
    Text, Caption: PChar; Flags: Integer): Integer; 
    stdcall; external 'user32.dll' name 'MessageBoxA';

上例中，user32.dll指定用于引入过程或函数的动态链接库名（也可以是
一个有序数），MessageBox指定从动态链接库中引入过程或函数名。

2. Assembler

该指示字表示过程或函数是使用嵌入式汇编语言编写的。例如函数声明：::

    function LongMul(X, Y: Integer): Longint;Assembler

3. Forward

该指示字表示一个过程或函数是向前查找的。在声明了一个过程或函数是
向前查找的之后，该过程或函数的定义必须在后面的某个地方定义。::

    procedure Walter(M, N: Integer); forward;
    procedure Clara(X, Y: Real);
    begin
        ...
        Walter(4, 5);
    end;

    procedure Walter;
    begin
        ...
        MessageBeep(0);
    end;

注意：不能在单元的interface部分声明向前查找过程。在使用向前查找过
程时，要注意相互递归。

组件的属性
==============================

- 注意align和alignment属性：align是构件在窗口中的位置，alignment是
  构件中的文本的对齐方式。
- 另外，要注意anchor属性，这表示构件的停靠点。如：我将窗口上一个
  panel的align属性设为alignclient。如果不想让它覆盖下面的构件，可
  以将anchor的bottom设为true。
- TImage部件用以在窗体中显示图像，它的Picture 属性保存着要显示的
  图像， 这是一个TPicture对象。AutoSize,Stretch属性是用来调节部件
  与图像的大小的。当AutoSize 为真值时，TImage部件将根据它所包含的
  图像的大小来调整自身的大小；当AutoSize为假值时，不论图像有多大，部
  件将保持设计时的大小。如果部件比图像小， 那么只有一部分图像是可
  见的。当Stretch为真值时，位图像将根据部件的大小调整自身的大小，
  当部件大小改变时，元文件也做相应变化。Stretch属性对图标没有作用。

菜单
==============================

1. 要包含一个隔离条，可以在CAPTION处键入短划横“-”即减号并回车。
2. 创建嵌套菜单，把加亮条移到它的上层菜单条上，按Ctrl+右行键，将弹
   出子菜单，就可以按照同上所述的方法进行创建工作了。
3. 设定加速键和热键。在输入时，将“&”放到需要指定为加速键的字母前
   面，该字母将被用下划线显示，运行时，按“Alt+加速键字母”可以激活该菜
   单条。设定热键也是很方便的，只需在Object Inspector中该菜单条的
   ShortCut属性值段的下拉菜单中，为它选定一个热键组合即可。在运行时，
   通过“Ctrl+热键字母”来激活菜单条。加速键和热键并不矛盾，您可以同时
   指定它们。
4. 禁止菜单自动添加加速键，把autohotkeys改为maManual。

