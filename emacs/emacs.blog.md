# 在Emacs中使用GNU Global阅读代码 #

### 什么是GNU Global ###

[GNU global](http://www.gnu.org/software/global/)
是一款优秀的代码阅读工具。
能对符号的定义和引用建立索引，方便代码阅读。

GNU global支持的语言很多，
它自身支持 C, C++, Yacc, Java, PHP4 和汇编语言中符号的定义和引用，
还通过 Exuberant Ctags 支持40余种语言的符号定义的索引。
能通过命令行使用，也能和Vim以及Emacs很好地集成。

### 安装GNU Global ###

对于Unix/Linux用户来说，可以直接从仓库进行安装。安装完不需要进行其它设置，很省事。

Windows用户要自己去下载。
到Gnu Global的 [下载页面](http://www.gnu.org/software/global/download.html)，
可以下载代码，自己用mingw编译，也可以下载预编译的二进制文件。

因为自己编译麻烦，我直接下载了二进制包。
下载zip压缩包后，解压，将其bin目录加入Emacs路径。
具体可以这样做：

    (setenv "PATH" (concat "/path/to/global/bin;" (getenv "PATH")))

然后在Emacs的shell中试一下 `gtags --help`，看gtags能否正常运行。

### 在Emacs中使用Gtags ###

1. 安装 `gtags.el`。
   gtags安装时自带了gtags.el，找到它，把它复制到emacs的 `load-path` 中。
   也可以用 elpa 安装 gtags.el.
   准备好 `gtags.el` 之后，在 .emacs 或是 .emacs.d/init.el 中加入
   `(setq gtags-suggested-key-mapping t)` 以使用建议的键绑定。


2. 生成代码索引文件。
   打开在代码目录下执行 `gtags`，将生成索引，生成GPATH, GTAGS, GRTAGS。
   如果想看详细输出，用 `gtags -v`，能看到哪些文件被索引了。

3. 在Emacs中打开一个源文件， `M-x gtags-mode`，如果 `gtags.el` 正确安装了，就会启动 gtags minor-mode。
   然后就可以使用gtags的按键绑定了。我常用的按键如下：

   - `C-c v`，告诉Emacs项目的根目录，即到哪里去找GTAGS等文件。这一步不要跳过，否则你查找符号时Emacs会问你去哪里查找tags。
   - `M-.`，跳转到符号定义。
   - `C-t`，返回。
   - `C-c g`，在代码中用grep查找符号。
   - `C-c s`, 搜索某个符号。
   - `C-c r`, 看一个函数在哪些地方被引用。

### 使用windows遇到的问题 ###

在Linux/Unix上使用Emacs + global时，一般不会有什么问题。
但在Windows上会遇到些问题。

第一个问题，我按 `C-c v` 告诉 global 去哪查找TAGS时。Emacs报错。

    gtags-get-rootpath: Searching for program: permission denied, global

这说明在执行gtags.el中的 `gtags-get-rootpath` 时，找不到 `global` 程序。

如果Emacs报错: `Searching for program: permission denied, xxx`
说明 xxx 不在 `exec-path` 中。

这里要说一下 emacs 中 "PATH" 和 exec-path 的区别。
如果你想在emacs的SHELL中调用某个程序，要把它的路径加入 "PATH" 中。
如果你想在 elisp 中调用某个程序，要把它的路径加入 `exec-path`.

Emacs启动时，会根据系统环境变量PATH的值初始化`exec-path`。
如果你后面通过 `setenv` 向 PATH 中加入了某个路径，
`exec-path`并不会自动包含这个路径。

比如，刚才我们通过

    (setenv "PATH" (concat "/path/to/global/bin;" (getenv "PATH")))

向PATH中加入了global的执行路径，`exec-path` 中并不包含该路径，所以会报错。
我们要向 `exec-path` 中加入该路径。

    (setq exec-path (append exec-path '("/path/to/global/bin")))

把global的执行路径加入 `exec-path` 之后，再按 `C-c v` 就能正常运行了。

按 `M-.` 寻找一个 TAG 试试。又出错了。

    global: directory 'e:/jollywing/job/Casparcg/Server/' not found.

其中`e:/jollywing/job/Casparcg/Server/`是刚才通过 `C-c v` 设置的项目根目录，怎么会找不到呢？

偶然发现，去掉路径最后的 `/` ，即根目录设为 `e:/jollywing/job/Casparcg/Server` 就可以了。

最后说明一下，在操蛋的windows下，才会遇到这些问题。

2014-05-13

# 挖掘Emacs Imenu的潜力 #

### Imenu介绍 ###

imenu是Emacs自带的一个工具，它能够分析当前缓冲区中的定义，并生成索引。

Imenu不仅能分析程序源文件，也能分析格式化的文档，比如HTML，Tex 以及轻量化标记语言 (rst,
markdown, emacs org等)。

对于程序源文件，它主要生成函数定义的索引。
(WhichFunction模式就是使用了imenu生成的索引信息，speedbar也使用了imenu生成的信息)。

对于结构化文档，它生成标题和章节的大纲。

### 使用Imenu ###

我们打开一个C的源文件，里面定义了几个函数。
`M-x imenu` 回车，imenu会提示你输入要跳转到那个符号定义。
我们按TAB，imenu就会把在一个缓冲区中列出所有的函数定义。
我们根据提示输入某个函数的名字，按回车跳转到定义处。

这样似乎不是很方便，我们可以 `M-x imenu-add-menubar-index`，
这时候菜单中多出一个Index的菜单，打开Index，里面就是imenu生成的索引。
用鼠标点击就可以导航了，方便多了吧。

我们可以设置在编辑某种主模式的文件时，imenu的索引自动出现在菜单中。
比如，我想在编辑c程序的时候，使用imenu的菜单索引。

    (add-hook 'c-mode-hook 'imenu-add-menubar-index)

如果想要所有模式下都在菜单栏显示imenu的索引，可以用[EmacsWiki](http://www.emacswiki.org)上的技巧：
因为你在进入某个主模式后，会运行 `font-lock-mode`。（注意，假设你已经 `(setq global-font-lock-mode t)`）。
你可以把 `imenu-add-menubar-index` 加在 `font-lock-mode-hook` 上。
用下面代码，你可以在任何支持imenu的buffer的菜单栏加入imenu索引。

    (defun try-to-add-imenu ()
      (condition-case nil (imenu-add-to-menubar "Imenu") (error nil)))
    (add-hook 'font-lock-mode-hook 'try-to-add-imenu)

我们发现Imenu菜单中有个 `*Rescan*` 项，它的作用是告诉imenu扫描缓冲区，重新生成索引。
有时，当我们更改了文件，Imenu并没有更新，这时我们就要按一下 `*Rescan*`。

### imenu的扩展 ###

- icicle-imenu: 可以分类浏览Index，比如专门看函数、变量、宏等。
- imenu+: 拓展imenu，可以支持开关函数，是否按某种方式排序，是否显示注释中的索引等。
- [imenu-anywhere](https://github.com/vitoshka/imenu-anywhere): 以IDO的方式
  显示所有打开的同类buffer中的索引。当你写只有几个源文件的小项目时，这个就差不
  多够用了。

### 高级用法：自定义Imenu ###

Imenu能支持很多模式。
但有的主模式并不支持imenu，这是因为在主模式定义时并没有定义 `imenu-generic-expression`。
这时，我们可以自己为该模式定义 `imenu-generic-expression`，不过比较复杂。
看 [EmacsWiki](http://www.emacswiki.org) 上的例子，为sql模式定义 `imenu-generic-expression`。

    (setq sql-imenu-generic-expression
           '(("Comments" "^-- \\(.+\\)" 1)
    	 ("Function Definitions" "^\\s-*\\(function\\|procedure\\)[ \n\t]+\\([a-z0-9_]+\\)\
     [ \n\t]*([a-z0-9 _,\n\t]*)[ \n\t]*\\(return[ \n\t]+[a-z0-9_]+[ \n\t]+\\)?[ai]s\\b" 2)
    	 ("Function Prototypes" "^\\s-*\\(function\\|procedure\\)[ \n\t]+\\([a-z0-9_]+\\)\
     [ \n\t]*([a-z0-9 _,\n\t]*)[ \n\t]*\\(return[ \n\t]+[a-z0-9_]+[ \n\t]*\\)?;" 2)
    	 ("Indexes" "^\\s-*create\\s-+index\\s-+\\(\\w+\\)" 1)
    	 ("Tables" "^\\s-*create\\s-+table\\s-+\\(\\w+\\)" 1)))

    (add-hook 'sql-mode-hook
            (lambda ()
               (setq imenu-generic-expression sql-imenu-generic-expression)))

总的来说，当我们编写小的项目和结构化文档时，imenu是个很实用的小工具。

2014-05-15 周四

# 探索Emacs SpeedBar #

    作者: Jolly Wing(jiqingwu@gmail.com)
    生成: 2014-05-16 周五
    转载请保留作者信息

### 简介 ###

从Emacs 23.2开始，Speedbar也变成了Emacs自带的组件。
和[imenu](http://blog.segmentfault.com/jollywing/1190000000507209)类似，
它也能显示文件内容的索引，但比imenu更强大一些。

`M-x speedbar` 会打开一个窄而高的导航窗口，里面显示的是文件列表，点击每个文件前的 `+`，能展开文件内的索引。
有的索引项还能够进一步展开，点击不能在展开的索引项，就能跳转到文件内对应的位置。
用鼠标用 speedbar 还是很方便的。

再次 `M-x speedbar` 会关闭speedbar窗口。在speedbar窗口按 `q`也会关闭speedbar窗口。

至于怎么使用，在speedbar窗口点右键，弹出的菜单已经够详细了。

要想让speedbar随Emacs一起启动，在启动文件里加上

    (speedbar 1)

### speedbar的显示模式 ###

speedbar有多种模式，可以显示以树形结构显示文件和目录，也可以显示当前活跃的buffer。
你可以在speedbar窗口点右键进入 `Display`的子菜单进行模式切换。

在显示文件模式下，speedbar可以作为文件管理器使用。快捷键如下：

- U 进入上层目录
- C 拷贝文件
- D 删除文件
- R 重命名

在显示缓冲区的模式时，也可以管理buffer。
如 `k` 删除buffer，`r` 重新从硬盘读取内容到buffer。

针对特别的缓冲区，speedbar会进入特别的模式。
比如你在查看emacs手册，speedbar会进入info模式，列出所有手册的节点和子节点，方便你阅读手册。

以上说的都是皮毛，下面讲点实在的，主要讲讲speedbar的工作原理。

### speedbar和imenu ###

speedbar使用什么数据生成的索引呢？
它不仅使用imenu的分析结果，也使用 *etags* (Emacs自带的生成tags的工具) 和 *semantic* (Emacs自带的用elisp实现的分析语法的工具)的分析结果。

默认情况下，speedbar使用的是imenu分析的结果。

我们可以通过查看 `speedbar-supported-extension-expressions` 变量的值，
(`C-h v speedbar-supported-extension-expressions RET`)
看看 speedbar 能分析哪些类型的文件。

### speedbar和etags ###

怎样让speedbar使用etags分析文件内容？
有一个变量 `speedbar-use-imenu-flag` 控制 speedbar 使用imenu还是etags分析源文件。
默认情况下这个变量的值是 `t`，即使用 imenu 的分析结果。
将这个变量值设为 `nil`，speedbar会使用etags分析文件。

    (setq speedbar-use-imenu-flag nil)

其实etags的分析结果好不到哪去。而且etags支持的文件类型很少。
`C-h v speedbar-fetch-etags-parse-list RET`查看一下
`speedbar-fetch-etags-parse-list` 的值， 结果如下：

    (("\\.\\([cChH]\\|c\\+\\+\\|cpp\\|cc\\|hh\\|java\\|cxx\\|hxx\\)\\'" . speedbar-parse-c-or-c++tag)
     ("^\\.emacs$\\|.\\(el\\|l\\|lsp\\)\\'" . "def[^i]+\\s-+\\(\\(\\w\\|[-_]\\)+\\)\\s-*")
     ("\\.tex\\'" . speedbar-parse-tex-string)
     ("\\.p\\'" . "\\(\\(FUNCTION\\|function\\|PROCEDURE\\|procedure\\)\\s-+\\([a-zA-Z0-9_.:]+\\)\\)\\s-*(?^?"))

看以看到，etags分析支持的文件只有 c/c++, java, lisp(elisp), tex, pascal几种。

### speedbar和semantic ###

真正强悍的是speedbar和semantic的结合。
怎么让speedbar使用semantic的分析结果？

1. 启动semantic，`M-x semantic-mode`
2. 执行 `(require 'semantic/sb)`，让speedbar使用semantic的分析结果。

再打开一个c/c++的源文件看看，speedbar中的索引细致多了。
用imenu和etags分析的索引只有类和函数。类的成员函数都分析不出来。
现在类的成员，全局变量和函数（包括函数的返回值和参数）都显示出来了。

而且，结合speedbar和semantic，我们在写代码的时候，speedbar还能提示代码的补全呢。
具体怎么做，等到写 **semantic** 专题的时候再讲解吧。

### speedbar的配置和扩展 ###

最后谈谈speedbar的配置和扩展。
speedbar的选项挺多，但需要配置的并不多。
授人以鱼，不如授人以渔。这里讲配置方法，不讲配置。

首先，我们看看speedbar有哪些变量可以配置。
`M-x describe-variable RET speedbar TAB`，会列出speedbar的所有变量。
选择你感兴趣的研究一番吧。

类似的，
`M-x describe-function RET speedbar TAB`，会列出speedbar的所有函数，
有些是改变speedbar行为的，自己研究吧。

其它的emacs组件也可以用类似的方法研究。

至于扩展，有一个叫 `sr-speedbar` 的，会把 speedbar嵌入到emacs的主窗口中。

-------------------------------------------------------------------------------

# Emacs org-mode导出html报错 #

不知道为什么，当org文件中含有`#+TITLE:xxx`时，导出会报类似下面的错误：

    Wrong type argument: listp, #("xxx" 0 3 (:parent (#0)))

暂时不清楚原因。

试验发现`emacs -q`启动Emacs，即不启用自己的配置，org模式导出含有`#+TITLE:xxx`的org文件是没有问题的。我发现我的配置中加载了自己下载的org-mode: `org-20151005`。大概这个版本有问题吧。

所以解决这个问题的方法如下：

1. 首先看自己是否下载了新的org，如果是这种情况可以`emacs -q`启动Emacs，试试Emacs自带的org是否好使。
2. 如果自己没有下载新的org，Emacs自带的org有问题，那就通过`package-install`安装一个新的org，再试试。
