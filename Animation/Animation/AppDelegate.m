//
//  AppDelegate.m
//  Animation
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewController1.h"
#import "HJStartAnimationView.h"
#import "LoadingAnimationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    navi.tabBarItem.title = @"等比";
    navi.navigationBar.translucent = true;
    navi.tabBarItem.image = [UIImage imageNamed:@"icon_noremal_cat"];
    navi.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_press_cat"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:161.0 / 255 green:161.0 / 255 blue:161.0 / 255 alpha:1]} forState:(UIControlStateNormal)];
    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:248.0 / 255 green:79.0 / 255 blue:82.0 / 255 alpha:1]} forState:(UIControlStateSelected)];
    
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:[[ViewController1 alloc] init]];
    navi1.tabBarItem.title = @"等高";
    navi1.navigationBar.translucent = true;
    navi1.tabBarItem.image = [UIImage imageNamed:@"icon_noremal_cat"];
    navi1.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_press_cat"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [navi1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:161.0 / 255 green:161.0 / 255 blue:161.0 / 255 alpha:1]} forState:(UIControlStateNormal)];
    [navi1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:248.0 / 255 green:79.0 / 255 blue:82.0 / 255 alpha:1]} forState:(UIControlStateSelected)];
    tabbar.viewControllers = @[navi, navi1];
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];
    LoadingAnimationController *loading = [[LoadingAnimationController alloc] init];
    [self.window addSubview:loading.view];
    [self.window bringSubviewToFront:loading.view];
//    self.window.rootViewController = [[LoadingAnimationController alloc] init];
//    [loading startAnimation];
    return YES;
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
