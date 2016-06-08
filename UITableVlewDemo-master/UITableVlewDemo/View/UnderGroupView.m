//
//  UnderGroupView.m
//  
//
//  Created by 陆巧怡 on 15/10/20.
//
//



#import "UnderGroupView.h"
@interface UnderGroupView ()
/**
 *  点赞
 */
@property (strong, nonatomic) UIButton *likeBtn;
@end

@implementation UnderGroupView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    self.likeBtn = [[UIButton alloc] init];
    [self.likeBtn setImage:[UIImage imageNamed:@"赞-灰"] forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.likeBtn];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.mas_equalTo(@13);
        make.bottom.equalTo(self.mas_bottom);

    }];
}

-(void)setViewAtuoLayout{
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.mas_equalTo(@13);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
}

@end
