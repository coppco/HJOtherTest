//
//  ViewController.m
//  02-弹出式按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import "ViewController.h"
#import "HJPopButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HJPopButton *button = [[HJPopButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50) subButtonImages:@[@"button1.png",@"button3.png",@"button4.png"] totalRadius:80 centerRadius:50 subRadius:50 centerImage:@"button2.png" centerBackground:nil addToParentView:self.view];
    button.center = self.view.center;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
