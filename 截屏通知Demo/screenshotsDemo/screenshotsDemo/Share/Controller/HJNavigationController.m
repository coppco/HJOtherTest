//
//  HJNavigationController.m
//  DevoutCat
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJNavigationController.h"
#import "UIColor+HJExtension.h"
#import "UIBarButtonItem+HJExtension.h"
#define kImage(imageName) ([UIImage imageNamed:(imageName)])
#define kPingFangLightFont(value) [UIFont fontWithName:(__iOS_9_0 ? @"PingFangSC-Light" : @"STHeitiSC-Light") size:(value)]
#define kPingFangMediumFont(value) [UIFont fontWithName:(__iOS_9_0 ? @"PingFangSC-Medium" : @"STHeitiSC-Medium") size:(value)]
#define kPingFangRegularFont(value) [UIFont fontWithName:(__iOS_9_0 ? @"PingFangSC-Regular" : @"STHeitiSC-Light") size:(value)]
#define fontWeight(x,y) [UIFont systemFontOfSize:x weight:y]

#ifndef __iOS_VERSION
#define __iOS_VERSION ([[UIDevice currentDevice].systemVersion floatValue])
#endif

#ifndef __iOS_5_0
#define __iOS_5_0 ((__iOS_VERSION) >= 5.0)
#endif
#ifndef __iOS_6_0
#define __iOS_6_0 ((__iOS_VERSION) >= 6.0)
#endif
#ifndef __iOS_7_0
#define __iOS_7_0 ((__iOS_VERSION) >= 7.0)
#endif
#ifndef __iOS_8_0
#define __iOS_8_0 ((__iOS_VERSION) >= 8.0)
#endif
#ifndef __iOS_9_0
#define __iOS_9_0 ((__iOS_VERSION) >= 9.0)
#endif
#ifndef __iOS_10_0
#define __iOS_10_0 ((__iOS_VERSION) >= 10.0)
#endif

@interface HJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HJNavigationController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    //背景颜色
//    bar.barTintColor = [UIColor colorWithRed:248 / 255.0 green:79 / 255.0 blue:83 / 255.0 alpha:1];
    //背景图片
        [bar setBackgroundImage:kImage(@"navigation_backgroundImage") forBarMetrics:(UIBarMetricsDefault)];
    //去掉全局导航条下面黑线
    [bar setShadowImage:[UIImage new]];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorFromRGBValue:0xFFFFFF], NSFontAttributeName : kPingFangLightFont(18)};
    if (__iOS_VERSION > 7.0) {
        bar.translucent = false;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (__iOS_VERSION <= 7.0) {
        self.navigationBar.translucent = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    #ifdef DEBUG
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.navigationBar addGestureRecognizer:tap];
    #endif
}
#ifdef DEBUG
- (void)tap:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateRecognized) {
        // This could also live in a handler for a keyboard shortcut, debug menu item, etc.
//        [[FLEXManager sharedManager] showExplorer];
    }
}
#endif
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.viewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:nil titleNormalColor:nil titleHighlightedColor:nil normalImage:@"back_normal" highlightedImage:@"back_press" target:self action:@selector(back:) edg:(UIEdgeInsetsMake(0, 0, 0, 0))];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back:(UIButton *)button {
    [self popViewControllerAnimated:true];
}

@end
