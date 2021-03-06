//
//  WhatKeyboard.m
//  SecurityKeyboard
//
//  Created by apple on 2017/8/25.
//  Copyright © 2017年 my. All rights reserved.
//

#import "WhatKeyboard.h"
#import "WhatButton.h"
#import "UIImage+ColorExtension.h"
#import "WhatPopView.h"

@interface WhatKeyboard ()
/*线条*/
@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray *lines;
/*字母按钮数组*/
@property (strong, nonatomic) IBOutletCollection(WhatButton) NSMutableArray *letterButtons;
/*约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showNumberConstraint;
/*额外的按钮*/
@property (weak, nonatomic) IBOutlet WhatButton *otherButton;
/*切换大小写*/
@property (weak, nonatomic) IBOutlet WhatButton *switchCapitalButton;
/*切换数字*/
@property (weak, nonatomic) IBOutlet WhatButton *switchNumberButton;
/*删除按钮*/
@property (weak, nonatomic) IBOutlet WhatButton *deleteButton;
/*确定按钮*/
@property (weak, nonatomic) IBOutlet WhatButton *confirmButton;
/*空格*/
@property (weak, nonatomic) IBOutlet WhatButton *spaceButton;
/*数字数组*/
@property(nonatomic, strong)NSMutableArray *numbers;
/*符号数组*/
@property(nonatomic, strong)NSMutableArray *characters;
/*大写字符*/
@property(nonatomic, strong)NSMutableArray *capitalLetters;
/*小写字符*/
@property(nonatomic, strong)NSMutableArray *smallLetters;
/*当前字符数组*/
@property(nonatomic, strong)NSMutableArray *currents;
/*弹出框*/
@property(nonatomic, strong)WhatPopView *popView;
/*当前选中按钮*/
@property(nonatomic, strong)WhatButton *selectButton;
/*定时器*/
@property(nonatomic, strong)NSTimer *timer;
/*是否选择*/
@property(nonatomic, assign)BOOL capitalSelected;
@property(nonatomic, assign)BOOL numberSelected;
/*清空*/
@property(nonatomic, assign)BOOL isClear;
@end

@implementation WhatKeyboard
- (void)dealloc {
    NSLog(@"%@释放了", self.class);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+ (instancetype)keyboard {
    WhatKeyboard *keyboard =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    return keyboard;
}
- (void)resetDefault {
    self.isClear = true;
    self.numberSelected = false;
    self.capitalSelected = false;
    [self changeCurrentType];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    self.backgroundColor = [UIColor colorWithRed:250 / 256.0 green:250 / 256.0  blue:250 / 256.0  alpha:1];
    self.switchCapitalButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.switchCapitalButton.titleLabel.font = [UIFont systemFontOfSize:14];
    for (UIView *view in self.lines) {
        view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    }
    for (WhatButton *button in self.letterButtons) {
        button.userInteractionEnabled = false;
    }
    self.otherButton.userInteractionEnabled = false;
    
    //特殊背景
    [self.switchCapitalButton setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:242 / 256.0  green:242 / 256.0 blue:242 / 256.0 alpha:1]] forState:(UIControlStateNormal)];
    [self.deleteButton setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithRed:242 / 256.0  green:242 / 256.0 blue:242 / 256.0 alpha:1]] forState:(UIControlStateNormal)];
    
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.confirmButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    [self.confirmButton setBackgroundImage:[UIImage imageFromColor:[[UIColor orangeColor] colorWithAlphaComponent:0.8]] forState:(UIControlStateNormal)];
    [self.confirmButton setBackgroundImage:[UIImage imageFromColor:[UIColor orangeColor]] forState:(UIControlStateHighlighted)];

    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.deleteButton addGestureRecognizer:press];
}

- (void)didBeginEditing:(NSNotification *)notification {
    if ([notification.object isKindOfClass:[UITextView class]]) {
        UITextView *textV = (UITextView *)notification.object;
        if (textV.inputView == self) {
            [self resetDefault];
        }
    }
    if ([notification.object isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)notification.object;
        if (textField.inputView == self) {
            [self resetDefault];
        }
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(delete:) userInfo:nil repeats:true];
    } else if (longPress.state == UIGestureRecognizerStateEnded || longPress.state == UIGestureRecognizerStateFailed || longPress.state == UIGestureRecognizerStateCancelled) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma - mark Actions

- (IBAction)switchCapital:(WhatButton *)sender {
    self.capitalSelected = !self.capitalSelected;
    [self changeCurrentType];
}
- (IBAction)switchNumber:(WhatButton *)sender {
    self.numberSelected = !self.numberSelected;
    self.capitalSelected = false;
    [self changeCurrentType];
}
- (void)clearText {
    if (self.isClear) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(clearText:)]) {
            [self.delegate clearText:self];
        }
        self.isClear = false;
    }
}
#pragma - mark WhatKeyboardDelegate

- (IBAction)delete:(WhatButton *)sender {
    [self clearText];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickDelete:)]) {
        [self.delegate didClickDelete:self];
    }
}
- (IBAction)confirm:(WhatButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickConfirm:)]) {
        [self.delegate didClickConfirm:self];
    }
}
- (IBAction)space:(WhatButton *)sender {
     [self clearText];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickSpace:)]) {
        [self.delegate didClickSpace:self];
    }
}



