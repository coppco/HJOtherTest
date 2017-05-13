//
//  HJShareSheetController.m
//  DevoutCat
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJShareSheetController.h"

#import "HJShareButton.h"
#import "UIViewController+KNSemiModal.h"
#import <Masonry.h>
#import "UIColor+HJExtension.h"
//适合使用次数多, 有缓存
#define kImage(imageName) ([UIImage imageNamed:(imageName)])
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


#define kPingFangLightFont(value) [UIFont fontWithName:(__iOS_9_0 ? @"PingFangSC-Light" : @"STHeitiSC-Light") size:(value)]
#define kPingFangMediumFont(value) [UIFont fontWithName:(__iOS_9_0 ? @"PingFangSC-Medium" : @"STHeitiSC-Medium") size:(value)]
#define kPingFangRegularFont(value) [UIFont fontWithName:(__iOS_9_0 ? @"PingFangSC-Regular" : @"STHeitiSC-Light") size:(value)]
#define fontWeight(x,y) [UIFont systemFontOfSize:x weight:y]

//获取主窗口的bounds
#define kMainScreenBounds ([UIScreen mainScreen].bounds)
//获取主窗口的bounds
#define kMainScreenSize ([UIScreen mainScreen].bounds.size)
//获取主窗口的高度
#define kMainScreenHeight ([UIScreen mainScreen].bounds.size.height)
//获取主窗口的宽度
#define kMainScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define kScale_view_heightWithNavi(value) ((([UIScreen mainScreen].bounds.size.height)) / (667.0) * (value))

//图片等比缩放
#define kScale_image_height(value) (([UIScreen mainScreen].bounds.size.width) / 375.0 * (value))

@interface HJShareSheetController ()
/*取消按钮*/
@property(nonatomic, strong)UIButton *cancelB;
/*类型视图*/
@property(nonatomic, strong)UIView *topView;
/*分享数组*/
@property(nonatomic, strong)NSMutableArray *shareA;

/*图片字典*/
@property(nonatomic, strong)NSDictionary *imageDic;

@end

@implementation HJShareSheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.cancelB];
    [self.view addSubview:self.topView];
    NSMutableArray *array = [NSMutableArray array];
    
    CGFloat paddingH = (kMainScreenWidth - 4 * 56 - 32) / 5;
    for (int i = 0; i < self.shareA.count; i++) {
        HJShareButton *button = [HJShareButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:self.shareA[i] forState:(UIControlStateNormal)];
        [button setImage:kImage(self.imageDic[self.shareA[i]]) forState:(UIControlStateNormal)];
        button.titleLabel.font = kPingFangLightFont(12);
        [button setTitleColor:[UIColor colorFromRGBValue:0x666666] forState:(UIControlStateNormal)];
        [self.topView addSubview:button];
        [array addObject:button];
        
        
        CGFloat y = (20);
        button.frame = CGRectMake(paddingH + (paddingH + 56) * (i % 4), y, 56, (62));
//        @weakify(self);
//        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
//            @strongify(self);
//            if ([self.shareA[i] isEqualToString:@"微信好友"]) {
//                [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatSession)];
//                return ;
//            }
//            if ([self.shareA[i] isEqualToString:@"朋友圈"]) {
//                [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatTimeLine)];
//                return ;
//            }
//            if ([self.shareA[i] isEqualToString:@"QQ好友"]) {
//                [self shareWebPageToPlatformType:(UMSocialPlatformType_QQ)];
//                return ;
//            }
//            if ([self.shareA[i] isEqualToString:@"新浪微博"]) {
//                [self shareWebPageToPlatformType:(UMSocialPlatformType_Sina)];
//                return ;
//            }
//        }];
        
    }
    
    [self.cancelB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-16);
        make.left.mas_equalTo(self.view.mas_left).offset(16);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(48);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.cancelB);
        make.height.mas_equalTo((102));
        make.bottom.mas_equalTo(self.cancelB.mas_top).offset(-8);
    }];
    
    //    if (array.count > 0) {
    //        [array mas_distributeViewsAlongAxis:(MASAxisTypeHorizontal) withFixedItemLength:56 leadSpacing:(kMainScreenWidth - 32 - 56 * array.count) / (array.count + 1) tailSpacing:(kMainScreenWidth - 32 - 56 * array.count) / (array.count + 1)];
    //        [array mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.width.mas_equalTo(50);
    //            make.top.mas_equalTo(self.topView.mas_top).offset(20);
    //            make.bottom.mas_equalTo(self.topView.mas_bottom).offset(-20);
    //        }];
    //    }
    
