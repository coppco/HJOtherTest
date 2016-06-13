//
//  TableViewModel.h
//  UITableVlewDemo
//
//  Created by 陆巧怡 on 15/10/18.
//  Copyright © 2015年 Simon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewModel : NSObject
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *type;

+ (instancetype) feedWithDictionary:(NSDictionary *) dictionary;

- (instancetype) initWithDictionary:(NSDictionary *) dictionary;
@end
