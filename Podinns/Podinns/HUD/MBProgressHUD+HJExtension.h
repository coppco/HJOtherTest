//
//  MBProgressHUD+HJExtension.h
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (HJExtension)
/*====================提示信息====================*/

/**
 显示提示信息

 @param message 消息
 @param imageName 图片
 @param inView 如果为nil, 显示在keywindow上面
 @param delay 延迟时间后消失
 */
+ (void)showMessage:(NSString *)message image:(NSString *)imageName inView:(UIView *)inView delay:(NSTimeInterval)delay;

/**
 显示成功提示

 @param message 消息
 @param inView 如果为nil, 显示在keywindow上面
 @param delay 延迟时间后消失
 */
+ (void)show_Success:(NSString *)message inView:(UIView *)inView delay:(NSTimeInterval)delay;
/**
 显示错误提示
 
 @param message 消息
 @param inView 如果为nil, 显示在keywindow上面
 @param delay 延迟时间后消失
 */

+ (void)show_Error:(NSString *)message inView:(UIView *)inView delay:(NSTimeInterval)delay;
/**
 显示警告提示
 
 @param message 消息
 @param inView 如果为nil, 显示在keywindow上面
 @param delay 延迟时间后消失
 */

+ (void)show_Warning:(NSString *)message inView:(UIView *)inView delay:(NSTimeInterval)delay;

/*====================显示菊花转====================*/

/**
 显示加载显示框

 @param message 消息
 @param inView 如果为nil, 显示在keywindow上面
 */
+ (void)show_HUDWithMessage:(NSString *)message inView:(UIView *)inView;
@end
