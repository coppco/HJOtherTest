//
//  ViewController.m
//  Pasteboard剪切板
//
//  Created by apple on 2017/5/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/*<#描述#>*/
@property(nonatomic, strong)UILabel *textL;
@end

@implementation ViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
- (void)change:(id)sender {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"剪切板更改" preferredStyle:(UIAlertControllerStyleAlert)];
    [vc addAction:[UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:vc animated:true completion:nil];
}
- (void)show:(id)sender {
    NSString *string = [UIPasteboard generalPasteboard].string;
    if (string.length > 0 && [string containsString:@"百度"]) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"检查到剪切板" message:string preferredStyle:(UIAlertControllerStyleAlert)];
        [vc addAction:[UIAlertAction actionWithTitle:@"知道了" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:vc animated:true completion:nil];
    }
//    UIApplicationDidBecomeActiveNotification
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UIPasteboardChangedNotification object:nil];
    self.textL = [[UILabel alloc] initWithFrame:(CGRectMake(100, 100, 200, 30))];
    self.textL.textColor = [UIColor whiteColor];
    self.textL.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.textL];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)canBecomeFirstResponder {
    return true;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.view.frame inView:self.view];
    // 在img1上显示菜单
    [menu setMenuVisible:YES animated:YES];
    
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(cut:) || action == @selector(paste:)) {
        return true;
    }
    return false;
}
- (void)cut:(id)sender {
    UIPasteboard *p = [UIPasteboard generalPasteboard];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    p.string = [dateFormatter stringFromDate:[NSDate date]];
}

- (void)paste:(id)sender {
    self.textL.text = [UIPasteboard generalPasteboard].string;
}

@end
