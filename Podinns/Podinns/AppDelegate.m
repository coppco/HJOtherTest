//
//  AppDelegate.m
//  Podinns
//
//  Created by apple on 2017/3/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "HJShortcutItem.h"
#import "AddAccountController.h"
//UNUserNotificationCenterDelegate iOS10 通知代理
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupLocalNotification];
    [HJShortcutItem setupShortcutItemWithApplication:application];
    return YES;
}

/**
 准备本地通知
 */
- (void)setupLocalNotification {
    if (__iOS_10_0) {
//    [UNUserNotificationCenter addNotificationRequest:withCompletionHandler:]
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {//没有授权, 请求权限
                [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    //设置代理
                    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
                    [self addLocalNotificationForiOS10];
                }];
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized){
                //设置代理
                [UNUserNotificationCenter currentNotificationCenter].delegate = self;
                [self addLocalNotificationForiOS10];
            }
        }];
    } else {
        if ([UIApplication sharedApplication].currentUserNotificationSettings.types != UIUserNotificationTypeNone) {
            [self addLocalNotification];
        } else {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil]];
        }
    }
}
/*iOS 8.0 本地通知*/
- (void)addLocalNotification {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//    dateWithTimeIntervalSince1970是早上八点,
    localNotification.fireDate = [NSDate dateWithTimeIntervalSince1970:12 * 60 * 60 + 60 * 30];
    localNotification.repeatInterval = NSCalendarUnitDay; //通知重复次数 -- 每天
    //设置通知属性
    localNotification.alertBody = @"🌛🌛Hi, 今天签到了吗?😁😁";//通知主体
    localNotification.applicationIconBadgeNumber = 1;//应用程序右上角显示的未读消息数
    localNotification.alertAction = @"点击开始签到😜";//待机界面的滑动动作提示
    localNotification.alertLaunchImage = @"Default";//通过点击通知打开应用时的启动图片，这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    localNotification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)addLocalNotificationForiOS10 {
    // 创建一个本地通知
    UNMutableNotificationContent *content_1 = [[UNMutableNotificationContent alloc] init];
    // 主标题
    content_1.title = [NSString localizedUserNotificationStringForKey:@"温馨提示" arguments:nil];
    // 副标题
    content_1.subtitle = [NSString localizedUserNotificationStringForKey:@"🌙🌙Hi, 今天你签到了吗?😁😁" arguments:nil];
    content_1.badge = [NSNumber numberWithInteger:1];
    content_1.body = [NSString localizedUserNotificationStringForKey:@"点击开始签到😜" arguments:nil];
    content_1.sound = [UNNotificationSound defaultSound];
    // 设置触发时间
//    UNTimeIntervalNotificationTrigger *trigger_1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    NSDateComponents *components= [[NSDateComponents alloc]init];
    components.hour= 20;//每天20点
    components.minute = 30;//30分钟
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:true];
    /*
     UNTimeIntervalNotificationTrigger ：一定时间后触发
     UNCalendarNotificationTrigger ： 在某月某日某时触发
     UNLocationNotificationTrigger ： 在用户进入或是离开某个区域时触发
     */
    // 创建一个发送请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"my_notification" content:content_1 trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}
//授权之后
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
}
//3D Touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type isEqualToString:HJShortcutItemTypeAdd]) {
        if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)self.window.rootViewController pushViewController:[[AddAccountController alloc] init] animated:true];
        }
    }
    if (completionHandler) {
        completionHandler(true);
    }
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillResignActive:(UIApplication *)application { 
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
