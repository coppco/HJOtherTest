//
//  AddAccountController.m
//  Podinns
//
//  Created by apple on 2017/3/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddAccountController.h"
#import "UITextField+HJExtension.h"

@interface AddAccountController ()
/*背景图*/
@property(nonatomic, strong)UIImageView * backgroundImageV;
/*输入框背景图*/
@property(nonatomic, strong)UIImageView * inputBackgroundImageV;
/*用户名输入框*/
@property(nonatomic, strong)UITextField * userNameTF;
/*密码输入框*/
@property(nonatomic, strong)UITextField * passwordTF;
/*时间背景图*/
@property(nonatomic, strong)UIImageView * timegroundImageV;
/*上次签到输入框*/
@property(nonatomic, strong)UITextField * lastSignTimeTF;
/*上次抽奖时间输入框*/
@property(nonatomic, strong)UITextField * lastLotteryTimeTF;
/*是否商旅卡*/
@property(nonatomic, strong)UISwitch * isTravel;
/*是否商旅卡*/
@property(nonatomic, strong)UILabel * isTravelL;
/*添加按钮*/
@property(nonatomic, strong)UIButton * addB;
@end

@implementation AddAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup {
    self.navigationItem.title = self.account == nil ? @"新增账号" : @"修改账户";
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    [self addAction];
}

- (void)buildUI {
    [self.view addSubview:self.backgroundImageV];
    
    [self.backgroundImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.view addSubview:self.inputBackgroundImageV];
    [self.inputBackgroundImageV addSubview:self.userNameTF];
    [self.inputBackgroundImageV addSubview:self.passwordTF];

    
    [self.inputBackgroundImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(50);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(100);
    }];
    
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
        make.size.mas_equalTo(self.passwordTF);
        make.bottom.mas_equalTo(self.passwordTF.mas_top);
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
        make.bottom.mas_equalTo(self.inputBackgroundImageV.mas_bottom);
    }];
    
    if (self.account != nil) {
        [self.view addSubview:self.timegroundImageV];
        [self.timegroundImageV addSubview:self.lastSignTimeTF];
        [self.timegroundImageV addSubview:self.lastLotteryTimeTF];
        
        [self.timegroundImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.left.centerX.mas_equalTo(self.inputBackgroundImageV);
            make.top.mas_equalTo(self.inputBackgroundImageV.mas_bottom).offset(10);
        }];
        [self.lastSignTimeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
            make.size.mas_equalTo(self.lastLotteryTimeTF);
            make.bottom.mas_equalTo(self.lastLotteryTimeTF.mas_top);
        }];
        
        [self.lastLotteryTimeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
            make.bottom.mas_equalTo(self.timegroundImageV.mas_bottom);
        }];

        
        [self.view addSubview:self.isTravel];
        [self.view addSubview:self.isTravelL];
        [self.view addSubview:self.addB];
        
        [self.isTravel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timegroundImageV.mas_bottom).offset(20);
            make.right.mas_equalTo(self.timegroundImageV).offset(-20);
        }];
        
        [self.isTravelL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.isTravel);
            make.centerX.mas_equalTo(self.timegroundImageV);
        }];
        
        [self.addB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.timegroundImageV);
            make.left.right.mas_equalTo(UIEdgeInsetsMake(0, 40, 0, 40));
            make.top.mas_equalTo(self.isTravel.mas_bottom).offset(20);
            make.height.mas_equalTo(33);
        }];
        
        self.userNameTF.text = self.account.userName;
        self.passwordTF.text = self.account.password;
        self.isTravel.on = self.account.IsTravel;
        [self.addB setTitle:@"修改" forState:(UIControlStateNormal)];
    } else {
        [self.view addSubview:self.isTravel];
        [self.view addSubview:self.isTravelL];
        [self.view addSubview:self.addB];
        
        [self.isTravel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.inputBackgroundImageV.mas_bottom).offset(20);
            make.right.mas_equalTo(self.inputBackgroundImageV).offset(-20);
        }];
        
        [self.isTravelL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.isTravel);
            make.centerX.mas_equalTo(self.inputBackgroundImageV);
        }];
        
        [self.addB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.inputBackgroundImageV);
            make.left.right.mas_equalTo(UIEdgeInsetsMake(0, 40, 0, 40));
            make.top.mas_equalTo(self.isTravel.mas_bottom).offset(20);
            make.height.mas_equalTo(33);
        }];
    }
    
    
    if (self.account != nil) {
        self.userNameTF.text = self.account.userName;
        self.passwordTF.text = self.account.password;
        self.lastSignTimeTF.text = self.account.last_signDate;
        self.lastLotteryTimeTF.text = self.account.last_lotteryDate;
        self.isTravel.on = self.account.IsTravel;
        [self.addB setTitle:@"修改" forState:(UIControlStateNormal)];
    }
}

