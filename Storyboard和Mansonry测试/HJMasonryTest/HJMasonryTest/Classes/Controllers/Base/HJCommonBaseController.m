//
//  HJCommonBaseController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJCommonBaseController.h"

@interface HJCommonBaseController ()

@end

@implementation HJCommonBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.bounds = CGRectMake(0, 0,30, 30);
    [button setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
#warning - 设置布局不是从Navigation Bar 顶部开始布局
    if (__IPHONE_7_0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

}

- (void)back:(UIButton *)button {
    //判断模态还是push过来的,模态过来的controller不会放在self.navigationController.viewControllers数组中
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1] == self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
