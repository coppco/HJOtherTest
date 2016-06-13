//
//  TopGroupView.m
//  UITableVlewDemo
//
//  Created by 陆巧怡 on 15/10/19.
//  Copyright © 2015年 Simon. All rights reserved.
//



#import "TopGroupView.h"

@interface TopGroupView ()
/**
 *  头像
 */
@property (nonnull, nonatomic, strong) UIImageView *iconImageView;
/**
 *  名称
 */
@property (nonnull, nonatomic, strong) UILabel *nickNameLabel;
/**
 *  时间
 */
@property (nonnull, nonatomic, strong) UILabel *timeLabel;
/**
 *  等级
 */
@property (nonnull, nonatomic, strong) UILabel *levelLabel;
@property (nonnull, nonatomic, strong) TableViewModel *temoModel;

@end

@implementation TopGroupView

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
    
    //头像
    self.iconImageView = [[UIImageView alloc]init];
    self.iconImageView.layer.cornerRadius = 20.0;
    self.iconImageView.layer.masksToBounds = YES;
    [self addSubview:self.iconImageView];
    
    //名字
    self.nickNameLabel = [[UILabel alloc]init];
    self.nickNameLabel.font = [UIFont systemFontOfSize:15];
    self.nickNameLabel.textColor = [UIColor orangeColor];
    [self addSubview:self.nickNameLabel];
    
    //时间
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.textColor = [UIColor blackColor];
    [self addSubview:self.timeLabel];
    
    //等级
    self.levelLabel = [[UILabel alloc]init];
    self.levelLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.levelLabel];
    
}

-(void)setViewAtuoLayout{
    //头像
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         *  相对于TopGroupView而言，距离顶部是10像素
         */
        make.top.equalTo(@10);
       
        /**
         *  相对于TopGroupView而言，距离左边是0像素
         */
        make.left.equalTo(@0);
        
        /**
         *  相对于TopGroupView而言，高度是40像素
         */
        make.height.equalTo(@40);
        
        /**
         *  相对于TopGroupView而言，宽度是40像素
         */
        make.width.equalTo(@40);
        /**
         *  相对于TopGroupView而言，距离底部是-10像素 ！！！在这里注意，这里是以TopGroupView的底部而言，往上走10个像素。因为基于y轴，所以它是要写出-10个像素
         */
        make.bottom.equalTo(@(-10));
    }];
    //昵称
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@10);
        /**
         *  相对iconImageView的最右边来说，距离iconImageView的最右边是10个像素
         */
        make.left.equalTo(self.iconImageView.mas_right).with.offset(10);
        make.height.equalTo(@15);
    }];
    //时间
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.iconImageView.mas_right).with.offset(10);
        make.height.equalTo(@15);
    }];
    //时间
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(self.nickNameLabel.mas_right).with.offset(10);
        make.height.equalTo(@15);
    }];
}

-(void)setModel:(TableViewModel *)model{
    
    self.nickNameLabel.text = model.username;
    self.timeLabel.text = model.time;
    self.levelLabel.text = @"99Lv";
    self.iconImageView.image =[UIImage imageNamed:@"111"];
}


@end
