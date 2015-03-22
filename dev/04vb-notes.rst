==============================
VB笔记
==============================

:create: 2011-12-19
:update: |date|

.. |date| date::

.. contents:: 目录

基本语法
==============================

Main()
------------------------------

Main是应用程序的入口函数，有四种版本：

- Sub Main() 
- Sub Main(ByVal CmdArgs() As String) 
- Function Main() As Integer 
- Function Main(ByVal CmdArgs() As String) As Integer 

常用的是Sub Main()。看一个最简单的vb程序。 ::

    Module Hello
    Sub Main()
        MsgBox("Hello World!") 
    End Sub
    End Module

下面是一个带有数组参数，并有返回值的例子。 ::

    Function Main(ByVal CmdArgs() As String) As Integer
        Dim ArgNum As Integer '命令行参数的索引
        If CmdArgs.Length > 0 Then ' See if there are any arguments.
            For ArgNum = 0 To UBound(CmdArgs)
                '检查各个命令行参数进行处理
                Next ArgNum
        End If
        MsgBox("Hello World!")
        Return 0
    End Function

数组
------------------------------

所有的数组都是由 System 命名空间的 Array 类继承而来，且可以在任何
数组上访问 System.Array 的方法和属性。在将一个数组变量赋值给另一个
数组变量时，只有指针进行了复制。

**数组的声明** ::

    Dim 数组名(最大下标) As 类型

如： ``Dim ClassMates(20) As String`` 。其中20是最大下标，0 是最小
下标，实际上数组中包含了21个元素。

数组声明指定一个数据类型，数组的所有元素必须都是该类型数据。如果数
据类型是 Object，则单个数组元素可以包含各种类型的数据（如对象、字
符串、数字等等）。 ::
    
    Dim EmployeeData(3) As Object
    EmployeeData(0) = "Ron Bendel"
    EmployeeData(1) = "4242 Maple Blvd"
    EmployeeData(2) = 48
    EmployeeData(3) = "06-09-1953"

可以定义空数组，如： ``Dim someArray(-1) As Short``

**多维数组的定义**

VB.Net中，最多可以定义32维数组。然而实际上我们连三维数组都很少用到。
下面是对一个二维数组的定义。 ::

    Dim Matrix(4, 9) As Integer

上面定义了一个五行十列的矩阵。

可以用GetLength得到每一维的长度，用GetUpperBound得到每一维的最大
下标。如：::

    Dim n1 As Int16 = Matrix.GetUpperBound(0) '得到行的最大下标
    Dim n2 As Int16 = Matrix.GetUpperBound(1) '得到列的最大下标

通过数组的Length属性可以得到数组元素的总个数。

**数组的初始化**

可以在声明数组的同时对其进行初始化，如： ::

    Dim b() As Byte = New Byte(){0, 1, 2}
    Dim b() As Byte = New Byte(2){0, 1, 2}

以类似方法初始化多维数组(使用New子句为数组变量分配数组对象)： ::

    Dim b(,) As Byte = New Byte(1,1){} '有默认值
    Dim b(,) As Byte = New Byte(,){{5,6},{8,0}}

区分数组对象和数组变量非常重要。数组对象创建之后就不再改变其大小和
级别。然而，数组变量在其生存期内可以被分配多个不同的数组，且所分配
数组可以是不同的大小和秩。

**调整数组大小**

通过使用 ReDim 或标准的赋值语句给数组变量赋以不同的数组对象，可以
随时改变它的大小。新数组对象可以有不同的维数和秩。当使用 ReDim 语
句改变数组大小时，数组原有的值通常会丢失。但您可以在 ReDim 语句中
使用 Preserve 关键字来保持这些值。例如，下面的语句分配一个新的数
组，其元素由现有 MyArray 的相应元素初始化，然后将新数组分配给
MyArray。 ::

    ReDim Preserve MyArray(10, 20)

类和对象
==============================

类定义： ::
    
    Class 类名
        [Inherits 类名]
        [Implements 接口名]
        属性和方法。。
    End Class

修饰符

- Public 项目中任何地方都可以访问。
- Private 该类只有在声明的上下文中可以访问。
- Protected 该类和其子类可以访问。
- Friend 只有包含该实体声明的程序内才可访问。如果类前面没加访问权
  限的修饰符默认都是Friend。
- MustInherit 不能实例化该类，相当于抽象类。
- NotInheritable 指示该类不能被继承。
- Inherits 继承某类。注意要另起一行，不然会报语法错误。
- Implements 实现某个接口。指此类中有该接口中声明的函数的实现。也
  要另起一行。
