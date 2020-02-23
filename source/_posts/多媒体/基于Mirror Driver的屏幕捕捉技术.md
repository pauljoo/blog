---
title: 基于Mirror Driver的屏幕捕捉技术
date: 2018-05-26 21:57:10
categories:
- 多媒体
tags:
---

```c
int _tmain(int argc, _TCHAR* argv[])
{
	//获取屏幕DC
	HDC hDesktopDC = CreateDC(L"DISPLAY", NULL, NULL, NULL);
	//内存DC
	HDC hMemoryDC = CreateCompatibleDC(hDesktopDC);

	//得到屏幕宽度
	int nScreenWidth = GetSystemMetrics(SM_CXSCREEN);
	int nScreenHeight = GetSystemMetrics(SM_CYSCREEN);

	//根据屏幕DC创建屏幕位图
	HBITMAP hCaptureBitmap = CreateCompatibleBitmap(hDesktopDC, nScreenWidth, nScreenHeight);

	//将位图选择到内存DC中
	SelectObject(hMemoryDC, hCaptureBitmap);

	//将屏幕DC传送到内存DC中
	BitBlt(hMemoryDC, 0, 0, nScreenWidth, nScreenHeight, hDesktopDC, 0, 0, SRCCOPY);

	//得到鼠标位置
	POINT pt;
	GetCursorPos(&pt);
	//加载鼠标位图
	HCURSOR m_hcursor = LoadCursor(NULL, IDC_ARROW);

	DrawIconEx(hMemoryDC, pt.x, pt.y, m_hcursor, 0, 0, 0, NULL, DI_NORMAL | DI_COMPAT);

	SelectObject(hMemoryDC, hCaptureBitmap);

	char str1[50] = "D:/123.bmp";
	SaveBMPToFile(hCaptureBitmap, str1, pt.x, pt.y);

	DeleteDC(hDesktopDC);
	DeleteDC(hMemoryDC);
	DeleteObject(hCaptureBitmap);
}
```