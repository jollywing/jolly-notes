# phpunit的安装 #

##官方指引

很遗憾， phpunit还没有在ArchLinux的仓库里。

所以使用下载安装的方式。按照[官方的指引](https://phpunit.de/getting-started.html)：

    wget https://phar.phpunit.de/phpunit.phar
    chmod +x phpunit.phar
    sudo mv phpunit.phar /usr/local/bin/phpunit
    phpunit --version

结果得到下面的错误：

    PHP Warning:  realpath(): open_basedir restriction in effect. File(/usr/local/bin/phpunit) is not within the allowed path(s): (/srv/http/:/home/:/tmp/:/usr/share/pear/) in /usr/local/bin/phpunit on line 3
    PHP Fatal error:  Class 'Phar' not found in /usr/local/bin/phpunit on line 714

## 启用phar扩展

先解决`Fatal error: Class 'Phar' not found`。

    ls /usr/lib/php/modules

发现有 phar.so，说明Phar的扩展已经安装，那么是不是该扩展没有Enable呢？
打开 `/etc/php/php.ini`搜索 `phar`，果然发现 `extension=phar.so`被注释掉了。去掉该行前面的 `;`，保存php.ini，再次运行 `phpunit --version`。

    PHP Warning:  realpath(): open_basedir restriction in effect. File(/usr/local/bin/phpunit) is not within the allowed path(s): (/srv/http/:/home/:/tmp/:/usr/share/pear/) in /usr/local/bin/phpunit on line 3
    PHP Warning:  Phar::mapPhar(): open_basedir restriction in effect. File(/usr/local/bin/phpunit) is not within the allowed path(s): (/srv/http/:/home/:/tmp/:/usr/share/pear/) in /usr/local/bin/phpunit on line 714

`Fatal error`解决了，但警告还在，而且phpunit没有正常运行。

## php对文件访问的保护机制

google之，发现这里有解释: http://www.templatemonster.com/help/open_basedir-restriction-in-effect-filex-is-not-within-the-allowed-paths-y.html

> PHP open_basedir protection tweak is a Safe Mode security measure that prevents users from opening files or scripts located outside of their home directory with PHP, unless the folder has specifically excluded. PHP open_basedir setting if enabled, will ensure that all file operations to be limited to files under certain directory, and thus prevent php scripts for a particular user from accessing files in unauthorized user’s account. When a script tries to open a file with, for example, fopen() or gzopen(), the location of the file is checked. When the file is outside the specified or permissible directory-tree, PHP will refuse to open it and the following errors may occur: ...

意思是说：php.ini中的`open_basedir`是php为保证安全进行文件访问的设置。如果该选项被赋值，所有的文件操作将限定在特定的目录里，这样可以防止某个用户使用php脚本读取未授权的内容。当你想通过`fopen`或`gzopen`打开一个文件时，如果该文件的位置不再被允许的目录下面，就会出现上述的警告信息。

从警告信息发现可以访问的目录包括 `/srv/http/:/home/:/tmp/:/usr/share/pear/`，刚好 `~/bin`即在PATH变量中，也属于可以被php脚本读取的目录，于是

    mv /usr/local/bin/phpunit ~/bin

再运行`phpunit --version`，得到正确结果：

    PHPUnit 4.5.0 by Sebastian Bergmann and contributors.

phpunit安装成功!

# 用phpunit入门TDD #

> 用phpunit实战TDD系列

## 从一个银行账户开始

假设你已经 [安装了phpunit](http://segmentfault.com/blog/jollywing/1190000002547947).

我们从一个简单的银行账户的例子开始了解TDD(Test-Driven-Development)的思想。

在工程目录下建立两个目录， `src`和`test`，在`src`下建立文件 `BankAccount.php`，在`test`目录下建立文件`BankAccountTest.php`。

按照TDD的思想，我们先写测试，再写生产代码，因此`BankAccount.php`留空，我们先写`BankAccountTest.php`。

    <?php
    class BankAccountTest extends PHPUnit_Framework_TestCase
    {
    }
    ?>

现在我们运行一下，看看结果。运行phpunit的命令行如下：

    phpunit --bootstrap src/BankAccount.php test/BankAccountTest.php

`--bootstrap src/BankAccount.php`是说在运行测试代码之前先加载 `src/BankAccount.php`，要运行的测试代码是`test/BankAccountTest.php`。

如果不指定具体的测试文件，只给出目录，phpunit则会运行目录下所有文件名匹配 `*Test.php` 的文件。因为`test`目录下只有`BankAccountTest.php`一个文件，所以执行

    phpunit --bootstrap src/BankAccount.php test

会得到一样的结果。

    There was 1 failure:

    1) Warning
    No tests found in class "BankAccountTest".

    FAILURES!
    Tests: 1, Assertions: 0, Failures: 1.

一个警告错误，因为没有任何测试。

## 账户实例化

下面我们添加一个测试。注意，TDD是一种设计方法，可以帮助你自底向上地设计一个模块的功能。我们写测试的时候，要从用户的角度出发。如果用户使用我们的`BankAccount`类，他首先做什么事呢？一定是新建一个BankAccount的实例。那么我们第一个测试就是对于 *实例化* 的测试。

    public function testNewAccount(){
        $account1 = new BankAccount();
    }

运行phpunit，意料之中地失败。

    PHP Fatal error:  Class 'BankAccount' not found in /home/wuchen/projects/jolly-code-snippets/php/phpunit/test/BankAccountTest.php on line 5

没有发现`BankAccount`类的定义，下面我们就要写生产代码。使测试通过。在`src/BankAccount.php`（后面称之为源文件）中输入以下内容：

    <?php
    class BankAccount {
    }
    ?>

运行phpunit，测试通过。

    OK (1 test, 0 assertions)

接下来，我们要增加测试，使得测试失败。如果新建一个账户，账户的余额应该是0。于是我们添加了一个`assert`语句：

    public function testNewAccount(){
        $account1 = new BankAccount();
        $this->assertEquals(0, $account1->value());
    }

注意`value()`是`BankAccount`的一个成员函数，当然这个函数还没有定义，作为使用者我们希望`BankAccount`提供这个函数。

运行phpunit，结果如下：

    PHP Fatal error:  Call to undefined method BankAccount::value() in /home/wuchen/projects/jolly-code-snippets/php/phpunit/test/BankAccountTest.php on line 6

结果告诉我们`BankAccount`并没有`value()`这个成员函数。添加生产代码：

    class BankAccount {
        public function value(){
            return 0;
        }
    }

为什么要让`value()`直接返回0,因为测试代码中希望`value()`返回0。TDD的原则就是不写多余的生产代码，刚好让测试通过即可。

## 账户的存取

运行phpunit通过后，我们先假设`BankAccount`的实例化已经满足要求了，接下来，用户希望怎么使用`BankAccount`呢？一定希望往里面存钱，嗯，希望`BankAccount`有一个deposit函数，通过调用该函数，可以增加账户余额。于是我们增加下一个测试。

    public function testDeposit(){
        $account = new BankAccount();
        $account->deposit(10);
        $this->assertEquals(10, $account->value());
    }

账户初始余额是0,我们往里面存10元，其账户余额当然应该为10。运行phpunit，测试失败，因为deposit函数还没有定义：

    .PHP Fatal error:  Call to undefined method BankAccount::deposit() in /home/wuchen/projects/jolly-code-snippets/php/phpunit/test/BankAccountTest.php on line 11

接下来在源文件中增加deposit函数：

    public function deposit($ammount) {
    }

再运行phpunit，得如下结果：

    1) BankAccountTest::testDeposit
    Failed asserting that 0 matches expected 10.

