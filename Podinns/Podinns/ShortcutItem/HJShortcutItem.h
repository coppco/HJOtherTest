//
//  HJShortcutItem.h
//  DevoutCat
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/*签到*/
UIKIT_EXTERN NSString *const HJShortcutItemTypeSign;
/*新增*/
UIKIT_EXTERN NSString *const HJShortcutItemTypeAdd;
@interface HJShortcutItem : NSObject

/**
 配置主屏幕的3D Touch, 在application performActionForShortcutItem获取点击事件

 @param application 应用程序
 */
+ (void)setupShortcutItemWithApplication:(UIApplication *)application;

+ (void)setupPeekWithController:(UIViewController *)controller inView:(UIView *)inView;
@end
