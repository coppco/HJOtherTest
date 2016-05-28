//
//  ViewController.m
//  03-带下划线的按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import "ViewController.h"
#import "HJUnderLineButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HJUnderLineButton *button = [[HJUnderLineButton alloc] init];

    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setTitle:@"www.baidu.com" forState:(UIControlStateNormal)];
    button.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 30);
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