这时因为我们在deposit函数中并没有操作账户余额，余额初始值为0，deposit函数执行之后依然是0，不是用户期望的行为。我们应该往余额上增加用户存入的数值。

为了操作余额，余额应该是BankAccount的一个成员变量。这个变量不允许外界随便更改，因此定义为私有变量。下面我们在生产代码中加入私有变量`$value`，那么`value`函数应该返回`$value`的值。

    class BankAccount {
        private $value;

        public function value(){
            return $this->value;
        }

        public function deposit($ammount) {
            $this->value = 10;
        }
    }

运行 phpunit，测试通过。接下来，我们想，用户还需要什么？对，取钱。当取钱时，账户余额要扣除这个值。如果给 `deposit`函数传递负数，就相当于取钱了。
于是我们在测试代码的`testDeposit`函数中增加两行代码。

    $account->deposit(-5);
    $this->assertEquals(5, $account->value());

再运行 phpunit，测试失败了。

    1) BankAccountTest::testDeposit
    Failed asserting that 10 matches expected 5.

这时因为在生产代码中我们简单地把`$value`设成10的结果。改进生产代码。

    public function deposit($ammount) {
        $this->value += $ammount;
    }

再运行phpunit，测试通过。

## 新的构造函数

接下来，我想到，用户可能需要一个不同的构造函数，当创建`BankAccount`对象时，可以传入一个值作为账户余额。于是我们在`testNewAccount`增加这种实例化的测试。

    public function testNewAccount(){
        $account1 = new BankAccount();
        $this->assertEquals(0, $account1->value());
        $account2 = new BankAccount(10);
        $this->assertEquals(10, $account2->value());
    }

运行phpunit，结果为：

    1) BankAccountTest::testNewAccount
    Failed asserting that null matches expected 10.

