# 动态库的版本 #

gcc 似乎无法指定要链接的动态库的版本， 但我们在 `/usr/lib` 目录下看到每个动态库都带有版本号。
比如 jpeg 的动态库，文件名是 `libjpeg.so.8.0.2`。那我们要链接jpeg的动态库时，是怎么链接到。

/usr/lib/libjpeg.so -> libjpeg.so.8.0.2

# untitled #
mmap 用于建立一段两个或更多程序都能访问的内存。
实际上文件描述符指向的内容并没有载入内存。
但你可以用访问内存的方法去访问文件中的数据。

    #include <sys/mman.h>
    void *mmap(void *addr, size_t len, int prot, int flags,
        int fildes, off_t off);

`addr`是映射的起始地址，你可以为它指定一个值。如果你传递0给它，系统将自动分配一个地址。
`len`是内存映射的长度。如果你传递0给`len`，则mmap调用会失败。
`prot`用于设置内存段的访问权限。
`PROT_READ`(可读), `PROT_WRITE`(可写), `PROT_EXEC`(可执行), `PROT_NONE`(不可访问).
`flags`控制对映射数据段的操作造成的影响。
`MAP_SHARED`(改变是共享的，对映射数据的修改会影响真实的对象),
`MAP_PRIVATE`(改变是私有的，对映射数据的修改不影响真实的对象),
`MAP_FIXED`(精确地翻译地址，告诉mmap返回的地址就是addr的值。不是所有实现都支持),
`fildes` 是文件描述符，`off`是文件的起始偏移，