//    @weakify(self);
//    [[self.cancelB rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
//        @strongify(self);
//        UIViewController * parent = [self.view containingViewController];
//        if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
//            [parent dismissSemiModalView];
//        }
//    }];
    
    
}

- (UIView *)topView {
    if (!_topView) {
        _topView = ({
            UIView *object = [[UIView alloc] init];
            object.backgroundColor = [UIColor whiteColor];
            object.layer.cornerRadius = 5;
            object;
        });
    }
    return _topView;
}

- (UIButton *)cancelB {
    if (!_cancelB) {
        _cancelB = ({
            UIButton *object = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [object setTitle:@"取消" forState:(UIControlStateNormal)];
            [object setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            object.backgroundColor = [UIColor whiteColor];
            object.layer.cornerRadius = 5;
            object;
        });
    }
    return _cancelB;
}
- (NSMutableArray *)shareA {
    if (!_shareA) {
        _shareA = ({
            NSMutableArray *object = [[NSMutableArray alloc] init];
//            if ([WXApi isWXAppSupportApi] && [WXApi isWXAppInstalled]) {//添加的微信
                [object addObject:@"微信好友"];
                [object addObject:@"朋友圈"];
//            }
//            if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
                [object addObject:@"QQ好友"];
//            }
            [object addObject:@"新浪微博"];
            object;
        });
    }
    return _shareA;
}

- (NSDictionary *)imageDic {
    if (!_imageDic) {
        _imageDic = ({
            NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"share_ circle", @"朋友圈",
                                    @"share_qq", @"QQ好友",
                                    @"share_wechat", @"微信好友",
                                    @"share_weibo", @"新浪微博", nil];
            object;
        });
    }
    return _imageDic;
}
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//    shareObject.shareImage = self.image;
//    shareObject.title = @"赚钱这种好事一定要分享给你哦~";
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            XHJLog(@"%@", error);
//            NSString *message = @"分享失败";
//            if (platformType == UMSocialPlatformType_QQ) {
//                message = @"分享QQ失败";
//            } else if (platformType == UMSocialPlatformType_WechatSession) {
//                message = @"分享微信失败";
//            } else if (platformType == UMSocialPlatformType_WechatTimeLine) {
//                message = @"分享朋友圈失败";
//            } else if (platformType == UMSocialPlatformType_Sina) {
//                message = @"分享新浪微博失败";
//            } else if (platformType == UMSocialPlatformType_Sms) {
//                message = @"分享短信失败";
//            }
//            [HJPromptView showImage:nil message:message top:true];
//        }else{
//            XHJLog(@"%@", data);
//            NSString *message = @"分享成功";
//            if (platformType == UMSocialPlatformType_QQ) {
//                message = @"分享QQ成功";
//            } else if (platformType == UMSocialPlatformType_WechatSession) {
//                message = @"分享微信成功";
//            } else if (platformType == UMSocialPlatformType_WechatTimeLine) {
//                message = @"分享朋友圈成功";
//            } else if (platformType == UMSocialPlatformType_Sina) {
//                message = @"分享新浪微博成功";
//            } else if (platformType == UMSocialPlatformType_Sms) {
//                message = @"分享短信成功";
//            }
//            [HJPromptView showImage:nil message:message top:true];
//        }
//    }];
//}

@end
