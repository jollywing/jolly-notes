## [SOLVED] C/C++ 有unsigned float和unsigned double类型吗？ ##
浮点数规范中没有关于符号的规定。
c/c++认为检测一个浮点数有没有符号是低效的。
参见[Why doesn't C have unsigned floats?](http://stackoverflow.com/questions/512022/why-doesnt-c-have-unsigned-floats)

## [UNSOLVED] C语言中浮点数的存储 ##


## C标准函数库 ##

## 中标软件 ##
写出查找从一个集合中输出所有子集合的算法.
写出quick_sort
如何看待在函数中定义很多静态变量.
写出在母串中查找子串出现次数的代码.
写出二分查找的代码.
循环链表的节点对换和删除。
实现任意长度的整数相加或者相乘功能。

int binary_search(int* arr, int key, int n)
{
   int low = 0;
   int high = n - 1;
   int mid;
   while (low <= high)
   {
      mid = (high + low) / 2;
      if (arr[mid] > k)
         high = mid - 1;
      else if (arr[mid] < k)
         low = mid + 1;
      else
         return mid;
   }
   return -1;
}
找出两个中文句子的相似度.(例如"中国江苏南京" "江苏省中国南京市".实际上是指的
同一个地方.面试官的要求是一分钟给出求相似度的算法.)(幸好听老师讲过中文分词,要不
然当场就挂了)

求出相似度的算法.

字符串相似度
中文相似度

不用任何局部和全局变量实现int strlen(char *a)

int strlen(char *a) {
    if('\0' == *a)
        return 0;
    else
        return 1 + strlen(a + 1);
}

int strlen(const char* str)
{
   assert(str != NULL);
   int len = 0;
   while ('\0' != *str++)
      len++;
   return len;
}

写函数完成内存的拷贝
void* memcpy( void *dst, const void *src, unsigned int len )
{
    register char *d;
    register char *s;
    if (len == 0)
        return dst;
    if ( dst > src )  //考虑覆盖情况
    {
        d = (char *)dst + len - 1;
        s = (char *)src + len - 1;
        while ( len >= 4 )  //循环展开，提高执行效率
        {
            *d-- = *s--;
            *d-- = *s--;
            *d-- = *s--;
            *d-- = *s--;
            len -= 4;
        }
        while ( len-- )
        {
            *d-- = *s--;
        }
    }
    else if ( dst < src )
    {
        d = (char *)dst;
        s = (char *)src;
        while ( len >= 4 )
        {
            *d++ = *s++;
            *d++ = *s++;
            *d++ = *s++;
            *d++ = *s++;
            len -= 4;
        }
        while ( len-- )
        {
            *d++ = *s++;
        }
    }
    return dst;
}
出现次数相当频繁
