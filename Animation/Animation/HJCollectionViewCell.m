//
//  HJCollectionViewCell.m
//  Animation
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJCollectionViewCell.h"
#import <Masonry.h>
#import "UIColor+HJExtension.h"
#import "UIFont+HJExtension.h"
#define kScale_width(value) ([UIScreen mainScreen].bounds.size.width / 375 * (value))
#define kScale_height(value) ([UIScreen mainScreen].bounds.size.height / 667 * (value))
#define kScale_font(value) ([UIScreen mainScreen].bounds.size.width / 375 * (value))
@interface HJCollectionViewCell ()
/*图片*/
@property(nonatomic, strong)UIImageView *backgroundImageV;
/*earningsL 收益*/
@property(nonatomic, strong)UILabel *earningsL;
/*%*/
@property(nonatomic, strong)UILabel *percentageL;
/*yearL*/
@property(nonatomic, strong)UILabel *yearL;
/*purchaseTopL*/
@property(nonatomic, strong)UILabel *purchaseTopL;
/*purchaseBottomL*/
@property(nonatomic, strong)UILabel *purchaseBottomL;
/*dateTopL*/
@property(nonatomic, strong)UILabel *dateTopL;
/*dateBottomL*/
@property(nonatomic, strong)UILabel *dateBottomL;
/*limitTopL*/
@property(nonatomic, strong)UILabel *limitTopL;
/*limitBottomL*/
@property(nonatomic, strong)UILabel *limitBottomL;
/*立即投资*/
@property(nonatomic, strong)UIButton *startB;
@end

@implementation HJCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    self.backgroundImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Group_29_Copy"]];
    [self.contentView addSubview:self.backgroundImageV];
    
    [self.backgroundImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    self.earningsL = ({
        UILabel *object = [[UILabel alloc] init];
//        object.text = @"15  %";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"15 %"];
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(35)], NSForegroundColorAttributeName : [UIColor colorFromRGBValue:0xfd7a23]} range:(NSMakeRange(0, 2))];
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(16)], NSForegroundColorAttributeName : [UIColor colorFromRGBValue:0xfd7a23]} range:(NSMakeRange(3, 1))];
        object.font = [UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(35)];
        object.attributedText = string;
//        object.textColor = [UIColor colorFromRGBValue:0xfd7a23];
        //        object.font = [UIFont systemFontOfSize:14];
//        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(35)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    self.percentageL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"%";
        object.textColor = [UIColor colorFromRGBValue:0xfd7a23];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(16)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    
    [self.contentView addSubview:self.earningsL];
//    [self.contentView addSubview:self.percentageL];
    [self.earningsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.height.mas_equalTo(kScale_height(35));
    }];
//    [self.percentageL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.earningsL.mas_bottom);
//        make.left.mas_equalTo(self.earningsL.mas_right).offset(4);
//        make.height.mas_equalTo(kScale_height(16));
//    }];
    
    self.yearL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"预计年化收益";
        object.textColor = [UIColor colorFromRGBValue:0x999999];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(14)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    
    [self.contentView addSubview:self.yearL];
    [self.yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.earningsL.mas_bottom).offset(4);
        make.height.mas_equalTo(kScale_height(14));
    }];
    
    self.purchaseTopL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"100元";
        object.textColor = [UIColor colorFromRGBValue:0x333333];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(16)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });

    self.purchaseBottomL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"起购金额";
        object.textColor = [UIColor colorFromRGBValue:0x999999];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(14)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    self.dateTopL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"30天";
        object.textColor = [UIColor colorFromRGBValue:0x333333];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(16)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    
    self.dateBottomL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"期限";
        object.textColor = [UIColor colorFromRGBValue:0x999999];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(14)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    self.limitTopL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"10000元";
        object.textColor = [UIColor colorFromRGBValue:0x333333];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(16)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    
    self.limitBottomL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"限额";
        object.textColor = [UIColor colorFromRGBValue:0x999999];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(14)];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });



    [self.contentView addSubview:self.purchaseTopL];
     [self.contentView addSubview:self.purchaseBottomL];
    [self.contentView addSubview:self.dateTopL];
    [self.contentView addSubview:self.dateBottomL];
    [self.contentView addSubview:self.limitTopL];
    [self.contentView addSubview:self.limitBottomL];

    [self.purchaseTopL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yearL.mas_bottom).offset(12);
        make.size.top.mas_equalTo(self.dateTopL);
        make.size.top.mas_equalTo(self.limitTopL);
        make.left.mas_equalTo(self.contentView).offset(8);
        make.right.mas_equalTo(self.dateTopL.mas_left);
        make.height.mas_equalTo(kScale_height(16));
    }];
    [self.dateTopL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.limitTopL.mas_left);
    }];
    [self.limitTopL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    [self.purchaseBottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.purchaseTopL.mas_bottom).offset(4);
        make.size.top.mas_equalTo(self.dateBottomL);
        make.size.top.mas_equalTo(self.limitBottomL);
        make.left.mas_equalTo(self.contentView).offset(8);
        make.right.mas_equalTo(self.dateBottomL.mas_left);
        make.height.mas_equalTo(kScale_height(14));
    }];
    [self.dateBottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.limitBottomL.mas_left);
    }];
    [self.limitBottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8);
    }];
    
    self.startB = ({
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:@"立即投资" forState:(UIControlStateNormal)];
        [button setTitle:@"立即投资" forState:(UIControlStateHighlighted)];
        [button setTitleColor:[UIColor colorFromHexString:@"ffffff"] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor colorFromHexString:@"ffffff"] forState:(UIControlStateHighlighted)];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:kScale_font(16)];
        button;
    });
    [self.contentView addSubview:self.startB];
    [self.startB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(kScale_height(-30));
    }];
}
@end
