//
//  UIViewController+MBProgressHUD.m
//  DevoutCat
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"

@implementation UIViewController (MBProgressHUD)
- (void)showLoadingHudWithMessage:(NSString *)message {
    [MBProgressHUD show_HUDWithMessage:message inView:self.view];
}

- (void)showMessage:(NSString *)message image:(NSString *)imageName delay:(NSTimeInterval)delay {
    [MBProgressHUD showMessage:message image:imageName inView:self.view delay:delay];
}
- (void)show_Success:(NSString *)message delay:(NSTimeInterval)delay {
     [MBProgressHUD show_Success:message inView:self.view delay:delay];
}
- (void)show_Error:(NSString *)message delay:(NSTimeInterval)delay {
    [MBProgressHUD show_Error:message inView:self.view delay:delay];
}
- (void)show_Warning:(NSString *)message delay:(NSTimeInterval)delay {
    [MBProgressHUD show_Warning:message inView:self.view delay:delay];
}
- (void)hideAllHud {
    [MBProgressHUD hideHUDForView:self.view animated:true];
}
@end
