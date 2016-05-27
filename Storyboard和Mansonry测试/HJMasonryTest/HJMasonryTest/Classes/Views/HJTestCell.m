//
//  HJTestCell.m
//  HJMasonryTest
//
//  Created by coco on 16/3/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "HJTestCell.h"

@interface HJTestCell ()
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleL;
@property (nonatomic, strong)UILabel *descL;
@end

@implementation HJTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}
- (void)initSubView {
    self.imageV = [[UIImageView alloc] init];
    self.imageV.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imageV];
    
    self.titleL = [[UILabel alloc] init];
    self.titleL.numberOfLines = 0;
    [self.contentView addSubview:self.titleL];
    
    self.descL = [[UILabel alloc] init];
    self.descL.numberOfLines = 0;
    self.descL.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.descL];
}
- (void)setModel:(HJTestModel *)model {
    _model = model;
    _titleL.text = model.title;
    _descL.text = model.desc;
    
    [self.imageV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.titleL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.left.mas_equalTo(self.imageV.mas_right).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.bottom.mas_equalTo(self.descL.mas_top).offset(-15);
    }];
    [self.descL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageV.mas_right).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
    }];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//+ (CGFloat)configWithModel:(HJTestModel *)mode {
//    
//}
@end
