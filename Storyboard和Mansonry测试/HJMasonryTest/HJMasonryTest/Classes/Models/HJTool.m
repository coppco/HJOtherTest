//
//  HJTool.m
//  HJMasonryTest
//
//  Created by coco on 16/3/28.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJTool.h"

@implementation HJTool
+ (UILabel *)allocLabelWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.numberOfLines = 0;
    label.textAlignment =1;
    return label;
}
@end
