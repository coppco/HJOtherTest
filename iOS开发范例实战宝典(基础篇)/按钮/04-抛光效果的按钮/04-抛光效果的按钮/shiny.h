//
//  shiny.h
//  抛光效果的按钮
//
//  Created by Love on 13-10-19.
//  Copyright (c) 2013年 Love. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shiny : UIButton
@property(strong, nonatomic)UIColor *myColor;
- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor;
-(void)wasPressed;
-(void)endedPress;
- (void)makeButtonShiny:(shiny*)button withBackgroundColor:(UIColor*)backgroundColor;

@end
