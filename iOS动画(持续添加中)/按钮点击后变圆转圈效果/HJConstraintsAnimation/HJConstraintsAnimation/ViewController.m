//
//  ViewController.m
//  HJConstraintsAnimation
//
//  Created by coco on 16/6/23.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "HJAnimationButton.h"

@interface ViewController ()
/**账号*/
@property (nonatomic, strong)UITextField *accountTF;
/**密码*/
@property (nonatomic, strong)UITextField *passwordTF;
/**登录*/
@property (nonatomic, strong)HJAnimationButton *loginB;
/**右侧按钮位置*/
@property (nonatomic, strong)UIButton *rightBarButton;

/**登录按钮的动画*/
@property (nonatomic, strong)CAKeyframeAnimation *loginInAnimation;
/**注销按钮的动画*/
@property (nonatomic, strong)CAKeyframeAnimation *loginOutAnimation;
@end

@implementation ViewController



#pragma mark - 懒加载
- (UITextField *)accountTF {
    if (!_accountTF) {
        _accountTF = [[UITextField alloc] init];
        _accountTF.layer.borderColor = [UIColor blackColor].CGColor;
        _accountTF.layer.borderWidth = 1;
        _accountTF.layer.cornerRadius = 4;
        _accountTF.borderStyle = UITextBorderStyleRoundedRect;
        _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountTF.placeholder = @"请输入账号";
    }
    return _accountTF;
}
- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.layer.borderColor = [UIColor blackColor].CGColor;
        _passwordTF.layer.borderWidth = 1;
        _passwordTF.layer.cornerRadius = 4;
        _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.secureTextEntry = YES;
    }
    return _passwordTF;
}
- (HJAnimationButton *)loginB {
    if (!_loginB) {
        _loginB = [HJAnimationButton buttonWithType:(UIButtonTypeCustom)];
        _loginB.backgroundColor = [UIColor colorWithRed:15 / 256.0 green:197/ 256.0 blue:99/ 256.0 alpha:1];
        [_loginB setTitle:@"登录" forState:(UIControlStateNormal)];
        _loginB.layer.cornerRadius = 5;
        [_loginB addTarget:self action:@selector(loginB:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _loginB;
}
- (UIButton *)rightBarButton {
    if (!_rightBarButton) {
        _rightBarButton = ({
            UIButton *object = [UIButton buttonWithType:(UIButtonTypeCustom)];
            object.frame = CGRectMake(0, 0, 30, 30);
            object.backgroundColor = [UIColor colorWithRed:15 / 256.0 green:197/ 256.0 blue:99/ 256.0 alpha:1];
            [object setTitle:@"注销" forState:(UIControlStateNormal)];
            object.titleLabel.font = [UIFont systemFontOfSize:13];
            [object addTarget:self action:@selector(loginOut) forControlEvents:(UIControlEventTouchUpInside)];
            object.layer.cornerRadius = 15;
            object.hidden = YES;
            object;
        });
    }
    return _rightBarButton;
}
- (CAKeyframeAnimation *)loginOutAnimation {
    if (!_loginOutAnimation) {
        _loginOutAnimation = ({
            CAKeyframeAnimation *object = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            object.duration = 0.4;
            object.delegate = self;
            UIBezierPath *bezier = [UIBezierPath bezierPath];
            [bezier moveToPoint:self.rightBarButton.center];
//            [bezier addQuadCurveToPoint:self.loginB.center controlPoint:CGPointMake(300, 300)];
            [bezier addCurveToPoint:self.loginB.center controlPoint1:CGPointMake(120, 240) controlPoint2:CGPointMake(26, 800)];
            object.path = bezier.CGPath;
            object.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            object.removedOnCompletion = NO;
            object.fillMode = kCAFillModeForwards;  //不会返回
            object;
        });
    }
    return _loginOutAnimation;
}
- (CAKeyframeAnimation *)loginInAnimation {
    if (!_loginInAnimation) {
        _loginInAnimation = ({
            CAKeyframeAnimation *object = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            object.duration = 0.4;
            object.delegate = self;
            UIBezierPath *bezier = [UIBezierPath bezierPath];
            [bezier moveToPoint:self.loginB.center];
            [bezier addQuadCurveToPoint:self.rightBarButton.center controlPoint:CGPointMake(300, 300)];
            object.path = bezier.CGPath;
            object.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //
            object.removedOnCompletion = NO;
//            object.fillMode = kCAFillModeForwards;  //不会返回
            object;
        });
    }
    return _loginInAnimation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self configSubview];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarButton];
}
- (void)configSubview {
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginB];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY);
        make.left.equalTo(@80);
        make.right.equalTo(@-80);
        make.height.mas_equalTo(30);
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.passwordTF);
        make.leading.trailing.equalTo(self.passwordTF);
        make.bottom.mas_equalTo(self.passwordTF.mas_top).offset(-20);
    }];
    
    [self.loginB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.equalTo(self.view.mas_centerY).offset(20);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    
}
//登录方法
- (void)loginB:(UIButton *)button {
    button.selected = !button.selected;
    button.selected ? [self loginButtonWillBeginSmall] : [self loginButtonWillBeginBig];
}

