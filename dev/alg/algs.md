

# 冒泡排序及其复杂度分析 #

- 问题：给定一个整数序列，按照从小到大的顺序（确切地说，是非递减的顺序）排列序列中的整数。
- 输入：一个整数序列。
- 输出：整数序列，其中的整数升序排列。

因为谭浩强的C语言教材，大家最熟悉的可能就是冒泡排序。
下面是冒泡排序的一个C语言实现，`a`是数组首地址， `size` 是数组元素的个数。

冒泡排序的思想，是让最大的数浮动到数组最后的位置，其次大的数浮动到数组倒数第二个位置……
当然，你也可以从大到小排序，也可以从后向前冒泡。其特征操作是相邻元素的比较和交换。

    void bubble_sort(int *a, int size)
    {
      int i, j, t;
      for(i = 1; i < size; ++i){
        for(j = 0; j < size -i; ++j){
          if(a[j] > a[j+1]){
            t = a[j];
            a[j] = a[j+1];
            a[j+1] = t;
          }
        } // end for j
      }// end for i
    }

时间复杂度分析。其外层循环执行 N - 1次。内层循环最多的时候执行N次，最少的时候执行1次，平均执行 `(N+1)/2`次。
所以循环体内的比较交换约执行 `(N - 1)(N + 1) / 2 = (N^2 - 1)/2`（其中`N^2`是仿照Latex中的记法，表示N的平方）。按照计算复杂度的原则，去掉常数，去掉最高项系数，其复杂度为`O(N^2)`。

冒泡算法的性能改进。上述算法的性能还有改进的空间。给定一个整数序列 `[9, 3, 4, 5, 7]`，每完成一次上述算法的外层循环，整数序列变化为：

    9, 3, 4, 5, 7
    3, 4, 5, 7, 9 (i = 1)
    3, 4, 5, 7, 9 (i = 2)
    3, 4, 5, 7, 9 (i = 3)
    3, 4, 5, 7, 9 (i = 4)

我们发现当第一次外层循环完成后，排序就完成了。后面的循环只有比较，而没有交换。
当一次外层循环中，相邻的元素没有发生交换，就说明数组已经是有序的了，这时可以跳出循环。
这样，我们可以设置一个布尔变量，记录一次外层循环中是否发生交换，如果未发生交换，算法就返回。

改进的冒泡排序的C语言实现如下：

    void bubble_sort_enhanced(int *a, int size)
    {
        int i, j, t;
        unsigned char swapped;
        for(i = 1; i < size; ++i) {
            swapped = 0;
            for(j = 0; j < size - i; ++j) {
                if(a[j] > a[j+1]){
                    t = a[j];
                    a[j] = a[j+1];
                    a[j+1] = t;
                    swapped = 1;
                }
            }
            if(!swapped)
                break;
        }
    }

按照改进的算法，对于一个已经有序的数组，算法完成第一次外层循环后就会返回。
实际上只发生了 N - 1次比较，所以最好的情况下，该算法复杂度是`O(N)`。

2015-03-18 Wed

# 选择排序及其复杂度分析 #

- 问题：给定一个整数序列，按照从小到大的顺序（确切地说，是非递减的顺序）排列序列中的整数。
- 输入：一个整数序列。
- 输出：整数序列，其中的整数升序排列。

选择排序的思想：选出最小的一个和第一个位置交换，选出其次小的和第二个位置交换 ……
直到从第N个和第N-1个元素中选出最小的放在第N-1个位置。

选择排序的C语言实现如下：

    void sel_sort(int *a, size_t size)
    {
        int i, j;
        int min_index;
        int t;
        for(i = 0; i < size - 1; i ++){
            min_index = i;
            for( j = i + 1; j < size; j++){
                if(a[j] < a[min_index])
                    min_index = j;
            }
            if (min_index != i){
                t = a[i];
                a[i] = a[min_index];
                a[min_index] = t;
            }
        }
    }

选择排序的Python实现如下：

    def selection_sort(int_list):
        l = len(int_list)
        for i in range(0, l - 1):
            min = i
            for j in range(i + 1, l):
                if int_list[j] < int_list[min]:
                    min = j
            if i != min:
                t = int_list[i]
                int_list[i] = int_list[min]
                int_list[min] = t

选择排序的复杂度分析。第一次内循环比较N - 1次，然后是N-2次，N-3次，……，最后一次内循环比较1次。
共比较的次数是 `(N - 1) + (N - 2) + ... + 1`，求等差数列和，得 `(N - 1 + 1)* N / 2 = N^2 / 2`。
舍去最高项系数，其时间复杂度为 `O(N^2)`。

虽然选择排序和冒泡排序的时间复杂度一样，但实际上，选择排序进行的交换操作很少，最多会发生 N - 1次交换。
而冒泡排序最坏的情况下要发生`N^2 /2`交换操作。从这个意义上讲，交换排序的性能略优于冒泡排序。
而且，交换排序比冒泡排序的思想更加直观。

2015-03-18 Wed

# 插入排序及其复杂度分析 #

- 问题：给定一个整数序列，按照从小到大的顺序（确切地说，是非递减的顺序）排列序列中的整数。
- 输入：一个整数序列。
- 输出：整数序列，其中的整数升序排列。

插入排序的思想：插入排序是在一个已经有序的小序列的基础上，一次插入一个元素。当然，刚开始这个有序的小序列只有1个元素，就是第一个元素。比较是从有序序列的末尾开始，也就是想要插入的元素和已经有序的最大者开始比起，如果比它大则直接插入在其后面，否则一直往前找直到找到它该插入的位置。如果碰见一个和插入元素相等的，那么插入元素把想插入的元素放在相等元素的后面。所以，相等元素的前后顺序没有改变，从原无序序列出去的顺序就是排好序后的顺序，所以插入排序是稳定的。

