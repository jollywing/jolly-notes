---
title: Linux下实现getch
layout: post
category: Linux开发
---

# Linux下实现getch() #

在windows下可以通过 `#include <conio.h>` 使用 `getch()`， 但是 `conio.h` 并不是一个标准的头文件，`conio` 也不是标准的c库。 所以如果在Linux下的c程序中 `#include <conio.h>` ，编程就会报错： `No Such file or directory!`

那么如果想在Linux下使用与`getch()` 功能相同的函数，怎么办呢？ 我们可以通过以下的程序模拟实现`getch()`。

    #include <termios.h>  /* for tcxxxattr, ECHO, etc */
    #include <unistd.h>   /* for STDIN_FILENO */

    /*simulate windows' getch(), it works!!*/
    int getch (void){
        int ch;
        struct termios oldt, newt;

        // get terminal input's attribute
        tcgetattr(STDIN_FILENO, &oldt);
        newt = oldt;

        //set termios' local mode
        newt.c_lflag &= ~(ECHO|ICANON);
        tcsetattr(STDIN_FILENO, TCSANOW, &newt);

    	//read character from terminal input
        ch = getchar();

        //recover terminal's attribute
        tcsetattr(STDIN_FILENO, TCSANOW, &oldt);

        return ch;
    }
