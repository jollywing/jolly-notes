标准文件描述符：0是标准输入，1是标准输出，2是标准错误输出。
如果想将标准输出和标准错误输出都重定向到一个文件，可以用>&来结合两个输出。如：kill -l 1234 >killouterr.txt 2>&1
如果想丢弃程序的输出信息，可以将之重新定向到Unix的通用回收站:/dev/null：kill -l 1234 >/dev/null 2>&1

shell的通配符扩展（globbing）
用*匹配一个字符串。
用?匹配单个字符。
[xyz]表示匹配xyz任意一个字符。
[^xyz]匹配没有出现在xyz中的字符。
{}匹配{}中的字符串分组。

引用一个命令的输出有两种方式：
`cmd`或$(cmd)
再加上管道，一个命令可以有三种表达方式：
1 more `grep -l POSIX *`
2 more $(grep -l POSIX *)
3 grep -l POSIX * |more

使用file工具可以查看文件类型。如file /usr/bin/gvim
