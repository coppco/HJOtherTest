//
//  NSObject+Caculator.m
//  ReactiveCocoaDemo
//
//  Created by coco on 16/5/13.
//  Copyright © 2016年 XHJ. All rights reserved.
//

#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"
@implementation NSObject (Caculator)
+ (CGFloat)makeCaculators:(void(^)(CaculatorMaker *))block; {
    CaculatorMaker *maker = [[CaculatorMaker alloc] init];
    block(maker);
    return maker.result;
}
@end
