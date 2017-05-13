//
//  CustomLayer.m
//  ForFlipBoard
//
//  Created by DamonNG on 15/6/19.
//  Copyright (c) 2015年 DamonNG. All rights reserved.
//

#import "CustomLayer.h"
#import "Flip.h"

@implementation CustomLayer
#pragma mark Public Methods
-(id)initWithFrame:(CGRect)frame{
    self=[super init];
    if (self){
        self.frame=frame;
        self.doubleSided=YES;
        self.anchorPoint=CGPointMake(0.5, 1.0f);
        self.position=CGPointMake(self.position.x,
                                  self.position.y-self.frame.size.height/2);
        
        _frontLayer=[[CALayer alloc]init];
        _frontLayer.frame=self.bounds;
        _frontLayer.backgroundColor=[UIColor whiteColor].CGColor;
        _frontLayer.doubleSided=NO;
        _frontLayer.name=@"frontLayer";
        _frontLayer.opaque=NO;
        //_frontLayer.contents=(id)image_2.CGImage;
        
        _backLayer=[[CALayer alloc]init];
        _backLayer.frame=self.bounds;
        _backLayer.backgroundColor=[UIColor whiteColor].CGColor;
        _backLayer.doubleSided=YES;
        _backLayer.name=@"backLayer";
        //_backLayer.contents=(id)image_1.CGImage;
        _backLayer.transform = JHFlipCATransform3DPerspectSimpleWithRotate(180.0f);
        _backLayer.opaque=YES;
        
        [self addSublayer:_backLayer];
        [self addSublayer:_frontLayer];
    }
    return self;
}

-(void)setFrontLayerContent:(UIImage *)images
{
    _frontLayer.contents=(id)images.CGImage;
}
-(void)setBackLayerContent:(UIImage *)images
{
    _backLayer.contents=(id)images.CGImage;
}


@end
