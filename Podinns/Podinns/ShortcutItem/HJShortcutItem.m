//
//  HJShortcutItem.m
//  DevoutCat
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJShortcutItem.h"
#import <AvailabilityInternal.h>
#import <Availability.h>

NSString *const HJShortcutItemTypeSign = @"HJShortcutItemTypeSign";
NSString *const HJShortcutItemTypeAdd = @"HJShortcutItemTypeAdd";

@implementation HJShortcutItem
+ (void)setupShortcutItemWithApplication:(UIApplication *)application {
    if (__iOS_9_0) {//iOS9.0以后
        if (application.shortcutItems == nil || application.shortcutItems.count == 0) {
            UIApplicationShortcutItem *sign = [[UIApplicationShortcutItem alloc] initWithType:HJShortcutItemTypeSign localizedTitle:@"签到" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"sign_time"] userInfo:nil];
            UIApplicationShortcutItem *add = [[UIApplicationShortcutItem alloc] initWithType:HJShortcutItemTypeAdd localizedTitle:@"新增账号" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"userName"] userInfo:nil];
            application.shortcutItems = @[sign, add];
        }
    }
}

+ (void)setupPeekWithController:(UIViewController <UIViewControllerPreviewingDelegate>*)controller inView:(UIView *)inView {
    if (__iOS_9_0 && controller.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [controller registerForPreviewingWithDelegate:controller sourceView:inView];
    }
}
@end