插入排序的C语言实现如下（a为数组首地址， size为数组中的元素个数）：

    void insertion_sort(int *a, size_t size)
    {
        int i, j, t;
        for(i = 1; i < size; i++){
            t = a[i];
            j = i - 1;
            while(j >= 0){
                if(a[j] > t){
                    a[j + 1] = a[j];
                }
                else
                    break;
                j--;
            }
            j += 1;
            a[j] = t;
        }
    }

插入排序的时间复杂度分析。在最坏情况下，数组完全逆序，插入第2个元素时要考察前1个元素，插入第3个元素时，要考虑前2个元素，……，插入第N个元素，要考虑前 `N - 1` 个元素。因此，最坏情况下的比较次数是 `1 + 2 + 3 + ... + (N - 1)`，等差数列求和，结果为 `N^2 / 2`，所以最坏情况下的复杂度为 `O(N^2)`。

最好情况下，数组已经是有序的，每插入一个元素，只需要考查前一个元素，因此最好情况下，插入排序的时间复杂度为`O(N)`。

2015-03-18 Wed

# 快速排序及其复杂度分析 #

快速排序有两个方向，左边的i下标一直往右走，当a[i] <= a[center_index]，其中center_index是中枢元素的数组下标，一般取为数组第0个元素。而右边的j下标一直往左走，当a[j] > a[center_index]。如果i和j都走不动了，i <= j, 交换a[i]和a[j],重复上面的过程，直到i>j。 交换a[j]和a[center_index]，完成一趟快速排序。在中枢元素和a[j]交换的时候，很有可能把前面的元素的稳定性打乱，比如序列为 5 3 3 4 3 8 9 10 11， 现在中枢元素5和3(第5个元素，下标从1开始计)交换就会把元素3的稳定性打乱，所以快速排序是一个不稳定的排序算法，不稳定发生在中枢元素和a[j]交换的时刻。

算法过程

　　设要排序的数组是A[0]……A[N-1]，首先任意选取一个数据（通常选用第一个数据）作为关键数据，然后将所有比它小的数都放到它前面，所有比它大的数都放到它后面，这个过程称为一趟快速排序。一趟快速排序的算法是：

1）设置两个变量I、J，排序开始的时候：I=0，J=N-1；

2）以第一个数组元素作为关键数据，赋值给key，即 key=A[0]；

3）从J开始向前搜索，即由后开始向前搜索（J=J-1），找到第一个小于key的值A[J]，并与A[I]交换；

4）从I开始向后搜索，即由前开始向后搜索（I=I+1），找到第一个大于key的A[I]，与A[J]交换；

5）重复第3、4、5步，直到 I=J； (3,4步是在程序中没找到时候j=j-1，i=i+1，直至找到为止。找到并交换的时候i， j指针位置不变。另外当i=j这过程一定正好是i+或j+完成的最后另循环结束)

　　例如：待排序的数组A的值分别是：（初始关键数据：X=49） 注意关键X永远不变，永远是和X进行比较，无论在什么位子，最后的目的就是把X放在中间，小的放前面大的放后面。

A[0] 、 A[1]、 A[2]、 A[3]、 A[4]、 A[5]、 A[6]：

49 38 65 97 76 13 27

　　进行第一次交换后： 27 38 65 97 76 13 49

( 按照算法的第三步从后面开始找)

　　进行第二次交换后： 27 38 49 97 76 13 65

( 按照算法的第四步从前面开始找>X的值，65>49,两者交换，此时：I=3 )

　　进行第三次交换后： 27 38 13 97 76 49 65

( 按照算法的第五步将又一次执行算法的第三步从后开始找

　　进行第四次交换后： 27 38 13 49 76 97 65

( 按照算法的第四步从前面开始找大于X的值，97>49,两者交换，此时：I=4,J=6 )

　　此时再执行第三步的时候就发现I=J，从而结束一趟快速排序，那么经过一趟快速排序之后的结果是：27 38 13 49 76 97 65，即所以大于49的数全部在49的后面，所以小于49的数全部在49的前面。

　　快速排序就是递归调用此过程——在以49为中点分割这个数据序列，分别对前面一部分和后面一部分进行类似的快速排序，从而完成全部数据序列的快速排序，最后把此数据序列变成一个有序的序列，根据这种思想对于上述数组A的快速排序的全过程如图6所示：

　　初始状态 {49 38 65 97 76 13 27}

　　进行一次快速排序之后划分为 {27 38 13} 49 {76 97 65}

　　分别对前后两部分进行快速排序 {27 38 13} 经第三步和第四步交换后变成 {13 27 38} 完成排序。

{76 97 65} 经第三步和第四步交换后变成 {65 76 97} 完成排序。

[排序算法总结](http://www.cnblogs.com/zzp28/articles/1788878.html)

本系列文章（更新中）：

1. [冒泡排序及其复杂度分析](http://www.cnblogs.com/jiqingwu/p/bubble_sort_analysis.html)
2. [选择排序及其复杂度分析](http://www.cnblogs.com/jiqingwu/p/selection_sort_algorithm.html)
3. [插入排序及其复杂度分析](http://www.cnblogs.com/jiqingwu/p/insertion_sort_algorithm.html)

# 二叉查找树 #

http://www.cnblogs.com/huangxincheng/archive/2012/07/21/2602375.html
