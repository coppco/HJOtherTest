//
//  ViewController.m
//  TPKeyboardAvoidingDemo
//
//  Created by coco on 16/5/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "ViewController.h"
#import <TPKeyboardAvoidingScrollView.h>
#import <Masonry.h>
#import <BlocksKit.h>

@interface ViewController ()
/*解决键盘遮挡的scrollview*/
@property (nonatomic, strong)TPKeyboardAvoidingScrollView *scrollow;
@end

@implementation ViewController
- (TPKeyboardAvoidingScrollView *)scrollow {
    if (_scrollow == nil) {
        _scrollow = [[TPKeyboardAvoidingScrollView alloc] init];
        [self.view addSubview:_scrollow];
    }
    return _scrollow;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *lastView = nil;
    for (int i = 0; i < 20; i++) {
        UITextField *field = [[UITextField alloc] init];
        field.tintColor = [UIColor redColor];
        field.borderStyle = UITextBorderStyleRoundedRect;
        field.placeholder = [NSString stringWithFormat:@"第%d个", i];
        [self.scrollow addSubview:field];
        
        if (lastView == nil) {
            [field mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(80);
                make.right.equalTo(self.view).offset(-80);
                make.top.mas_equalTo(10);  //这里不能是self.view  不然会有bug
                make.height.mas_equalTo(30);
            }];
        } else {
            [field mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(lastView);
                make.top.equalTo(lastView.mas_bottom).offset(20);
                make.height.equalTo(lastView);
            }];
        }
        lastView = field;
    }
    
    [self.scrollow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.bottom.equalTo(lastView.mas_bottom).offset(20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
