//
//  ViewController.m
//  09-多个颜色的滑块
//
//  Created by coco on 16/5/31.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJSlider.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet HJSlider *slider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.value = 0.3;
    self.slider.midValue = 0.8;
    
    self.slider.minimumTrackTintColor = [UIColor orangeColor
                                         ];
    self.slider.maximumTrackTintColor = [UIColor blueColor];
    
    self.slider.middleTrackTintColor = [UIColor greenColor];
    
    self.slider.thumbTintColor = [UIColor purpleColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
