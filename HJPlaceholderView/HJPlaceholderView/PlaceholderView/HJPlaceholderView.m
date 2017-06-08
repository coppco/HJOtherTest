//
//  HJPlaceholderView.m
//  HJPlaceholderView
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJPlaceholderView.h"

NSString *const HJPlaceholderStatusNoDataText = @"亲, 暂无数据哦~";
NSString *const HJPlaceholderStatusNoNetworkText = @"亲, 你的网络视乎断开了~";
NSString *const HJPlaceholderStatusServerErrorText = @"亲, 服务器升级中, 请稍后再试";


@interface HJPlaceholderView ()
/*图片*/
@property(nonatomic, strong)UIImageView *imageV;
/*描述*/
@property(nonatomic, strong)UILabel *descriptL;
/*视图*/
@property(nonatomic, strong)UIView *containerView;
/*按钮*/
@property(nonatomic, strong)UIButton *clickB;

/*描述文本字典*/
@property(nonatomic, strong)NSMutableDictionary *stateDescribes;
/*图片字典*/
@property(nonatomic, strong)NSMutableDictionary *stateImages;
/*按钮点击事件*/
@property(nonatomic, strong)NSMutableDictionary *stateOperations;
@end

@implementation HJPlaceholderView
+ (HJPlaceholderView *)placeholderViewForView:(UIView *)superView {
    HJPlaceholderView *placeView = [[HJPlaceholderView alloc] initWithFrame:CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height)];
    placeView.containerView = superView;
    return placeView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        self.status = HJPlaceholderStatusNormal;
        [self addSubview:self.imageV];
        [self addSubview:self.descriptL];
        [self addSubview:self.clickB];
        [self.clickB addTarget:self action:@selector(didClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}
- (void)didClick:(UIButton *)sender {
    placeholderOperation code = self.stateOperations[@(self.status)];
    if (code) {
        code();
    }
}
- (void)prepare {
    self.backgroundColor = [UIColor grayColor];
    [self setDescribe:HJPlaceholderStatusNoDataText status:HJPlaceholderStatusNoData];
    [self setDescribe:HJPlaceholderStatusNoNetworkText status:HJPlaceholderStatusNoNetwork];
    [self setDescribe:HJPlaceholderStatusServerErrorText status:HJPlaceholderStatusServerError];
    
    
}

- (void)setDescribe:(NSString *)describe status:(HJPlaceholderStatus)status {
    if (describe == nil) {
        return;
    }
    self.stateDescribes[@(status)] = describe;
    self.descriptL.text = self.stateDescribes[@(self.status)];
}

- (void)setImage:(NSString *)imageName status:(HJPlaceholderStatus)status {
    if (imageName == nil) {
        return;
    }
    self.stateImages[@(status)] = imageName;
}

- (void)setOperationBlock:(placeholderOperation)block status:(HJPlaceholderStatus)status {
    if (block == nil) {
        return;
    }
    self.stateOperations[@(status)] = [block copy];
}

- (void)show {
    [self.containerView addSubview:self];
    self.hidden = false;
}

- (void)hide {
    [self removeFromSuperview];
    self.hidden = true;
}

#pragma - mark setter
- (void)setStatus:(HJPlaceholderStatus)status {
    if (_status == status) {
        return;
    }
    _status = status;
    if (_status == HJPlaceholderStatusNormal) {
        //正常状态下隐藏
        [self hide];
    } else {
        if (!self.superview) {
            [self show];
        }
        self.imageV.image = [UIImage imageNamed:self.stateImages[@(self.status)]];
        self.descriptL.text = self.stateDescribes[@(self.status)];
        
        [self.imageV sizeToFit];
        self.imageV.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 0.35);
    
        [self.descriptL sizeToFit];
        self.descriptL.center = CGPointMake(self.frame.size.width / 2, self.imageV.frame.origin.y + self.imageV.frame.size.height + 20);
        
        self.clickB.bounds = CGRectMake(0, 0, 80, 30);
        self.clickB.center = CGPointMake(self.frame.size.width / 2, self.descriptL.frame.origin.y + self.descriptL.frame.size.height + 30);
    }
}

#pragma - mark getter
- (NSMutableDictionary *)stateDescribes {
    if (!_stateDescribes) {
        _stateDescribes = ({
            NSMutableDictionary *object = [NSMutableDictionary dictionary];
            object;
        });
    }
    return _stateDescribes;
}
- (NSMutableDictionary *)stateImages {
    if (!_stateImages) {
        _stateImages = ({
            NSMutableDictionary *object = [NSMutableDictionary dictionary];
            object;
        });
    }
    return _stateImages;
}

- (NSMutableDictionary *)stateOperations {
    if (!_stateOperations) {
        _stateOperations = ({
            NSMutableDictionary *object = [NSMutableDictionary dictionary];
            object;
        });
    }
    return _stateOperations;
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

- (UILabel *)descriptL {
    if (!_descriptL) {
        _descriptL = ({
            UILabel *object = [[UILabel alloc] init];
            object.numberOfLines = 0;
            object.textAlignment = NSTextAlignmentCenter;
//            object.textColor = [UIColor colorFromRGBValue:0x666666];
//            object.font = kPingFangLightFont(16);
            object;
        });
    }
    return _descriptL;
}
- (UIButton *)clickB {
    if (!_clickB) {
        _clickB = ({
            UIButton *object = [UIButton buttonWithType:(UIButtonTypeCustom)];
            object.backgroundColor = [UIColor redColor];
            object;
        });
    }
    return _clickB;
}
@end
