//
//  Movie.m
//  iCarouselDemo
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "Movie.h"
#import <MJExtension.h>

@implementation Images


@end

@implementation Movie

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"images":@"Image"
             };
}
    
@end
