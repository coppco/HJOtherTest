//
//  HJScrollViewController.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJScrollViewController.h"

@interface HJScrollViewController ()
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation HJScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
}
- (void)initSubView {
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    UIView *lastView = nil;
    for (int i = 0; i < 20; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = [self getString];
        label.textColor = [self randomColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor lightGrayColor];
        [self.scrollView addSubview:label];

        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.view).offset(-15);
            if (lastView == nil) {
                make.top.mas_equalTo(self.scrollView).offset(20);
            } else {
                make.top.mas_equalTo(lastView.mas_bottom).offset(20);
            }
//            make.left.mas_equalTo(15);
//            make.right.mas_equalTo(self.view).offset(-15);
//            
//            if (lastView) {
//                make.top.mas_equalTo(lastView.mas_bottom).offset(20);
//            } else {
//                make.top.mas_equalTo(self.scrollView).offset(20);
//            }

        }];
        lastView = label;
    }
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.bottom.mas_equalTo(lastView.mas_bottom).offset(20);
    }];
}
- (NSString *)getString {
    NSMutableString *string = [NSMutableString string];
    NSInteger random = arc4random()  % 20 + 1;
    for (int i = 0; i < random; i++) {
        [string appendFormat:@"%d哈哈-呵呵", random];
    }
    return string;
}
- (UIColor *)randomColor {
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}



@end
