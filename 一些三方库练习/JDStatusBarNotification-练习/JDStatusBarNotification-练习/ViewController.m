//
//  ViewController.m
//  JDStatusBarNotification-练习
//
//  Created by coco on 16/5/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import <JDStatusBarNotification.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JDStatusBarNotification showWithStatus:@"刷新成功" dismissAfter:1.5f styleName:JDStatusBarStyleSuccess];
    });
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [JDStatusBarNotification showWithStatus:@"刷新成功" dismissAfter:1.5f styleName:JDStatusBarStyleSuccess];
        [JDStatusBarNotification showWithStatus:@"加载错误" dismissAfter:1.5 styleName:JDStatusBarStyleError];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
