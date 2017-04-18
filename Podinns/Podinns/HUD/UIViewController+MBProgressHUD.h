//
//  UIViewController+MBProgressHUD.h
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MBProgressHUD)

/**
 显示加载框

 @param message 消息
 */
- (void)showLoadingHudWithMessage:(NSString *)message;

/**
 显示提示信息

 @param message 消息
 @param imageName 图片
 @param delay 延迟时间后消失
 */
- (void)showMessage:(NSString *)message image:(NSString *)imageName delay:(NSTimeInterval)delay;

/**
 显示成功信息
 
 @param message 消息
 @param delay 延迟时间后消失
 */
- (void)show_Success:(NSString *)message delay:(NSTimeInterval)delay;

/**
 显示错误信息
 
 @param message 消息
 @param delay 延迟时间后消失
 */
- (void)show_Error:(NSString *)message delay:(NSTimeInterval)delay;

/**
 显示警告信息
 
 @param message 消息
 @param delay 延迟时间后消失
 */
- (void)show_Warning:(NSString *)message delay:(NSTimeInterval)delay;

/**
 隐藏加载框
 */
- (void)hideAllHud;
@end
