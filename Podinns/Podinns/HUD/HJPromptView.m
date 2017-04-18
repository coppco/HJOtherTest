//
//  HJPromptView.m
//  HJOrange
//
//  Created by apple on 2017/2/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJPromptView.h"

@interface HJPromptView ()
//获取主窗口的宽度
#define kMainScreenWidth  ([UIScreen mainScreen].bounds.size.width)
//获取主窗口的高度
#define kMainScreenHeight ([UIScreen mainScreen].bounds.size.height)
/**
 标题
 */
@property(nonatomic, strong)UILabel *titleL;

/**
 图片
 */
@property(nonatomic, strong)UIImageView *imageV;

/**
 是否已经显示
 */
@property(nonatomic, assign)BOOL isShow;
@end

@implementation HJPromptView

#pragma mark - 懒加载
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = ({
            UILabel *object = [[UILabel alloc] init];
            object.font = [UIFont boldSystemFontOfSize:13];
            object.textAlignment = NSTextAlignmentCenter;
            object.numberOfLines = 0;
            object.textColor = [UIColor whiteColor];
            object;
        });
    }
    return _titleL;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object;
        });
    }
    return _imageV;
}


static HJPromptView * promptView = nil;
+ (HJPromptView *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        promptView = [[self alloc] init];
        [promptView addSubview:promptView.titleL];
        [promptView addSubview:promptView.imageV];
        promptView.backgroundColor = [UIColor colorWithRed:0x17 / 255.0 green:0x17 / 255.0 blue:0x17 / 255.0 alpha:0.8];
        promptView.layer.cornerRadius = 5;
        promptView.layer.masksToBounds = YES;
    });
    return promptView;
}

+ (void)showImage:(NSString *)imageName message:(NSString *)message {
    HJPromptView *shared = [self shareInstance];
    if (shared.isShow) { //已经显示, 取消之前显示的视图
        [self cancelPreviousPerformRequestsWithTarget:self selector:@selector(showImage:message:) object:nil];
    }
    shared.titleL.text = message;

    shared.titleL.width = kMainScreenWidth - 60;
    [shared.titleL sizeToFit];
    
    if (imageName) {
        shared.imageV.image = [UIImage imageNamed:imageName];
    } else {
        shared.imageV.image = nil;
    }
    
    shared.imageV.width = kMainScreenWidth - 60;
    [shared.imageV sizeToFit];
    
    shared.width = MAX(shared.imageV.width, shared.titleL.width) + 40;
    shared.height = shared.imageV.height + shared.titleL.height + 30;
    shared.x = (kMainScreenWidth - shared.width) / 2;
    shared.y = (kMainScreenHeight - shared.height) / 2;
    
    shared.titleL.centerX = shared.width / 2;
    shared.imageV.centerX = shared.width / 2;
    if (CGSizeEqualToSize(shared.imageV.frame.size, CGSizeZero)) {
        shared.titleL.y = 15;
    } else {
        shared.imageV.y = 10;
        shared.titleL.y = shared.imageV.maxY + 10;
    }
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:shared];
    shared.alpha = 0;
    shared.isShow = YES;
    [UIView animateWithDuration:0.25 animations:^{
        shared.alpha = 1;
    }];
    
    [self performSelector:@selector(hidden) withObject:nil afterDelay:1.25];
}

+ (void)hidden {
    [UIView animateWithDuration:0.25 animations:^{
        [self shareInstance].alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self shareInstance].isShow = NO;
            [[self shareInstance] removeFromSuperview];
        }
    }];
}

@end
