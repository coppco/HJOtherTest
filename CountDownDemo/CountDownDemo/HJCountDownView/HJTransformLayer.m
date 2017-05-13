//
//  HJTransformLayer.m
//  CountDownDemo
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJTransformLayer.h"

@implementation HJTransformLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.doubleSided = YES;
    self.anchorPoint = CGPointMake(0.5, 1.0f);
    [self addSublayer:self.topLayer];
    [self addSublayer:self.bottomLayer];
}

- (CALayer *)topLayer {
    if (!_topLayer) {
        _topLayer = ({
            CALayer *object = [[CALayer alloc] init];
            object.backgroundColor=[UIColor whiteColor].CGColor;
            object.doubleSided=NO;
            object.name=@"topLayer";
            object.opaque=NO;
            object;
        });
    }
    return _topLayer;
}

- (CALayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = ({
            CALayer *object = [[CALayer alloc] init];
            object.backgroundColor=[UIColor whiteColor].CGColor;
            object.doubleSided=YES;
            object.name=@"bottomLayer";
            object.opaque = YES;
#warning 需要做
//            _bottomLayer.transform=JHFlipCATransform3DPerspectSimpleWithRotate(180.0f);
            object;
        });
    }
    return _bottomLayer;
}

- (void)updateLayerContent:(UIImage *)image isTop:(BOOL)isTop {
    if (isTop) {
        self.topLayer.contents = (id)image.CGImage;
    } else {
        self.bottomLayer.contents = (id)image.CGImage;
    }
}

- (void)layoutSublayers {
    [super layoutSublayers];
    self.position = CGPointMake(self.position.x, self.position.y-self.frame.size.height/2);
    self.topLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2);
    self.bottomLayer.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2);
}
@end
