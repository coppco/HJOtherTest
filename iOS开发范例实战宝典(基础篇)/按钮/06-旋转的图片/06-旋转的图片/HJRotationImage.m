//
//  HJRotationImage.m
//  06-旋转的图片
//
//  Created by coco on 16/5/30.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJRotationImage.h"

typedef NS_ENUM(NSInteger, HJRotationImageType)  {
    HJRotationImageTypeNone,  //没有状态
    HJRotationImageTypeStop,  //停止状态
    HJRotationImageTypeRotation  //选择状态
};

@interface HJRotationImage ()
/*是否在转动*/
@property (nonatomic, assign)BOOL isRotation;

/*记录之前的状态*/
@property (nonatomic, assign)HJRotationImageType type;
@end

@interface HJRotationImage ()
/*动画*/
@property (nonatomic, strong)CABasicAnimation *rotationAnimation;
@end
@implementation HJRotationImage

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configSubView];
    }
    return self;
}
- (void)configSubView {
    self.isRotation = NO;
    self.type = HJRotationImageTypeNone;
    
    self.imageV = [[UIImageView alloc] init];
    self.imageV.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.imageV];
    
    self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    self.rotationAnimation.repeatCount = MAXFLOAT;
    self.rotationAnimation.cumulative = NO;
    self.rotationAnimation.duration = 20; //动画持续时间  越小动画转的越快
    self.rotationAnimation.removedOnCompletion = NO;  //动画完成后不结束,这个属性很重要,不写切换home返回会,动画不再动了

    [self.imageV.layer addAnimation:self.rotationAnimation forKey:@"Rotation"]; //图片layer添加动画
    self.layer.speed = 0; //通过控制
}
- (void)startRotation {
    self.isRotation = YES;

    //start Animation
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1;  //超过1 动画时间就是duration / speed 会缩短时间的,例如为2那么播放速度就是用来的2倍
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
    NSLog(@"%f", [self.layer convertTime:CACurrentMediaTime() fromLayer:nil]);
    
    //监听进入前台和后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
//前台
- (void)willEnterForeground {
    if (self.type == HJRotationImageTypeRotation) {
        [self startRotation];
    }
    self.type = HJRotationImageTypeNone;
}
//后台
- (void)didEnterBackground {
    if ([self isRotation]) {
        self.type = HJRotationImageTypeRotation;
        [self stopRotation];
    } else {
        self.type = HJRotationImageTypeStop;
    }
}
- (void)stopRotation {
    self.isRotation = NO;

    //pause
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageV.center = self.center;
    self.imageV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.imageV.layer.borderWidth = 2;
    self.imageV.layer.cornerRadius = self.imageV.frame.size.width / 2;
    self.imageV.layer.borderColor = [UIColor redColor].CGColor;
    self.imageV.layer.masksToBounds = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isRotation = !self.isRotation;
    if (self.isRotation) {
        [self startRotation];
    } else {
        [self stopRotation];
    }
}

- (BOOL)isRotationAnimation {
    return self.isRotation;
}
@end
