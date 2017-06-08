//
//  DetailViewController.m
//  iCarouselDemo
//
//  Created by apple on 2017/2/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailViewController.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "Movie.h"
#import <MJExtension.h>

//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UIScrollView *mainScrollView;
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIScrollView *detailScrollView;
/*图片*/
@property(nonatomic, strong)UIImageView *imageV;

/*文本*/
@property(nonatomic, strong)UILabel *textL;

/*弹出框*/
@property(nonatomic, strong)UIMenuController *sharedMenuVC;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情页面";
    [self setup];
}

- (void)setup {
    [self.mainScrollView addSubview:self.detailScrollView];
    [self.mainScrollView addSubview:self.tableView];
    [self.view addSubview:self.mainScrollView];
    
    self.detailScrollView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            //            self.scrollV.contentOffset = CGPointMake(0, IPHONE_H);
            [_mainScrollView setContentOffset:CGPointMake(0, self.view.frame.size.height)];
            
        } completion:^(BOOL finished) {
            //结束加载
            [self.detailScrollView.mj_footer endRefreshing];
        }];
    }];
    
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            //            self.scrollV.contentOffset = CGPointMake(0, IPHONE_H);
            [_mainScrollView setContentOffset:CGPointMake(0, 0)];
            
        } completion:^(BOOL finished) {
            //结束加载
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    Images *images = ((Movie *)self.movies[self.index]).images;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:images.large] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error == nil && image != nil) {
            self.textL.text = [NSString stringWithFormat:@"大图图片大小: %@\n\n大图地址:\t%@\n\n中图地址:\t%@\n\n小图地址:\t%@", NSStringFromCGSize(image.size), images.large, images.medium, images.small];
        }
    }];
}

#pragma - mark 懒加载
- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        _mainScrollView.pagingEnabled = true;
        _mainScrollView.scrollEnabled = false;
        _mainScrollView.bounces = true;
        _mainScrollView.backgroundColor = [UIColor greenColor];
        _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 3 - 64);
    }
    return _mainScrollView;
}
- (UIScrollView *)detailScrollView {
    if (!_detailScrollView) {
        _detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        _detailScrollView.pagingEnabled = false;
        _detailScrollView.bounces = true;
        
        [_detailScrollView addSubview:self.imageV];
        self.imageV.frame = _detailScrollView.bounds;
        
        _detailScrollView.backgroundColor = [UIColor whiteColor];
        [_detailScrollView addSubview:self.textL];
        self.textL.mj_x = 0;
        self.textL.mj_y = [UIScreen mainScreen].bounds.size.height;
        self.textL.mj_w = [UIScreen mainScreen].bounds.size.width;
        self.textL.mj_h = [UIScreen mainScreen].bounds.size.height;
        
        _detailScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2);
    }
    return _detailScrollView;
}
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = ({
            UIImageView *object = [[UIImageView alloc] init];
            object.contentMode = UIViewContentModeScaleAspectFit;
            object;
        });
    }
    return _imageV;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UILabel *)textL {
    if (!_textL) {
        _textL = ({
            UILabel *object = [[UILabel alloc] init];
            object.textColor = [UIColor blackColor];
            object.numberOfLines = 0;
            object.userInteractionEnabled = true;
            UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
            tap.minimumPressDuration = 0.8;
            [object addGestureRecognizer:tap];
            object;
        });
    }
    return _textL;
}
- (UIMenuController *)sharedMenuVC {
    if (!_sharedMenuVC) {
        _sharedMenuVC = ({
            UIMenuController *object = [[UIMenuController alloc] init];

//            UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"copy" action:@selector(copy:)];
//            object.menuItems = @[copy];
            object;
        });
    }
    return _sharedMenuVC;
}
- (void)copy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.textL.text;
}
- (void)tapPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.sharedMenuVC setTargetRect:[UIScreen mainScreen].bounds inView:self.textL];
        [self.sharedMenuVC setMenuVisible:true animated:true];
    }
}
- (BOOL)canBecomeFirstResponder {
    return true;
}
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    NSArray* array = @[@"copy:",@"cut:",@"select:",@"selectAll:",@"paste:"];
//    if ([array containsObject:NSStringFromSelector(action)]) {
//        return YES;
//    }
//    return [super canPerformAction:action withSender:sender];
//}
#pragma - mark Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:((Movie *)self.movies[indexPath.row]).images.medium] placeholderImage:[UIImage imageNamed:@"logo.jpg"]];
    cell.textLabel.text = ((Movie *)self.movies[indexPath.row]).title;
    return  cell;
}
@end
