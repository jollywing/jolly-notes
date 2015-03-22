==============================
MFC笔记
==============================

:author: jiqing
:email: jiqingwu@gmail.com
:create: 2011-12-19
:update: |date|

.. |date| date::

.. contents:: 目录

代码结构
==============================

程序执行过程
------------------------------

1. 调用框架提供的WinMain函数
2. 调用theApp.InitApplication, theApp.InitInstance
3. 调用theApp.run进入消息循环
4. 退出时调用app实例的ExitInstance函数

增加自己的代码：

- 可以把自己的头文件放到stdafx.h中#include。

消息映射机制
------------------------------

添加自定义消息： 

- 在类的头文件中：#define msg_name (WM_USER+n)
- 类定义中添加：afx_msg type funcname(WPARAM wParam, LPARAM
  lParam);
- 消息映射中添加：ON_MESSAGE(msg_name, funcname)
- 适当处添加：LRESULT SendMessage( UINT message, WPARAM wParam =
  0, LPARAM lParam = 0 );(等消息处理完再返回)
- BOOL PostMessage( UINT message, WPARAM wParam = 0, LPARAM
  lParam = 0 );（把消息放到队列就返回）
- LRESULT SendDlgItemMessage( int nID, UINT message, WPARAM
  wParam = 0, LPARAM lParam = 0 );

上面三个函数都属于CWnd类。

消息响应函数其实和其他的成员函数一样，你可以在函数中手动调用它们。

程序框架全部以面向对象的方式组织，文档视图分离。



文档视图结构
==============================

视图控制
------------------------------

- 给视图类加入滚动条 ::

    BOOL CMyView::PreCreateWindow(CREATESTRUCT& cs)
    {
    	// TODO: ......
    	cs.style = cs.style | WS_HSCROLL |WS_VSCROLL;
    	... ...
    }

- 要禁用自动添加文档标题的功能，和视图类的PreCreateWindow中添加如
  下代码：::

    cs.style=cs.style&(~FWS_ADDTOTITLE);

- 设定窗口大小 ::

    BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
    {
    	...... ......
    	// TODO: ......
    	cs.cx = 1000;
    	cs.cy = 650;
    	......
    }

- cview中可以实现scrollBar？可以。加入flat scrollbar 或microsoft
  frame scrollbar控件。

程序行为
------------------------------

- 让程序启动时自动最大化、最小化：C\*App::InitInstance中，更改
  m_pMainWnd->ShowWindow(SW_SHOW) 中的SW_SHOW为SW_SHOWMAXMIZED或
  SW_SHOWMINIMIZED。
- 要增加程序启动画面，可以在CMainFrame::OnCreate中添加自己的代码。

    
一些全局函数
==============================

- 显示对话框的全局函数： ::

      int AFXAPI AfxMessageBox (LPCTSTR lpszText,
      UINT nType = MB_OK, UINT nIDHelp = 0)

- CWnd的成员函数： ::

      int MessageBox( LPCTSTR lpszText,LPCTSTR lpszCaption
       = NULL, UINT nType = MB_OK );

消息框按钮类型如下：

- MB_ABORTRETRYIGNORE 	消息框中显示Abort、Retry、Ignore按钮
- MB_OK			显示OK按钮
- MB_OKCANCEL 		显示OK、Cancel按钮
- MB_RETRYCANCEL 		显示Retry、Cancel按钮
- MB_YESNO 		显示Yes、No按钮
- MB_YESNOCANCEL 		显示Yes、No、Cancel按钮

图标风格

- MB_ICONINFORMATION 显示一个i图标，表示提示
- MB_ICONEXCLAMATION 显示一个惊叹号，表示警告
- MB_ICONSTOP 显示手形图标，表示警告或严重错误
- MB_ICONQUESTION 显示问号图标，表示疑问

控件
==============================

问：MFC中控件怎么和为控件添加的变量关联起来？

