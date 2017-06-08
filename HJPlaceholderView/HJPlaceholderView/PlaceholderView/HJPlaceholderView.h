//
//  HJPlaceholderView.h
//  HJPlaceholderView
//
//  Created by apple on 2017/5/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 类型

 - HJPlaceholderTypeNormal: 状态状态, 不会显示
 - HJPlaceholderTypeNoData: 无数据状态
 - HJPlaceholderTypeNoNetworw: 无网络状态
 - HJPlaceholderTypeServerError: 服务器错误状态
 */
typedef NS_ENUM(NSInteger, HJPlaceholderStatus) {
    HJPlaceholderStatusNormal = 1,
    HJPlaceholderStatusNoData = 2,
    HJPlaceholderStatusNoNetwork = 3,
    HJPlaceholderStatusServerError = 4
};

/**操作*/
typedef void (^placeholderOperation)();

//默认文本
UIKIT_EXTERN NSString *const HJPlaceholderStatusNoDataText;
UIKIT_EXTERN NSString *const HJPlaceholderStatusNoNetworkText;
UIKIT_EXTERN NSString *const HJPlaceholderStatusServerErrorText;

@interface HJPlaceholderView : UIView

+ (HJPlaceholderView *)placeholderViewForView:(UIView *)superView;



/*当前状态*/
@property(nonatomic, assign)HJPlaceholderStatus status;

/**
 根据状态设置图片

 @param imageName 图片名称
 @param status 状态
 */
- (void)setImage:(NSString *)imageName status:(HJPlaceholderStatus)status;

/**
 根据状态设置描述文本

 @param describe 描述文本
 @param status 状态
 */
- (void)setDescribe:(NSString *)describe status:(HJPlaceholderStatus)status;


/**
 根据状态设置按钮点击事件

 @param block 操作
 @param status 状态
 */
- (void)setOperationBlock:(placeholderOperation)block status:(HJPlaceholderStatus)status;
@end
