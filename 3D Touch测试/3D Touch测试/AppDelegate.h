//
//  AppDelegate.h
//  3D Touch测试
//
//  Created by apple on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
/*充值*/
UIKIT_EXTERN NSString *const HJShortcutItemTypeRecharge;
/*提现*/
UIKIT_EXTERN NSString *const HJShortcutItemTypeWithdraw;
/*我的投资*/
UIKIT_EXTERN NSString *const HJShortcutItemTypeMyRecord;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

