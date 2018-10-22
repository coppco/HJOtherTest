//
//  LoadingAnimationController.m
//  Animation
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoadingAnimationController.h"
#import "UIView+HJExtension.h"
#import "ViewController.h"
@interface LoadingAnimationController ()
/*背景图片*/
@property(nonatomic, strong)UIImageView * backgroundImageV;
/*掉落的💰*/
@property(nonatomic, strong)UIImageView * moneyImageV;
/*logo*/
@property(nonatomic, strong)UIImageView * logoImageV;
/*hi*/
@property(nonatomic, strong)UIImageView * hiImageV;
@end

@implementation LoadingAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//     [[UIApplication sharedApplication] setStatusBarHidden:YES];
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarHidden:false];
//}
- (void)setup {
    [self.view addSubview:self.backgroundImageV];
    [self.view addSubview:self.moneyImageV];
    [self.view addSubview:self.logoImageV];
    [self.view addSubview:self.hiImageV];

    
    self.backgroundImageV.frame = self.view.bounds;
    self.logoImageV.size = CGSizeMake(106, 106);
    self.logoImageV.centerX = self.view.width / 2;
    self.logoImageV.centerY = self.view.height * 0.39;
    
    self.moneyImageV.size = CGSizeMake(31, 31);
    self.moneyImageV.y = -50;
    self.moneyImageV.centerX = self.view.centerX;
    
    self.hiImageV.size = CGSizeMake(35, 34);
    self.hiImageV.x = self.logoImageV.maxX ;
    self.hiImageV.y = self.logoImageV.minY - self.hiImageV.height;
    [self startAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)startAnimation {
    [self.moneyImageV startAnimating];
    [UIView animateWithDuration:1.6 animations:^{
        self.moneyImageV.centerY = self.logoImageV.minY + self.moneyImageV.height / 2;
    } completion:^(BOOL finished) {
        self.moneyImageV.animationImages = nil;
        [self logoAnimation];
    }];
}
- (void)logoAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        self.logoImageV.transform = CGAffineTransformScale(self.logoImageV.transform, 1.1, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.logoImageV.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.hiImageV.alpha = 1;
                self.hiImageV.transform = CGAffineTransformIdentity;
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.3];
            }];
        }];
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0.5;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[ViewController alloc] init];
    }];
}
#pragma - mark 懒加载
-(UIImageView *)backgroundImageV {
    if (!_backgroundImageV) {
        _backgroundImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"reg_img_white"];
            object;
        });
    }
    return _backgroundImageV;
}
-(UIImageView *)moneyImageV {
    if (!_moneyImageV) {
        _moneyImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            NSMutableArray *images = [NSMutableArray array];
            for (int i = 1; i <= 6; i++) {
                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"animation_GoldRotation0%d", i]]];
            }
            object.animationImages = images;
            object.animationDuration = 0.4;
            object.animationRepeatCount = 4;
            object;
        });
    }
    return _moneyImageV;
}
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"reg_img_logo"];
            object;
        });
    }
    return _logoImageV;
}
- (UIImageView *)hiImageV {
    if (!_hiImageV) {
        _hiImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"reg_img_version"];
            object.alpha = 0;
            object.transform = CGAffineTransformScale(object.transform, 0.7, 0.7);
            object;
        });
    }
    return _hiImageV;
}- (BOOL)prefersStatusBarHidden {
    return true;
}
@end
