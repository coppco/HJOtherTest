//
//  Movie.h
//  iCarouselDemo
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Images : NSObject
    @property(nonatomic, copy)NSString *small;
    @property(nonatomic, copy)NSString *large;
    @property(nonatomic, copy)NSString *medium;
    @end

@interface Movie : NSObject
    
    @property(nonatomic, copy)NSString *title;
    @property(nonatomic, strong)Images *images;
    
@end

