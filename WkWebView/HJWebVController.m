//
//  HJWebVController.m
//  DevoutCat
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//  网络连接控制器

#import "HJWebVController.h"
#import "HJLoadingProgressView.h"
#import "RechargeWithdrawController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UMMobClick/MobClick.h>
#import <IQKeyboardManager.h>
#import "HJShareSheetController.h"
#import <WXApi.h>
#import "ShareVo.h"
#import "HJTabBarController.h"
#import "HotDetailVController.h"
#import "ActivityCenterController.h"
#import "HotListVo.h"
#import "HJMyRewardController.h"
#import "RedEnvelopeController.h"
#import <WebKit/WebKit.h>
#import "HJWeakScriptMessageDelegate.h"

@interface HJWebVController ()<UIWebViewDelegate, UIActionSheetDelegate, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
/*webView*/
@property(nonatomic, strong)UIWebView *webView;
/**
 wkWebView iOS8以后使用
 */
@property(nonatomic, strong)WKWebView *wkWebView;
/*进度条*/
@property(nonatomic, strong)HJLoadingProgressView *progressView;
/*返回按钮*/
@property(nonatomic, strong)UIButton *backB;
/*返回文本*/
@property(nonatomic, copy)NSString *resultDesc;
/*sheet*/
@property(nonatomic, strong)UIActionSheet *sheet;
/*分享页面*/
@property(nonatomic, strong)HJShareSheetController *shareSheetVC;
/*分享数据*/
@property(nonatomic, strong)ShareVo *shareData;
@property(nonatomic, strong)UIBarButtonItem *editB;
@end

@implementation HJWebVController

- (UIBarButtonItem *)editB {
    if (!_editB) {
        _editB = ({
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [button setTitle:@"分享" forState:(UIControlStateNormal)];
            [button setTitle:@"分享" forState:(UIControlStateSelected)];
            button.titleLabel.font = kPingFangLightFont(15);
            [button addTarget:self action:@selector(changed:) forControlEvents:(UIControlEventTouchUpInside)];
            [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
             [button setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
            [button sizeToFit];
            UIBarButtonItem *object = [[UIBarButtonItem  alloc] initWithCustomView:button];
            object;
        });
    }
    return _editB;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (__iOS_8_0) {
        [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"webViewHandles"];
        self.wkWebView = nil;
    } else {
        self.webView = nil;
    }
    XHJLog(@"%@释放了", self.class);
}
- (void)changed:(UIButton *)button {
    [self.sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //微信好友
        [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatSession)];
    } else if (buttonIndex == 1) {
        //微信朋友圈
        [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatTimeLine)];
    } else if (buttonIndex == 2) {
        //取消
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:) name:kLoginSuccessKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLogin:) name:kLogoutSuccessKey object:nil];
    
        if ([self.urlString containsString:@"BonusRainOrders/BonusRanking"] && [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
//    if ([self.urlString containsString:@"BonusRainOrders/BonusRanking"]) {
        //请求数据
        @weakify(self);
        [[HJHttpManager sharedInstance] requestObjectWithURL:kShareRankLink class:[ShareReturnVo class] type:(RequestTypePost) paramObject:nil paramDictionary:@{@"investorId": @(appDelegate.isLogin ? appDelegate.userInfo.InvestorId : 0)} progress:nil success:^(NSObject *object) {
            @strongify(self);
            ShareReturnVo *data = (ShareReturnVo *)object;
            if ([data.RespCode isEqualToString:@"000"] && data.RespData.ImageLink.length > 0 && data.RespData.UrlLink.length > 0 && data.RespData.Title.length > 0 && data.RespData.Summary.length > 0) {
                self.shareData = data.RespData;
                self.navigationItem.rightBarButtonItem = self.editB;
            }
        } failure:^(NSError *error) {
        }];
    }
    if (__iOS_8_0) {
        [self.view addSubview:self.wkWebView];
    } else {
        [self.view addSubview:self.webView];
    }
    [self.view addSubview:self.progressView];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:nil font: nil titleNormalColor:nil titleHighlightedColor:nil normalImage:@"back_normal" highlightedImage:@"back_press" target:self action:@selector(back:) edg:(UIEdgeInsetsMake(0, 0, 0, 0))];
    
    UIBarButtonItem *bu = self.navigationItem.leftBarButtonItem;
    NSMutableArray *arrays = [NSMutableArray array];
    if (bu != nil) {
        [arrays addObject:bu];
    }
    [arrays addObject:[[UIBarButtonItem alloc] initWithCustomView:self.backB]];
    self.navigationItem.leftBarButtonItems = arrays;
    
    @weakify(self);
    [[self.backB rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        @strongify(self);
        if (!(self.navigationController.viewControllers.count > 1)) {
            [self dismissViewControllerAnimated:true completion:nil];
            return;
        }
        
        if (self.isBackToMain) {
            [self.navigationController popToRootViewControllerAnimated:true];
        }   else {
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
    
    if (__iOS_8_0) {
        [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafe_Area_bottom);
        }];
        
        RAC(self.progressView, progress) = [RACSignal combineLatest:@[RACObserve(self, wkWebView.estimatedProgress)] reduce:^id (NSNumber *progress){
            return progress;
        }];
        
    } else {
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kSafe_Area_bottom);
        }];
    }
    [self loadWebView];
}
- (void)back:(UIButton *)button {
    if (!(self.navigationController.viewControllers.count > 1)) {
        //model进来的
        if (__iOS_8_0) {
            if ([self.wkWebView canGoBack]) {
                [self.wkWebView goBack];
            } else {
                [self dismissViewControllerAnimated:true completion:nil];
            }
        } else {
            if ([self.webView canGoBack]) {
                [self.webView goBack];
            } else {
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }
        return;
    }
    if (__iOS_8_0) {
        if ([self.wkWebView canGoBack]) {
            [self.wkWebView goBack];
        } else {
            if (self.isBackToMain) {
                [self.navigationController popToRootViewControllerAnimated:true];
            }   else {
                [self.navigationController popViewControllerAnimated:true];
            }
        }
    } else {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        } else {
            if (self.isBackToMain) {
                [self.navigationController popToRootViewControllerAnimated:true];
            }   else {
                [self.navigationController popViewControllerAnimated:true];
            }
        }
    }
}

