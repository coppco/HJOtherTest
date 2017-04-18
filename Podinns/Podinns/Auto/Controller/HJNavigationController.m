//
//  HJNavigationController.m
//  DevoutCat
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJNavigationController.h"

@interface HJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HJNavigationController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor colorWithRed:248 / 255.0 green:79 / 255.0 blue:83 / 255.0 alpha:1];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    bar.translucent = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

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
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:nil titleNormalColor:nil titleHighlightedColor:nil normalImage:@"ic_recommend_back_normal" highlightedImage:@"ic_recommend_back_press" target:self action:@selector(back:) edg:(UIEdgeInsetsMake(0, -15, 0, 0))];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back:(UIButton *)button {
    [self popViewControllerAnimated:true];
}

@end
