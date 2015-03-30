# 用Grub4dos引导，硬盘安装ArchLinux #

本来在工作机上用winXP，最近想深入Linux开发，于是决定装个Linux。家里的archLinux + awesome用得很好，
于是决定在工作机上也装一套。

不想刻盘，也不想用U盘，通过Grub引导吧。从网上搜了一下，这方面的经验分享很多，我参考的是这一篇。
http://blog.csdn.net/xiaoyanghuaban/article/details/22613987

## 准备grub4dos

下载grub4dos，[这里](http://grub4dos.chenall.net/)是作者的网站？可以下载到最新版。

解压，将其中得 `grldr`, `grub.exe` 和 sample 目录下的 `menu.lst` 复制到 C:。

修改`c:\boot.ini`。添加一个启动项`c:\grldr="Grub"`，并把默认的入口改为`c:\grldr`。

    [boot loader]
    timeout=10
    default=c:\grldr
    [operating systems]
    multi(0)disk(0)rdisk(0)partition(1)\WINDOWS="Microsoft Windows XP Professional" /noexecute=optin /fastdetect /noexecute=alwaysoff
    c:\grldr="Grub"

你可以重新启动，试一下看grub4dos是否正常工作。

## 准备镜像 ##

到 https://www.archlinux.org/download/ 下载最新版 ArchLinux，当前的版本是 `2015.03.01`。
你可以下载其torrent文件，然后用bt工具下载，也可以从镜像站点直接下载。

下载完之后，镜像文件是 `archlinux-2015.03.01-dual.iso`，`dual`表示iso里同时包含了32位和64位两个版本。
将此镜像复制到C盘根目录，并用解压缩工具解压出`arch/boot/i686`下的两个文件: archiso.img 和 vmlinuz，放在C盘根目录下。（i686表示32位的系统，如果你想安装64位的，就把`arch/boot/x86_64`下的两个文件解压出来）

## 引导 ##

然后在`menu.lst`中增加一个入口：

    title Install ArchLinux ...
    root (hd0,0)
    kernel /vmlinuz     archisolabel=ARCH-201503
    initrd /archiso.img

hd0表示第一个硬盘，如果你只有一个硬盘，它一定是`hd0`。
(hd0,0)表示第一个硬盘的第一个分区。

重启机器，用`Install ArchLinux ...`入口，引导进程会因为找不到光盘而停下来，并给你一个root用户的提示符。

我们手动加载镜像:

    mkdir /iso
    mount -r -t ntfs /dev/sda1 /iso
    modprobe loop
    losetup /dev/loop6 /iso/archlinux-20150301-dual.iso
    ln -s /dev/loop6 /dev/disk/by-label/ARCH-201503
    exit

因为我们帮忙挂载好了镜像，系统完成了引导，进入系统，我们得到一个root用户的提示符。

（注意，如果你的C盘是Fat32分区，就把`-ntfs`改为`-vfat`。）

## 准备分区

运行 `fdisk /dev/sda`，添加三个分区，

- /dev/sda7 (512M, 用于`/boot`)，
- /dev/sda8 (30G，用于根系统，即 `/`),
- /dev/sda9 (60G，用于 `/home`)

将三个分区格式化

    mkfs.ext4 /dev/sda7
    mkfs.ext4 /dev/sda8
    mkfs.ext4 /dev/sda9

挂载 `/boot` 和 `/home`

    # mount /dev/sda8 /mnt
    # mkdir /mnt/{boot, home}
    # mount /dev/sda7 /mnt/boot
    # mount /dev/sda9 /mnt/home

## 安装 ##

为了加快软件下载速度，我们先改一下源列表，编辑 `/etc/pacman.d/mirrorlist`。
搜索China，把中国的镜像站点都保留下来，其余的都删掉。
然后，把163的镜像站点放在第一位。

安装基本系统和网络工具

    pacmstrap /mnt base base-devel net-tools

生成文件分区表

    genfstab -U -p /mnt >> /mnt/etc/fstab

用 `arch-chroot /mnt` 改变根目录，到我们真正安装的系统下去操作：

1. 编辑`locale.gen`，把`en_US.UTF-8`, `zh_CN.UTF-8`, `zh_CN.GBK`, `zh_CN.GB2312`, `zh_CN.GB18030`前的`#`去掉，然后运行`locale-gen`生成这些字符集的locale。
2. 设置时区， `ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime`
3. 设置主机名, `echo your_host_name >> /etc/hostname`
4. 生成ramdisk， `mkinitcpio -p linux`
5. 用户，先用`passwd`更改root的密码，然后`useradd -m -g users -G wheel -s /bin/bash your_user_name`添加用户，并`passwd your_user_name`设置密码。

然后`exit`退出chroot，重启吧。再进winXP，改一下`c:\menu.lst`，添加ArchLinux的启动入口

    title GNU/Linux ArchLinux
    root (hd0,6)
    kernel /boot/vmlinuz-linux root=/dev/sda8 ro vga=791 init=/usr/lib/systemd/systemd
    initrd /boot/initramfs-linux.img
    boot

重启后，发现ArchLinux没有自动联网，我手动运行了一下 `dhcpd`，网络就通了。

## 图形界面

你可以 `lspci -v`看一下，发现所有的设备都已经被驱动起来。这就是ArchLinux爽的地方。

为xserver安装显示驱动: `# pacman -S xf86-video-ati xf86-video-intel`。
Ati驱动独立显卡，intel驱动GPU。

检查有没有 `startx` 程序，如果没有，就安装 `xorg-xinit`。

接下来，就是我常用的软件了，我最爱的编辑器Emacs和最喜欢的窗口管理器Awesome。

对了，还有fcitx输入法。因为我用双拼，所以不觉得Linux下的输入法有多逊。

编辑 ~/.xinitrc，内容如下：

    export LC_CTYPE="zh_CN.UTF-8"
    export XMODIFIERS=@im=fcitx
    fcitx -d
    exec dbus-launch awesome

注意， awesome 前面的 dbus-launch 是必要的。这样，文件管理器才会显示可以挂载的卷和移动设备。

`startx`，开始工作吧。

笔记本之前用 winxp 系统，风扇老是呜呜叫，现在灰常安静有没有。

2015-03-11 Wed


## flash player plugin ##
/usr/lib/mozilla/plugins/libflashplayer.so
pacman -S flashplugin

## GTK主题设置 ##
https://wiki.archlinux.org/index.php/GTK%2B

驱动触摸板
pacman -S xf86-input-synaptics

ntfs-3g
支持ntfs写入，否则只能读不能写

## 如果装好Linux，没有声音，怎么办？ ##

现代的Linux发行版对声卡的支持都应该没有问题。系统装好，声卡就应该正常工作。
（尤其是ArchLinux，我觉得对硬件支持最跟得上时代步伐。）

可是我用mplayer播放mp3文件却没有声音，但也没有看到报错信息。

`lspci -v` 发现声卡驱动确实载入。

`alsa-mixer`(需要安装alsa-utils)把Master的音量也调到了最大。

百思不得其解啊。

查看 [Arch wiki](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture#Unmuting_the_channels) 才知道，alsa默认把所有通道静音。

打开`alsa-mixer`，如果发现Master下面显示MM，则表示Master通道被静音。我的果然是MM。

用左右方向键选中Master通道，按`m`键，切换静音状态，会发现`MM`变为了`00`，这时Master通道的静音状态就被取消了。

再用mplayer播放歌曲，就正常发声了。

2015-03-12 Thu


[ArchWiki上关于默认应用的文章](https://wiki.archlinux.org/index.php/Default_applications)
