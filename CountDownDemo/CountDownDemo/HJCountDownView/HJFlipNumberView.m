//
//  HJFlipNumberView.m
//  CountDownDemo
//
//  Created by apple on 2017/5/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJFlipNumberView.h"
#import "HJTransformLayer.h"

#define kDegreesToRadian(x) (M_PI * (x) / 180.0 )

@interface HJFlipNumberView ()<CAAnimationDelegate>
/*定时器*/
@property(nonatomic, strong)NSTimer *timer;

/*上面图片*/
@property(nonatomic, strong)UIImageView *topImageV;
@property(nonatomic, strong)UIImageView *bottomImageV;
@property(nonatomic, strong)UIImageView *flipingImageV;


/*顶部图片*/
@property(nonatomic, strong)NSMutableArray *topA;
/*底部图片*/
@property(nonatomic, strong)NSMutableArray *bottomA;
@end

@implementation HJFlipNumberView

//+ (Class)layerClass {
//    return [HJTransformLayer class];
//}
//- (HJTransformLayer *)transformLayer {
//    return (HJTransformLayer *)self.layer;
//}
- (instancetype)initWithCurrentNumber:(NSInteger)currentNumber totalNumber:(NSInteger)totalNumber {
    self = [super init];
    if (self) {
        _currentNumber = currentNumber;
        _totalNumber = totalNumber;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frmae currentNumber:(NSInteger)currentNumber totalNumber:(NSInteger)totalNumber {
    self = [super initWithFrame:frmae];
    if (self) {
        _currentNumber = currentNumber;
        _totalNumber = totalNumber;
        [self setupUI];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentNumber = 0;
        _totalNumber = 0;
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.topA = [NSMutableArray arrayWithCapacity:0];
    self.bottomA = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i <= 9; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"CountDown_%d", i]];
        NSArray *array = JHFlip_make_hsplit_images_for_image(image);
        [self.topA addObject:array.firstObject];
        [self.bottomA addObject:array.lastObject];
    }
    
    [self addSubview:self.topImageV];
    [self addSubview:self.bottomImageV];
    [self addSubview:self.flipingImageV];
    
    self.topImageV.image = self.topA.firstObject;
    self.flipingImageV.image = self.topA.firstObject;
    self.bottomImageV.image = self.bottomA.firstObject;
    
    if (self.totalNumber < self.currentNumber) {
#if DEBUG
        NSLog(@"%@", [NSString stringWithFormat:@"TotalNumber是%ld, currentNumber是%ld, currentNumber不能比totalNumber大", (long)_totalNumber, (long)_currentNumber]);
#endif
        return;
    }
}

- (void)startFlip {
    self.flipingImageV.hidden = false;

    self.currentNumber = (self.currentNumber + 1) % self.totalNumber;
    self.topImageV.image = self.topA[self.currentNumber];
    self.flipingImageV.image = self.bottomA[self.currentNumber];
    [self.flipingImageV.layer addAnimation:[self rotation:0.5 degree:0 direction:0 repeatCount:0] forKey:@"123"];
}

-( CABasicAnimation *)rotation:( float )dur degree:( float )degree direction:( int )direction repeatCount:( int )repeatCount {
    //[CATransaction begin];
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform.rotation.x" ];
    
    //animation. toValue = [ NSValue valueWithCATransform3D :rotationTransform];
    animation.fromValue = @(-M_PI);
    animation.toValue = @(0);
//    animation.fromValue	= [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)];
//    animation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation. duration   =  0.8;
    
    //这两句是保持移动后保持不变
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeForwards;
    animation. delegate = self ;
    return animation;
}

- (void)animationDidStart:(CAAnimation *)anim {
        self.bottomImageV.hidden = true;
//    _next_layer = [layerArray objectAtIndex:_currentPage];
//    _next_layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);
//    _next_layer.hidden = NO;
//    
//    _bottom_layer.hidden = NO;
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(here) userInfo:nil repeats:NO];
}
//
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    self.flipingLayer.hidden = true;
    self.flipingImageV.hidden = true;
    self.bottomImageV.hidden = false;
    self.bottomImageV.image = self.bottomA[self.currentNumber];
//    [self.flipingLayer removeAnimationForKey:@"transform"];
//    [self bringSubviewToFront:_bottomImageView];
//    
//    _bottom_layer = [layerHelperArray objectAtIndex:(_currentPage-1+_flipNumber)%_flipNumber];
//    _bottom_layer.transform = CATransform3DMakeRotation(0, 1, 0, 0);
//    ((CustomLayer*)[layerHelperArray objectAtIndex:_currentPage]).hidden = YES;
//    ((CustomLayer*)[layerHelperArray objectAtIndex:_currentPage]).transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
//    
//    [_dragging_layer removeAnimationForKey: @"transform"];
//    _dragging_layer.hidden = YES;
    
}

- (UIImageView *)topImageV {
    if (!_topImageV) {
        _topImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object;
        });
    }
    return _topImageV;
}
- (UIImageView *)flipingImageV {
    if (!_flipingImageV) {
        _flipingImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.layer.anchorPoint = CGPointMake(0.5, 0);
            object.hidden = true;
            object;
        });
    }
    return _flipingImageV;
}
- (UIImageView *)bottomImageV {
    if (!_bottomImageV) {
        _bottomImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object;
        });
    }
    return _bottomImageV;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.topImageV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2);
    self.bottomImageV.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2);
    self.flipingImageV.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2);
}

///分割图片
static inline NSArray* JHFlip_make_hsplit_images_for_image(UIImage* image){
    CGSize halfSize=CGSizeMake(image.size.width, image.size.height/2);
    UIGraphicsBeginImageContext(halfSize);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity); // 2-1
    CGContextTranslateCTM(context, 0, halfSize.height); // 3-1
    CGContextScaleCTM(context, 1.0, -1.0); // 4-1
    CGImageRef imageRef=image.CGImage;
    CGContextDrawImage(context, CGRectMake(0, -1*halfSize.height,
                                           image.size.width,
                                           image.size.height),
                       imageRef);
    UIImage* imageFirst=UIGraphicsGetImageFromCurrentImageContext();
    

    CGContextClearRect(context, CGRectMake(0, 0, image.size.width , image.size.height));
    CGContextDrawImage(context, CGRectMake(0,0,
                                           image.size.width,
                                           image.size.height),
                       imageRef);
    UIImage* imageSecond=UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    //WLog_Float(@"hSplitImageToArray duration", CFAbsoluteTimeGetCurrent()-startTime);
    return @[imageFirst,imageSecond,];
}
@end