//按钮变小动画
- (void)loginButtonWillBeginSmall {
    [self.loginB start];
    [self.loginB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_centerY).offset(20);
    }];
    
    [UIView animateWithDuration:.15f animations:^{
        [self.view layoutIfNeeded];
        self.loginB.layer.cornerRadius = 20;
    } completion:^(BOOL finished) {
    }];
    
    //动画实现一个点,移动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loginIn];
        });
    });
}
//注销
- (void)loginOut {
    self.loginB.hidden = NO;
    self.rightBarButton.hidden = YES;
    [self.loginB.layer addAnimation:self.loginOutAnimation forKey:@"move222"];
}
- (void)loginIn {
    self.loginB.hidden = YES;
    self.rightBarButton.hidden = NO;
    [self.rightBarButton.layer addAnimation:self.loginInAnimation forKey:@"move111"];

}

/**
 *  这里登录和注销动画经历过3次变动:
     第一次、登录后,  使用登录按钮做动画,  注销以后使用注销按钮做动画, 然后在动画完成的animationDidStopd:代理方法中,判断  两个按钮的hidden     弊端:  在动画完成后做动画的按钮会显示一下再消失
 
    第二次、登录后使用注销按钮做动画,  直接隐藏登录按钮,  注销后使用登录按钮做动画,隐藏注销按钮    弊端: 在注销动画时,登录按钮会被导航栏遮挡
    第三次、都是用注销按钮来做动画,  原因: 注销按钮在导航栏上面,不会出现遮挡的问题,  但是还是会出现第一次的问题,
 
 */
#pragma mark - animationDelegate
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    if ([self.loginB.layer animationForKey:@"move111"] == anim) {
//        self.rightBarButton.hidden = NO;
//        self.loginB.hidden = YES;
//    } else if ([self.rightBarButton.layer animationForKey:@"move222"] == anim){
//        self.rightBarButton.hidden = YES;
//        self.loginB.hidden = NO;
//        [self.loginB stop];
//        [self loginButtonWillBeginBig];
//    }
//}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([self.loginB.layer animationForKey:@"move222"] == anim) {
        [self loginButtonWillBeginBig]; //应该在loginOutAnimation完成之后
        self.loginB.selected = NO;
    }
}
- (void)loginButtonWillBeginBig {
    [self.loginB stop];
    [self.loginB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.equalTo(self.view.mas_centerY).offset(20);
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
    }];
    
    [UIView animateWithDuration:.15f animations:^{
        [self.view layoutIfNeeded];
        self.loginB.layer.cornerRadius = 5;
    }];
}
@end