- (void)addAction {
    __weak __typeof__(self) weakSelf = self;
    [[self.passwordTF rac_signalForControlEvents:(UIControlEventEditingDidBegin)] subscribeNext:^(id x) {
//        weakSelf.passwordTF.placeHolderColor = [UIColor whiteColor];
    }];
    [[self.userNameTF rac_signalForControlEvents:(UIControlEventEditingDidBegin)] subscribeNext:^(id x) {
//        weakSelf.userNameTF.placeHolderColor = [UIColor whiteColor];
    }];
    [[self.passwordTF rac_signalForControlEvents:(UIControlEventEditingDidEnd)] subscribeNext:^(id x) {
        weakSelf.passwordTF.placeHolderColor = [UIColor grayColor];
    }];
    [[self.userNameTF rac_signalForControlEvents:(UIControlEventEditingDidEnd)] subscribeNext:^(id x) {
        weakSelf.userNameTF.placeHolderColor = [UIColor grayColor];
    }];
    
    [[self.addB rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(UIButton *x) {
         [weakSelf.view endEditing:true];
        if (weakSelf.account != nil) {
            weakSelf.account.userName = self.userNameTF.text;
            weakSelf.account.password = self.passwordTF.text;
            weakSelf.account.last_signDate = self.lastSignTimeTF.text;
            weakSelf.account.last_lotteryDate = self.lastLotteryTimeTF.text;
            weakSelf.account.IsTravel = self.isTravel.on ? 1 : 0;
            [FMDBHandle updateAccountWith:weakSelf.account];
            
            [weakSelf show_Success:@"修改账户成功" delay:1.5];
            [weakSelf performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
            return ;
        }
        if ([FMDBHandle isExistsForUserName:weakSelf.userNameTF.text]) {
            [weakSelf show_Error:[NSString stringWithFormat:@"已经添加过%@, 不能重复添加!", weakSelf.userNameTF.text] delay:1.5];
        } else {
            [FMDBHandle addAccountWithUserName:weakSelf.userNameTF.text password:weakSelf.passwordTF.text IsTravel:weakSelf.isTravel.on ? 1 : 0];
            [weakSelf show_Success:[NSString stringWithFormat:@"添加%@成功", weakSelf.userNameTF.text] delay:2];
            weakSelf.userNameTF.text = nil;
            weakSelf.passwordTF.text = nil;
            weakSelf.isTravel.on = false;
        }
       
    }];
    
    //值绑定
    RAC(self.addB, enabled) = [RACSignal combineLatest:@[self.userNameTF.rac_textSignal, self.passwordTF.rac_textSignal] reduce:^id (NSString *name, NSString *password){
        return @(name.length == 11 && password.length >= 6);
    }];
}
- (void)dismiss {
    [self.navigationController popViewControllerAnimated:true];
}
#pragma - mark 懒加载
- (UIImageView *)backgroundImageV {
    if (!_backgroundImageV) {
        _backgroundImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.image = [UIImage imageNamed:@"login_register_background"];
            object;
        });
    }
    return _backgroundImageV;
}
- (UIImageView *)inputBackgroundImageV {
    if (!_inputBackgroundImageV) {
        _inputBackgroundImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.userInteractionEnabled = true;
            object.image = [UIImage imageNamed:@"login_rgister_textfield_bg"];
            object;
        });
    }
    return _inputBackgroundImageV;
}
- (UIImageView *)timegroundImageV {
    if (!_timegroundImageV) {
        _timegroundImageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.userInteractionEnabled = true;
            object.image = [UIImage imageNamed:@"login_rgister_textfield_bg"];
            object;
        });
    }
    return _timegroundImageV;
}

