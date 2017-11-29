---
title: Linux终端输出彩色字符
layout: post
category: Linux开发
---

# Linux终端彩色字符的输出方法[收藏] #

在 ANSI 兼容终端（例如 xterm、rxvt、konsole 等）里， 可以用彩色显示文本而不仅仅是黑白。但是我们自己编写的程序能否输出彩色的字符呢？当然答案是肯定的。下面的语句就输出高亮的黑色背景的绿色字。

    printf("\033[1;40;32m%s\033[0m", "Hello,NSFocus\n");

`\033` 声明了转义序列的开始，然后是 `[` 开始定义颜色。后面的 `1` 定义了高亮显示字符。然后是背景颜色，这里面是40，表示黑色背景。接着是前景颜色，这里面是32，表示绿色。我们用 `\033[0m` 关闭转义序列， `\033[0m` 是终端默认颜色。

通过上面的介绍，就知道了如何输出彩色字符了。因此，我就不再多说了。下面是对于彩色字符颜色的一些定义：


    前景            背景              颜色
    ---------------------------------------
    30                40              黑色
    31                41              紅色
    32                42              綠色
    33                43              黃色
    34                44              藍色
    35                45              紫紅色
    36                46              青藍色
    37                47              白色

    代码              意义
    -------------------------
    0                终端默认设置
    1                高亮显示
    4                使用下划线
    5                闪烁
    7                反白显示
    8                不可见

下面给出了一个C语言的示例：

    #include <stdio.h>

    int main(int argc,char **argv)
    {
        unsigned char attr[]={0,1,4,5,7,8};
        unsigned char fore[]={30,31,32,33,34,35,36,37};
        unsigned char back[]={40,41,42,43,44,45,46,47};
        int adx,fdx,bdx;

        for(bdx=0;bdx <sizeof(back);bdx++)
        {
            for(fdx=0;fdx <sizeof(fore);fdx++)
            {
                for(adx=0;adx <sizeof(attr);adx++)
                {
                    printf("\033[%d;%d;%dmhello,NSFocus!!!\033[0m",
                        attr[adx],fore[fdx],back[bdx]);
                    printf("<==attr=%d,fore=%d,back=%d\n",
                        attr[adx],fore[fdx],back[bdx]);
                }
            }
            printf("\n");
        }
    }
