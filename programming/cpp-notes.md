
virtual
==============================

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
