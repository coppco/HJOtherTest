//
//  HJShareController.m
//  DevoutCat
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJShareController.h"
#import "HJShareButton.h"
#import "UIViewController+KNSemiModal.h"
#import "HJShareSheetController.h"
#import "UIView+HJExtension.h"
#import <Masonry.h>
#import "UIColor+HJExtension.h"

//适合使用次数多, 有缓存
#define kImage(imageName) ([UIImage imageNamed:(imageName)])
#define __isIPHONE_4 ((CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 1.0))
#define __isIPHONE_4S ((CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 480))) && ([UIScreen mainScreen].scale == 2.0))
#define __isIPHONE_5 CGSizeEqualToSize(kMainScreenSize, CGSizeMake(320, 568))
#define __isIPHONE_6 CGSizeEqualToSize(kMainScreenSize, CGSizeMake(375, 667))
#define __isIPHONE_6P CGSizeEqualToSize(kMainScreenSize, CGSizeMake(414, 736))


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

@interface HJShareController ()
/*背景图*/
@property(nonatomic, strong)UIImageView *backgroundImageV;
/*滤镜*/
@property(nonatomic, strong)CIFilter *filter;
/*标题*/
@property(nonatomic, strong)UILabel *titleL;
/*二维码*/
@property(nonatomic, strong)UIImageView *QRcodeImageV;
/*头像*/
@property(nonatomic, strong)UIImageView *logoImageV;
/*说明*/
@property(nonatomic, strong)UILabel *snapL;

/*分享数组*/
@property(nonatomic, strong)NSMutableArray *shareA;

/*图片字典*/
@property(nonatomic, strong)NSDictionary *imageDic;

/*底部图片*/
@property(nonatomic, strong)UIImageView *bottomImageV;

/*是否显示了*/
@property(nonatomic, assign)BOOL isShowSheet;


@end

@implementation HJShareController
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = true;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(semiModalDismissed:)
                                                 name:kSemiModalDidHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = false;
}
- (void)didScreenshot:(NSNotification *)notification {
    if (self.isShowSheet) {
        return;
    }
    self.bottomImageV.hidden = false;
    UIImage *image = [self.backgroundImageV hj_snapshotsWithType:(HJViewSnapshotsTypeNone)];
    self.bottomImageV.hidden = true;
    self.view.userInteractionEnabled = false;
    self.isShowSheet = true;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HJShareSheetController *sheetVC = [HJShareSheetController new];
        sheetVC.image = image;
        sheetVC.view.frame = CGRectMake(0, kMainScreenHeight - 184, kMainScreenWidth, 184);
        self.navigationController.navigationBar.alpha = 0;
        self.bottomImageV.hidden = false;
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[HJShareButton class]]) {
                HJShareButton *button = (HJShareButton *)view;
                button.hidden = true;
            }
        }
        [self.navigationController presentSemiViewController:sheetVC withOptions:@{
                                                                                   KNSemiModalOptionKeys.pushParentBack    : @(YES),
                                                                                   KNSemiModalOptionKeys.animationDuration : @(0.5),
                                                                                   KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                                   KNSemiModalOptionKeys.parentAlpha     : @(1),
                                                                                   KNSemiModalOptionKeys.disableCancel : @(NO)
                                                                                   }];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setQRImage {
    [self.filter setDefaults];
    [self.filter setValue:[@"https://www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding] forKeyPath:@"InputMessage"];
    self.QRcodeImageV.image = [self createNonInterpolatedUIImageFormCIImage:self.filter.outputImage size:kScale_image_height(180)];
    self.logoImageV.hidden = false;
}

//生成高清二维码方法
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
{
    CGRect extentRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    //return [UIImage imageWithCGImage:scaledImage]; // 黑白图片
    UIImage *newImage = [UIImage imageWithCGImage:scaledImage];
    //    return [self imageBlackToTransparent:newImage withRed:200.0f andGreen:70.0f andBlue:189.0f];
    return newImage;
}
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"分享邀请";
    [self.view addSubview:self.backgroundImageV];
    [self.backgroundImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.backgroundImageV addSubview:self.titleL];
    [self.backgroundImageV addSubview:self.QRcodeImageV];
    [self.backgroundImageV addSubview:self.snapL];
    [self.QRcodeImageV addSubview:self.logoImageV];
    [self.backgroundImageV addSubview:self.bottomImageV];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kScale_view_heightWithNavi(184));
        make.left.mas_equalTo(kScale_view_heightWithNavi(193 / 2));
        make.right.mas_equalTo(-kScale_view_heightWithNavi(197 / 2));
    }];
    
    [self.QRcodeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleL.mas_bottom).offset(kScale_view_heightWithNavi(8));
        make.centerX.mas_equalTo(self.backgroundImageV);
        make.size.mas_equalTo(CGSizeMake(kScale_view_heightWithNavi(180), kScale_view_heightWithNavi(180)));
    }];
    
    [self.snapL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleL);
        make.top.mas_equalTo(self.QRcodeImageV.mas_bottom).offset(kScale_view_heightWithNavi(8));
    }];
    
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.QRcodeImageV);
        make.size.mas_equalTo(CGSizeMake(kScale_image_height(32), kScale_image_height(32)));
    }];
    
    [self.bottomImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backgroundImageV);
        make.bottom.mas_equalTo(self.backgroundImageV.mas_bottom).offset(-31);
    }];
    
    NSInteger count = self.shareA.count;
    CGFloat paddingH = (kMainScreenWidth - 3 * 56) / 4;
    for (int i = 0; i < self.shareA.count; i++) {
        HJShareButton *button = [HJShareButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:self.shareA[i] forState:(UIControlStateNormal)];
        [button setImage:kImage(self.imageDic[self.shareA[i]]) forState:(UIControlStateNormal)];
        button.titleLabel.font = kPingFangLightFont(12);
        [button setTitleColor:[UIColor colorFromRGBValue:0x666666] forState:(UIControlStateNormal)];
        [self.view addSubview:button];
        CGFloat y = count <= 3 ? (kMainScreenHeight - 20 - 62) : (i > 2 ? (kMainScreenHeight - 20 - 62) : (kMainScreenHeight - 20 - 62 - 16.5 - 62));
        button.frame = CGRectMake(paddingH + (paddingH + 56) * (i % 3), y, 56, 62);
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
//            if ([self.shareA[i] isEqualToString:@"短信分享"]) {
//                [self shareWebPageToPlatformType:(UMSocialPlatformType_Sms)];
//                return ;
//            }
//        }];
    }
    
    [self setQRImage];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //模拟截屏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationUserDidTakeScreenshotNotification object:nil];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma - mark getter

