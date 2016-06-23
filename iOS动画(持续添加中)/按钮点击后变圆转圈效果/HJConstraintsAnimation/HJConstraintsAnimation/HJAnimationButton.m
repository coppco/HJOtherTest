//
//  HJAnimationButton.m
//  HJConstraintsAnimation
//
//  Created by coco on 16/6/23.
//  Copyright © 2016年 XHJ. All rights reserved.
//  

#import "HJAnimationButton.h"

const NSTimeInterval duration = 1.2;

@interface HJAnimationButton ()
/**组动画*/
@property (nonatomic, strong)CAAnimationGroup *group;
/**layer*/
@property (nonatomic, strong)CAShapeLayer *circle;
@end

@implementation HJAnimationButton
- (CAShapeLayer *)circle {
    if (!_circle) {
        _circle = ({
            CAShapeLayer *object = [[CAShapeLayer alloc] init];
            object.fillColor = [UIColor clearColor].CGColor;
            object.strokeColor = [UIColor whiteColor].CGColor;
            object.lineWidth = 1;
            object.opacity = 0;
            object.strokeEnd = object.strokeStart = 0;
            object;
        });
        [self.layer addSublayer: _circle];
    }
    return _circle;
}

- (CAAnimationGroup *)group {
    if (!_group) {
        _group = ({
            CAAnimationGroup *object = [CAAnimationGroup animation];
            
            CABasicAnimation * endAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
            endAnimation.fromValue = @0;
            endAnimation.toValue = @1;
            /*
            CABasicAnimation * startAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
            startAnimation.beginTime = CACurrentMediaTime() + duration / 2;
            startAnimation.fromValue = @0;
            startAnimation.toValue = @1;
            */
            object.animations = @[endAnimation];
            object.duration = duration;
            object.repeatCount = MAXFLOAT;
             object.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            object.removedOnCompletion = NO;
            object;
        });
    }
    return _group;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min = MIN(self.frame.size.width / 2, self.frame.size.height / 2) * 0.9;
    self.circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.frame.size.width / 2 - min / 2, self.frame.size.height / 2 - min / 2, min, min)].CGPath;
}
- (void)start {
    [self.circle removeAnimationForKey:@"start"];
    [self.circle addAnimation:self.group forKey:@"start"];
    [UIView animateWithDuration:0.15 animations:^{
        self.circle.opacity = 1;
        self.titleLabel.alpha = 0;
    }];
}
- (void)stop {
    [self.circle removeAnimationForKey:@"start"];
    [UIView animateWithDuration:0.15 animations:^{
        self.circle.opacity = 0;
        self.titleLabel.alpha = 1;
    }];
}
@end
