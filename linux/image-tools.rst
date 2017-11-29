=================================
Linux图像处理
=================================

ImageMagick
=================================

安装imagemagick包后，会有以下执行程序（可以用dpkg -L imagemagick
查看）：

- compare
- animate
- convert
- composite
- conjure
- import
- identify
- stream
- display
- montage
- mogrify

display
------------------------------------

display除了查看图片外，主要用于设置桌面背景。
下面的例子将居中显示图片作为桌面背景。::

  display -window root -backdrop imageName

我还不知道怎么拉伸呢。

import
------------------------------------

import的主要用途是截屏。::

  import -screen ~/imageName

当你点击一个窗口，会截出这个窗口的图。
当你划动鼠标，会截整个屏幕。

``import ~/imageName`` 会截取你选中的屏幕部分。

缩放
------------------------------

使用 convert中的resize子命令。
::

  convert -resize wxh src-pic dst-pic

如果不保持宽高比，强制按指定的宽度和高度缩放，要在geometry后加 `!` ，如：
::

  convert -resize wxh! src-pic dst-pic

宽度和高度可以使用像素表示，也可以用百分比表示：
::

  convert -resize 50%x50% src-pic dst-pic

可以只指定宽度，高度会按高宽比自动计算。::

  convert -resize 100 src-pic dst-pic

