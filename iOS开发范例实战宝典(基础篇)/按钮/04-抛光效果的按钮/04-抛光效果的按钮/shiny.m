//
//  shiny.m
//  抛光效果的按钮
//
//  Created by Love on 13-10-19.
//  Copyright (c) 2013年 Love. All rights reserved.
//

#import "shiny.h"

@implementation shiny


- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myColor = backgroundColor;
        [self makeButtonShiny:self withBackgroundColor:backgroundColor];
        [self addTarget:self action:@selector(wasPressed) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(endedPress) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)makeButtonShiny:(shiny*)button withBackgroundColor:(UIColor*)backgroundColor
{
    
    CALayer *layer = button.layer;
    layer.cornerRadius = 8.0f;
    layer.masksToBounds = YES;
    layer.borderWidth = 2.0f;
    layer.borderColor = [UIColor colorWithWhite:0.4f alpha:0.2f].CGColor;
    
    
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = button.layer.bounds;
    
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    

    [button.layer addSublayer:shineLayer];
    
    [button setBackgroundColor:backgroundColor];
}


-(void)wasPressed
{
    UIColor *newColor;
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0, white = 0.0;
    

    if([self.myColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self.myColor getRed:&red green:&green blue:&blue alpha:&alpha];
        [self.myColor getWhite:&white alpha:&alpha];
        
        if(!(red + green + blue) && white){
            
            newColor = [UIColor colorWithWhite:white - 0.2 alpha:alpha];
        } else if(!(red + green + blue) && !white) {
       
            newColor = [UIColor colorWithWhite:white + 0.2 alpha:alpha];
        } else{
       
            newColor = [UIColor colorWithRed:red - 0.2 green:green - 0.2 blue:blue - 0.2 alpha:alpha];
        }
    }
    self.backgroundColor = newColor;
    
}

-(void)endedPress
{
    self.backgroundColor = self.myColor;
}




@end
