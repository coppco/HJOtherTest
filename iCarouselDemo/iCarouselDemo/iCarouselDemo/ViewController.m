//
//  ViewController.m
//  iCarouselDemo
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import <iCarousel.h>
#import <AFNetworking.h>
#import "Movie.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "DetailViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kHotUrl @"http://api.douban.com/v2/movie/in_theaters?count=100&udid=b6dcdfae53dd3e58ba9610bdf8e2e3cc40e3134b&start=0&client=s%3Amobile%7Cy%3AAndroid+4.4.2%7Co%3AKHHCNBF5.0%7Cf%3A70%7Cv%3A2.7.4%7Cm%3AWanDouJia_Parter%7Cd%3A865983026114430%7Ce%3AXiaomi+HM2014501&apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E4%B8%8A%E6%B5%B7"

@interface ViewController ()<iCarouselDelegate, iCarouselDataSource>
@property (nonatomic, strong)iCarousel *iCarouselView;
@property(nonatomic, strong)NSMutableArray *models;
@property(nonatomic, strong)UIImageView *backImageV;
/*type*/
@property(nonatomic, assign)NSInteger type;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更换" style:(UIBarButtonItemStyleDone) target:self action:@selector(change:)];
    self.type = 2;
    
    [self getHotData];
}

- (void)change:(UIBarButtonItem *)item {
    self.type++;
    if (self.type > 11) {
        self.type = 0;
    }
    self.iCarouselView.type = self.type;
}

- (void)getHotData {
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"model"]) {
//        self.models = [Movie mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"model"]];
//        [self setupUI];
//        return;
//    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:kHotUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[NSUserDefaults standardUserDefaults] setObject:responseObject[@"subjects"] forKey:@"model"];
        NSArray *models = [Movie mj_objectArrayWithKeyValuesArray:responseObject[@"subjects"]];
//        NSLog(@"%@", responseObject);
//        for (Movie *model in models) {
//            if (self.models.count < 3) {
//                [self.models addObject:model];
//            }
//        }
        self.models = models;
        [self setupUI];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)setupUI {
    [self.view addSubview:self.backImageV];
    [_backImageV sd_setImageWithURL:[NSURL URLWithString:((Movie *)self.models[0]).images.large]];
    [self.view addSubview:self.iCarouselView];
}

#pragma - mark 懒加载
- (iCarousel *)iCarouselView {
    if (!_iCarouselView) {
        _iCarouselView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kWidth, 400)];
//        _iCarouselView.type = 5; //扇形
//        _iCarouselView.type = 3;  //圆筒形状
//        _iCarouselView.type = 2;
        _iCarouselView.type = iCarouselTypeRotary;
//        iCarouselTypeWheel  轮子
        
        _iCarouselView.delegate = self;
        _iCarouselView.dataSource = self;
        _iCarouselView.pagingEnabled = true;
        _iCarouselView.scrollOffset = 0;
    }
    return _iCarouselView;
}
- (UIImageView *)backImageV {
    if (!_backImageV) {
        _backImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, _backImageV.frame.size.width, _backImageV.frame.size.height)];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        [_backImageV addSubview:toolbar];
    }
    return _backImageV;
}
- (NSMutableArray *)models {
    if (!_models) {
        _models = [NSMutableArray arrayWithCapacity:3];
    }
    return _models;
}
#pragma - mark Delegate DataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel * __nonnull)carousel {
    return (self.models.count);
}
- (UIView *)carousel:(iCarousel * __nonnull)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    Images *image = ((Movie *)self.models[index]).images;
    
    if (view == nil) {
        view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 50 , 220 ,  300 )];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50 , 220 , 300)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:image.large]];
    [view addSubview:imageView];
    return view;
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    if (self.iCarouselView.scrollOffset == self.models.count) {
        self.iCarouselView.scrollOffset = self.models.count - 1;
    }
    
    Images *image = ((Movie *)self.models[(NSInteger)self.iCarouselView.scrollOffset]).images;
    
    [self.backImageV sd_setImageWithURL:[NSURL URLWithString:image.large]];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.movies = self.models;
    vc.index = index;
    [self.navigationController pushViewController:vc animated:true];
}

@end
