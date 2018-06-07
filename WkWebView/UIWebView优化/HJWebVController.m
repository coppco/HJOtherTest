//
//  HJWebVController.m
//  DevoutCat
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//  网络连接控制器

#import "HJWebVController.h"
#import "HJLoadingProgressView.h"
#import "LoginVo.h"
#import "HJInvestResultController.h"
#import "RechargeWithdrawController.h"
#import <WebKit/WebKit.h>

@interface HJWebVController ()<UIWebViewDelegate, WKUIDelegate, WKNavigationDelegate>
/*webView*/
@property(nonatomic, strong)UIWebView *webView;

/*wkWebView*/
@property(nonatomic, strong)WKWebView *wkWebView;
/*是否需要加载js*/
@property(nonatomic, assign)BOOL needLoadJSPost;
/*进度条*/
@property(nonatomic, strong)HJLoadingProgressView *progressView;
/*返回按钮*/
@property(nonatomic, strong)UIButton *backB;

///*账户输入框*/
//@property(nonatomic, strong)UITextField *accountTF;
///*密码输入框*/
//@property(nonatomic, strong)UITextField *passwordTF;

//@property (nonatomic, strong) NavigationInteractiveTransition *navT;

//@property (nonatomic,strong) UIPanGestureRecognizer *popRecognizer;

@end

@implementation HJWebVController

- (void)dealloc {
    self.webView = nil;
    XHJLog(@"%@释放了", self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (__iOS_8_0) {
        [self.view addSubview:self.wkWebView];
    } else {
        [self.view addSubview:self.webView];
    }
    
    [self.view addSubview:self.progressView];
    
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
        if (__iOS_8_0) {
            if ([self.wkWebView canGoBack]) {
                [self.wkWebView goBack];
            }
        } else {
            if ([self.webView canGoBack]) {
                [self.webView goBack];
            }
        }
    }];
    
    if (__iOS_8_0) {
        [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    } else {
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    
    
    if (self.urlString) {
        if (self.body.count != 0) {
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
            [request setHTTPBody: [params dataUsingEncoding: NSUTF8StringEncoding]];
            if (__iOS_8_0) {
//                [self.wkWebView loadRequest:request]; //这里有BUG, POST请求无法传递参数
                self.needLoadJSPost = true;
                // 获取JS所在的路径
                NSString *path = [[NSBundle mainBundle] pathForResource:@"JSPost" ofType:@"html"];
                // 获得html内容
                NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                [self.wkWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
            } else {
                [self.webView loadRequest:request];
            }
        } else {
            //get
            if (__iOS_8_0) {
                 [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
            } else {
                [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
            }
        }
    }
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    
//    UIGestureRecognizer *gesture = self.navigationController.interactivePopGestureRecognizer;
//    gesture.enabled = NO;
//    UIView *gestureView = gesture.view;
//    
//    _popRecognizer = [[UIPanGestureRecognizer alloc] init];
//    _popRecognizer.delegate = self;
//    _popRecognizer.maximumNumberOfTouches = 1;
//    [gestureView addGestureRecognizer:_popRecognizer];
//    
//    _navT = [[NavigationInteractiveTransition alloc] initWithViewController:self.navigationController];
//    [_popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];

}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    //记录当前是是否是通过手势滑动回去
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"isGesturePop"];
//    /**
//     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
//     */
//    return self.navigationController.viewControllers.count != 1 && ![[self.navigationController valueForKey:@"_isTransitioning"] boolValue];
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = ({
            UIWebView *object = [[UIWebView alloc] init];
            object.scalesPageToFit = true;
            object.delegate = self;
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
            [object setTitle:@"返回" forState:(UIControlStateNormal)];
            [object setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            object.size = CGSizeMake(50, 32);
            object.hidden = true;
            object;
        });
    }
    return _backB;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.progressView startLoadingAnimation];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressView endLoadingAnimation];
    self.backB.hidden = !webView.canGoBack;
}

