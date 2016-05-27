//
//  HJTestCell.h
//  HJMasonryTest
//
//  Created by coco on 16/3/29.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJTestModel.h"
@interface HJTestCell : UITableViewCell
@property (nonatomic, strong)HJTestModel *model;
/**
 *  @author XHJ, 16-03-29 10:03:51
 *
 *  配置model
 *
 *  @param mode 返回一个cell的高度
 *
 *  @return
 */
+ (CGFloat)configWithModel:(HJTestModel *)mode;
@end
