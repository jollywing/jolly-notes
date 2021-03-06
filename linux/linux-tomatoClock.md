---
title: 自制Linux下的番茄钟
layout: post
---

# 自制Linux下的番茄钟 #

习惯使用番茄工作法，在Linux上工作时也需要一个番茄钟。
安装一个Linux下番茄钟工作软件？
其实根本没必要，我们可以用Linux下经典的at命令实现一个简单的番茄钟。

## 安装at ##

一般Linux基本系统里都包含了at这个小巧实用的工具，不需要安装。

不过林子大了，什么鸟都有，比如我最近使用的centOS中居然没有at命令。
于是我安装这个包。

    sudo yum install at

你可以用 =which at= 查看有没有at命令。如果没有，就安装一个。

## at的基本用法 ##

软件准备好了，简单实验一下at的用法。

首先我们要启动atd服务。

    # service atd start

如果你没有service命令，你可能需要使用类似下面的命令。

    # /etc/init.d/atd start

或许你的系统已经抛弃了initscripts，已经再用systemd了，
你可以用systemd启动服务

    # systemctl start atd

服务启动后，我们看看怎么用at添加一个定时任务。

输入 `at now+1 minutes` 回车，
命令行显示 `>` ，让你输入要执行的任务。
我们输入 `echo "hello world!"`
按 control 和 d 结束任务输入。

这样我们就有了一个job. 输入 `atq` 命令可以查看任务队列。
有任务号和任务将执行的时间。

上面添加的任务表示1分钟后，在终端输出 `hello world!`

想查看某个任务的详细信息， `at -c 任务号`.

想删除某个任务, `atrm 任务号` 或者 `at -d 任务号`

这个交互式的输入任务的方式比较麻烦，不利于用脚本添加at任务。
怎么办？可以用管道为at指定任务。
上面添加任务的过程可以简化为一行命令

    echo "echo 'hello, world!'"|at now+1 minutes

## 用at做番茄钟 ##

一个番茄钟是25分钟，
在at命令中使用 `now+25 minutes` 就能指定25分钟的时间间隔。
当一个番茄钟的时间间隔过去后，用什么方式提醒我们时间到了呢?
我们可以播放一段音乐，显示一个图片，甚至播放一段视频。

好，因为在办公室里使用，播放音乐会干扰别人，我们就采用显示一张图片的方式吧。
显示图片的工具很多。比如 feh，比如 ImageMagick 中的 display。
当然别的还有很多。这里以 feh 为例。

我们可以显示一个美女图片，比如其路径是 ~/pics/girl.png 。
那么我们要执行的任务就是 `feh ~/pics/girl.png` 。
我们想要25分钟后，显示这个图片，就这样做：

    echo 'feh ~/pics/girl.png' | at now+25 minutes

我们可以先把时间间隔设为一分钟，看看效果。

    echo 'feh ~/pics/girl.png' | at now+1 minutes

一分钟到了，怎么回事？不显示图片。
`atq` 查看任务队列，队列也空了，证明任务执行完了。
`atq` 输出时，告诉我： You have mail in /var/spool/mail/jolly.
（其中jolly是我的用户名）。
`cat /var/spool/mail/jolly` 查看邮件，内容是：

> (feh:2632): Gdk-WARNING **: cannot open display:

display后面是空的，证明feh执行的时候没有指定display。
再加入上述任务：

    echo 'feh ~/pics/girl.png' | at now+1 minutes

`at -c 任务号` 查看它的详细内容。

发现在 'feh' 命令之前，还有很多的环境变量。
但环境变量里不包含 DISPLAY。怪不得找不到display呢。

`echo $DISPLAY` ，发现DISPLAY的值是 `:0`.

好，我们在执行feh命令的同时，用 *env* 指定DISPLAY的值。
再实验一下：

    echo 'env DISPLAY=:0 feh ~/pics/girl.png' | at now+1 minutes

一分钟之后，果然开始显示图片了。
成功！

## 用脚本包装 ##

为了方便，我们写一个脚本， new-clock

    #!/bin/sh
    echo "env DISPLAY=:0 feh ~/pics/girl.png" |at now+25 minutes

`chmod +x new-clock`，把new-clock放入执行路径，比如放入 ~/bin 目录下。

    cp new-clock ~/bin

这样我们敲入 'new-clock' 命令，就启动了一个番茄钟。
25分钟过后，将显示图片提醒我们。

如果你没有X环境，就不能用显示图片的方式了，可以播放声音来提醒。

2014-03-21 Fri