#pragma - mark 导航栏
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    _popRecognizer.delegate = self;
////    [self.navigationController setNavigationBarHidden:false animated:animated];
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    _popRecognizer.delegate = nil;
//}
#pragma mark -- UIWebView代理方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return [self judgeWithURLString:request.URL.absoluteString];
}

- (BOOL)judgeWithURLString:(NSString *)url {
    XHJLog(@"%@===========-----------", url);
    if ([url containsString:@"RespCode="]) {
        [self dealWithURLString:url];
        return false;
    }
    return true;
}

- (void)dealWithURLString:(NSString *)url {
    //投资
    if ([self.urlString containsString:kInvestSubmitURL]) {
        HJInvestResultController *investResultVC = [[HJInvestResultController alloc] init];
        investResultVC.urlString = url;
        [self.navigationController pushViewController:investResultVC animated:true];
        return;
    }
    
    //这里需要判断汇付的具体接口再做处理
    if ([url containsString:@"RespCode=000"]) {
        if ([url containsString:@"RechargeComplete"]) {
                RechargeWithdrawController *rechargeSucc = [[RechargeWithdrawController alloc]init];
                rechargeSucc.type = RechargeSussess;
                rechargeSucc.title = @"充值成功";
            
                [self.navigationController pushViewController:rechargeSucc animated:YES];
            
        }else if ([url containsString:@"WithdrawComplete"]){
            RechargeWithdrawController *withdrawSucc = [[RechargeWithdrawController alloc]init];
            withdrawSucc.type = WithdrawSussess;
            withdrawSucc.title = @"提现成功";
            [self.navigationController pushViewController:withdrawSucc animated:YES];
        }else {
            
            [HJPromptView showImage:nil message:@"成功" top:true];
            //实名认证成功
            appDelegate.userInfo.IsAuth = 1;
            UIViewController *vc = [[UIViewController alloc]init];
            vc.view.backgroundColor = [UIColor redColor];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
#warning iOS 8
        if ([url containsString:@"RechargeComplete"]) {
            
            RechargeWithdrawController *rechargeFail = [[RechargeWithdrawController alloc]init];
            rechargeFail.type = RechargeFail;
            rechargeFail.title = @"充值失败";
            [self.navigationController pushViewController:rechargeFail animated:YES];
        }else if ([url containsString:@"WithdrawComplete"]) {
            RechargeWithdrawController *withdrawFail = [[RechargeWithdrawController alloc]init];
            withdrawFail.type = WithdrawFail;
            withdrawFail.title = @"提现失败";
            [self.navigationController pushViewController:withdrawFail animated:YES];
        }
        
         [HJPromptView showImage:nil message:@"失败" top:true];
        //失败
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    XHJLog(@"加载出错%@", error);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}


#pragma mark -- WKWebView代理方法
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self.progressView startLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (self.needLoadJSPost) {
        [self postRequestWithJS];
        self.needLoadJSPost = false;
    }
    [self.progressView endLoadingAnimation];
    self.backB.hidden = !webView.canGoBack;
}
// 调用JS发送POST请求
- (void)postRequestWithJS {
    NSMutableString *params = [[NSMutableString alloc] init];
    NSArray *array = self.body.allKeys;
    for (int i = 0; i < array.count; i++) {
        if (i == 0) {
            [params appendString:kStringFormat(@"\"%@\":\"%@\"", array[i], self.body[array[i]])];
        } else {
            [params appendString:kStringFormat(@",\"%@\":\"%@\"", array[i], self.body[array[i]])];
        }
    }
    // 发送POST的参数
//    NSString *postData = @"\"username\":\"aaa\",\"password\":\"123\"";
    // 请求的页面地址
    XHJLog(@"%@", params);
    NSString *urlStr = self.urlString;
    // 拼装成调用JavaScript的字符串
    NSString *jscript = [NSString stringWithFormat:@"post('%@', {%@});", urlStr, params];
    
    // NSLog(@"Javascript: %@", jscript);
    // 调用JS代码
    [self.wkWebView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
        
    }];
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    NSString *url = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if ([url containsString:@"RespCode="]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [self dealWithURLString:url];
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    XHJLog(@"%@", error);
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    XHJLog(@"%@", error);
}

@end
