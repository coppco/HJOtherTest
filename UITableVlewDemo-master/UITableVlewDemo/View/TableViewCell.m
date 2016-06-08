//
//  TableViewCell.m
//  UITableVlewDemo
//
//  Created by 陆巧怡 on 15/10/18.
//  Copyright © 2015年 Simon. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()
@property (nonnull, strong, nonatomic) UILabel *titleLabel;

/**
 *  公共的UIView，这个相当于是底色的白色图
 */
@property (nonnull, nonatomic, strong) UIView *publicView;//版块0
/**
 *  顶部组件
 */
@property (nonnull, strong, nonatomic) TopGroupView *topGroupView;//版块1
/**
 *  中部组件
 */
@property (nonnull, strong, nonatomic) MidGroupView *midGroupView;//版块2
/**
 *  底部组件
 */
@property (nonnull, strong, nonatomic) UnderGroupView *undGroupView;//版块3

@end

@implementation TableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


/**
 *  初始化cell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
        [self createView];
        [self setViewAtuoLayout];
        [self setNeedsLayout];
        
        NSLog(@"%f",self.bounds.size.height);

    }
    
    return self;
}
#pragma make 创建子控件
- (void) createView {

    /**
     *  在这里我创建了一个底部白色的publicView，然后把topGroupView，midGroupView，undGroupView添加到publicView。最后就把publicView添加到contentView上。
     *  在这里要注意。版块topGroupView，midGroupView，undGroupView是相对于publicView来做布局的。publicView是相对于contentView上来布局的。
     */
    
    
    /**
     版块0
     */
    self.publicView = [[UIView alloc]init];
    self.publicView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.publicView];
    
    /**
     版块1
     */
    self.topGroupView =[[TopGroupView alloc]init];
    [self.publicView addSubview:self.topGroupView];
    
    /**
     版块2
     */
    self.midGroupView =[[MidGroupView alloc]init];
    [self.publicView addSubview:self.midGroupView];

    /**
     版块3
     */
    self.undGroupView =[[UnderGroupView alloc]init];
    [self.publicView addSubview:self.undGroupView];
}


#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    [self.publicView mas_makeConstraints:^(MASConstraintMaker *make) {
        //相对于self.contentView而言，距离顶部是10像素
        make.top.equalTo(@10);
        //相对于self.contentView而言，距离左边是0像素
        make.left.equalTo(@10);
        //相对于self.contentView而言，距离右边是0像素
        make.right.equalTo(@(-10));
        /**
         *  相对于self.contentView而言，距离底部是向上偏移了0像素 这里是重点。因为topGroupView，midGroupView，undGroupView都是添加在publicView上。所以底部的相对位置是要以publicView相对
         *  于self.contentView来自适应的。
         */
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
    
    [self.topGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@10);
        make.bottom.equalTo(self.topGroupView.mas_bottom);
        make.right.equalTo(@(-10));
    }];
 
    [self.midGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         *  相对topGroupView的底部来说，距离底部是0像素.
         */
        make.top.equalTo(self.topGroupView.mas_bottom).with.offset(0);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        /**
         *  相对undGroupView的顶部来计算
         */
        make.bottom.equalTo(self.undGroupView.mas_top);
    }];
    
    [self.undGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         *  相对midGroupView的底部来说，距离底部是0像素
         */
        make.top.equalTo(self.midGroupView.mas_bottom).with.offset(0);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        /**
         *  相对publicView的底部来计算。因为这个相对于publicView来说，它是最底部的组件。
         */
        make.bottom.equalTo(self.publicView.mas_bottom);
    }];
}

/**
 *  设置控件属性
 */
- (void)setModel:(TableViewModel *)model {
    
    _model = model;
    self.topGroupView.model = model;
    self.midGroupView.model = model;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}


@end