答：是通过DoDataExchange函数进行关联的，请看一个例子：::

  void CHtmlEditorDlg::DoDataExchange(CDataExchange* pDX)
  {
  	CDialog::DoDataExchange(pDX);
  	//{{AFX_DATA_MAP(CHtmlEditorDlg)
  	DDX_Control(pDX, IDC_STATUS, m_ctrlStatus);
  	DDX_Control(pDX, IDC_EXPLORER1, m_ctrlWeb);
  	DDX_Text(pDX, IDC_ADDRESS, m_sAddres);
  	//}}AFX_DATA_MAP
  }

菜单
------------------------------

添加菜单的命令提示时： ``str1\nstr2`` str1是显示在状态栏的说
明，str2是tip。

Picture
------------------------------

Picture控件的type为bitmap时，可以装载位图资源。下面的例子演示了如
何载入外部的位图文件。

假设图片控件的ID为IDC_PICFRAME; 用ClassWinzard给IDC_PICFRAME添加
控制变量m_PicFrame(派生自CStatic)，然后得到HBITMAP句柄。::

    HBITMAP   hbitmap=(HBITMAP)LoadImage(AfxGetInstanceHandle(),
    sPicName,IMAGE_BITMAP,0,0,LR_LOADFROMFILE|LR_DEFAULTSIZE); 
    m_PicFrame.SetBitmap(hbitmap);   
    Invalidate();   

Static Text
------------------------------

下面的例子演示了如何设置Static Text的字体。假设Static与m_static关
联： ::

    //create font
    CFont   font;   
    LOGFONT   log;   
    GetObject(::GetStockObject(DEFAULT_GUI_FONT),sizeof(log),&log);   
    log.lfHeight=20;     //改   
    log.lfWidth=20;       //改   
    log.lfCharSet=GB2312_CHARSET;   
    lstrcpy(log.lfFaceName,"黑体");   
    font.CreateFontIndirect(&log); 
    //set font
    m_static.SetFont(&font);

Radio Button
------------------------------

先为对话框加上2个radio button，分别是Radio1和Radio2。

问：如何让Radio1或者Radio2默认选上？如何知道哪个被选上了？

答：关键是选上，"默认"只要放在OnInitDialog()即可。三种方法可以让它选上。

第一种：::

    ((CButton *)GetDlgItem(IDC_RADIO1))->SetCheck(TRUE);//选上
    ((CButton *)GetDlgItem(IDC_RADIO1))->SetCheck(FALSE);//不选上
    ((CButton *)GetDlgItem(IDC_RADIO1))->GetCheck();返回1表示选上，0表示没选上

第二种：

关联一个control型变量（子类化），好ctrl+W(即打开classwizard),点开
Member Variables，咦？怎么没有IDC_RADIO1这个ID？原来是没有分组。
因为radio button通常都是成组使用的，在一组里面是互斥的。取消，回
到对话框资源面板，右键Radio1查看属性把Group选上，那么，Radio1和
Radio2就是一组了（怎么知道他们是一组的？后面说）。此时，就可以为
Radio1增加一control型变量m_ctrlRadio1了。如下：
::

    m_ctrlRadio1.SetCheck(TRUE);

同样可以使用GetCheck()获取状态。

第三种：

关联一个int型变量（同样需要先分组）m_nRadio1，打开对话框构造函数，你
会发现有：::

    m_nRadio1 = -1; //-1表示哪个都没有选上

如果你把-1改成0，就会发现Radio1默认被选上了，依此类推，m_nRadio1
的值为1 就是第二个被选上了（这里同样有问题，哪个是第一个？哪个是
第二个？）。

获取状态很简单，updateData(TRUE)后判断m_nRadio1的值即可。

问题2：如何使用多组？