- (UIImageView *)backgroundImageV {
    if (!_backgroundImageV) {
        _backgroundImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            if (__isIPHONE_5) {
                object.image = kImage(@"share_background_320");
            } else {
                object.image = kImage(@"share_background");
            }
            object;
        });
    }
    return _backgroundImageV;
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
            [object addObject:@"短信分享"];
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
                                    @"share_email", @"短信分享",
                                    @"share_qq", @"QQ好友",
                                    @"share_wechat", @"微信好友",
                                    @"share_weibo", @"新浪微博", nil];
            object;
        });
    }
    return _imageDic;
}
- (CIFilter *)filter {
    if (!_filter) {
        _filter =
        _filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        
        // 2.还原滤镜默认属性
        [_filter setDefaults];
        
        // 3.设置需要生成二维码的数据到滤镜中
        // OC中要求设置的是一个二进制数据
        //        NSData *data = [@"http://www.jianshu.com/p/05949cc8f7af" dataUsingEncoding:NSUTF8StringEncoding];
        //        [_filter setValue:data forKeyPath:@"InputMessage"];
        
        // 4.从滤镜从取出生成好的二维码图片
        //        CIImage *ciImage = [filter outputImage];
    }
    return _filter;
}

- (UIImageView *)QRcodeImageV {
    if (!_QRcodeImageV) {
        _QRcodeImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object;
        });
    }
    return _QRcodeImageV;
}

- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = ({
            UIImageView *object = [[UIImageView alloc] initWithImage:kImage(@"share_logo")];
            object.hidden = true;
            object;
        });
    }
    return _logoImageV;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = ({
            UILabel *object = [[UILabel alloc] init];
            object.font = kPingFangRegularFont(16);
            object.textColor = [UIColor colorFromRGBValue:0x666666];
            object.text = @"邀请好友扫一扫\n下载APP, 领红包!";
            object.textAlignment = NSTextAlignmentCenter;
            object.numberOfLines = 0;
            object;
        });
    }
    return _titleL;
}

- (UILabel *)snapL {
    if (!_snapL) {
        _snapL = ({
            UILabel *object = [[UILabel alloc] init];
            object.font = kPingFangLightFont(12);
            object.textColor = [UIColor colorFromRGBValue:0x666666];
            object.text = @"(截屏也可以分享哦)";
            object.textAlignment = NSTextAlignmentCenter;
            object;
        });
    }
    return _snapL;
}
- (UIImageView *)bottomImageV {
    if (!_bottomImageV) {
        _bottomImageV = ({
            UIImageView *object = [[UIImageView alloc] initWithImage:kImage(@"share_qianchengmao")];
            object.hidden = true;
            object;
        });
    }
    return _bottomImageV;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.bottomImageV.hidden = false;
//    [self.backgroundImageV hj_snapshotsWithType:(HJViewSnapshotsTypePhotes)];
//    self.bottomImageV.hidden = true;
//}

//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
//    
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    if (platformType == UMSocialPlatformType_Sina) {
//        messageObject.text = kStringFormat(@"%@%@%@", self.shareData.Title, self.shareData.Summary, self.shareData.UrlLink);
//        UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:self.shareData.Title descr:self.shareData.Summary thumImage:self.shareData.ImageLink];
//        shareObject.shareImage = self.shareData.ImageLink;
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject;
//    } else if (platformType == UMSocialPlatformType_Sms) {
//        //创建网页内容对象
//        UMShareSmsObject *shareObject = [[UMShareSmsObject alloc] init];
//        //设置网页地址
//        shareObject.smsContent = kStringFormat(@"%@%@%@", self.shareData.Title, self.shareData.Summary, self.shareData.UrlLink);
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject;
//    } else {
//        //创建网页内容对象
//        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareData.Title descr:self.shareData.Summary thumImage:self.shareData.ImageLink];
//        //设置网页地址
//        shareObject.webpageUrl = self.shareData.UrlLink;
//        
//        //分享消息对象设置分享内容对象
//        messageObject.shareObject = shareObject;
//    }
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
//        } else {
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

- (void)semiModalDismissed:(NSNotification *) notification {
    self.bottomImageV.hidden = true;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[HJShareButton class]]) {

            HJShareButton *button = (HJShareButton *)view;
            button.hidden = false;
        }
    }
    self.navigationController.navigationBar.alpha = 1;
    self.isShowSheet = false;
    self.view.userInteractionEnabled = true;
}
@end
