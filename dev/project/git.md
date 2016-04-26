# 搭建本地Git仓库 #

## 0x0 开启ssh服务

首先开启ssh服务，允许其它人通过ssh访问你在本地搭建的git仓库。

在Debian/Ubuntu下，安装 `openssh-server`，然后用 `systemctl start ssh` 来开启ssh服务。

## 0x1 建立本地仓库

可以建一个名为`git`的用户，以root权限运行

    adduser git

系统会自动创建 `/home/git` 为 `git` 的家目录，并提示你设定git的密码。

`su - git` 切换到 `git` 用户。在 `/home/git` 下新建目录： `mkdir code-base`。

这里我们把`code-base`作为代码仓库的目录名，你可以取其它名字。

进入`code-base`目录，运行

    git init

这样我们的本地仓库就建好了。

    touch readme.txt
    git add readme.txt
    git ci -a -m 'create repo'

这样仓库里就有了 `master` 分支。

## 0x2 clone仓库

退出`git`用户，回到自己的家目录。运行一下命令来克隆我们刚才建的代码仓库。

    git clone ssh://git@xxx.xxx.xxx.xxx/home/git/code-base/.git

其中 `xxx.xxx.xxx.xxx` 是你本机的IP地址。

输入`git`用户的密码，则开始克隆`code-base`。

进入`code-base`目录，你可以像使用 _github_ 上的仓库一样进行操作了：添加文件，修改内容，`git commit`, `git push origin master`等。

在局域网其它机器上，运行同样的命令来克隆仓库：

    git clone ssh://git@xxx.xxx.xxx.xxx/home/git/code-base/.git

2016-04-21 Thu
