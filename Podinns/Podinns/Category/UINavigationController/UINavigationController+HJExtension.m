//
//  UINavigationController+HJExtension.m
//  Podinns
//
//  Created by apple on 2017/3/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UINavigationController+HJExtension.h"

@implementation UINavigationController (HJExtension)
- (void)showText:(NSString *)text {
    if ([self show]) {
        //已经显示, 取消显示
        [UINavigationController cancelPreviousPerformRequestsWithTarget:self selector:@selector(showText:) object:nil];
        [UINavigationController cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenMessageL) object:nil];
    }
    UILabel *messageL = [self messageL];
    
    messageL.alpha = 0;
    messageL.text = text;
    messageL.y = 64 - messageL.height;
    
    if (messageL.superview) {
        [messageL removeFromSuperview];
    }
    [self.view insertSubview:messageL belowSubview:self.navigationBar];
    [self setShow:true];
    [UIView animateWithDuration:0.5 animations:^{
        messageL.y = 64;
//        messageL.transform = CGAffineTransformMakeTranslation(0, messageL.height);
        messageL.alpha = 1;
    }];
    [self performSelector:@selector(hiddenMessageL) withObject:nil afterDelay:1.5];
    
}


- (void)hiddenMessageL {
    UILabel *messageL = [self messageL];
    [UIView animateWithDuration:0.5 animations:^{
//        messageL.transform = CGAffineTransformIdentity; //取消形变
        messageL.y = 64 - messageL.height;
        messageL.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self setShow:false];
            [messageL removeFromSuperview];
        }
    }];
}

- (void)setMessageL:(UILabel *)messageL {
    objc_setAssociatedObject(self, @selector(messageL), messageL, OBJC_ASSOCIATION_RETAIN);
}
- (UILabel *)messageL {
    UILabel *messageL = objc_getAssociatedObject(self, @selector(messageL));
    if (messageL == nil) {
        messageL = [[UILabel alloc] init];
        messageL.textColor = [UIColor whiteColor];
        messageL.textAlignment = NSTextAlignmentCenter;
        messageL.numberOfLines = 0;
        messageL.width = [UIScreen mainScreen].bounds.size.width;
        messageL.height = 35;
        messageL.backgroundColor = [UIColor grayColor];
        [self setMessageL:messageL];
    }
    return messageL;
}

- (void)setShow:(BOOL)show {
    objc_setAssociatedObject(self, @selector(show), @(show), OBJC_ASSOCIATION_ASSIGN);
}

/**
 是否显示
 */
- (BOOL)show {
    return objc_getAssociatedObject(self, @selector(show));
}
@end
