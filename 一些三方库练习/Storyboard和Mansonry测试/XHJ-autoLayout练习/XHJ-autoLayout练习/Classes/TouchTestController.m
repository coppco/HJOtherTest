//
//  TouchTestController.m
//  XHJ-autoLayout练习
//
//  Created by coco on 16/3/25.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "TouchTestController.h"

@interface TouchTestController ()


@end

@implementation TouchTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)button:(UIButton *)sender {
    NSLog(@"%@", [sender class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
