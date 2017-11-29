# Linux/Unix 下自制番茄钟 #

习惯使用番茄工作法，在Linux上工作时也需要一个番茄钟。 安装一个Linux下番茄钟工作软件？ 其实根本没必要，我们可以用Linux下经典的at命令实现一个简单的番茄钟。

### 安装AT ###

一般Linux基本系统里都包含了at这个小巧实用的工具，不需要安装。

不过林子大了，什么鸟都有，比如我最近使用的centOS中居然没有at命令。 于是我安装这个包。

    sudo yum install at

你可以用 `which at` 查看有没有at命令。如果没有，就安装一个。

### AT的基本用法 ###

软件准备好了，简单实验一下at的用法。

首先我们要启动atd服务 (freeBSD似乎不需要这一步，而且找不到atd服务)。

    # service atd start

如果你没有service命令，你可能需要使用类似下面的命令。

    # /etc/init.d/atd start

或许你的系统已经抛弃了initscripts，已经再用systemd了， 你可以用systemd启动服务

    # systemctl start atd

服务启动后，我们看看怎么用at添加一个定时任务。

输入 `at now+1 minutes` 回车， 命令行显示 > ，让你输入要执行的任务。 我们输入 `echo "hello world!"` 按 control 和 d 结束任务输入。

这样我们就有了一个job. 输入 `atq` 命令可以查看任务队列。 有任务号和任务将执行的时间。

上面添加的任务表示1分钟后，在终端输出 `hello world!`

想查看某个任务的详细信息， `at -c 任务号`.

想删除某个任务, `atrm 任务号` 或者 `at -d 任务号`

这个交互式的输入任务的方式比较麻烦，不利于用脚本添加at任务。 怎么办？可以用管道为at指定任务。 上面添加任务的过程可以简化为一行命令

    echo "echo 'hello, world!'"|at now+1 minutes

### 用AT做番茄钟 ###

一个番茄钟是25分钟， 在at命令中使用 `now+25 minutes` 就能指定25分钟的时间间隔。 当一个番茄钟的时间间隔过去后，用什么方式提醒我们时间到了呢? 我们可以播放一段音乐，显示一个图片，甚至播放一段视频。

好，因为在办公室里使用，播放音乐会干扰别人，我们就采用显示一张图片的方式吧。 显示图片的工具很多。比如 feh，比如 ImageMagick 中的 display。 当然别的还有很多。这里以 feh 为例。

我们可以显示一个美女图片，比如其路径是 ~/pics/girl.png 。 那么我们要执行的任务就是 `feh ~/pics/girl.png` 。 我们想要25分钟后，显示这个图片，就这样做：

    echo 'feh ~/pics/girl.png' | at now+25 minutes

我们可以先把时间间隔设为一分钟，看看效果。

    echo 'feh ~/pics/girl.png' | at now+1 minutes

一分钟到了，怎么回事？不显示图片。 atq 查看任务队列，队列也空了，证明任务执行完了。 atq 输出时，告诉我： *You have mail in /var/spool/mail/jolly*. （其中jolly是我的用户名）。 用 mail 命令查看邮件，内容是：

    (feh:2632): Gdk-WARNING **: cannot open display:

display后面是空的，证明feh执行的时候没有指定display。 再加入上述任务：

    echo 'feh ~/pics/girl.png' | at now+1 minutes

`at -c 任务号` 查看它的详细内容。

发现在 'feh' 命令之前，还有很多的环境变量。 但环境变量里不包含 DISPLAY。怪不得找不到display呢。

`echo $DISPLAY` ，发现DISPLAY的值是 :0.

好，我们在执行feh命令的同时，用 env 指定DISPLAY的值。 再实验一下：

    echo 'env DISPLAY=:0 feh ~/pics/girl.png' | at now+1 minutes

一分钟之后，果然开始显示图片了。 成功！

### 用脚本包装 ###

为了方便，我们写一个脚本， new-clock

    #!/bin/sh
    echo "env DISPLAY=:0 feh ~/pics/girl.png" |at now+25 minutes

`chmod +x new-clock`
把new-clock放入执行路径，比如放入 ~/bin 目录下。

    cp new-clock ~/bin

这样我们敲入 'new-clock' 命令，就启动了一个番茄钟。 25分钟过后，将显示图片提醒我们。

如果你没有X环境，就不能用显示图片的方式了，可以播放声音来提醒。

2014-04-02

# 为FreeBSD安装adobe flash插件 #

参考 [FreeBSD官方手册浏览器一章](http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/desktop-browsers.html)。

1. `pkg install nspluginwrapper`
   *nspluginwrapper* 是一个辅助安装配置 NetScape Plugin的工具。
   可以为NetScape家族的浏览器安装在其它系统上构建的插件，比如安装在Linux上编译的flash plugin。
2. 通过ports安装 `linux-f10-flashplugin11`。 f10表示Fedora 10。
   `cd /usr/ports/www/linux-f10-flashplugin11`
   `sudo make install`
   `sudo make clean`
3. 安装flash plugin. `nspluginwrapper -v -a -i`，-v表示输出详细信息， -a表示自动探测可用插件， -i表示安装。
   这将会把 `flash-player-plugin.so` 安装到 `~/.mozilla/plugins` 目录下。
   如果你日后更新了flash player的插件，要执行一次 `nspluginwrapper -v -a -u`， -u表示update。
