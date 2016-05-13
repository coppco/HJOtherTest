//
//  ViewController.m
//  ReactiveCocoaDemo
//
//  Created by coco on 16/5/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*测试链式编程*/
    CGFloat result =  [NSObject makeCaculators:^(CaculatorMaker *maker) {
        maker.add(11).sub(10).and.with.muilt(1.1).divide(1.23);
    }];
    NSLog(@"测试链式编程=====%f", result);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
