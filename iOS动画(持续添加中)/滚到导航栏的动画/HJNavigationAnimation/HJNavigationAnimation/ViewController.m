//
//  ViewController.m
//  HJNavigationAnimation
//
//  Created by coco on 16/6/23.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJDDD.h"
@interface ViewController ()
/**<#描述#>*/
@property (nonatomic, strong)UITextField *text;
/**<#描述#>*/
@property (nonatomic, strong)HJDDD *text1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     UIKeyboardTypePhonePad
     UIKeyboardTypeNamePhonePad  默认使用系统键盘
     */
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 100, 40)];
    self.text = textField;
    textField.layer.borderWidth = 2;
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.keyboardType = UIKeyboardTypeASCIICapable;
    textField.secureTextEntry = YES; //设置了以后  密文  而且系统自带键盘
    
    
    [self.view addSubview:textField];
    
    HJDDD *textField1 = [[HJDDD alloc] initWithFrame:CGRectMake(50, 200, 100, 40)];
    self.text1 = textField1;
    textField1.layer.borderWidth = 2;
    textField1.layer.borderColor = [UIColor blackColor].CGColor;
    textField1.keyboardType = UIKeyboardTypeDecimalPad;
//    textField1.secureTextEntry = YES; //设置了以后  密文  而且系统自带键盘
    [self.view addSubview:textField1];
//    [self.text1 addTarget:self action:@selector(dfddf:) forControlEvents:(UIControlEventEditingChanged)];
//     [self.text1 addTarget:self action:@selector(dfddf:) forControlEvents:(UIControlEventEditingDidBegin)];
//    [self.text1 addTarget:self action:@selector(dfddf:) forControlEvents:(UIControlEventEditingDidEnd)];
//    [self.text1 addTarget:self action:@selector(qq:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
//     [self.text1 addTarget:self action:@selector(dfddf:) forControlEvents:(UIControlEventEditingChanged | UIControlEventEditingDidBegin | UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit)];
}
- (void)dfddf:(UITextField *)te {
//    te.secureTextEntry = YES;
    NSLog(@"1fddfgfdg");
    te.secureTextEntry = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self dfddf:self.text1];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
}
@end
