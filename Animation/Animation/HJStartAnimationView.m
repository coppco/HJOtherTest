//
//  HJStartAnimationView.m
//  Animation
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJStartAnimationView.h"
#import "AppDelegate.h"
#import "UIView+HJExtension.h"

//获取主窗口的bounds
#define kMainScreenBounds ([UIScreen mainScreen].bounds)
//获取主窗口的bounds
#define kMainScreenSize ([UIScreen mainScreen].bounds.size)
//获取主窗口的高度
#define kMainScreenHeight ([UIScreen mainScreen].bounds.size.height)
//获取主窗口的宽度
#define kMainScreenWidth  ([UIScreen mainScreen].bounds.size.width)
/**获取主窗口*/
#define kMainScreen ([[UIApplication sharedApplication] keyWindow])
/*==================系统版本==================*/
#ifndef __iOS_VERSION
#define __iOS_VERSION ([[UIDevice currentDevice].systemVersion floatValue])
#endif

#ifndef __iOS_5_0
#define __iOS_5_0 ((__iOS_VERSION) >= 5.0)
#endif
#ifndef __iOS_6_0
#define __iOS_6_0 ((__iOS_VERSION) >= 6.0)
#endif
#ifndef __iOS_7_0
#define __iOS_7_0 ((__iOS_VERSION) >= 7.0)
#endif
#ifndef __iOS_8_0
#define __iOS_8_0 ((__iOS_VERSION) >= 8.0)
#endif
#ifndef __iOS_9_0
#define __iOS_9_0 ((__iOS_VERSION) >= 9.0)
#endif
#ifndef __iOS_10_0
#define __iOS_10_0 ((__iOS_VERSION) >= 10.0)
#endif

#define __isIPHONE_4 (CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 1.0)
#define __isIPHONE_4S (CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 2.0)
#define __isIPHONE_5 CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 568))
#define __isIPHONE_6 CGSizeEqualToSize(kMainScreenSize, CGSizeMake(375, 667))
#define __isIPHONE_6P CGSizeEqualToSize(kMainScreenSize, CGSizeMake(414, 736))


@interface HJStartAnimationView ()
/*背景图片*/
@property(nonatomic, strong)UIImageView * backImageV;
/*掉落的💰*/
@property(nonatomic, strong)UIImageView * moneyImageV;
/*logo*/
@property(nonatomic, strong)UIImageView * logoImageV;
/*hi*/
@property(nonatomic, strong)UIImageView * hiImageV;
@end

@implementation HJStartAnimationView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    [self addSubview:self.backImageV];
    [self addSubview:self.moneyImageV];
    [self addSubview:self.logoImageV];
    [self addSubview:self.hiImageV];
}

+ (HJStartAnimationView *)startWith:(UIWindow *)windown{
    HJStartAnimationView *animationView = [[HJStartAnimationView alloc] initWithFrame:windown.bounds];
    [windown addSubview:animationView];
    [windown bringSubviewToFront:animationView];
    return animationView;
}

- (void)startAnimation {
    [self.moneyImageV startAnimating];
    [UIView animateWithDuration:2 animations:^{
        self.moneyImageV.y = self.height * 0.3 + self.moneyImageV.height;
        NSLog(@"%f", self.moneyImageV.y);
    } completion:^(BOOL finished) {
        [self logoAnimation];
    }];
}
- (void)logoAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        self.logoImageV.transform = CGAffineTransformScale(self.logoImageV.transform, 1.2, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.logoImageV.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.hiImageV.alpha = 1;
                self.hiImageV.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

+ (UIWindow *)window {
    UIWindow *window = nil;
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        window = [delegate performSelector:@selector(window)];
    } else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

- (UIImageView *)backImageV {
    if (!_backImageV) {
        _backImageV = ({
            UIImageView *imageV = [[UIImageView alloc] init];
            if ((__isIPHONE_4) || (__isIPHONE_4S)) {
                imageV.image = [UIImage imageNamed:@"reg_img_white_i4"];
            } else if (__isIPHONE_5){
                imageV.image = [UIImage imageNamed:@"reg_img_white_i5"];
            } else {
                imageV.image = [UIImage imageNamed:@"reg_img_white"];
            }
            imageV;
        });
    }
    return _backImageV;
}

- (UIImageView *)moneyImageV {
    if (!_moneyImageV) {
        _moneyImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            NSMutableArray *images = [NSMutableArray array];
            NSString *name = @"animation_GoldRotation_i50";
            if ((__isIPHONE_6P)) {
                name = @"animation_GoldRotation0";
            }
            for (int i = 1; i <= 6; i++) {
                [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d", name, i]]];
            }
            object.size = CGSizeMake(31, 31);
            object.centerY = -31;
            object.centerX = kMainScreenWidth / 2;
            object.image = [UIImage imageNamed:@"animation_GoldRotation01"];
            object.animationImages = images;
            object.animationDuration = 0.5;
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
            NSString *name = @"reg_img_logo_i5";
            if (__isIPHONE_6P) {
                name = @"reg_img_logo";
            }
            UIImage *image = [UIImage imageNamed:name];
            object.image = image;
            [object sizeToFit];
            object;
        });
    }
    return _logoImageV;
}
- (UIImageView *)hiImageV {
    if (!_hiImageV) {
        _hiImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            NSString *name = @"reg_img_version_i5";
            if (__isIPHONE_6P) {
                name = @"reg_img_version";
            }
            UIImage *image = [UIImage imageNamed:name];
            object.image = image;
            [object sizeToFit];
            object.alpha = 0;
            object.transform = CGAffineTransformScale(object.transform, 0.7, 0.7);
            object;
        });
    }
    return _hiImageV;
}

-(UIImage *)launchImage
{
    UIImage *imageP = [self launchImageWithType:@"Portrait"];
    if(imageP) return imageP;
    UIImage *imageL = [self launchImageWithType:@"Landscape"];
    if(imageL) return imageL;
    NSLog(@"获取LaunchImage失败!请检查是否添加启动图,或者规格是否有误.");
    
    return nil;
}
-(UIImage *)launchImageWithType:(NSString *)type
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = type;
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            if([dict[@"UILaunchImageOrientation"] isEqualToString:@"Landscape"])
            {
                imageSize = CGSizeMake(imageSize.height, imageSize.width);
            }
            if(CGSizeEqualToSize(imageSize, viewSize))
            {
                launchImageName = dict[@"UILaunchImageName"];
                UIImage *image = [UIImage imageNamed:launchImageName];
                return image;
            }
        }
    }
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.backImageV.frame = self.bounds;
    self.logoImageV.x = self.width / 2 - self.logoImageV.width / 2;
    self.logoImageV.centerY = self.height * 0.4;
    
    self.hiImageV.x = self.logoImageV.maxX ;
    self.hiImageV.y = self.logoImageV.minY - self.hiImageV.height;
}

@end
