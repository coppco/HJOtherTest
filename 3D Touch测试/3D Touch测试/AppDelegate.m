//
//  AppDelegate.m
//  3D Touch测试
//
//  Created by apple on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"

NSString *const HJShortcutItemTypeRecharge = @"HJShortcutItemTypeRecharge";
NSString *const HJShortcutItemTypeWithdraw = @"HJShortcutItemTypeWithdraw";
NSString *const HJShortcutItemTypeMyRecord = @"HJShortcutItemTypeMyRecord";
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self addHomeScreenQuickActionWithApplication:application];
    return YES;
}
//3D Touch只能iOS9以后的6s设备上面才能使用, 使用前需要判断
- (void)addHomeScreenQuickActionWithApplication:(UIApplication *)application {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        //不存在的时候去添加
        if (application.shortcutItems == nil || application.shortcutItems.count == 0) {
            //UIApplicationShortcutIcon可以是系统的样式, 也可以是自定义图标
            UIApplicationShortcutItem *recharge = [[UIApplicationShortcutItem alloc] initWithType:HJShortcutItemTypeRecharge localizedTitle:@"快速充值" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"recharge"] userInfo:nil];
            UIApplicationShortcutItem *withdraw = [[UIApplicationShortcutItem alloc] initWithType:HJShortcutItemTypeWithdraw localizedTitle:@"提现" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"withdraw"] userInfo:nil];
            UIApplicationShortcutItem *myRecord = [[UIApplicationShortcutItem alloc] initWithType:HJShortcutItemTypeMyRecord localizedTitle:@"账单" localizedSubtitle:@"" icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"myRecord"] userInfo:nil];
            application.shortcutItems = @[myRecord, withdraw, recharge];
        }
    }
}

//点击3D Touch 的处理事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        if ([shortcutItem.type isEqualToString:HJShortcutItemTypeRecharge]) {//充值
            //code
        } else if ([shortcutItem.type isEqualToString:HJShortcutItemTypeWithdraw]) {
            //code
        } else if ([shortcutItem.type isEqualToString:HJShortcutItemTypeMyRecord]) {
        }
        //如果操作已经完成传入true
        if (completionHandler) {
            completionHandler(true);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
