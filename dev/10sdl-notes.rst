==============================
SDL笔记
==============================

:author: jiqing
:email: jiqingwu@gmail.com
:create: 2011-12-14
:update: |date|

.. |date| date::

.. contents:: 目录

SDL_Surface
==============================

当你需要直接修改一个SDL_Surface中的像素时，如果这个 surface 需要
Lock，你必须先 SDL_LockSurface(surface)，对该 surface 的操作完成
后，再 SDL_UnlockSurface(surface)。
你可以用 SDL_MUSTLOCK(surface) 判断是否需要 Lock。

输入和事件处理
==============================

SDL使用事件响应输入和窗口管理器的行为，
事件分为四类（可以查看SDL_events.h）：

- 键盘事件
- 鼠标事件
- 窗口事件：得到/失去焦点，移动，改变尺寸，关闭等。
- 系统相关的事件，不懂。

在使用时，不需要单独初始化，即SDL_Init(SDL_INIT_VIDEO)之后就可以
进行事件处理了。

SDL\_gfx
==============================

SDL\_gfxPrimitives
------------------------------

可以查看 SDL\_gfxPrimitives.h 得知当前可用的接口。
颜色格式为0xRRGGBBAA.

**Pixel**

- int pixelColor(SDL_Surface * dst, Sint16 x, Sint16 y,Uint32
  color);
- int pixelRGBA(SDL_Surface * dst, Sint16 x, Sint16 y, Uint8
  r,Uint8 g, Uint8 b, Uint8 a);

**Horizontal line**

- int hlineColor(SDL_Surface * dst, Sint16 x1, Sint16 x2,Sint16
  y, Uint32 color);
- int hlineRGBA(SDL_Surface * dst, Sint16 x1, Sint16 x2,Sint16 y,
  Uint8 r, Uint8 g, Uint8 b, Uint8 a);

**Vertical line**

- int vlineColor(SDL_Surface * dst, Sint16 x, Sint16 y1,Sint16
  y2, Uint32 color);
- int vlineRGBA(SDL_Surface * dst, Sint16 x, Sint16 y1,Sint16 y2,
  Uint8 r, Uint8 g, Uint8 b, Uint8 a);

**Rectangle**

- int rectangleColor(SDL_Surface * dst, Sint16 x1, Sint16
  y1,Sint16 x2, Sint16 y2, Uint32 color);
- int rectangleRGBA(SDL_Surface * dst, Sint16 x1, Sint16
  y1,Sint16 x2, Sint16 y2, Uint8 r, Uint8 g,Uint8 b, Uint8 a);

**Filled rectangle (Box)**

- int boxColor(SDL_Surface * dst, Sint16 x1, Sint16 y1,Sint16 x2,
  Sint16 y2, Uint32 color);
