//
//  ViewController.m
//  11-带label的滑块
//
//  Created by coco on 16/6/1.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJTextSlider.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet HJTextSlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *currentL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.maximumValue = 100;
    self.slider.minimumValue = 1;
    self.slider.value = 1.3;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
