//
//  HJCoverFlowLayout.h
//  DevoutCat
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCoverFlowLayout : UICollectionViewFlowLayout
/*缩放系数*/
@property(nonatomic, assign)CGFloat scaleCoefficient;
/*垂直系数*/
@property(nonatomic, assign)CGFloat verticalCoefficient;

@end