- int boxRGBA(SDL_Surface * dst, Sint16 x1, Sint16 y1, Sint16
  x2,Sint16 y2, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

**Line**

- int lineColor(SDL_Surface * dst, Sint16 x1, Sint16 y1,Sint16
  x2, Sint16 y2, Uint32 color);
- int lineRGBA(SDL_Surface * dst, Sint16 x1, Sint16 y1,Sint16 x2,
  Sint16 y2, Uint8 r, Uint8 g, Uint8 b,Uint8 a);

**AA Line**

- int aalineColor(SDL_Surface * dst, Sint16 x1, Sint16 y1,Sint16
  x2, Sint16 y2, Uint32 color);
- int aalineRGBA(SDL_Surface * dst, Sint16 x1, Sint16 y1,Sint16
  x2, Sint16 y2, Uint8 r, Uint8 g, Uint8 b,Uint8 a);

**Circle**

- int circleColor(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16 r,
  Uint32 color);
- int circleRGBA(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16
  rad, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

**AA Circle**

- int aacircleColor(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16
  r, Uint32 color);
- int aacircleRGBA(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16
  rad, Uint8 r, Uint8 g, Uint8 b,Uint8 a);

**Filled Circle**

- int filledCircleColor(SDL_Surface * dst, Sint16 x, Sint16
  y,Sint16 r, Uint32 color);
- int filledCircleRGBA(SDL_Surface * dst, Sint16 x, Sint16
  y,Sint16 rad, Uint8 r, Uint8 g, Uint8 b,Uint8 a);

**Ellipse**

- int ellipseColor(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16
  rx, Sint16 ry, Uint32 color);
- int ellipseRGBA(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16
  rx, Sint16 ry, Uint8 r, Uint8 g,Uint8 b, Uint8 a);

**AA Ellipse**

- int aaellipseColor(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16
  rx, Sint16 ry, Uint32 color);
- int aaellipseRGBA(SDL_Surface * dst, Sint16 x, Sint16 y,Sint16
  rx, Sint16 ry, Uint8 r, Uint8 g,Uint8 b, Uint8 a);

**Filled Ellipse**

- int filledEllipseColor(SDL_Surface * dst, Sint16 x, Sint16
  y,Sint16 rx, Sint16 ry, Uint32 color);
- int filledEllipseRGBA(SDL_Surface * dst, Sint16 x, Sint16
  y,Sint16 rx, Sint16 ry, Uint8 r, Uint8 g,Uint8 b, Uint8 a);

**Arc** 

- int arcColor(SDL_Surface * dst, Sint16 x, Sint16 y, Sint16 r,
  Sint16 start, Sint16 end, Uint32 color);
- int arcRGBA(SDL_Surface * dst, Sint16 x, Sint16 y, Sint16 rad,
  Sint16 start, Sint16 end,Uint8 r, Uint8 g, Uint8 b, Uint8 a);

**Pie**

- int pieColor(SDL_Surface * dst, Sint16 x, Sint16 y, Sint16
  rad,Sint16 start, Sint16 end, Uint32 color);
- int pieRGBA(SDL_Surface * dst, Sint16 x, Sint16 y, Sint16
  rad,Sint16 start, Sint16 end, Uint8 r, Uint8 g, Uint8 b, Uint8
  a);

**Filled Pie**

- int filledPieColor(SDL_Surface * dst,Sint16 x, Sint16 y, Sint16
  rad,Sint16 start, Sint16 end, Uint32 color);
- int filledPieRGBA(SDL_Surface * dst, Sint16 x, Sint16 y, Sint16
  rad,Sint16 start, Sint16 end, Uint8 r, Uint8 g, Uint8 b, Uint8
  a);

**Trigon**

- int trigonColor(SDL_Surface * dst, Sint16 x1, Sint16 y1, Sint16
  x2, Sint16 y2, Sint16 x3, Sint16 y3, Uint32 color);
- int trigonRGBA(SDL_Surface * dst, Sint16 x1, Sint16 y1, Sint16
  x2, Sint16 y2, Sint16 x3, Sint16 y3,Uint8 r, Uint8 g, Uint8 b,
  Uint8 a);

**AA-Trigon**

- int aatrigonColor(SDL_Surface * dst,Sint16 x1, Sint16 y1,
  Sint16 x2, Sint16 y2,Sint16 x3, Sint16 y3, Uint32 color);
- int aatrigonRGBA(SDL_Surface * dst, Sint16 x1, Sint16 y1,
  Sint16 x2, Sint16 y2,Sint16 x3, Sint16 y3,Uint8 r, Uint8 g,
  Uint8 b, Uint8 a);

**Filled Trigon** 

- int filledTrigonColor(SDL_Surface * dst, Sint16 x1, Sint16 y1,
  Sint16 x2,Sint16 y2, Sint16 x3, Sint16 y3, int color);
- int filledTrigonRGBA(SDL_Surface * dst, Sint16 x1, Sint16 y1,
  Sint16 x2,Sint16 y2, Sint16 x3, Sint16 y3,Uint8 r, Uint8 g,
  Uint8 b, Uint8 a);

**Polygon**

- int polygonColor(SDL_Surface * dst, Sint16 * vx, Sint16 *
  vy,int n, Uint32 color);
- int polygonRGBA(SDL_Surface * dst,Sint16 * vx, Sint16 * vy,int
  n, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

**AA-Polygon**

- int aapolygonColor(SDL_Surface * dst, Sint16 * vx, Sint16 *
  vy,int n, Uint32 color);
- int aapolygonRGBA(SDL_Surface * dst, Sint16 * vx, Sint16 *
  vy,int n, Uint8 r, Uint8 g, Uint8 b, Uint8 a);

**Filled Polygon**

- int filledPolygonColor(SDL_Surface* dst, Sint16 * vx,Sint16 *
  vy, int n, int color);
- int filledPolygonRGBA(SDL_Surface* dst, Sint16 * vx,Sint16 *
  vy, int n, Uint8 r, Uint8 g,Uint8 b, Uint8 a);

**Textured Polygon**

- int texturedPolygon(SDL_Surface \* dst, Sint16 \* vx, Sint16 \*
  vy, int n, SDL_Surface \*texture, int texture_dx, int
  texture_dy);

**Bezier Curveint**

- bezierColor(SDL_Surface * dst, Sint16 * vx, Sint16 * vy, int n,
  int s, Uint32 color);
- int bezierRGBA(SDL_Surface * dst, Sint16 * vx, Sint16 * vy,int
  n, int s, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
  *Note: s is the number of steps to render*.

**Rounded Rectangle**

- int roundedRectangleColor(SDL_Surface * dst, Sint16 x1, Sint16
  y1, Sint16 x2, Sint16 y2, Sint16 rad, Uint32 color);
- int roundedRectangleRGBA(SDL_Surface * dst, Sint16 x1, Sint16
  y1,Sint16 x2, Sint16 y2, Sint16 rad, Uint8 r, Uint8 g, Uint8 b,
  Uint8 a);

**Rounded Box**

- int roundedBoxColor(SDL_Surface \*dst, Sint16 x1, Sint16 y1,
  Sint16 x2, Sint16 y2, Sint16 rad, Uint32 color);
- int roundedBoxRGBA(SDL_Surface \*dst, Sint16 x1, Sint16 y1,
  Sint16 x2, Sint16 y2, Sint16 rad, Uint8 r, Uint8 g, Uint8 b,
  Uint8 a);

**Thick Line**

- int thickLineColor(SDL_Surface * dst, Sint16 x1, Sint16 y1,
  Sint16 x2, Sint16 y2, Uint8 width, Uint32 color);
- int thickLineRGBA(SDL_Surface * dst, Sint16 x1, Sint16 y1,
  Sint16 x2, Sint16 y2, Uint8 width, Uint8 r, Uint8 g, Uint8 b,
  Uint8 a);

**Characters/Strings**

- int characterColor(SDL_Surface * dst, Sint16 x, Sint16 y,char
  c, Uint32 color);
- int characterRGBA(SDL_Surface * dst, Sint16 x, Sint16 y,char c,
  Uint8 r, Uint8 g, Uint8 b, Uint8 a);
- int stringColor(SDL_Surface * dst, Sint16 x, Sint16 y, char
  \*c,Uint32 color);
- int stringRGBA(SDL_Surface * dst, Sint16 x, Sint16 y, char
  \*c,Uint8 r, Uint8 g, Uint8 b, Uint8 a);
- void gfxPrimitivesSetFont(unsigned char *fontdata, int cw, int
  ch); *Note: Several font definitions are included*.
