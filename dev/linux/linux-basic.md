#Linux静态库生成指南#

Linux上的静态库，其实是目标文件的归档文件。
在Linux上创建静态库的步骤如下：

1. 写源文件，通过 `gcc -c xxx.c` 生成目标文件。
2. 用 `ar` 归档目标文件，生成静态库。
3. 配合静态库，写一个使用静态库中函数的头文件。
4. 使用静态库时，在源码中包含对应的头文件，链接时记得链接自己的库。

下面通过实例具体讲解。

## 写源文件，生成目标文件。

第一个源文件 my_print.c


    #include <stdio.h>

    void cout(const char * message)
    {
        fprintf(stdout, "%s\n", message);
    }

源文件2： my_math.c


    int add(int a, int b)
    {
        return a + b;
    }

    int subtract(int a, int b)
    {
        return a - b;
    }

使用gcc，为这两个源文件生成目标文件：

    gcc -c my_print.c my_math.c

我们就得到了 my_print.o 和 my_math.o。

## 归档目标文件，得到静态库。

我们使用 ar 将目标文件归档：

    ar crv libmylib.a my_print.o my_math.o

我们就得到了libmylib.a，这就是我们需要的静态库。

上述命令中 crv 是 ar的命令选项：

- c 如果需要生成新的库文件，不要警告
- r 代替库中现有的文件或者插入新的文件
- v 输出详细信息

通过 `ar t libmylib.a` 可以查看 `libmylib.a` 中包含的目标文件。

可以通过 `ar --help` 查看更多帮助。

注意：我们要生成的库的文件名必须形如 `libxxx.a` ，这样我们在链接这个库时，就可以用 `-lxxx`。
反过来讲，当我们告诉编译器 `-lxxx`时，编译器就会在指定的目录中搜索 `libxxx.a` 或是 `libxxx.so`。

## 生成对应的头文件

头文件定义了 libmylib.a 的接口，也就是告诉用户怎么使用 libmylib.a。

新建my_lib.h， 写入内容如下：

    #ifndef __MY_LIB_H__
    #define __MY_LIB_H__

    int add(int a, int b);
    int subtract(int a, int b);

    void cout(const char *);
    #endif

## 测试我们的静态库

在同样的目录下，建立 test.c:

    #include "my_lib.h"

    int main(int argc, char *argv[])
    {
        int c = add(15, -21);
        cout("I am a func from mylib ...");
        return 0;
    }


这个源文件中引用了 libmylib.a 中的 `cout` 和 `add` 函数。

编译test.c:

    gcc test.c -L. -lmylib

将会生成a.out，通过 ./a.out 可以运行该程序。说明我们的静态库能正常工作。

上面的命令中 `-L.` 告诉 gcc 搜索链接库时包含当前路径， `-lmylib` 告诉 gcc 生成可执行程序时要链接 `libmylib.a`。

## 通过makefile自动化

上面的步骤很繁琐，还是写个简单的makefile吧，内容如下：

    .PHONY: build test

    build: libmylib.a

    libmylib.a: my_math.o my_print.o
    	ar crv $@ my_math.o my_print.o

    my_math.o: my_math.c
    	gcc -c my_math.c

    my_print.o: my_print.c
    	gcc -c my_print.c

    test: a.out

    a.out: test.c
    	gcc test.c -L. -lmylib


makefile写好后，运行 `make build` 将会构建 libmylib.a， 运行 `make test` 将会生成链接 libmylib.a 的程序。

如果你在 windows 上使用 mingw，和Linux下生成静态库的方法是一样的。

2015-03-10 Tue
