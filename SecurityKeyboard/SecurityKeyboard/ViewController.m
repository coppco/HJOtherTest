//
//  ViewController.m
//  SecurityKeyboard
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 my. All rights reserved.
//

#import "ViewController.h"
#import "WhatKeyboard.h"
@interface ViewController ()<WhatKeyboardDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自定义键盘";
    // Do any additional setup after loading the view, typically from a nib.
    
    WhatKeyboard *keyboard = [WhatKeyboard keyboard];
    keyboard.delegate = self;
    self.textField.inputView = keyboard;
    [self.textField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];

}

#pragma - mark delegate
- (void)clearText:(WhatKeyboard *)keyboard {
    self.textField.text = nil;
}
- (void)didClickSpace:(WhatKeyboard *)keyboard {
    [self.textField insertText:@" "];
}

- (void)didClickDelete:(WhatKeyboard *)keyboard {
    [self.textField deleteBackward];
}

- (void)didClickConfirm:(WhatKeyboard *)keyboard {
    [self.textField resignFirstResponder];
}

- (void)didClickCharacter:(WhatKeyboard *)keyboard withString:(NSString *)str {
    [self.textField insertText:str];
}

@end
