# Windows上安装QT4后更改MinGW的路径 #

在windows上安装使用MinGW的QT4时，并不会一起安装MinGW。
在安装过程中，会让你指定已经安装的MinGW的路径。
当你使用QT4时，将使用你指定的MinGW的路径下的g++来编译构建程序。

在安装QT4之后，如果想更改MinGW的路径，在哪里更改呢。

原来在QT4的bin目录下，有一个 `qtvars.bat` 的批处理文件。
它是QT4安装时根据你的选择和输入自动生成的。
当你启动QT4的命令行提示符时，会执行这个文件，设置执行路径。

在我的 `qtvars.bat` 中有这样一行，这行设置了MinGW路径。

    set PATH=%PATH%;E:\jollywing\MinGW\bin

把 `E:\jollywing\MinGW\bin` 更改成你的MinGW下bin目录的路径，就可以了。

2014-06-11 周三

# google-test #

pacman -S gtest

test.cpp:

    #include <gtest/gtest.h>
    #include "calc.h"

    // TEST(TestCaseName, TestName)
    TEST(CalcTest, AddSubtractTest)
    {
        // EXPECT_* 失败时，继续向下运行
        EXPECT_EQ(3, add(1, 2));
    }

    int main(int argc, char *argv[])
    {
        testing::InitGoogleTest(&argc, argv);
        return RUN_ALL_TESTS();
    }

calc.h:

    #ifndef CALC__H__
    #define CALC__H__

    int add(int, int);

    #endif

calc.cpp:

    int add(int n1, int n2)
    {
        return n1 + n2;
    }

`g++ test.cpp calc.cpp -lgtest`

    TEST(CalcTest, AddSubtractTest)
    {
        // EXPECT_* 失败时，继续向下运行
        EXPECT_EQ(3, Calculator.add(1, 2));
    }

error: ‘Calculator’ was not declared in this scope

class Calculator {
};

‘add’ is not a member of ‘Calculator’



class Calculator {
  public:
    // the function is private by default
    static int add(int, int);
};

undefined reference to `Calculator::add(int, int)'


    #include "calc.h"

    int Calculator::add(int n1, int n2)
    {
        return n1 + n2;
    }

OK.

http://www.cnblogs.com/coderzh/archive/2009/03/31/1426758.html