- (void)loadWebView {
    if ([self.urlString hasPrefix:@"http"]) {
        if (self.body.count != 0) {
            if ([self.body.allKeys containsObject:@"InvestorId"] || [self.body.allKeys containsObject:@"investorId"]) {
                self.body[@"investorId"] = @(appDelegate.userInfo.InvestorId);
            }
            self.body[@"SourceType"] = @"iOS";
            self.body[@"AppVersion"] = kAppVersion;
            //加密
            if ([self.body.allKeys containsObject:@"CheckValue"] || [self.body.allKeys containsObject:@"checkValue"]) {
                NSString *userID = kStringFormat(@"%ld",appDelegate.userInfo.InvestorId);
                if (!userID) {
                    userID = @"0";
                }
                NSString *requestTime = [HJHttpManager getRequestTime];
                if ([self.urlString containsString:HTTP]) {
                    NSString *value = [[[kStringFormat(@"/%@/%@/%@/%@", [self.urlString componentsSeparatedByString:HTTP].lastObject, userID, requestTime, appDelegate.userInfo.TokenId) uppercaseString].md5String substringWithRange:NSMakeRange(3, 20)] uppercaseString];
                    self.body[@"CheckValue"] = value;
                    self.body[@"RequestTime"] = requestTime;
                } else if ([self.urlString containsString:GAME]) {
                    NSString *value = [[[kStringFormat(@"/%@/%@/%@/%@", [self.urlString componentsSeparatedByString:GAME].lastObject, userID, requestTime, appDelegate.userInfo.TokenId) uppercaseString].md5String substringWithRange:NSMakeRange(3, 20)] uppercaseString];
                    self.body[@"CheckValue"] = value;
                    self.body[@"RequestTime"] = requestTime;
                }else if ([self.urlString containsString:WINXIN]) {
                    NSString *value = [[[kStringFormat(@"/%@/%@/%@/%@", [self.urlString componentsSeparatedByString:WINXIN].lastObject, userID, requestTime, appDelegate.userInfo.TokenId) uppercaseString].md5String substringWithRange:NSMakeRange(3, 20)] uppercaseString];
                    self.body[@"CheckValue"] = value;
                    self.body[@"RequestTime"] = requestTime;
                } else {
                    NSString *pattern = @"http[s]?://[a-zA-Z0-9\\-.:]*/";
                    NSError *error = nil;
                    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:(NSRegularExpressionCaseInsensitive) error:&error];
                    if (error == nil) {
                        NSRange range = [regex rangeOfFirstMatchInString:self.urlString options:(0) range:NSMakeRange(0, self.urlString.length)];
                        if (range.location != NSNotFound) {
                            //找到了
                            NSString *headerString = [self.urlString substringWithRange:range];
                            NSString *value = [[[kStringFormat(@"/%@/%@/%@/%@", [self.urlString componentsSeparatedByString:headerString].lastObject, userID, requestTime, appDelegate.userInfo.TokenId) uppercaseString].md5String substringWithRange:NSMakeRange(3, 20)] uppercaseString];
                            self.body[@"CheckValue"] = value;
                            self.body[@"RequestTime"] = requestTime;
                        }
                    }
                }
            }
            
            //post
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
            [request setHTTPMethod:@"POST"];
            NSMutableString *params = [[NSMutableString alloc] init];
            NSArray *array = self.body.allKeys;
            for (int i = 0; i < array.count; i++) {
                if (i == 0) {
                    [params appendString:kStringFormat(@"%@=%@", array[i], self.body[array[i]])];
                } else {
                    [params appendString:kStringFormat(@"&%@=%@", array[i], self.body[array[i]])];
                }
            }
            XHJLog(@"POST: ====%@?%@", self.urlString, params);
            [request setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
            if (__iOS_8_0) {
                [self.wkWebView loadRequest:request];
            } else {
                [self.webView loadRequest:request];
            }
            [self showLoadingHudWithMessage:kLoadingText];
        } else {
            XHJLog(@"GET: ====%@", self.urlString);
            if (__iOS_8_0) {
                [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
            } else {
                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
            }
            [self showLoadingHudWithMessage:kLoadingText];
        }
    } else {
        XHJLog(@"本地: ====%@", self.urlString);
        if (__iOS_8_0) {
            NSString *html = [[NSString alloc] initWithContentsOfFile:self.urlString encoding:NSUTF8StringEncoding error:nil];
            [self.wkWebView loadHTMLString:html baseURL:nil];
        } else {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
        }
        [self showLoadingHudWithMessage:kLoadingText];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        if (self.isViewLoaded && !self.view.window) {
            self.view = nil;
        }
    }
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = ({
            UIWebView *object = [[UIWebView alloc] init];
            object.scalesPageToFit = true;
            object.delegate = self;
            object.scrollView.bounces = false;
            object;
        });
    }
    return _webView;
}
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = ({
            WKWebView *object = [[WKWebView alloc] init];
            object.UIDelegate = self;
            object.navigationDelegate = self;
            
            [object.configuration.userContentController addScriptMessageHandler:[[HJWeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"webViewHandles"];
            object;
        });
    }
    return _wkWebView;
}
- (HJLoadingProgressView *)progressView {
    if (!_progressView) {
        _progressView = ({
            HJLoadingProgressView *object = [[HJLoadingProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
            object;
        });
    }
    return _progressView;
}

- (UIButton *)backB {
    if (!_backB) {
        _backB = ({
            UIButton *object = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [object setTitle:NSLocalizedString(@"关闭", nil) forState:(UIControlStateNormal)];
            [object setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            object.size = CGSizeMake(45, 32);
            
            object.hidden = true;
            object;
        });
    }
    return _backB;
}
- (UIActionSheet *)sheet {
    if (!_sheet) {
        _sheet = ({
            UIActionSheet *object = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"发送给微信好友", @"分享到微信朋友圈", nil];
            object;
        });
    }
    return _sheet;
}

- (HJShareSheetController *)shareSheetVC {
    if (!_shareSheetVC) {
        _shareSheetVC = ({
            HJShareSheetController *object = [[HJShareSheetController alloc] init];
            object;
        });
    }
    return _shareSheetVC;
}

#pragma - mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return  true;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    XHJLog(@"加载出错%@", error);
    [self hideAllHud];
     [self.progressView endLoadingAnimation];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressView startLoadingAnimation];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressView endLoadingAnimation];
    self.backB.hidden = !webView.canGoBack;
    [self hideAllHud];
    
    if ([self.urlString containsString:kEntrance]) {
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        NSString *textJS = @"document.title";
        self.navigationItem.title = [context evaluateScript:textJS].toString;
        @weakify(self);
        context[@"toInvestVC"] = ^() {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self);
                    [self.navigationController popToRootViewControllerAnimated:false];
                    UIViewController *tab = appDelegate.window.rootViewController;
                    if ([tab isKindOfClass:[UITabBarController class]]) {
                        UITabBarController *tabBarVC = (UITabBarController *)tab;
                        tabBarVC.selectedIndex = 1;
                    }
                });
            });
            
        };
        
        context[@"alert"] = ^(id name) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:kStringFormat(@"%@", name) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            });
        };
        
        NSString *btnClick = @"document.getElementById('investRedirect').onclick = toInvestVC";
        
        [context evaluateScript:btnClick];
    }
    
    [self addPublicMethod];
    
    if (!(self.navigationItem.title.length > 0)) {
        JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        NSString *textJS = @"document.title";
        self.navigationItem.title = [context evaluateScript:textJS].toString;
    }
}

