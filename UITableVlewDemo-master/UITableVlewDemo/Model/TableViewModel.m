//
//  TableViewModel.m
//  UITableVlewDemo
//
//  Created by 陆巧怡 on 15/10/18.
//  Copyright © 2015年 Simon. All rights reserved.
//

#import "TableViewModel.h"

@implementation TableViewModel



+ (instancetype) feedWithDictionary:(NSDictionary *) dictionary{
    
    return [[self alloc]initWithDictionary:dictionary];
}

- (instancetype) initWithDictionary:(NSDictionary *) dictionary{
    
    self = [super init];
    
    if (self) {
        
        self.title = dictionary[@"title"];
        self.content = dictionary[@"content"];
        self.username = dictionary[@"username"];
        self.time = dictionary[@"time"];
        self.imageName = dictionary[@"imageName"];
        self.icon = dictionary[@"icon"];
        self.type = dictionary[@"type"];
    }
    
    return self;
}
@end
