//
//  HJPopButton.h
//  02-弹出式按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPopButton : UIView
/**中心按钮*/
@property (nonatomic, strong)UIButton  *centerButton;

/**子按钮的图片数组*/
@property (nonatomic, strong)NSArray  *subImages;

/**子按钮展开半径*/
@property (nonatomic, assign)CGFloat  totalRadius;

/**中心按钮宽高*/
@property (nonatomic, assign)CGFloat  centerRadius;

/**子按钮宽高*/
@property (nonatomic, assign)CGFloat  subRadius;

/**父视图*/
@property (nonatomic, strong)UIView  *parentView;

/**是否展开*/
@property (nonatomic, assign, getter=isExpanded, readonly) BOOL expanded;

- (instancetype)initWithFrame:(CGRect)frame
                            subButtonImages:(NSArray <NSString *>*)subImages
                            totalRadius:(CGFloat)totalRadius
                            centerRadius:(CGFloat)centerRadius
                            subRadius:(CGFloat)subRadius
                            centerImage:(NSString *)centerImageName
                            centerBackground:(NSString *)centerBackgroundName
                            addToParentView:(UIView *)parentView;
@end
