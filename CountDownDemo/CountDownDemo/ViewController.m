//
//  ViewController.m
//  CountDownDemo
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "HJFlipNumberView.h"


@interface ViewController ()
/*定时器*/
@property(nonatomic, strong)NSTimer *timer;

/**/
@property(nonatomic, strong)HJFlipNumberView *flipV;

/*测试类*/
@property(nonatomic, strong)UIImageView *testV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flipV = [[HJFlipNumberView alloc] initWithFrame:(CGRectMake(self.view.frame.size.width / 2 - 10, 150, 35 / 2.0, 56 / 2.0)) currentNumber:0 totalNumber:9];
    [self.view addSubview:self.flipV];
    
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:@"开始" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    button.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 200, 100, 39);  [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button1 setTitle:@"停止" forState:(UIControlStateNormal)];
    [button1 setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    button1.frame = CGRectMake(self.view.frame.size.width / 2 - 50, 250, 100, 39);
    [self.view addSubview:button1];
    
    [button addTarget:self action:@selector(startTimer:) forControlEvents:(UIControlEventTouchUpInside)];
    [button1 addTarget:self action:@selector(endTimer:) forControlEvents:(UIControlEventTouchUpInside)];

    self.testV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"0_top"]];
        self.testV.layer.anchorPoint = CGPointMake(0.5, 1);
    self.testV.frame = CGRectMake(self.view.frame.size.width / 2 - 14, 300, 28, 39 / 2.0);
    [self.view addSubview:self.testV];
}
- (void)startTimer:(id)sender {
//    [self.timer invalidate];
//    self.timer = nil;
    
    [self.flipV startFlip];
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform.rotation.x" ];
    
    //animation. toValue = [ NSValue valueWithCATransform3D :rotationTransform];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI);
    //    animation.fromValue	= [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)];
    //    animation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation. duration   =  2;
    
    //这两句是保持移动后保持不变
    animation.removedOnCompletion = true;
    animation.fillMode = kCAFillModeForwards;

    [self.testV.layer addAnimation:animation forKey:@"rotation"];
//    animation. delegate = self ;

    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timer:) userInfo:nil repeats:false];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
- (void)endTimer:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timer:(NSTimer *)timer {
    [self.flipV startFlip];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
