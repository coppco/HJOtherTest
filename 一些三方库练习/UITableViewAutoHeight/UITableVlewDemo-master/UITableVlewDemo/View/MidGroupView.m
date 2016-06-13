//
//  MidGroupView.m
//  UITableVlewDemo
//
//  Created by 陆巧怡 on 15/10/19.
//  Copyright © 2015年 Simon. All rights reserved.
//

#import "MidGroupView.h"

@interface MidGroupView ()
/**
 *  内容
 */
@property (strong, nonatomic) UILabel *contentLabel;
/**
 *  图片
 */
@property (strong, nonatomic) UIImageView *contentImageView;
@end

@implementation MidGroupView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        [self setViewAtuoLayout];

    }
    return self;
}

-(void)createUI{
    
    //文字内容
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    //图片
    self.contentImageView = [[UIImageView alloc]init];
    [self addSubview:self.contentImageView];
    
    
}

-(void)setViewAtuoLayout{
    
    //文字内容
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    //图片
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
}

-(void)setModel:(TableViewModel *)model{
    
    self.contentLabel.text = model.content;
    self.contentImageView.image = model.imageName.length > 0 ? [UIImage imageNamed:model.imageName] : nil;
}

@end
