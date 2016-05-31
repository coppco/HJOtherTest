//
//  ViewController.m
//  06-旋转的图片
//
//  Created by coco on 16/5/30.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJRotationImage.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet HJRotationImage *rotationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rotationView.imageV.image = [UIImage imageNamed:@"dog.jpg"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.rotationView stopRotation];
    });
    
    HJRotationImage *imageV = [[HJRotationImage alloc] init];
    [self.view addSubview:imageV];
    imageV.frame = CGRectMake(50, 50, 100, 100);
    imageV.imageV.image = [UIImage imageNamed:@"dog.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
