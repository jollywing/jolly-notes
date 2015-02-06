## 目录 ##
1. [字符串](#string)

<a name="#string"></a>
## 字符串 ##

- 复制字符串 `strcpy(char *dest, const char *src)`, `#include <string.h>`, 注意： **即使dest的空间不足，也可以复制成功。**
- 复制字符串 `strcpy(char *dest, const char *src, size_t n)`, `#include <string.h>`, 当你想复制`src`的全部内容时，记得n为 `strlen(src)+1`，这样可以包含src结尾处的0.
