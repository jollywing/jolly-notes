
++++++++++++++++++++++++++++++
Linux下连接VPN
++++++++++++++++++++++++++++++

:作者: 吉庆
:Email: jiqingwu@gmail.com
:创建: 2012-06-04
:更新: |date|

.. |date| date::

.. contents:: 目录

什么是VPN
------------------------------

VPN 是 Virtual Private Network 的缩写，译为虚拟专用网络，是通过公
网访问私有网络的一种技术。之所以称作虚拟的，是因为它在公网上建立
了一条虚拟的端到端链路，VPN 客户端可以通过 隧道技术 （UDP打洞？）
直接访问VPN服务器。

对于我们，VPN的主要用途是绕过默认路由的内容拦截，将 HTTP请求 加密发送到 VPN
服务器，再由 VPN服务器 解密后将请求路由出去。也就是 “翻墙”。

VPN的类型
------------------------------

根据使用协议的不同，主要有三类使用较多的VPN ：

- PPTP (Microsoft VPN)。对应的客户端是 pptpclient，需要 主机名，
  用户名，和密码。
- Cisco VPN（思科VPN），对应的客户端是 vpnc，需要主机名、组名、组
  密码、用户名和用户密码。
- OpenVPN，对应的客户端程序似乎也是 openvpn。（？）配置比较麻烦，
  如有需要请参考 archwiki_ 。

由于我只实践了连接 microsoft vpn，本文主要讲解在命令行下用
pptpclient 连接 microsoft 的方法。

.. _archwiki: https://wiki.archlinux.org/index.php/OpenVPN

命令行用 PPTP 连接 windows VPN
--------------------------------------------------

第一步，安装 pptpclient, 
ArchLinux下 ``# pacman -S pptpclient`` 。
Debian或Ubuntu下对应的软件包名似乎是 ``pptp-linux`` ，
``# apt-get install pptp-linux`` 。

假设你要建立的 VPN 隧道名叫 ``myvpn`` ，用你喜欢的编辑器建立
``/etc/ppp/peers/myvpn`` 。
内容如下： ::

    remotename myvpn
    linkname myvpn
    ipparam myvpn
    pty "pptp <host> --nolaunchpppd "
    name <name>
    usepeerdns
    require-mppe
    refuse-eap
    noauth
    
    # adopt defaults from the pptp-linux
    file /etc/ppp/options.pptp

请将 <host> 换成你的 VPN服务器的 域名或 IP，
将 <name> 换成你登录 VPN 服务器的用户名。

然后编辑
``/etc/ppp/chap-secrets`` ，这里保存了登录VPN服务器的用户名和密码。
在文件末尾追加：::

    <name>	myvpn	<passwd> *

记住用你的用户名和密码替换 <name> 和 <passwd>。

配置结束，测试：::

    # pon myvpn nodetach

如果成功，程序不会报错退出，而且会返回本地和远程主机IP以及DNS。

可以用 ``route`` 查看本机的网络出口。可以看见网络出口增加了路由到
VPN服务器的 ``ppp0`` 。如果 ``ppp0`` 已被占用（如你已经拨号连接互
联网），vpn的出口将是 ``ppp1`` ，依此类推。

这时想 “翻墙”还不行。因为默认的路由还不是走的 VPN 隧道，所以你还
是不能访问 `google+`_ 。

我们可以将 VPN隧道 设为默认路由，如果你的vpn出口是 ppp0，用如下命
令： ::

    # route add default dev ppp0

现在，所有的Internet流量都将通过 VPN 中转，翻墙成功，再试一下
`google+`_ 吧。

.. _`google+`: https://plus.google.com


GUI工具
------------------------------

如果你使用桌面环境，可以省点事。

如果你用gnome，可以通过 networkmanager 来建立 VPN 
连接。前提是安装 network-manager-pptp, network-manager-vpnc,
network-manager-openvpn 对 network-manager 进行扩展。

如果你使用KDE，可以安装 kvpnc ，它也是能对付各种 VPN 连接。

如果你没用桌面环境，当然也可以安装 networkmanager 或者 kvpnc，
但我想你可能更倾向于用 依赖很少的wicd 来管理网络连接。
很遗憾，wicd暂不支持 VPN。

说明
------------------------------

还是一知半解，难免有理解错误的地方。
为了交流提高，如果你发现了错误，请一定通过评论或 email我
(jiqingwu@gmail.com) 的方式告诉我，让我们一起来完善这篇文章。

参考了以下文章：

1. https://help.ubuntu.com/community/VPNClient
2. https://wiki.archlinux.org/index.php/Microsoft_VPN_client_setup_with_pptpclient


