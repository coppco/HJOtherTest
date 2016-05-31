//
//  ViewController.m
//  08-环形滑块
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJCircleSlider.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet HJCircleSlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider addTarget:self action:@selector(valueChange:) forControlEvents:(UIControlEventValueChanged)];
    
    self.slider.value = 0.5;
    
    //保留三位有效数字
    CGFloat value = round(100.844999 * 1000) / 1000;
}
- (void)valueChange:(HJCircleSlider *)slider {
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f", slider.value];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
