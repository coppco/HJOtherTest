//
//  MBProgressHUD+HJExtension.m
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MBProgressHUD+HJExtension.h"

@implementation MBProgressHUD (HJExtension)
static MBProgressHUD *defaultHUD = nil;
+ (MBProgressHUD *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultHUD = [[MBProgressHUD alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        defaultHUD.contentColor = [UIColor whiteColor];  //文字菊花等颜色
        defaultHUD.bezelView.color = [UIColor blackColor];  //中间背景颜色
        defaultHUD.label.font = [UIFont boldSystemFontOfSize:12];
        defaultHUD.animationType = MBProgressHUDAnimationFade;
        defaultHUD.removeFromSuperViewOnHide = true;  //隐藏时从父视图移除
    });
    return defaultHUD;
}

+ (void)showMessage:(NSString *)message image:(NSString *)imageName inView:(UIView *)inView delay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD shareInstance];
    if (!hud.superview) {
        [hud removeFromSuperview];
    }
    inView = (inView == nil ? [UIApplication sharedApplication].keyWindow : inView);
    //隐藏view上面的菊花转,提示信息等
    [MBProgressHUD hideHUDForView:inView animated:false];
    hud.frame = inView.bounds;
    [inView addSubview:hud];
    [inView bringSubviewToFront:hud];
    
    if (imageName != nil && imageName.length != 0) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        hud.mode = MBProgressHUDModeCustomView;
    } else {
        hud.customView = nil;
        hud.mode = MBProgressHUDModeText;
    }
    hud.label.text = message;
    [hud showAnimated:true];
    [hud hideAnimated:true afterDelay:delay];
}

+ (void)show_Success:(NSString *)message inView:(UIView *)inView delay:(NSTimeInterval)delay {
    [self showMessage:message image:@"MBProgressHUD.bundle/success.png" inView:inView delay:delay];
}

+ (void)show_Error:(NSString *)message inView:(UIView *)inView delay:(NSTimeInterval)delay {
    [self showMessage:message image:@"MBProgressHUD.bundle/error.png" inView:inView delay:delay];
}

+ (void)show_Warning:(NSString *)message inView:(UIView *)inView delay:(NSTimeInterval)delay {
    [self showMessage:message image:@"MBProgressHUD.bundle/warning.png" inView:inView delay:delay];
}

+ (void)show_HUDWithMessage:(NSString *)message inView:(UIView *)inView {
    inView = inView != nil ? inView : [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:inView animated:false];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:inView animated:true];
    hud.contentColor = [UIColor whiteColor];  //文字菊花等颜色
    hud.bezelView.color = [UIColor blackColor];  //中间背景颜色
    hud.label.font = [UIFont boldSystemFontOfSize:12];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.removeFromSuperViewOnHide = true;  //隐藏时从父视图移除
    hud.label.text = message;
    hud.mode = MBProgressHUDModeIndeterminate;  //
}


@end