#pragma - mark WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self hideAllHud];
    [self.progressView endLoadingAnimation];
    self.backB.hidden = !webView.canGoBack;
    
    if (!(self.navigationItem.title.length > 0)) {
        self.navigationItem.title = webView.title;
    }
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    [self hideAllHud];
    [self.progressView endLoadingAnimation];
    [self show_Error:kNetworkError delay:2];
}
#pragma - mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"JS 调用了 %@ 方法，传回参数 %@",message.name,message.body);
}
#pragma - mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandle {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:kStringFormat(@"%@", message) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    });
    completionHandle();
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (navigationAction.targetFrame != nil) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


- (void)addPublicMethod {
    @weakify(self);
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //使用原生弹框
    context[@"alert"] = ^(id name) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:kStringFormat(@"%@", name) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        });
    };
    
    //调用原生方法
    context[@"toNativePage"] = ^(NSString *pageName, NSString *bidId) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            //去首页
            if ([[pageName lowercaseString] isEqualToString:@"home"]) {
                [self gotoHomePage];
                return ;
            }
            //投资列表页面
            if ([[pageName lowercaseString] isEqualToString:@"investlist"]) {
                [self gotoInvestPage];
                return ;
            }
            
            //标的详情页面
            if ([[pageName lowercaseString] isEqualToString:@"invest"]) {
                [self gotoBidDetailPage: bidId];
                return ;
            }
            
            //登录
            if ([[pageName lowercaseString] isEqualToString:@"login"]) {
                [self gotoLogin];
                return ;
            }
            
            //注册
            if ([[pageName lowercaseString] isEqualToString:@"regest"]) {
                [self gotoRegest];
                return ;
            }
            
            //我的奖励
            if ([[pageName lowercaseString] isEqualToString:@"reward"]) {
                [self gotoReward:bidId];
                return ;
            }
            
            //活动中心
            if ([[pageName lowercaseString] isEqualToString:@"activity"]) {
                [self gotoActivity];
                return ;
            }
            
            //红包雨页面
            if ([[pageName lowercaseString] isEqualToString:@"redrain"]) {
                [self gotoRedRain];
                return ;
            }
        });
    };
    
    //分享方法
    context[@"shareMsg"] = ^(NSString *url, NSString *title, NSString *desc, NSString *imageUrl, NSString *type) {
        @strongify(self);
        if ([[type lowercaseString] isEqualToString:@"wechatsession"]) {
            self.shareData = [[ShareVo alloc] initWithUrlLink:url imageLink:imageUrl title:title summary:desc];
            [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatSession)];
            return ;
        } else if ([[type lowercaseString] isEqualToString:@"wechattimeline"]) {
            self.shareData = [[ShareVo alloc] initWithUrlLink:url imageLink:imageUrl title:title summary:desc];
            [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatTimeLine)];
            return ;
        }else if ([[type lowercaseString] isEqualToString:@"qq"]) {
            self.shareData = [[ShareVo alloc] initWithUrlLink:url imageLink:imageUrl title:title summary:desc];
            [self shareWebPageToPlatformType:(UMSocialPlatformType_QQ)];
            return ;
        }else if ([[type lowercaseString] isEqualToString:@"sina"]) {
            self.shareData = [[ShareVo alloc] initWithUrlLink:url imageLink:imageUrl title:title summary:desc];
            [self shareWebPageToPlatformType:(UMSocialPlatformType_Sina)];
            return ;
        }
        if (url.length == 0 || title.length == 0 || desc.length == 0 || imageUrl.length == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"参数为空, 无法分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            HJShareSheetController *sheetVC = [HJShareSheetController new];
            ShareVo *shareData = [ShareVo new];
            shareData.UrlLink = url;
            shareData.ImageLink = imageUrl;
            shareData.Title = title;
            shareData.Summary = desc;
            sheetVC.shareData = shareData;
            sheetVC.showAnimation = true;
            sheetVC.definesPresentationContext = true;
            sheetVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            appDelegate.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:sheetVC animated:false completion:^{
                sheetVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
            }];
            appDelegate.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;            
        });
    };
    
    //获取投资人id
    context[@"getInvestorId"] = ^NSString* () {
        return kStringFormat(@"%ld", appDelegate.userInfo.InvestorId);
    };
    
}
- (void)gotoHomePage {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *tab = appDelegate.window.rootViewController;
            if ([tab isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tabBarVC = (UITabBarController *)tab;
                
                if (tabBarVC.selectedIndex != 0) {
                    tabBarVC.selectedIndex = 0;
                } else {
                    [((UINavigationController *)tabBarVC.selectedViewController) popToRootViewControllerAnimated:true];
                }
            }
        });
    });
}
- (void)gotoInvestPage {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *tab = appDelegate.window.rootViewController;
            if ([tab isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tabBarVC = (UITabBarController *)tab;
                tabBarVC.selectedIndex = 1;
            }
            
            [self.navigationController popViewControllerAnimated:true];
        });
    });
}
- (void)gotoBidDetailPage:(NSString *)bidId {
    if (bidId.length == 0 || bidId == nil) {
        [self gotoInvestPage];
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *tab = appDelegate.window.rootViewController;
            if ([tab isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tabBarVC = (UITabBarController *)tab;
                tabBarVC.selectedIndex = 1;
                HotDetailVController *hotDetailVC = [[HotDetailVController alloc] init];
                HotListItem *item = [[HotListItem alloc] init];
                item.ID = bidId.integerValue;
                hotDetailVC.item = item;
                [((UINavigationController *)tabBarVC.selectedViewController) pushViewController:hotDetailVC animated:false];
            }
            [self.navigationController popViewControllerAnimated:true];
        });
    });
}
- (void)gotoLogin {
    if (appDelegate.isLogin) {
        [HJPromptView showImage:nil message:@"您已经登录过了!" top:true];
        return;
    }
    [self presentViewController:[[HJNavigationController alloc] initWithRootViewController:[[HJNewLoginController alloc] init]] animated:true completion:nil];
}
- (void)gotoRegest {
    if (appDelegate.isLogin) {
        [HJPromptView showImage:nil message:@"您已经登录过了!" top:true];
        return;
    }
    HJNewLoginController *regest = [[HJNewLoginController alloc] init];
    regest.isRegest = true;
    [self presentViewController:[[HJNavigationController alloc] initWithRootViewController:regest] animated:true completion:nil];
}
- (void)gotoReward:(NSString *)bidId {
    if (!appDelegate.isLogin) {
        [self gotoLogin];
        return;
    }
    
    if (bidId.length == 0 || bidId == nil || [bidId isEqualToString:@"undefined"]) {
        [self.navigationController pushViewController:[HJMyRewardController new] animated:true];
    } else {
        //01 现金券 02 投资红包，03加息券
        NSInteger index = 0;
        if ([bidId isEqualToString:@"01"]) {
            index = 0;
        }else if ([bidId isEqualToString:@"02"]) {
            index = 2;
        } else if ([bidId isEqualToString:@"03"]) {
            index = 1;
        }
        HJMyRewardController *rewardVC = [HJMyRewardController new];
        rewardVC.index = index;
        [self.navigationController pushViewController:rewardVC animated:true];
    }
}
- (void)gotoActivity {
    [self.navigationController pushViewController:[ActivityCenterController new] animated:true];
}
- (void)gotoRedRain {
    RedEnvelopeController * redEVC = [[RedEnvelopeController alloc] init];
    redEVC.title = @"疯狂抢红包";
    [self.navigationController pushViewController:redEVC animated:true];
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    NSString *title = @"分享翻倍";
    NSString *desc = kStringFormat(@"红包雨开始抢啦！我今天在虔诚猫金服红包雨中超越了%d%%的朋友，快来跟我一起抢红包！", (arc4random() % 10) + 90);
    id shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AppIcon60x60@2x" ofType:@"png"]];
    NSString *urlString = kStringFormat(@"%@Account/UserShareBonusRegister?rank=96&inviter=%ld&from=timeline&isappinstalled=1&winzoom=1", GAME,appDelegate.userInfo.InvestorId);
    
    if (self.shareData != nil) {
        title = self.shareData.Title;
        desc = self.shareData.Summary;
        urlString = self.shareData.UrlLink;
        shareImage = self.shareData.ImageLink;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (platformType == UMSocialPlatformType_Sina) {
        messageObject.text = kStringFormat(@"%@%@%@", title, desc, urlString);
        UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:desc thumImage:shareImage];
        shareObject.shareImage = shareImage;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    } else if (platformType == UMSocialPlatformType_QQ || platformType == UMSocialPlatformType_WechatSession) {
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:shareImage];
        //设置网页地址
        shareObject.webpageUrl = urlString;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    } else {
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:desc descr:desc thumImage:shareImage];
        //设置网页地址
        shareObject.webpageUrl = urlString;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    //调用分享接口
    @weakify(self);
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        @strongify(self);
        if (error) {
            [HJPromptView showImage:nil message:@"分享失败" top:true];
        }else{
            [HJPromptView showImage:nil message:@"分享成功" top:true];
            if ([self.urlString containsString:@"BonusRain/PlayIndex"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //翻倍
                    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
                    NSString *textJS = @"shareDouble()";
                    [context evaluateScript:textJS];
                    
                    //分享成功隐藏弹窗
                    NSString *textJS2 = @"hide_div()";
                    [context evaluateScript:textJS2];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:true];
                    });
                });
            }
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
    [[IQKeyboardManager sharedManager] setEnable:false];
#ifndef DEBUG
    if (self.eventID.length > 0) {
        [MobClick beginEvent:self.eventID];
    }
#endif    
}
//登录通知
- (void)didLogin:(NSNotification *)notification {
    [self loadWebView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:true];
#ifndef DEBUG
    if (self.eventID.length > 0) {
        [MobClick endEvent:self.eventID];
    }
#endif
}
@end
