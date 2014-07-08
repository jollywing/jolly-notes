

# Python学习笔记 #

    :author: jiqing Wu
    :email: jiqingwu@gmail.com
    :create: 2010-03-23
    :update: 2014-07-04


## Python概述 ##
1. 你为什么要学习python?
2. python能有哪些用途？

### 编程思想 ###

- 对于寻求快速解决问题，而不是研究问题的Pythoner们，精确、恰当地描述问
  题，就等于写好了程序框架。
- 当感到一个问题复杂时，要确认哪些部分是造成复杂的原因，
  然后试图去除或替换这部分。


### 基本语法 ###

- *语句末尾什么时候需要分号？* 语句末尾不用分号。如果你想在一行中包含多个语句，才用分号分割。
- 如果一个语句分多行来写，需要用 `\` 来显式地连接。
  但当 `(,[,{` 没有闭合时，可以不加 `\` 直接换行。
  这叫隐式地连接。
- 函数等结构不用{}来标识，由缩进级别来识别程序结构。
- 从 `#` 开始，一直到一行结束都是注释。

### 编程规范 ###


### 获得帮助 ###

从交互解释器中获得帮助，例如你想了解 `raw_input` 函数，
你可以输入 `help(raw_input)` 查看该函数的在线文档。
用 `dir(xyz)` 可以查看某个对象的属性和方法。
当你遇到一个陌生的对象时，可以通过这些了解，从这个角度上说，
python是自足的。

注意：python3已经没有 `raw_input`，代之以 `input`

输入 help() 进入交互式的帮助环境，输入quit回车退出。

-------------------------------------------------------------------------------

## 输入输出 ##

### 打印 ###

print可以将输出重定向到文件。如

下面是python2的代码

    logfile = open('/tmp/mylog.txt', 'a')
    print >> logfile, 'Fatal err: invalid input!'
    logfile.close()

python3的代码

    logfile = open('/tmp/mylog.txt', 'a')
    print('Fatal err: invalid input!', file=logfile)
    logfile.close()

默认情况是，print会在打印内容后自动加换行符，
只要在后面加个逗号，就可以改变这种行为：

    print 'abc',    # python 2
    print('abc', end='') #python 3

不加任何参数的print会输出一个换行符。

python3中语法有变化，参数需要用括号围起来，参见 `help(print)` 。


### 获取输入 ###


可以用 `raw_input` 函数获得标准输入，并用 `int()` 将之转换为整数。
如：

    num = raw_input('Enter a number')
    print 'Doubling your number: %d' % (int(num)*2)


## 基本类型和运算 ##


### 类型和类型转换 ###

- 转换成整型： ``int(a)``
- 转换成浮点型： ``float(a)``

python的布尔类型： True False
0, 0.0, None, [], '', (), {} 都被认为是假的。
其它都是真的。

### 算术逻辑和关系运算 ###

Python有两个除法符号： `/` 和 `//` 。

`/` ，在python2中，当除数和被除数都是整数时，进行整除；当有一个数是浮点数时，进行真
正的除法。在python3中，都是浮点除。

`//` ，在python2中，不管是不是浮点数，结果都是整除的结构。
在python3中，如果两个数是整数，是整除。如果两个数至少有一个是浮点数，也是整除，但结果是浮点数的形式。

`a ** b` 表示求a的b次方。

`abs(-5)` 取绝对值。

移位操作： << 和 >>

位与： &
位或: |
位异或: ^
按位翻转: ~

Python 也支持两种不等于操作符： `!=` 和 `<>` 。
前者是c风格， 后者是Pascal风格。推荐用前者。
在python3中已经不支持 `<>`。

Python的逻辑操作符有： `and` ， `or` ， `not` 。
表达式 `3 < 4 < 5` 相当于 `3 < 4 and 4 < 5` 。

Python 支持增量赋值，也就是操作符和等号合在一起的形式，如 `n = n *
10` 。但Python不支持自增1和自减1操作符。

Python中用0x或0X的前缀表示十六进制，如 `0x988` 。

类似c语言中的三元操作符: `cond ? true_value:false_value`
python这样实现： `cond and true_value or false_value`
注意其中 `true_value` 的值不能为假。

## 数据结构 ##

### 字符串 ###

字符串格式化： `'I like {} more than {}.'.format('dog', 'cat')` 输出什么？
对应的python2中应该如何写？
`'I like %s more than %s.'%('dog', 'cat')`.

Python中字符串常量用单引号或双引号括起来，
如果用连续三个单引号或双引号括起来的字符串类似于原文照排的字符串，
可以包含换行等特殊字符。这种方式用来写在线文档。
字符串变量其实是一个list对象。

- `''.join(list)` 可以把字符串列表对象拼接成一个字符串。
- s.startswith('abc')
- s.endswith('abc')
- 'abc' in s
- s.find('abc') 如果s不包含abc，会返回-1。
- s.replace('abc', 'ABC') 返回一个新的字串，abc被替换成ABC.

自然字符串， `r'ab\c'` 中 `\` 就是 `\` 本身，不再具有转义作用。
自然字符串以 `r` 或是 `R` 引导。

unicode字符串，以 `u` 或 `U`引导。
如果你的字符串中含有非 ascii 字符，就使用unicode字符串。

字符串自动连接：
`'What\'s the' ' time?'` == `"What's the time?"`

字符串可以用 `+` 做拼接操作。比如 'a' + 'b' 会得到 'ab'.
也可以用 `*` 做重复拼接。比如 'La' * 3 会得到 'LaLaLa'.

`help(str)` 获得全面的帮助。

### 列表 ###

列表和元组可以存储不同类型的对象。
元素之间用逗号间隔，从0开始索引。


切片操作： `aList[start:end]`, 截取从start到end的子列表，但不包括end位置的元素。
`aList[0:3]` 并不包含索引为3的元素。
如果不指定start，start = 0
如果不指定end, end = len(aList)

+ `aList[2:]` 从索引为2的元素到最后一个元素。
+ `aList[:3]` 从索引为0的元素到索引为2的元素。
+ `aList[:]` 返回和 `aList`完全相同的列表。
+ `aList[-1]` 索引最后一个元素。
+ `aList[-2]` 倒数第2个元素。
+ `aList[-len(aList)]` 第一个元素。

（*注意: 字符串、元组、列表都是序列，都支持索引和切片操作。*）

用append添加元素。
del mylist[0] 删除第一个元素。
mylist.sort() 返回一个排好序的列表。

Python有个非常高级的特性就是列表解析，
如 ``[x ** 2 for x in range(4)]``
解析后将是 ``[0, 1, 4, 9]`` 。
还有更复杂的， ``[x ** 2 for x in range(8) if not x % 2]``
解析后就是 ``[0, 4, 16, 36]`` 。

enumerate(aList)会返回一个元组列表，每个元组的形式如(索引,元素)。

### 元组 ###

元组可以看成只读的列表，元素的个数不能增加，元素的值也不可更改。
用 `()` 定义一个元组， 如

    a_tuple = ('BeiJin', 'NanJin', 'ShangHai')

如果你定义一个只包含一个元素的元组，必须包含在元素后面加一个 `,`
否则，括号会被忽略。

    t = (1,)

### 字典 ###

    d = {key1: value1, key2: value2}

key必须是不可变的值，且不能重复。
value可以是变量。

建立一个字典：

    dict1 = {}
    dict2 = {'animal':'dog', 'port':80}

访问字典中的元素：

    for key in dict2.keys():
      print '%s:%s' % (key, dict2[key])

或

    for name, address in d.items():
        print 'Contact %s at %s' % (name, address)

想看字典中是否有某个键值：

    if 'dog' in dict2:
      print True
  
    if 'dog' not in dict2:
      print False

给字典添加元素：

    # 如果dict2中有ip键，则更新值，否则是添加
    dict2['ip'] = '192.168.1.234'

删除字典中的元素：

    del dict2['ip']
    dict2.clear()     #清空所有元素
    del dict2     #销毁dict2

（注意，字典不是序列，不支持按下标的索引。dict中的元素也没有固定顺序。）

-------------------------------------------------------------------------------

## 基本程序结构 ##

### 分支与循环 ###

if语句：

    if exp1:
      if_suite
    elif exp2:
      elif_suite
    else:
      else_suite

while语句：

    while exp:
      while_suite

你可以在while语句后面跟一个else块。
当循环结束后，else块会被执行。
需要注意的是，如果你用 `break` 中途退出循环， else子块将不被执行。

    while exp:
      while_suite
    else:
      else_suite

**for循环**：

for可以迭代一个列表中的各个元素，如

    for item in aList:
      print item

与while类似，for也可以跟一个else子块。
需要注意的是，如果你用 `break` 中途退出循环， else子块将不被执行。

    for item in aList:
      print item
    else:
      do something
      
用range可以生成一个整数的列表。
range(n)是从0到n-1。

    for i in range(0, 5, 2):
      print i,

将输出：

    0 2 4

## 函数 ##

### docstring ###

用三个单引号或是双引号包围的是 docstring.
可以用docstring做函数的文档。


    def print_max(a, b):
        ''' Given two integers, print the max. '''
        if a > b:
            print(a)
        else:
            print(b)
    
    print(print_max.__doc__)

用 `help(print_max)` 也会显示`print_max`的docstrin.

文档字符串的惯例是一个多行字符串，它的首行以大写字母开始，句号结尾。第二行是空行，从第三行开始是详细的描述。 强烈建议 你在你的函数中使用文档字符串时遵循这个惯例。

### 返回值 ###

函数在调用前必须先定义，如果函数没有return语句，就自动返回None对象。
对于一个没有 return 的函数，你可以通过 `print foo()` 来验证看是不是返回None.

对于暂时未定义的函数，你可以在函数内使用 `pass`

    def bar():
        pass

### 默认参数 ###

函数的参数可以有一个默认值，如

    def foo(debug=True):
      if debug:
        print 'DEBUG MODE!'
      print 'done'

只有在形参表末尾的那些参数可以有默认参数值，即你不能在声明函数形参的时候，先
声明有默认值的形参而后声明没有默认值的形参。这是因为赋给形参的值是根据位置而
赋值的。例如，def func(a, b=5)是有效的，但是def func(a=5, b)是 无效 的。

### 关键参数 ###

我们可以通过参数名称来给参数传值，使用名称，可以不遵守函数定义中参数的顺序。
如：

    def foo(a, b = 'a', c = 'Hello'):
        print a, b, c

    foo('HaHa', c = 'Yes')
    foo(b = 'Rain', a = 'Me')
    foo('Snow', 'Day')

### 全局变量 ###

函数内声明的变量都是局部变量。
要想在函数内使用全局变量，用 `global` 修饰该变量。

    x = 10

    def foo():
        global x
        print(x)

一条global语句可以指定多个全局变量。

    global x, y, z


## 模块 ##

    import sys
    
    # avoid this, it makes you program hard to read, and may result in name confictions.
    from sys import *

每个以 .py 为扩展名的python程序都是一个模块。
比如我们写了 module_a.py， 里面定义了一个 shit 函数。
我们可以这样使用：

    import module_a
    module_a.shit()

也可以这样：

    from module_a import shit
    shit()

dir函数来列出模块定义的标识符。标识符有函数、类和变量。

当你为dir()提供一个模块名的时候，它返回模块定义的名称列表。如果不提供参数，它返回当前模块中定义的名称列表。

## 类和对象 ##

### 类的变量 ###

    class CLS(object):
        instance_count = 0
        def __init__(self):
            blabla...

        def __del__(self):
            unconstructor ...

上面的 `instance_count` 就是类的变量，在类的实例里可以用 CLS.instance_count 访问它。

### 继承 ###
一个子类型在任何需要父类型的场合可以被替换成父类型，即对象可以被视作是父类的实例，这种现象被称为多态现象。

使用父类的构造函数(python不会自动调用基类的构造函数)，和方法。

    class Plant(object):
        def __init__(self):
            ... ...
        def show(self):
            ... ...

    class Tree(Plant):
        def __init__(self):
            Plant.__init__(self)
            ... ...
        def show(self):
            Plant.show(self)
            ... ...


### 特殊函数 ###

- `__init__(self,...)` 在新建对象恰好要被返回使用之前被调用。
- `__del__(self)`	恰好在对象要被删除之前调用。
- `__str__(self)`	在我们对对象使用print语句或是使用str()的时候调用。
- `__lt__(self,other)`	当使用 小于 运算符（<）的时候调用。类似地，对于所有的运算符（+，>等等）都有特殊的方法。
- `__getitem__(self,key)`	使用x[key]索引操作符的时候调用。
- `__len__(self)`	对序列对象使用内建的len()函数的时候调用。

## 异常处理 ##

    try:
        do something...
        do something...
    except EOFERROR:
        handle ...
    except (Exception1, Exception2):
        blablabla...
    except:
        handle ...

    try:
        blablabla...
    except:
        blablabla...
    else:
        blablabla...

当没有异常发生，`else`子块会被执行。

用 `raise` 抛出异常。

    
    class ShortInputException(Exception):
        def __init__(self, length, atleast):
            Exception.__init__(self)
            self.length = length
            self.atleast = atleast
    
    # if __name__ = main:
    s = input('Input something:')
    
    try:
        if len(s) < 3:
            # use raise to throw exception.
            # which to throw is a instance of subclass of Exception or Error
            raise ShortInputException(len(s), 3)
    # catch exception use except, where e is instance of ShortInputException
    except ShortInputException as e:
        print('Your input string is shorter than {}.'.format(e.atleast))
    else:
        print(s)
    finally:
        print('whatever I will say something.')

上例中有 finally 子块。
不管是否发生异常， finally子块都会被执行。

## python标准库 ##

### 文件操作 ###


打开文件： ``handle = open(file_name, access_mode = 'r')``

访问模式可以是 'r', 'w', 'a'(追加)。还可以是 '+'(读写), 'b'(二进制)访
问。如果不提供access_mode的参数，默认是'r'。

用 ``handle.close()`` 关闭文件。


## 网络编程 ##

.. {{{1

通过python可以启动简单的http服务，不需要启动apache。::

    python -m SimpleHTTPServer 8080

然后通过 ``http://localhost:8080`` 就可以访问当前目录了。
python真是威武。

.. }}}1

