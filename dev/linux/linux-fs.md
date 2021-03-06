

## 文件系统 ##

对于Linux系统，文件系统指的是某个格式化后用于存储文件的设备（如硬盘、软盘或cd-rom）。文件系统可以在很多允许随机访问的存储介质上建立。
为什么不能在顺序访问的存储介质上建立文件系统，如磁带？
二级扩展文件系统－ext2。CD-rom的文件系统－ISO 9660。
Linux下，文件的绝对路径名要小于1024个字符。

## 文件类型 ##

普通文件, 目录文件, 链接文件, 设备文件, 管道文件

1. 普通文件分为文本文件和二进制文件.
2. 设备文件使用主设备号(指定设备类型)和次设备号(指定具体设备)来指定某外部设备.按数据访问方式的不同, 设备分为字符设备和块设备. 大多数设备能同时支持这两种方式.
3. 目录文件（与之对应的是正规文件）是包含文件列表的特殊文件。只有内核能写目录文件。用ls -l查看文件信息时，会发现目录文件的权限的第一个字母是d如drwx------，表示directory。
4. 链接文件分为软链接文件和硬链接文件。

## inode ##

Linux采用索引结构，一个文件占若干个不连续的存储块。这些块的块号记录在一个索引块中。索引块称为 `inode` 结构。

    [inode][data1][data2]...[dataN]

每个磁盘分区有一个文件系统，每个文件系统包含一个引导块，一个记录文件系统信息的超级块，和inode链，以及目录块和数据块。

    [boot block?] [super block?]
    [inode1] [inode2] [inode3] ...
    [data1] [data2] [data3] [dir1]
    [data4] [data5] [dir2] ...

inode中并不包含文件名，文件名存在目录块中。
超级块中记录了inode表、空闲块表等重要信息在磁盘上存放位置。超级块有多大呢？

## 文件访问 ##

在Linux中，几乎一切都是文件。
所以在大多数情况下，只需要使用5个基本的函数:open, close, read, write, ioctl.
系统使用文件时，使用的是文件的inode编号，目录结构只是为了方便人们使用。

## 设备文件 ##

Linux中比较重要的设备文件有3个：/dev/console, /dev/tty, /dev/null
/dev/console是系统控制台，错误信息和诊断信息会被发送到这个设备。
/dev/tty是进程的控制终端。
/dev/null 空设备，所有对这个设备的输出都会丢失。

## API ##

stat和fstat返回一个包含所有文件属性的信息结构。