多组和一组是一样的使用，只要搞清楚哪个是哪一组的就行了。再为对话框
添加Radio3和Radio4。很简单，先为这些Radio Button排个顺序，就是排列
他们的TAB ORDER。在对话框资源面板上Ctrl+D，然后按你自己的理想顺序
用鼠标逐个点击就可以了。不妨假设Radio1、Radio2、Radio3、 Radio4分
别是1、2、3、4。Radio1和Radio3都选上Group属性，那么，1、2是一组，3、
4是另外一组，因为分组的原则是在选上 Group属性的这一个开始直到碰到
下一个选上Group属性的。你不妨再Ctrl+D，令Radio1、Radio2、Radio3、
Radio4分别是1、3、2、4，那么Radio1和Radio3是一组，如果
m_nRadio1=1,此时是Radio3被选上而不是Radio2被选上。分好了组就分别使
用它们吧。

嗯，也许你还要为它们添加鼠标单击事件，非常简单。

标签页
------------------------------

1. 首先创建一个MFC对话框框架，在对话框资源上从工具箱中添加上一个
   Tab Control 控件，根据需要修改一下属性，然后右击控件，为这个控
   件添加一个变量， 将此控件跟一个CTabCtrl类变量绑定在一起，这里设
   为m_tabctrl。
2. 创建两个新的对话框资源，其属性作如下修改： ::

        Border：none   //边界为空,这样它就没了标题栏   
        Style：Child   //   这样这个模板就可以当作另一个窗口的子窗口了。   

   其它如果没有必要，就不用改了。 在上面加一些控件什么的，具体操作跟
   普通对话框没有区别。 完成后从这两个对话框模板生成两个新的对话框类。

3. 在主对话框中为新添加进来的两个类增加两个变量，如： ::

        CDialog1   m_mm1;   
        CDialog2   m_mm2;   

4. 在主对话框的OnInitDialog()函数中添加如下类似的代码： ::

    TCITEM   item;   
    item.mask   =   TCIF_TEXT;   
    item.pszText   =   "第一页";   

    m_tabctrl.InsertItem   (0,&item);   
    item.pszText   ="第二页";   
    m_tabctrl.InsertItem   (1,&item);   

    m_mm1.Create(IDD_DIALOG1,&m_tabctrl);   
    m_mm2.Create(IDD_DIALOG2,&m_tabctrl);   

    m_mm1.SetWindowPos(NULL,10,30,400,100,SWP_SHOWWINDOW);   
    m_mm2.SetWindowPos(NULL,10,30,400,100,SWP_HIDEWINDOW   );   

   解释如下： 两个InsertItem函数的调用是为了给标签控件增加两个标签
   页面，文本是标题。 SetWindowPos()函数设置这两个对话框在Z顺序中
   的位置，显示或隐藏状态.。

5. 在主对话中为标签控件添加一个标签选择改变（TCN_SELCHANGE）的控件
   通知消息，以便在用户选择标签时通知主对话框。在主对话框的编辑界
   面右击标签控件 ，选择添加一个事件可以完成这个操作。 在事件处理
   中添加如下代码，如下例： ::

    void CtabdialogDlg::OnTcnSelchangeTab1(NMHDR *pNMHDR, 
         LRESULT  *pResult)   
    {   
        CRect   r;   
        m_tabctrl.GetClientRect   (&r);   
    
        switch(m_tabctrl.GetCurSel())   
        {   
        case   0:   
            m_mm1.SetWindowPos(NULL, 10, 30, r.right - 20,
                             r.bottom - 40, SWP_SHOWWINDOW);   
            m_mm2.SetWindowPos(NULL, 10, 30, r.right - 20,
                             r.bottom - 40, SWP_HIDEWINDOW);   
            break;   
        case   1:   
            m_mm1.SetWindowPos(NULL, 10, 30, r.right - 20,
                             r.bottom - 40, SWP_HIDEWINDOW);   
            m_mm2.SetWindowPos(NULL, 10, 30, r.right - 20,
                             r.bottom - 40, SWP_SHOWWINDOW);   
            break;   
        }   
        *pResult   =   0;   
    }   

   要想知道用户选择那个标签页，要通过m_tabctrl.GetCurSel()函数。为
   了不使显示的子对话框覆盖标签控件的显示，所以要获得标签控件的尺寸然
   后设置各页面 的尺寸。

