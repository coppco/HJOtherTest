//
//  ViewController.m
//  iOS_Font
//
//  Created by apple on 2017/3/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
/*文本*/
@property(nonatomic, strong)UILabel *label;
/*fontB*/
@property(nonatomic, strong)UIButton *fontB;
/*picker*/
@property(nonatomic, strong)UIPickerView *pickerView;
/*familyA*/
@property(nonatomic, strong)NSMutableArray *familyA;
/*fontA*/
@property(nonatomic, strong)NSMutableArray *fontA;
@end

@implementation ViewController
- (UILabel *)label {
    if (!_label) {
        _label = ({
            UILabel *object = [[UILabel alloc] init];
            object.text = @"当前未设置字体";
            object.textAlignment = NSTextAlignmentCenter;
            object.textColor = [UIColor blackColor];
            object;
        });
    }
    return _label;
}
- (UIButton *)fontB {
    if (!_fontB) {
        _fontB = ({
            UIButton *object = [[UIButton alloc] init];
            [object setTitle:@"设置字体" forState:(UIControlStateNormal)];
            [object setTitle:@"设置字体" forState:(UIControlStateHighlighted)];
            [object setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [object setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
            object.backgroundColor = [UIColor redColor];
            object.layer.cornerRadius = 5;
            object.layer.masksToBounds = true;
            [object addTarget:self action:@selector(show:) forControlEvents:(UIControlEventTouchUpInside)];
            object;
        });
    }
    return _fontB;
}
- (NSMutableArray *)familyA {
    if (!_familyA) {
        _familyA = [NSMutableArray array];
    }
    return _familyA;
}
- (NSMutableArray *)fontA {
    if (!_fontA) {
        _fontA = [NSMutableArray array];
    }
    return _fontA;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = ({
            UIPickerView *object = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
            object.dataSource = self;
            object.delegate = self;
            object.hidden = true;
            object.backgroundColor = [UIColor lightGrayColor];
            object;
        });
    }
    return _pickerView;
}
//显示pickerView
- (void)show:(UIButton *)button {
    [self.view addSubview:self.pickerView];
    self.pickerView.hidden = false;
    self.pickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    [self.view bringSubviewToFront:self.pickerView];
    [self.pickerView selectRow:0 inComponent:0 animated:false];
    if (self.fontA.count > 0) {
        self.label.text = [NSString stringWithFormat:@"当前字体: %@", self.fontA[0]];
        self.label.font = [UIFont fontWithName:self.fontA[0] size:15];
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.pickerView.frame.size.width, self.pickerView.frame.size.height);
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    self.label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 100);
    
    [self.view addSubview:self.fontB];
    self.fontB.frame = CGRectMake(0, 0, self.view.frame.size.width * 0.3, 30);
    self.fontB.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - 50);
    
    self.familyA = [[[NSArray alloc] initWithArray:[UIFont familyNames]] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }].mutableCopy;
    for (int i = 0 ; i < self.familyA.count; i++) {
        if (i == 0) {
            self.fontA = [[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:self.familyA.firstObject]].mutableCopy;
            break;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - mark Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.familyA.count;
    } else {
        return self.fontA.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.familyA[row];
    } else {
        return self.fontA[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.fontA = [[NSMutableArray alloc] initWithArray:[UIFont fontNamesForFamilyName:self.familyA[row]]];
        [self.pickerView selectRow:0 inComponent:1 animated:true];
        [self.pickerView reloadComponent:1];
        if (self.fontA.count > 0) {
            self.label.text = [NSString stringWithFormat:@"当前字体: %@", self.fontA[0]];
            self.label.font = [UIFont fontWithName:self.fontA[0] size:15];
        }
    } else {
        if (self.fontA.count > row) {
            self.label.text = [NSString stringWithFormat:@"当前字体: %@", self.fontA[row]];
            self.label.font = [UIFont fontWithName:self.fontA[row] size:15];            
        }
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width / 2;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.pickerView.hidden == false) {
        [UIView animateWithDuration:0.3 animations:^{
            self.pickerView.frame = CGRectMake(0, self.view.frame.size.height, self.pickerView.frame.size.width, self.pickerView.frame.size.height);
        } completion:^(BOOL finished) {
            if (finished) {
                self.pickerView.hidden = true;
            }
        }];
    }
}
@end
