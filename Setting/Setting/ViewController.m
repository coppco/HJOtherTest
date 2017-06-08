//
//  ViewController.m
//  Setting
//
//  Created by apple on 2017/5/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>

@interface ViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation ViewController
- (IBAction)phone:(UIButton *)sender {
    NSString *title = sender.currentTitle;
    
    NSString *urlString = @"";
    
    if ([title isEqualToString:@"打电话"]) {
        // 直接拨打电话
        //NSString *url=[NSString stringWithFormat:@"tel://%@",phoneNumber];
        // 会提示用户是否拨打电话
        //NSString *url=[NSString stringWithFormat:@"telprompt://%@",phoneNumber];
//        urlString = @"tel://15105713500";
         urlString = @"telprompt://15105713500";
    } else if([title isEqualToString:@"发短信"]) {
        urlString = @"sms://15105713500";
    } else if([title isEqualToString:@"发邮件"]) {
        urlString = @"mailto://120903100@qq.com";
    } else if([title isEqualToString:@"上网"]) {
        urlString = @"https://www.baidu.com";
    } else if([title isEqualToString:@"设置"]) {
        urlString = UIApplicationOpenSettingsURLString;
    } else if([title isEqualToString:@"更新"]) {
        urlString = @"https://itunes.apple.com/cn/app/id333206289?mt=8";
    } else if([title isEqualToString:@"评论"]) {
        urlString = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=333206289&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8";;
    } else if([title isEqualToString:@"内部评论"]) {
        [self evaluate];
        return;
    } else if([title isEqualToString:@"QQ"]) {
        urlString = @"mqq://im/chat?chat_type=wpa&uin=120903100&version=1&src_type=web";
//        urlString = @"weixin:";
    } else {
        return;
    }
//    MFMessageComposeViewController
//    MFMailComposeViewController
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
    }
    
}

- (void)evaluate{
    
    //初始化控制器
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:  @{SKStoreProductParameterITunesItemIdentifier : @"333206289"} completionBlock:^(BOOL result, NSError *error) {
      if(!error) {
      }
  }];
    //模态弹出AppStore应用界面
    [self presentViewController:storeProductViewContorller animated:true completion:nil];
}
//https://itunes.apple.com/cn/app/xcode/id497799835
-(void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