- (UITextField *)userNameTF {
    if (!_userNameTF) {
        _userNameTF = ({
            UITextField *object = [[UITextField alloc] init];
            object.placeholder = @"请输入用户名";
            object.textColor = [UIColor whiteColor];
            object.borderStyle = UITextBorderStyleNone;
            object.tintColor = [UIColor whiteColor]; //光标颜色
            object.clearButtonMode = UITextFieldViewModeWhileEditing;
            object.adjustsFontSizeToFitWidth = true;
            object.minimumFontSize = 13;
//            object.keyboardType = UIKeyboardTypePhonePad;
            object.keyboardType = UIKeyboardTypeNumberPad;
            object.returnKeyType = UIReturnKeyNext;
            object.placeHolderColor = [UIColor grayColor];
            object;
        });
    }
    return _userNameTF;
}
- (UITextField *)lastSignTimeTF {
    if (!_lastSignTimeTF) {
        _lastSignTimeTF = ({
            UITextField *object = [[UITextField alloc] init];
            object.placeholder = @"请输入上次签到时间";
            object.textColor = [UIColor whiteColor];
            object.borderStyle = UITextBorderStyleNone;
            object.tintColor = [UIColor whiteColor]; //光标颜色
            object.clearButtonMode = UITextFieldViewModeWhileEditing;
            object.adjustsFontSizeToFitWidth = true;
            object.minimumFontSize = 13;
            object.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            object.returnKeyType = UIReturnKeyNext;
            object.placeHolderColor = [UIColor grayColor];
            object.inputView = [self addToolBar];
            object;
        });
    }
    return _lastSignTimeTF;
}

