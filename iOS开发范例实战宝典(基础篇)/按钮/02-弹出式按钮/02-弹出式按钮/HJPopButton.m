//
//  HJPopButton.m
//  02-弹出式按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import "HJPopButton.h"
/**角度转弧度*/
#define kHJAngleToRadian(x) ((x)*M_PI)/180
@interface HJPopButton ()

{
    CGPoint kHJPopButtonStartLocation;
    CGPoint kHJPopButtonFinalLocation;
}

/**子按钮的数组*/
@property (nonatomic, strong)NSMutableArray  *subButtons;

@end

@implementation HJPopButton

@synthesize expanded = _expanded;

- (NSMutableArray *)subButtons {
    if (_subButtons == nil) {
        _subButtons = [NSMutableArray array];
    }
    return _subButtons;
}
- (BOOL)isExpanded {
    return _expanded;
}
- (instancetype)initWithFrame:(CGRect)frame
              subButtonImages:(NSArray<NSString *> *)subImages
                            totalRadius:(CGFloat)totalRadius
                           centerRadius:(CGFloat)centerRadius
                              subRadius:(CGFloat)subRadius
                            centerImage:(NSString *)centerImageName
                       centerBackground:(NSString *)centerBackgroundName
                        addToParentView:(UIView *)parentView {
    self = [super initWithFrame:frame];
    if (self) {
        self.parentView = parentView;
        self.totalRadius = totalRadius;
        self.subImages = subImages;
        self.centerRadius = centerRadius;
        self.subRadius= subRadius;
        _expanded = NO;
        if (self.parentView) {
            [self.parentView addSubview:self];
        }
        //配置中心按钮
        [self configCenterButtonWithImage:centerImageName backgroundImage:centerBackgroundName centerRadius:centerRadius];
        //子按钮
        [self configureTheButtons:subImages];
    }
    return self;
}
/*中心按钮*/
- (void)configCenterButtonWithImage:(NSString *)centerImageName backgroundImage:(NSString *)centerBackgroundName centerRadius:(CGFloat)centerRadios {
    self.centerButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    if (centerImageName.length == 0) {
        centerImageName = @"dc-center";
    }
    [self.centerButton setImage:[UIImage imageNamed:centerImageName] forState:(UIControlStateNormal)];
    if (centerBackgroundName == nil) {
        centerBackgroundName = @"dc-background";
    }
    [self.centerButton setBackgroundImage:[UIImage imageNamed:centerBackgroundName] forState:UIControlStateNormal];
    [self.centerButton addTarget:self action:@selector(buttonPress:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.centerButton];
}
/*按钮方法*/
- (void)buttonPress:(UIButton *)button {
    //中心按钮方法
    if (button == self.centerButton) {
        if (!self.isExpanded) {
            //展开按钮
            NSLog(@"展开");
            [self subButtonAppear];
            _expanded = YES;
        } else {
            //收起按钮
            NSLog(@"收起");
            [self subButtonDismiss];
            _expanded = NO;
        }
    } else {
        //子按钮方法
        
        
    }
}
/*子按钮*/
- (void)configureTheButtons:(NSArray *)subImages {
    if (subImages.count <= 0) {
        return;
    }
    for (int i = 0; i < subImages.count; i++) {
        UIButton *subButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [subButton setImage:[UIImage imageNamed:subImages[i]] forState:(UIControlStateNormal)];
        subButton.hidden = YES;
        [self.subButtons addObject:subButton];
        [self addSubview:subButton];
    }
}
/*布局*/
- (void)layoutSubviews {
    [super layoutSubviews];
    self.centerButton.center = self.center;
    self.centerButton.frame = CGRectMake(0, 0, self.centerRadius, self.centerRadius);
    
    //终点
    kHJPopButtonFinalLocation = CGPointMake(self.centerButton.center.x, self.centerButton.center.y);
    
    //起点
    kHJPopButtonStartLocation = CGPointZero;
    for (UIButton *button in self.subButtons) {
        button.center = kHJPopButtonStartLocation;
        button.frame = CGRectMake(0, 0, self.subRadius, self.subRadius);
    }
    
}
//展开
- (void)subButtonAppear {
    for (UIButton *button in self.subButtons) {
        button.hidden = NO;
        [self button:button appearAtPoint:[self appearPointWithSubButton:button] delay:0.7 duration:0.5];
    }
}
- (CGPoint)appearPointWithSubButton:(UIButton *)button {
    //每一个的弧度
    CGFloat radian = 2 * M_PI / self.subButtons.count;
    NSUInteger index = [self.subButtons indexOfObject:button];
    
    CGFloat x = self.centerButton.center.x + self.totalRadius * sinf(index * radian);
    CGFloat y = self.centerButton.center.y - self.totalRadius * cosf(index * radian);

    return CGPointMake(x, y);
}
//动画方法
- (void)button:(UIButton *)button appearAtPoint:(CGPoint)point delay:(CGFloat)delay duration:(NSTimeInterval)duration {
    button.center = point;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.duration = duration;
    //layer的动画,在xy轴上面从小到大再还原
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:(CATransform3DMakeScale(0.1, 0.1, 1))], [NSValue valueWithCATransform3D:(CATransform3DMakeScale(1.3, 1.3, 1))], [NSValue valueWithCATransform3D:(CATransform3DMakeScale(1, 1, 1))]];
    scaleAnimation.calculationMode = kCAAnimationLinear;
    //动画的时间间距
    scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:delay],[NSNumber numberWithFloat:1.0f]];
    button.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [button.layer addAnimation:scaleAnimation forKey:@"buttonAppear"];
}
//收起
- (void)subButtonDismiss {
    for (UIButton *button in self.subButtons) {
        [self button:button dismissAtPoint:[self appearPointWithSubButton:button] delay:0.3 animationDuration:1];
    }
}
- (void)button:(UIButton *)button dismissAtPoint:(CGPoint)point delay:(CGFloat)delay animationDuration:(CGFloat)duration {
    //旋转
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.duration = duration * delay;
    rotation.values = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:1],[NSNumber numberWithFloat:0.0f]];
    rotation.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:delay],[NSNumber numberWithFloat:1.0f]];
    
    //平移
    CAKeyframeAnimation *pan = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pan.duration = duration * (1 - delay);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    
//    CGPathAddLineToPoint(path, NULL, location.x + axisX, location.y + axisY);
    CGPathAddLineToPoint(path, NULL, kHJPopButtonFinalLocation.x, kHJPopButtonFinalLocation.y);
    pan.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 1.0f;
    group.animations = @[rotation, pan];

    group.fillMode=kCAFillModeForwards;
    group.removedOnCompletion = NO;  //不移除
    
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    
    button.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    [button.layer addAnimation:group forKey:@"buttonDismiss"];
    [button performSelector:@selector(setHidden:) withObject:@YES afterDelay:duration];
}

@end
