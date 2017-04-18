//
//  AccountTableViewCell.m
//  Podinns
//
//  Created by apple on 2017/3/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AccountTableViewCell.h"

@interface AccountTableViewCell ()
/*是否有效*/
@property (weak, nonatomic) IBOutlet UIImageView *availableImageV;
/*用户名*/
@property (weak, nonatomic) IBOutlet UILabel *userNameL;
/*密码*/
@property (weak, nonatomic) IBOutlet UILabel *passwordL;
/*是否商旅卡*/
@property (weak, nonatomic) IBOutlet UILabel *isTravelL;
/*最后登录时间*/
@property (weak, nonatomic) IBOutlet UILabel *last_login_timeL;
/*最后签到时间*/
@property (weak, nonatomic) IBOutlet UILabel *last_sign_timeL;
/*最后抽奖时间*/
@property (weak, nonatomic) IBOutlet UILabel *last_lottery_timeL;
@property (weak, nonatomic) IBOutlet UILabel *last_weekLotteryDateL;

/*总积分*/
@property (weak, nonatomic) IBOutlet UILabel *total_bonusL;

@end

@implementation AccountTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAccount:(AccountVo *)account {
    if (account.isAvailable == 0) {
        self.availableImageV.image = [UIImage imageNamed:@"account_error"];
    } else if (account.isAvailable == 1) {
        self.availableImageV.image = [UIImage imageNamed:@"account_success"];
    } else if (account.isAvailable == 2) {
        self.availableImageV.image = [UIImage imageNamed:@"account_warning"];
    }
    
    self.userNameL.text = account.userName;
    self.passwordL.text = account.password;
    self.isTravelL.text = (account.IsTravel == 0 ? @"否" : @"是");
    self.last_sign_timeL.text = account.last_signDate.length == 0 ? @"N/A" : account.last_signDate;
    self.last_login_timeL.text = account.last_loginDate.length == 0 ? @"N/A" : account.last_loginDate;
    self.last_lottery_timeL.text = account.last_lotteryDate.length == 0 ? @"N/A" : account.last_lotteryDate;
    self.last_weekLotteryDateL.text = account.last_weekLotteryDate.length == 0 ? @"N/A" : account.last_weekLotteryDate;
    self.total_bonusL.text = account.totalBonus.length == 0 ? @"N/A" : account.totalBonus;
}

@end