绘图
==============================

如何实现双缓冲
------------------------------

首先给出实现的程序，然后再解释，同样是在OnDraw(CDC \*pDC)中：
::

    CDC MemDC; //首先定义一个显示设备对象
    CBitmap MemBitmap;//定义一个位图对象
    //随后建立与屏幕显示兼容的内存显示设备
    MemDC.CreateCompatibleDC(NULL);
    //这时还不能绘图，因为没有地方画 ^_^
    //下面建立一个与屏幕显示兼容的位图，至于位图的大小嘛，可以用窗口的大小
    MemBitmap.CreateCompatibleBitmap(pDC,nWidth,nHeight);
    
    //将位图选入到内存显示设备中
    //只有选入了位图的内存显示设备才有地方绘图，画到指定的位图上
    CBitmap *pOldBit=MemDC.SelectObject(&MemBitmap);
    
    //先用背景色将位图清除干净，这里我用的是白色作为背景
    //你也可以用自己应该用的颜色
    MemDC.FillSolidRect(0,0,nWidth,nHeight,RGB(255,255,255));
    
    //绘图
    MemDC.MoveTo(……);
    MemDC.LineTo(……);
    
    //将内存中的图拷贝到屏幕上进行显示
    pDC->BitBlt(0,0,nWidth,nHeight,&MemDC,0,0,SRCCOPY);
    
    //绘图完成后的清理
    MemBitmap.DeleteObject();
    MemDC.DeleteDC();
    
上面的注释应该很详尽了，废话就不多说了。

绘制半透明位图
------------------------------

有的时侯，我们希望显示一幅半透明的位图。也就是说我们将一幅位图B显
示到A位图上，又希望透过B位图看到A位图的一部分图像但不是全部。比如
A位图是一幅曲线图，B是一幅提示位图，我们想在显示提示的同时看到已显
示的曲线，但不需要曲线的背景 ，就需有用到半透明位图。曲线看上去就
象从B位图中渗透过来，其实半透明技术就是一种渗透技术，渗透公式我们
可选用多种，在这里我们选用（A AND 0x7F）OR B。注意，白色不能产生渗
透。
::

    //参数说明：
    //hDIB -位图句柄
    //pPal -位图调色板
    //xDest -显示位图的左上角x坐标
    //yDest -显示位图的左上角y坐标
    void DrawSemiTransparentBitmap(CDC *pDC, int nXDest,
        int nYDest, HGLOBAL hDIB,CPalette *pPal)
    BITMAPINFO &bmInfo = *(LPBITMAPINFO)hDIB ;
    int nColors = bmInfo.bmiHeader.biClrUsed ? 
        bmInfo.bmiHeader.biClrUsed : 1 << 
        bmInfo.bmiHeader.biBitCount;
    int nWidth = bmInfo.bmiHeader.biWidth;
    int nHeight = bmInfo.bmiHeader.biHeight;
    LPVOID lpDIBBits = (LPVOID)(bmInfo.bmiColors + nColors);
    CDC memDC;
    memDC.CreateCompatibleDC( pDC );
    CBitmap bmp;
    bmp.CreateCompatibleBitmap( pDC, nWidth, nHeight );
    CBitmap *pOldBitmap = memDC.SelectObject( &bmp );
    if( pDC->GetDeviceCaps(RASTERCAPS) & RC_PALETTE&&nColors<256)
    CPalette *pOldMemPalette = memDC.SelectPalette(pPal, FALSE);
    memDC.RealizePalette();
    ::SetDIBitsToDevice(memDC.m_hDC, 0, 0, nWidth, 
        nHeight, 0, 0, 0, nHeight, lpDIBBits,
        (LPBITMAPINFO)hDIB, DIB_RGB_COLORS);

    CDC maskDC;
    CBitmap mbm;
    maskDC.CreateCompatibleDC(pDC);
    mbm.CreateCompatibleBitmap(pDC, nWidth, nHeight);
    maskDC.SelectObject(&mbm);
    maskDC.FillSolidRect(CRect(0, 0, nWidth, nHeight),
        RGB(0x7F, 0x7F, 0x7F));
    pDC->BitBlt(nXDest, nYDest, nWidth, nHeight, &maskDC, 0, 0, SRCAND);
    pDC->BitBlt(nXDest, nYDest, nWidth, nHeight, &memDC, 0, 0, SRCPAINT);
    memDC.SelectObject(pOldBitmap);

