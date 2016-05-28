//
//  ViewController.m
//  04-抛光效果的按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import "ViewController.h"
#import "HJShinyButton.h"
#import "shiny.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect1 = CGRectMake(120,252,100,100);
    CGRect rect2 = CGRectMake(100,100,150,50);
    
    /*
    HJShinyButton *button1 = [[HJShinyButton alloc] initWithFrame:CGRectMake(120,252,100,100) withBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:button1];
    
    HJShinyButton *button2 = [[HJShinyButton alloc] initWithFrame:CGRectMake(100,100,150,50)withBackgroundColor:[UIColor yellowColor]];

    button2.frame = CGRectMake(100,100,150,50);
    [self.view addSubview:button2];
*/
    HJShinyButton *button1 = [[HJShinyButton alloc] initWithFrame:rect1];
    [self.view addSubview:button1];
    
    //直接init方法的话 需要把方法写在layoutsubviews
    HJShinyButton *button2  = [[HJShinyButton alloc] init];
    button2.frame  = rect2;
    [self.view addSubview:button2];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
