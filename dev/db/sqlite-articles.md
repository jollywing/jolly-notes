# sqlite3使用sqlite2创建的数据库 #

## 问题

用 `sqlite 2.8.17` 创建了一个数据库 `heroes.db`。
其中创建了一个表 `heroes`，这张表中存储的是魔兽争霸中英雄的技能数据。
`select * from heroes;`会得到：

    大魔法师|人族|水元素|暴风雪|辉煌光环|时空传送
    山丘之王|人族|风暴之锤|雷霆一击|重击|天神下凡
    血魔法师|人族|炎击|放逐|吸魔|火凤凰
    圣骑士|人族|圣光|圣盾|神圣光环|复活

但是用python通过sqlite3操作`heroes.db`的时候会报错。

    Error: file is encrypted or is not a database

我想也许是sqlite3和sqlite2创建的数据库格式不同造成的。

果然，直接用sqlite3的命令行工具操作`heroes.db`，也报同样的错误。

## 解决

接下来的工作，就是把sqlite2创建的`heroes.db`转换成sqlite3可以使用的格式：

用`sqlite heroes.db`打开数据库文件，然后在sqlite shell中执行：

    .output heroes.sql
    .dump heroes
    .exit

现在`heroes.sql`的内容如下：

    BEGIN TRANSACTION;
    create table heroes (name varchar, race varchar, skill1 varchar, skill2 varchar, skill3 varchar, superskill varchar);
    INSERT INTO heroes VALUES('大魔法师','人族','水元素','暴风雪','辉煌光环','时空传送');
    INSERT INTO heroes VALUES('山丘之王','人族','风暴之锤','雷霆一击','重击','天神下凡');
    INSERT INTO heroes VALUES('血魔法师','人族','炎击','放逐','吸魔','火凤凰');
    INSERT INTO heroes VALUES('圣骑士','人族','圣光','圣盾','神圣光环','复活');
    COMMIT;

可以把原来的`heroes.db`删除了： `rm heroes.db`。

用sqlite3创建新的数据库文件并导入数据：

    sqlite3 heroes.db < heroes.sql

## 验证

现在再用sqlite3 打开heroes.db看看，已经可以进行查询和增改删操作了。
当然python也能通过`import sqlite3`使用该数据库了。

注意，再用sqlite时，直接使用sqlite3比较好，因为python好像只直接支持sqlite3。

2016-03-24 Thu