如何画透明位图
------------------------------

画透明位图通常的方法是使用遮罩。所谓遮罩就是一张黑白双色的位图，他
和要透明的位图是对应的，遮罩描述了位图中需要透明的部分，透明的部分
是黑色的，而不透明的是白色的，白色的部分就是透明的部分。

假设图A是要画的透明位图，图B是遮罩，图A上是一个大写字母A,字母是红
色的，背景是黑色的，图B背景是白色的，上面有一个黑色的字母A和图A的
形状是一样的。比如我们要在一张蓝天白云的背景上透明地画图A，就是只
把红色的字母A画上去。我们可以先将图B和背景进行与操作，再把图B和背
景进行或操作就可以了。

用VC++ MFC实现的代码如下：::

    void CDemoDlg::OnPaint(){
        CPaintDC dc(this);
        Cbitmap BmpBack,BmpA,BmpB,*pOldBack,*pOldA,*pOldB;
        BmpBack.LoadBitmap(IDB_BACKGROUND); // 载入背景图
        BmpA.LoadBitmap(IDB_BITMAPA); //载入图A
        BmpB.LoadBitmap(IDB_BITMAPB); //载入图B
        CDC dcBack,dcA,dcB; //声明三个内存DC用于画图
        dcBack.CreateCompatibleDC(&dc);
        dcA.CreateCompatibleDC(&dc);
        dcB.CreateCompatibleDC(&dc); //把这三个内存DC创建成和PaintDC兼容的DC
        pOldBack=dcBack.SelectObject(&BmpBack);
        pOldA=dcA.SelectObject(&BmpA);
        pOldB=dcB.SelectObject(&BmpB); //把三个位图选入相应的DC
        dc.BitBlt(0,0,100,100,&dcBack,0,0,SRCCOPY); //画背景
        dc.BitBlt(0,0,48,48,&dcB,0,0,SRCAND); //用与的方式画遮罩图B
        dc.BitBlt(0,0,48,48,&dcA,0,0,SRCPAINT); //用或的方式画遮图A
        dcBack.SelectObject(pOldBack);
        dcBack.SelectObject(pOldA);
        dcBack.SelectObject(pOldB); //从内存DC中删除位图
    }
        
