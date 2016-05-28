//
//  HJUnderLineButton.h
//  03-带下划线的按钮
//
//  Created by M-coppco on 16/5/28.
//  Copyright © 2016年 M-coppco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJUnderLineButton : UIButton
/**下划线颜色*/
@property (nonatomic, strong)UIColor  *underLineColor;
/**是否高亮*/
@property (nonatomic, assign)BOOL  highlight;
@end
