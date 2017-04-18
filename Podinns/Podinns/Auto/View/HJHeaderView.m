//
//  HJHeaderView.m
//  Podinns
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJHeaderView.h"

@interface HJHeaderView ()
/*用户名*/
@property(nonatomic, strong)UILabel * userNameL;
/*开始按钮*/
@property(nonatomic, strong)UIButton * startB;
@end

@implementation HJHeaderView

+ (HJHeaderView *)headerViewWith:(UITableView *)tableView {
    HJHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:@"headerView"];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.userNameL];
        [self.contentView addSubview:self.startB];
        [self.startB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(UIEdgeInsetsMake(5, 0, 5, 15));
            make.width.mas_equalTo(80);
        }];
        [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 0));
            make.right.mas_equalTo(self.startB.mas_left).offset(-20);
        }];
        
        RAC(self.startB, enabled) = [RACSignal combineLatest:@[RACObserve(self, account.last_signDate), RACObserve(self, account.last_lotteryDate), RACObserve(self, account.last_weekLotteryDate)] reduce:^id (NSString *sign, NSString *lottery, NSString *week){
            return @(!([NSDate dateFromString:sign dateFormatter:SQLDataFormatter].isToday) || !([NSDate dateFromString:lottery dateFormatter:SQLDataFormatter].isToday) || !([NSDate dateFromString:week dateFormatter:SQLDataFormatter].isThisWeek));
        }];
        @weakify(self);
        [[self.startB rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
            @strongify(self);
            if (self.headerBlock) {
                self.headerBlock(self);
            }
        }];
    }
    return self;
}
- (void)setAccount:(AccountVo *)account {
    _account = account;
    self.userNameL.text = account.userName;
}
- (UILabel *)userNameL {
    if (!_userNameL) {
        _userNameL = ({
            UILabel *object = [[UILabel alloc] init];
            object.textColor = [UIColor blackColor];
            object.font = [UIFont systemFontOfSize:20];
            object;
        });
    }
    return _userNameL;
}
- (UIButton *)startB {
    if (!_startB) {
        _startB = ({
            UIButton *object = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [object setTitle:@"开始" forState:(UIControlStateNormal)];
            object.titleLabel.font = [UIFont systemFontOfSize:15];
            [object setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [object setBackgroundImage:[UIImage imageNamed:@"login_register_button"] forState:(UIControlStateNormal)];
            [object setBackgroundImage:[UIImage imageNamed:@"login_register_button_click"] forState:(UIControlStateHighlighted)];
            object.layer.cornerRadius = 5;
            object.layer.masksToBounds = true;
            object;
        });
    }
    return _startB;
}
@end