你会看到红色的字母A透明地画在背景上了。用遮罩的方法必须事先做好遮
罩，遮罩和位图大小一样等于多消耗一倍的资源，比较浪费。还有一种画透
明位图的方法，基本原理是一样的，只是不用事先做好遮罩，根据需要动态
生成遮罩，但是要求需要透明的位图必须指定一种透明色，凡是这个透明色
的地方则画成透明的。用VC++ MFC实现的代码如下：
::

    /* 这是一个用来画透明位图的函数
    CDC *pDC 需要画位图的CDC指针
    UINT IDImage 位图资源ID
    Crect &rect 指定位图在pDC中的位置
    COLORREF rgbMask 位图的透明色
    */
    void DrawTransparentBitmap(CDC *pDC, UINT IDImage,
        CRect &rect, COLORREF rgbMask)
    {
    	CDC ImageDC,MaskDC;
    	CBitmap Image,*pOldImage;
    	CBitmap maskBitmap,*pOldMaskDCBitmap ;
    	Image.LoadBitmap(IDImage);
    	ImageDC.CreateCompatibleDC(pDC);
    	pOldImage=ImageDC.SelectObject(&Image);
    	MaskDC.CreateCompatibleDC(pDC);
    	maskBitmap.CreateBitmap( rect.Width() , rect.Height() , 1, 1, NULL );
    	pOldMaskDCBitmap = MaskDC.SelectObject( &maskBitmap );
    	ImageDC.SetBkColor(rgbMask);
    	MaskDC.BitBlt( 0, 0, rect.Width(), rect.Height(),
            &ImageDC, 0, 0, SRCCOPY );
    	ImageDC.SetBkColor(RGB(0,0,0));
    	ImageDC.SetTextColor(RGB(255,255,255));
    	ImageDC.BitBlt(0, 0, rect.Width(), rect.Height(),
            &MaskDC, 0, 0, SRCAND);
    	pDC->BitBlt(rect.left,rect.top,rect.Width(), 
            rect.Height(), &MaskDC, 0, 0, SRCAND);
    	pDC->BitBlt(rect.left,rect.top,rect.Width(), 
            rect.Height(), &ImageDC, 0, 0,SRCPAINT);
    	MaskDC.SelectObject(pOldMaskDCBitmap);
    	ImageDC.SelectObject(pOldImage);
    }

::
    
    void DrawTransparentBitmap( CDC *pDC, CRect *pRectDraw, 
            HBITMAP hBmpDraw, COLORREF clrMask )
    { 
        if( NULL == pDC || NULL == pRectDraw || NULL == hBmpDraw )
          return;

        // 内存位图大小
        CRect rcMem;
        rcMem.SetRect( 0, 0, pRectDraw->Width(), pRectDraw->Height() );
        
        // 创建内存缓冲区
        CDC dcMem;
        dcMem.CreateCompatibleDC( pDC );
        CBitmap bmpMem;
        bmpMem.CreateCompatibleBitmap( pDC, rcMem.Width(),
                rcMem.Height() );
        dcMem.SelectObject( &bmpMem );
        dcMem.BitBlt( 0, 0, rcMem.Width(), rcMem.Height(), 
                      pDC, pRectDraw->left, pRectDraw->top, SRCCOPY );
        
        // 图片
        CDC dcImg;
        dcImg.CreateCompatibleDC( pDC );
        dcImg.SelectObject( CBitmap::FromHandle( hBmpDraw ) );
        
        // 掩码位图
        CDC dcMask;
        dcMask.CreateCompatibleDC( pDC ); 
        CBitmap bmpMask;
        bmpMask.CreateBitmap( rcMem.Width(), rcMem.Height(), 
                              1, 1, NULL );
        dcMask.SelectObject( &bmpMask );
        dcMask.SetBkColor( clrMask ); 
        dcMask.BitBlt( 0, 0, rcMem.Width(), rcMem.Height(),
                       &dcImg, 0, 0, SRCCOPY );
        
        dcImg.SetBkColor( RGB(0,0,0) );
        dcImg.SetTextColor( RGB(255,255,255) );
        dcImg.BitBlt( 0, 0, rcMem.Width(), rcMem.Height(),
                      &dcMask, 0, 0, SRCAND );
        
        dcMem.SetBkColor( RGB(255,255,255) );
        dcMem.SetTextColor( RGB(0,0,0) );
        dcMem.BitBlt( rcMem.left, rcMem.top, rcMem.Width(),
                      rcMem.Height(), &dcMask, 0, 0, SRCAND );
        dcMem.BitBlt( rcMem.left, rcMem.top, rcMem.Width(), 
                      rcMem.Height(), &dcImg, 0, 0, SRCPAINT );
        
        pDC->BitBlt( pRectDraw->left, pRectDraw->top,
                     rcMem.Width(), rcMem.Height(),
                     &dcMem, 0, 0, SRCCOPY );
        
        // 释放内存
        bmpMask.DeleteObject();
        dcMask.DeleteDC();
        dcImg.DeleteDC();
        bmpMem.DeleteObject();
        dcMem.DeleteDC();
    }
    

