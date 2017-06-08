//
//  DetailViewController.h
//  iCarouselDemo
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface DetailViewController : UIViewController

@property(nonatomic, strong)NSArray *movies;
/*c*/
@property(nonatomic, assign)NSInteger index;
@end
