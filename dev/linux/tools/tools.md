

# Linux编程笔记 #

## ELF ##

executable and Linking Format.
1995年起，称为linux标准的二进制格式。
之前Linux的二进制格式是a.out。

## gcc ##

1. gcc一个.c文件，会直接生成一个执行文件，默认名字为a.out。如果要指定执行文件名，使用-o参数，比如`gcc -o test test.c`。
2. `gcc -S test.c`是只编译不链接，会生成test.s的中间文件，`gcc test.s` 又会生成执行文件。
3. 如果test.c文件里include了自己写的头文件--test.h，只需要gcc test.c，gcc会自动寻找test.c中include的头文件。
4. 如果有两个以上的c文件，例如有test.c和 `test_again.c`，test.c中引用了 `test_again.c` 中的函数，如果单独编译test.c会报错。但同时编译两个c文件，不管是 `gcc test.c test_again.c` 还是 `gcc test_again.c test.c` 都能正确编译。
5. 不能单独编译一个 没有入口函数的c文件。


## GNU工具链 ##

1. tar打包解压源代码；
2. autoconf 生成configure脚本；
3. make控制编译，makefile可以手写，也可以用configure脚本生成；
4. gcc，鼎鼎大名的GNU C编译器，但实际上它只能生成汇编代码，不过它知道怎样借助于GNU汇编器和链接器生成最终的可执行文件。

## 其它有用的工具 ##

1. gprof. 可以告诉每个函数被调用的次数，和每个函数执行需要的时间。在用gcc或g++编译程序时，要加上 `-pg` 选项。程序每次执行时会生成gmon.out，gprof用这个文件来分析程序。
2. ldd. ldd = Library Dependence Display. `ldd binary-name` 可以显示该程序依赖的共享库。
3. `lsof <a given file>`, 查看正在访问该文件的进程。lsof = list opened files. lsof程序需要额外安装。
4. nm. 使用nm可以看到目标文件、函数库或可执行文件中包含的函数。
