//
//  HJShareButton.m
//  DevoutCat
//
//  Created by apple on 2017/5/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJShareButton.h"
#import "UIView+HJExtension.h"
@implementation HJShareButton

-(void)layoutSubviews {
    [super layoutSubviews];
    //图片
    self.imageView.size = CGSizeMake(44, 44);
    self.imageView.center = CGPointMake(self.size.width / 2, 22);
    
    //文字
    self.titleLabel.size = CGSizeMake(self.self.width, 14);
    self.titleLabel.center = CGPointMake(self.size.width / 2, self.height - 7);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