- (UITextField *)lastLotteryTimeTF {
    if (!_lastLotteryTimeTF) {
        _lastLotteryTimeTF = ({
            UITextField *object = [[UITextField alloc] init];
            object.placeholder = @"请输入上次抽奖时间";
            object.textColor = [UIColor whiteColor];
            object.borderStyle = UITextBorderStyleNone;
            object.tintColor = [UIColor whiteColor]; //光标颜色
            object.clearButtonMode = UITextFieldViewModeWhileEditing;
            object.adjustsFontSizeToFitWidth = true;
            object.minimumFontSize = 13;
            object.keyboardType = UIKeyboardTypeDefault;
            object.returnKeyType = UIKeyboardTypeNumbersAndPunctuation;
            object.placeHolderColor = [UIColor grayColor];
            object.inputView = [self addToolBar];
            object;
        });
    }
    return _lastLotteryTimeTF;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = ({
            UITextField *object = [[UITextField alloc] init];
            object.placeholder = @"请输入密码";
            object.textColor = [UIColor whiteColor];
            object.borderStyle = UITextBorderStyleNone;
            object.tintColor = [UIColor whiteColor]; //光标颜色
            object.clearButtonMode = UITextFieldViewModeWhileEditing;
            object.adjustsFontSizeToFitWidth = true;
            object.minimumFontSize = 13;
            object.keyboardType = UIKeyboardTypeDefault;
            object.returnKeyType = UIReturnKeyDone;
//            object.secureTextEntry = true;
            object.placeHolderColor = [UIColor grayColor];
            object;
        });
    }
    return _passwordTF;
}
- (UISwitch *)isTravel {
    if (!_isTravel) {
        _isTravel = ({
            UISwitch *object = [[UISwitch alloc] init];
            object;
        });
    }
    return _isTravel;
}
- (UILabel *)isTravelL {
    if (!_isTravelL) {
        _isTravelL = ({
            UILabel *object = [[UILabel alloc] init];
            object.text = @"商旅卡";
            object.font = [UIFont systemFontOfSize:15];
            object.textColor = [UIColor whiteColor];
            object;
        });
    }
    return _isTravelL;
}
- (UIButton *)addB {
    if (!_addB) {
        _addB = ({
            UIButton *object = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [object setTitle:@"添加" forState:(UIControlStateNormal)];
            object.titleLabel.font = [UIFont systemFontOfSize:15];
            [object setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [object setBackgroundImage:[UIImage imageNamed:@"login_register_button"] forState:(UIControlStateNormal)];
             [object setBackgroundImage:[UIImage imageNamed:@"login_register_button_click"] forState:(UIControlStateHighlighted)];
            object.layer.cornerRadius = 5;
            object.layer.masksToBounds = true;
            object;
        });
    }
    return _addB;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *delete = [UIPreviewAction actionWithTitle:@"删除" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [FMDBHandle deleteAccountWith:self.account.userName];
        if (self.didDelete) {
            self.didDelete(self.account);
        }
    }];
    UIPreviewAction *copy = [UIPreviewAction actionWithTitle:@"复制" style:(UIPreviewActionStyleDefault) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [FMDBHandle deleteAccountWith:self.account.userName];
        
    }];

    return @[copy, delete];
}

- (void)yesterday:(UIButton *)button {
    if (self.lastSignTimeTF.isFirstResponder) {
        self.lastSignTimeTF.text = [[[NSDate date] dateByAddDay:-1] stringWithFormatter:SQLDataFormatter];
    }
    if (self.lastLotteryTimeTF.isFirstResponder) {
        self.lastLotteryTimeTF.text = [[[NSDate date] dateByAddDay:-1] stringWithFormatter:SQLDataFormatter];
    }
}
- (void)today:(UIButton *)button {
    if (self.lastSignTimeTF.isFirstResponder) {
        self.lastSignTimeTF.text = [[NSDate date] stringWithFormatter:SQLDataFormatter];
    }
    if (self.lastLotteryTimeTF.isFirstResponder) {
        self.lastLotteryTimeTF.text = [[NSDate date] stringWithFormatter:SQLDataFormatter];
    }

}

- (void)tomorrow:(UIButton *)button {
    if (self.lastSignTimeTF.isFirstResponder) {
        self.lastSignTimeTF.text = [[[NSDate date] dateByAddDay:1] stringWithFormatter:SQLDataFormatter];
    }
    if (self.lastLotteryTimeTF.isFirstResponder) {
        self.lastLotteryTimeTF.text = [[[NSDate date] dateByAddDay:1] stringWithFormatter:SQLDataFormatter];
    }

}

- (UIToolbar *)addToolBar {
    //工具栏
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(2, 5, 50, 25);
    [btn1 setTitle:@"昨天" forState:(UIControlStateNormal)];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn1 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(yesterday:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(2, 5, 50, 25);
    [btn2 setTitle:@"今天" forState:(UIControlStateNormal)];
    btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn2 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(today:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(2, 5, 50, 25);
    [btn3 setTitle:@"明天" forState:(UIControlStateNormal)];
    btn3.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn3 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn3 addTarget:self action:@selector(tomorrow:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem * btnSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * btnSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    toolBar.items = @[[[UIBarButtonItem alloc]initWithCustomView:btn1], btnSpace1, [[UIBarButtonItem alloc]initWithCustomView:btn2], btnSpace2, [[UIBarButtonItem alloc]initWithCustomView:btn3]];
    return toolBar;
}
@end