4. 测试是否安装成功: 在firefox地址栏输入 `about:plugins`，回车，会看见flash player在插件列表中，并且是enabled。
5. 如果插件不能激活，应该是没有加载linux模块，`sudo kldload linux`。
   如果想让系统开机自动加载linux模块，编辑 `/etc/rc.conf`，加入 `linux_enable="YES"`。

2014-05-20 周二


# Linux系统接入小区宽带 #

    jollywing(jollywing@foxmail.com)

## 安装 rp-pppoe ##

今天去联通营业厅开通了家庭宽带，回到家就搜索怎么用Linux接入小区宽带，发现大多数人都选择用PPPOE拨号上网，看来这是个不错的选择。

我用 `pacman -Ss pppoe` 搜索ArchLinux的代码仓库，发现了 `rp-pppoe`。
（如果你用Debian/Ubuntu，可以用 `apt-cache search pppoe`。）

`rp-pppoe` 的描述是

    Roaring Penguin's Point-to-Point Protocol over Ethernet client.

看来 Roaring Penguin 是该软件的作者。
如果该软件是基于pppoe写的，那么它一定比pppoe方便，否则作者没有写这个软件的必要。
我安装使用之后，发现果然如此。不需要看手册，也不用改配置文件，就会使用。

好吧，开始安装

    sudo pacman -S rp-pppoe

如果你用 Debian/ubuntu，应该是 `sudo apt-get install rp-pppoe`.

## rp-pppoe的使用 ##

先看看rp-pppoe往系统里安装了哪些文件

    sudo pacman -Ql rp-pppoe

得到下面的输出

    rp-pppoe /etc/
    rp-pppoe /etc/ppp/
    rp-pppoe /etc/ppp/firewall-masq
    rp-pppoe /etc/ppp/firewall-standalone
    rp-pppoe /etc/ppp/pppoe-server-options
    rp-pppoe /etc/ppp/pppoe.conf
    rp-pppoe /usr/
    rp-pppoe /usr/bin/
    rp-pppoe /usr/bin/pppoe
    rp-pppoe /usr/bin/pppoe-connect
    rp-pppoe /usr/bin/pppoe-relay
    rp-pppoe /usr/bin/pppoe-server
    rp-pppoe /usr/bin/pppoe-setup
    rp-pppoe /usr/bin/pppoe-sniff
    rp-pppoe /usr/bin/pppoe-start
    rp-pppoe /usr/bin/pppoe-status
    rp-pppoe /usr/bin/pppoe-stop
    rp-pppoe /usr/lib/
    rp-pppoe /usr/lib/rp-pppoe/
    rp-pppoe /usr/lib/rp-pppoe/README
    rp-pppoe /usr/lib/rp-pppoe/rp-pppoe.so
    rp-pppoe /usr/lib/systemd/
    rp-pppoe /usr/lib/systemd/system/
    rp-pppoe /usr/lib/systemd/system/adsl.service
    ... ...

可以发现，该软件包带的程序(/usr/bin下的文件)有:

- pppoe-connect
- pppoe-relay
- pppoe-server
- **pppoe-setup**
- pppoe-sniff
- **pppoe-start**
- **pppoe-status**
- **pppoe-stop**

对我们有用的有四个程序

- pppoe-setup 配置。不用自己编辑配置文件，它问你答的交互式配置，很简单
- pppoe-start 拨号连线，拨号成功，则联网成功
- pppoe-stop 切断拨号
- pppoe-status 查看连线的状态。

好吧，我们先来配置如何拨号

    sudo pppoe-setup

按提示输入用户名，密码，DNS等，DNS的配置我参考了[这里](http://ip.yqie.com/dns_liantong.htm)。
我用的是河北联通，主DNS配置成 `202.99.160.68`, 辅助DNS配置成 `202.99.166.4`。
配置结束后，该程序还会告诉你运行 `pppoe-start` 开始拨号。

那我们开始拨号

    sudo pppoe-start

程序输出为

    ....... Connected!

打开浏览器试试，可以上网了。

运行 `pppoe-status` 查看连线的状态。可以看到IP，接收和发送了多少报文，走了多少流量。

如果要切断连线，就用

    sudo pppoe-stop

## 通过systemd的服务使用rp-pppoe ##

在查看rp-pppoe安装了哪些文件时，可以看到该软件还安装了一个systemd的服务文件

    /usr/lib/systemd/system/adsl.service

这说明我们还可以用以下方式拨号:

- `sudo systemctl start adsl`, 拨号联网
- `sudo systemctl stop adsl`, 切断连接
- `sudo systemctl enable adsl`, 让系统开机自动拨号

## 总结 ##

本文介绍了使用 `rp-pppoe` 在Linux下拨号上网的方法。
通过介绍，可以看出，相对于传统的 ppp 程序， rp-pppoe的配置和使用都更加直观，简单。

最后，说明一下，在使用rp-pppoe之前，一定要看看你的猫是否正常工作。
**记得打开用户手册，看看各个指示灯明、暗、闪烁的含义。**
如果发现硬件连接不正常，就先联系服务提供商解决硬件问题。

我一开始没看说明书，在电脑上鼓捣了两个小时，都没联上网。看了路由器的说明书，才知道红灯闪烁是光纤没有接好。

2015-02-05 Thu
