//
//  HJWebVController.h
//  DevoutCat
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJWebVController : UIViewController
/*url地址*/
@property(nonatomic, copy)NSString *urlString;

/*body*/
@property(nonatomic, strong)NSDictionary *body;
@end

