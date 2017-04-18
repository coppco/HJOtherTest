//
//  CommonDefine.h
//  DevoutCat
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//  通用宏定义

#ifndef CommonDefine_h
#define CommonDefine_h

#define kViewH(view) view.frame.size.height
#define kViewW(view) view.frame.size.width
#define kViewX(view) view.frame.origin.x
#define kViewY(view) view.frame.origin.y

//获取主窗口的bounds
#define kMainScreenBounds ([UIScreen mainScreen].bounds)
//获取主窗口的bounds
#define kMainScreenSize ([UIScreen mainScreen].bounds.size)
//获取主窗口的高度
#define kMainScreenHeight ([UIScreen mainScreen].bounds.size.height)
//获取主窗口的宽度
#define kMainScreenWidth  ([UIScreen mainScreen].bounds.size.width)
/**获取主窗口*/
#define kMainScreen ([[UIApplication sharedApplication] keyWindow])
//获取正在显示的窗口(有可能是键盘等)
#define kVisibleScreen ([[UIApplication sharedApplication].windows lastObject])

/*==================字符串拼接==================*/
#define kStringFormat(FORMAT, ...) ([NSString stringWithFormat:FORMAT, ##__VA_ARGS__])

/*==================设备型号==================*/
#define __isIPHONE_4 (CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 1.0)
#define __isIPHONE_4S (CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 2.0)
#define __isIPHONE_5 CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 568))
#define __isIPHONE_6 CGSizeEqualToSize(kMainScreenSize, CGSizeMake(375, 667))
#define __isIPHONE_6P CGSizeEqualToSize(kMainScreenSize, CGSizeMake(414, 736))

/*==================系统版本==================*/
#ifndef __iOS_VERSION
#define __iOS_VERSION ([[UIDevice currentDevice].systemVersion floatValue])
#endif

#ifndef __iOS_5_0
#define __iOS_5_0 ((__iOS_VERSION) >= 5.0)
#endif
#ifndef __iOS_6_0
#define __iOS_6_0 ((__iOS_VERSION) >= 6.0)
#endif
#ifndef __iOS_7_0
#define __iOS_7_0 ((__iOS_VERSION) >= 7.0)
#endif
#ifndef __iOS_8_0
#define __iOS_8_0 ((__iOS_VERSION) >= 8.0)
#endif
#ifndef __iOS_9_0
#define __iOS_9_0 ((__iOS_VERSION) >= 9.0)
#endif
#ifndef __iOS_10_0
#define __iOS_10_0 ((__iOS_VERSION) >= 10.0)
#endif

/*==================版本号==================*/
//version版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//bulid构建版本号
#define AppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/*========================NSLog=======================*/
#ifdef DEBUG
#define XHJLog(FORMAT, ...) NSLog(@"%@:%d行   \n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#else
#define XHJLog(FORMAT, ...) nil
#endif

#endif /* CommonDefine_h */
