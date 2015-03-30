

# 数据结构与算法 #

    Content: 本文档收集我所写的关于数据结构和算法的文章。
    文档格式: markdown
    作者: jollywing@foxmail.com

# 整数的二进制表示中包含多少个1 #

- 问题：给定一个整数，如何判断该整数的二进制表示里有多少个1。
- 现实用途：应该可以用于数据的校验。

解法(c++)：

    #include <iostream>
    #include <assert.h>

    using namespace std;

    // 求解x的二进制表示里有多少个1的算法。
    // x = x & (x -1); 每次消掉一个1.
    int get_one_bit_count(int x) {
        int count = 0;
        while(x){
            count ++;
            x = x & (x - 1);
        }
        return count;
    }

    // 用例测试
    int main() {
        assert(get_one_bit_count(32) == 1);
        assert(get_one_bit_count(15) == 4);
        assert(get_one_bit_count(7) == 3);
        assert(get_one_bit_count(0) == 0);
        return 0;
    }

2015-03-13 Fri
