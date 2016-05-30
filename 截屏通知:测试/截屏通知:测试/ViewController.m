//
//  ViewController.m
//  截屏通知:测试
//
//  Created by coco on 16/5/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIApplicationUserDidTakeScreenshotNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)takeScreenshot:(NSNotification *)notification {
    NSLog(@"%@", notification);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
