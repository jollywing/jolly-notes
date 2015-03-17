

# virtual #

- virtual是实现多态的关键字。
- 被virtual修饰的函数称为虚函数。
- 虚函数才能被派生类重写，但也可以继承父类中的缺省实现。
- 纯虚函数（函数声明后加 const = 0）相当于接口，必须在派生类中重新声明并实现。
- 子类中与父类中虚函数同名的函数自动为虚函数，因此在声明时，可以加
  virtual，也可以不加。

** C++
*** auto
*** wchar_t, wstring
*** lambda function
http://www.devdiv.com/c_lambda_-blog-124976-12996.html
*** Ptr<>

# 类型转换 #

    float a = 0.1f;
    int b = (int &)a;

`(int &)a` 是取 a 的前4个字节，并按整数读取其值。

# OO #
面向对象设计的三原则：封装、继承、多态

    Which of the following are not related to object-oriented design?
    A. Inheritance; B Liskov substitution principle(里氏代换);
    C. Open-close principle (开闭原则);
    D. Polymorphism (多态); E. Defensive programming (防御式编程).

上述题的答案是E.

里氏替换原则是继承复用的基石：子类型能够替换其基类型。

开闭原则是面向对象设计的重要特性之一：对扩展是开放的，对修改是封闭的。

防御式编程只是一种编程技巧，其思想为：子程序不因传入错误数据而崩溃。但每个程序员都防御式编程，容易使程序偏离预定的行为。


C++中的空类默认产生哪些类成员函数？
默认构造函数，析构函数、拷贝构造函数、赋值函数。

当调用默认构造函数构造对象时，不要用 `C c();` 而是用 `C c;`。`C c();`会把`c`声明为一个函数。

C++中的struct可以拥有 `构造/析构/成员函数` 吗？如果可以，那么struct和class的分别是什么？
答：可以。而且struct也可以继承。
struct和class的唯一区别是: class的成员变量默认是private，而struct的成员变量默认是public。
c++存在`struct`关键字，主要是为了让c++编译器可以编译c代码。

注意，如果类里面有静态成员变量，该成员变量只是声明。必须在类外定义该变量，初始化。