#pragma - mark Touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super  touchesBegan:touches withEvent:event];
    self.selectButton = nil;
    
    if ([UIDevice currentDevice].systemVersion.floatValue <= 9.0) {
        UITouch *touch = touches.anyObject;
        
        CGPoint location = [touch locationInView:touch.view];
        WhatButton *btn = [self keyboardButtonWithLocation:location];
        
        if (btn) {
            self.selectButton = btn;
            [self.popView showFromButton:btn];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    
    CGPoint location = [touch locationInView:touch.view];
    WhatButton *btn = [self keyboardButtonWithLocation:location];
    
    if (btn) {
        self.selectButton = btn;
        [self.popView showFromButton:btn];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.popView removeFromSuperview];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.popView removeFromSuperview];
    
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:touch.view];
    WhatButton *btn = [self keyboardButtonWithLocation:location];
    
    if (btn) {
         [self clearText];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCharacter:withString:)]) {
            [self.delegate didClickCharacter:self withString:btn.currentTitle];
        }
    } else if (self.selectButton) {
         [self clearText];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCharacter:withString:)]) {
            [self.delegate didClickCharacter:self withString:self.selectButton.currentTitle];
        }
    }

}

- (void)changeCurrentType {
    self.otherButton.hidden = !self.numberSelected;
    self.showNumberConstraint.constant = self.numberSelected ? - [UIScreen mainScreen].bounds.size.width / 20.0 : 0;
    
    if (self.numberSelected) {
        [self.switchCapitalButton setTitle:@"符\n号" forState:(UIControlStateNormal)];
        [self.switchCapitalButton setTitle:@"数\n字" forState:(UIControlStateSelected)];
        [self.switchCapitalButton setImage:nil forState:(UIControlStateNormal)];
        [self.switchCapitalButton setImage:nil forState:(UIControlStateSelected)];
    } else {
        [self.switchCapitalButton setTitle:nil forState:(UIControlStateNormal)];
        [self.switchCapitalButton setTitle:nil forState:(UIControlStateSelected)];
        [self.switchCapitalButton setImage:[UIImage imageNamed:@"keyboard_small"] forState:(UIControlStateNormal)];
        [self.switchCapitalButton setImage:[UIImage imageNamed:@"keyboard_capital"] forState:(UIControlStateSelected)];
    }
    
    //字符
    if (self.capitalSelected && self.numberSelected) {
        self.currents = self.characters;
        [self.otherButton setTitle:@"•" forState:(UIControlStateNormal)];
        return;
    }
    //数字
    if (!self.capitalSelected && self.numberSelected) {
        self.currents = self.numbers;
        [self.otherButton setTitle:@"\"" forState:(UIControlStateNormal)];
        return;
    }

    //大写字母
    if (self.capitalSelected && !self.numberSelected) {
        self.currents = self.capitalLetters;
        return;
    }
    //小写
    if (!self.capitalSelected && !self.numberSelected) {
        self.currents = self.smallLetters;
        [self.switchNumberButton setTitle:@"#+123" forState:(UIControlStateNormal)];
        return;
    }
}

- (void)setCurrents:(NSMutableArray *)currents {
    _currents = currents;
    
    for (int i = 0; i < self.currents.count; i++) {
        [self.letterButtons[i] setTitle:self.currents[i] forState:(UIControlStateNormal)];
    }
    
}

#pragma mark - Private Methods

- (WhatButton *)keyboardButtonWithLocation:(CGPoint)location {
    for (WhatButton *button in self.letterButtons) {
        if (CGRectContainsPoint(button.frame, location)) {
            return button;
        }
    }
    if (CGRectContainsPoint(self.otherButton.frame, location)) {
        return self.otherButton;
    }
    return nil;
}



#pragma - mark lazy load
- (NSMutableArray *)smallLetters {
    if (!_smallLetters) {
        _smallLetters = ({
            NSMutableArray *object = [[NSMutableArray alloc] initWithObjects:@"q", @"w", @"e", @"r", @"t", @"y", @"u", @"i", @"o", @"p", @"a", @"s", @"d", @"f", @"g", @"h", @"j", @"k", @"l", @"z", @"x", @"c", @"v", @"b", @"n", @"m", nil];
            object;
        });
    }
    return _smallLetters;
}
- (NSMutableArray *)capitalLetters {
    if (!_capitalLetters) {
        _capitalLetters = ({
            NSMutableArray *object = [[NSMutableArray alloc] initWithObjects:@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P", @"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L", @"Z", @"X", @"C", @"V", @"B", @"N", @"M", nil];
            object;
        });
    }
    return _capitalLetters;
}
- (NSMutableArray *)numbers {
    if (!_numbers) {
        _numbers = ({
            NSMutableArray *object = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @".", @",", @"?", @"!", @"'", @"+", @"=", nil];
            //@"\""
            object;
        });
    }
    return _numbers;
}

- (NSMutableArray *)characters {
    if (!_characters) {
        _characters = ({
            NSMutableArray *object = [[NSMutableArray alloc] initWithObjects:@"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"_", @"\\", @"|", @"/", @"~", @"<", @">", @"`", @"¥", @"€", @"￡", @".", @",", @"?", @"!", @"'", @"+", @"=", nil];
            //@"•"
            object;
        });
    }
    return _characters;
}
- (WhatPopView *)popView {
    if (!_popView) {
        _popView = ({
            WhatPopView *object = [WhatPopView popView];
            object;
        });
    }
    return _popView;
}
@end
