# JollyWing's Android Dev Cheat Sheet #

>都是构建应用的积木，方便自己查询，保持更新

## 环境 ##

1. 安装 *JDK*.
2. 安装 *Apache Ant*.
3. 下载 *Android sdk*, 解压，配置好环境变量，tools和platform_tools都加入PATH。
4. 在命令行运行 ~android~ ，会启动 *android sdk and avd manager* ，通过它可以建立虚拟设备，管理API。
5. [可选] 为Emacs安装 *android-mode*.
6. 因为GFW，安装SDK时总是失败怎么办。启动 *free gate*，为 *android sdk and avd manager* 设置代理。

## 命令行 ##

1. 创建工程. `android create project --name <your_project_name> --package <your_package_name> --activity <main_activity_name> --path <your_project_dir_path> --target <target_id>`
2. 查看有哪些 *target* 可用： `android list target`
3. 升级工程: `android update project --name <project_name> --target <target_id> --path <path>`. (当你要更换target时有用，或者你升级了android开发工具包，也要update一下工程。)
4. 建立一个用debug key签名的应用, 开发时常用的命令。`ant debug`.
5. 建立软件的正式版本, `ant release`
6. 构建测试: `ant test`
7. 只编译java类： `ant compile`
8. 清理编译结果: `ant clean`
9. 安装debug版本到模拟器或已连接的设备: `ant installd`
10. 安装release版本到模拟器或已连接的设备: `ant installr`
11. 安装测试， `ant installt`
12. 卸载， `ant uninstall`
13. 安装一个已有的apk, `adb install hello.apk`
14. 创建模拟器avd(android virtual device)。`android create avd -n <avd_name> -t <target_id>`. 最好在管理器里创建。
15. 查看可用的avd. `android list avd`.
16. 启动avd. `emulator -avd <avd_name>`
17. 查看logcat: `adb logcat`

## 模拟器常用快捷键： ##

- Alt-Enter 全屏
- Home: Home
- Esc: 返回
- F2: Menu
- Ctrl-F11: 在横屏竖屏之间切换。

## Emacs android模式 ##
- `M-x android-mode`，启动`android mode`.
- `C-c C-c c`, 生成(create) debug版本的apk.
- `C-c C-c i`, 安装(install) apk到模拟器或是设备.
- `C-c C-c u`, 卸载(uninstall) apk.
- `C-c C-c e`, 启动模拟器(emulator).
- `C-c C-c d`, 启动ddms.
- `C-c C-c l`, 查看logcat.
- `C-c C-c C`, 清理(Clean) 编译结果。

## android系统的目录结构 ##

- `/system` 存放的是rom的信息；
- `/system/app` 存放rom本身附带的软件即系统软件；
- `/system/data` 存放/system/app 中核心系统软件的数据文件信息。
- `/data` 存放的是用户的软件信息（非自带rom安装的软件）；
- `/data/app` 存放用户安装的软件；
- `/data/data` 存放所有软件（包括/system/app 和 /data/app 和 /mnt/asec中装的软件）的一些lib和xml文件等数据信息；
- `/data/dalvik-cache` 存放程序的缓存文件，这里的文件都是可以删除的。

##  Android Dalvik和JVM的区别 ##
1. `JVM`运行的Java字节码，它从`.class`文件或Jar包中加载字节码然后执行； `Dalvik` 运行的是 `dex` 文件(Dalvik Executable)，生成APK时，Dx工具把所有`.class`文件编译成一个 `dex` 文件。
2. `JVM`是基于栈的，而 `Dalvik` 是基于寄存器实现的。因此 `Dalvik` 比`JVM`有更好的性能，只是硬件通用性差些。
3. 相对于`JVM`来说， `Dalvik` 占用的CPU资源和内存空间都比较少。

2015-02-28 周六

## 设置环境变量ANDROID_SDK_HOME有什么用？ ##

默认情况下，开发者创建的AVD(Android Virtual Device)存放在家目录的.android下。

如果是Linux，其路径就是 `/home/<your_user_name>/.android`。

如果用windows XP，其路径就是 `C:\documents and settings\<your_user_name>\.android`。（win7和win8略有不同）。

如果想更改AVD的存放位置，可以设置环境变量 `ANDROID_SDK_HOME`。

比如在windows下设置 `ANDROID_SDK_HOME` 的值为 `e:\jollywing\`，则你的AVD就会存放在 `e:\jollywing\.android` 目录下。

2015-02-28 周六

## android命令 ##
- android list 会同时列出target和AVD.
- android list avd 列出可用的虚拟设备
- android list target 列出可用的API.

## Android TDD ##
<http://www.cnblogs.com/jacktu/archive/2009/04/17/1438270.html>

android create project -n exercise -t 3 -p ./exercise -k org.jollywing -a MainActivity

mkdir org/jollywing/test
Edit `org/jollywing/test/TestActivity.java`.
ant install
adb shell am instrument -e class org.jollywing.test.TestActivity -w org.jollywing/android.test.InstrumentationTestRunner
