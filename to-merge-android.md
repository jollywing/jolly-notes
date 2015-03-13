R.java是用AAPT工具扫描生成的。

在xml中使用资源
`@资源对应的内部类的类命/资源项的名称`，比如
`android:label="@string/app_name"`

对于标识符资源是特例，因为它不需要专门的文件来定义。
`@+id/标识符代号`

一般为应用指定的包名，应该可以唯一地表示该应用。比如`org.jollywing.helloandroid`

为应用指定需要的权限：在AndroidManifest.xml中，在<manifest ...>标签下添加：

    <uses-permission android:name="android.permission.CALL_PHONE"/>

也可以在<activity.../>标签下添加权限，表示调用该程序所需的权限

    <uses-permission android:name="android.permission.SEND_SMS"/>

应用程序的权限定义在 `Manifest.permission` 中。