这时因为`BankAccount`没有带参数的构造函数，因此`new BankAccount(10)`会返回一个空对象，空对象的`value()`函数自然返回的也是null。为了通过测试，我们在生产代码中增加带参数的构造函数。

    public function __construct($n){
        $this->value = $n;
    }

再运行测试：

    1) BankAccountTest::testNewAccount
    Missing argument 1 for BankAccount::__construct(), called in /home/wuchen/projects/jolly-code-snippets/php/phpunit/test/BankAccountTest.php on line 5 and defined

    /home/wuchen/projects/jolly-code-snippets/php/phpunit/src/BankAccount.php:5
    /home/wuchen/projects/jolly-code-snippets/php/phpunit/test/BankAccountTest.php:5

    2) BankAccountTest::testDeposit
    Missing argument 1 for BankAccount::__construct(), called in /home/wuchen/projects/jolly-code-snippets/php/phpunit/test/BankAccountTest.php on line 12 and defined

    /home/wuchen/projects/jolly-code-snippets/php/phpunit/src/BankAccount.php:5
    /home/wuchen/projects/jolly-code-snippets/php/phpunit/test/BankAccountTest.php:12

两个调用`new BankAccount()`的地方都报告了错误，增加了带参数的构造函数，不带参数的构造函数又不行了。从`c++/java`过渡来的同学马上想到增加一个默认的构造函数：

    public function __construct() {
        $this->value = 0;
    }

但这样是不行的，因为php不支持函数重载，所以不能有多个构造函数。

怎么办？对了，我们可以为参数增加默认值。修改构造函数为：

    public function __construct($n = 0){
        $this->value = $n;
    }

这样调用 `new BankAccount()`时，相当于传递了0给构造函数，满足了需求。
phpunit运行以下，测试通过。

这时，我们的生产代码为：

    <?php
    class BankAccount {
        private $value;             // default to 0

        public function __construct($n = 0){
            $this->value = $n;
        }

        public function value(){
            return $this->value;
        }

        public function deposit($ammount) {
            $this->value += $ammount;
        }
    }
    ?>

## 总结

虽然我们的代码并不多，但是每一步都写得很有信心，这就是TDD的好处。即使你对php的语法不是很有把握（比如我），也可以对自己的代码很有信心。

用TDD的方式写程序的另一个好处，就是编码之前不需要对单个模块进行仔细的设计，可以在写测试的时候进行设计。这样开发出来的模块既可以满足用户需要，也不会冗余。

后面将会介绍 phpunit 的更多用法。

2015-02-10 Tue

## phpunit ##
针对类 Class 的测试写在类 ClassTest 中。

ClassTest（通常）继承自 PHPUnit_Framework_TestCase。

测试都是命名为 test* 的公用方法。

另外，你可以在方法的文档注释块(docblock)中使用 @test 标注将其标记为测试方法。

在测试方法内，类似于 assertEquals()（参见附录 A）这样的断言方法用来对实际值与预期值的匹配做出断言。

    /**
     * @test
     * @expectedException InvalidArgumentException
     */
    public function newAccountException() {
        $r = 0 - rand(10, 100);
        $account = new BankAccount($r);
    }

1) BankAccountTest::newAccountException
Failed asserting that exception of type "InvalidArgumentException" is thrown.

    public function __construct($n = 0){
        if($n < 0){
            throw new InvalidArgumentException('Account value can not be negative', 10);
        }
        $this->value = $n;
    }

# ArchLinux上LEMP环境搭建 #
LEMP = Linux + Nginx + Mysql + PHP.
Nginx以其轻巧稳定，有盖过Apache的势头。
为什么用E代表Nginx，因为Nginx的发音为`engine x`。

本文虽是在ArchLinux上部署LEMP，对其它Linux发行版的部署也有指导意义。

首先，我们安装PHP.

    # pacman -S php

安装 nginx

    # pacman -S nginx

nginx本身不会解析php脚本，它可以利用fastcgi解析php脚本。

    # pacman -S php-fpm

`fpm` 是 `fastcgi process manager` 的缩写。

让php-fpm也负责处理html文件（可选）。

编辑 `/etc/php/php-fpm.conf`，

    security.limit_extensions = .php .php3 .php4 .php5 .html .htm

    systemctl start php-fpm

编辑 `/etc/nginx/nginx.conf`，把处理php脚本的部分去掉注释，并修改成类似的样子。

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        location ~ \.(php|html|htm)$ {
           root           /home/wuchen/projects/goto-kick;
           fastcgi_pass   unix:/run/php-fpm/php-fpm.sock;
           fastcgi_index  index.php;
           fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
           include        fastcgi_params;
        }

然后，`systemctl restart nginx`应该就可以了。
参见 <https://wiki.archlinux.org/index.php/Nginx#PHP_implementation>.
