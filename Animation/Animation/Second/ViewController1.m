//
//  ViewController.m
//  Animation
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController1.h"
#import <Masonry.h>
#import "UIColor+HJExtension.h"
#import "HJWheelView.h"
#import "HJCoverFlowLayout.h"
#import "HJCollectionViewCell1.h"

#define radio_width(value) (value)
#define radio_height(value) (value)
@interface ViewController1 ()<UICollectionViewDelegate, UICollectionViewDataSource>
/*scrollView*/
@property(nonatomic, strong)UIScrollView *scrollView;
/*imageV*/
@property(nonatomic, strong)HJWheelView *bannerImageV;

/*头条*/
@property(nonatomic, strong)UIImageView *leftImageV;

/*头条*/
@property(nonatomic, strong)UIImageView *rightImageV;
/*文本*/
@property(nonatomic, strong)UILabel *scrollViewL;
/*line*/
@property(nonatomic, strong)UIView *line1;
/*line*/
@property(nonatomic, strong)UIView *line2;
/*totalTopL*/
@property(nonatomic, strong)UILabel *totalTopL;
/*totalTopL*/
@property(nonatomic, strong)UILabel *totalBottomL;
/*personTopL*/
@property(nonatomic, strong)UILabel *personTopL;
/*PersonBottomL*/
@property(nonatomic, strong)UILabel *PersonBottomL;

/*collectionView*/
@property(nonatomic, strong)UICollectionView *collectionView;

/*line3*/
@property(nonatomic, strong)UIView *line3;
/*描述*/
@property(nonatomic, strong)UILabel *descriL;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem: 3 * 10 / 2 inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:false];
}
- (void)setup {
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-49);
    }];
    
    self.bannerImageV = [[HJWheelView alloc] init];
//    self.bannerImageV.isAutoPlay = true;
    self.bannerImageV.imagesA = @[@"home_banner",@"home_banner", @"https://oss-proxy.lianhuanet.com/lianhuanet/basefile/2016-10-13/c5d0d74f-b37b-411a-b09a-b8b6af021da6.jpg?response-content-type=image/jpg", @"https://oss-proxy.lianhuanet.com/lianhuanet/basefile/2016-10-13/a38e0dce-8879-426d-9772-869dbe31cbf9.png?response-content-type=image/png"].mutableCopy;
    [self.scrollView addSubview:self.bannerImageV];
    [self.bannerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(radio_height(180));
    }];
    
    self.leftImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.scrollView addSubview:self.leftImageV];
    self.rightImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.scrollView addSubview:self.rightImageV];
    self.rightImageV.backgroundColor = [UIColor randomColor];
    self.leftImageV.backgroundColor = [UIColor randomColor];
    
    self.scrollViewL = [[UILabel alloc] init];
//    self.scrollViewL.font = [UIFont systemFontOfSize:14];
    self.scrollViewL.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    self.scrollViewL.textColor = [UIColor colorFromHexString:@"666666"];
    self.scrollViewL.text = @"虔诚猫改版啦, 普天同庆, 天降红包大礼等你来拿";
    [self.scrollView addSubview:self.scrollViewL];
    
    [self.scrollViewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerImageV.mas_bottom).offset(12);
        make.height.mas_equalTo(radio_height(14));
    }];
    
    [self.leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.scrollViewL);
        make.left.mas_equalTo(self.view.mas_left).offset(16);
        make.right.mas_equalTo(self.scrollViewL.mas_left).offset(-8);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.centerY.mas_equalTo(self.scrollViewL);
        make.right.mas_equalTo(self.view.mas_right).offset(-16);
        make.left.mas_equalTo(self.scrollViewL.mas_right).offset(8);
    }];
    
    self.line1 = [[UIView alloc] init];
    self.line1.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
    [self.scrollViewL addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.scrollViewL.mas_bottom).offset(12);
    }];
    
    self.totalTopL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"9,999,999,999.00";
        object.textColor = [UIColor colorFromRGBValue:0x333333];
//        object.font = [UIFont systemFontOfSize:16];
        object.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    self.totalBottomL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"平台累计交易额";
        object.textColor = [UIColor colorFromRGBValue:0x999999];
//        object.font = [UIFont systemFontOfSize:14];
       object.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    self.personTopL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"99,999,999";
        object.textColor = [UIColor colorFromRGBValue:0x333333];
//        object.font = [UIFont systemFontOfSize:16];
        object.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    self.PersonBottomL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"累计注册人数";
        object.textColor = [UIColor colorFromRGBValue:0x999999];
//        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:14];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });

    [self.scrollView addSubview:self.personTopL];
    [self.scrollView addSubview:self.totalTopL];
    [self.scrollView addSubview:self.totalBottomL];
    [self.scrollView addSubview:self.PersonBottomL];
    
    [self.totalTopL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line1.mas_bottom).offset(12);
        make.size.top.mas_equalTo(self.personTopL);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.personTopL.mas_left);
        make.height.mas_equalTo(radio_height(15));
    }];
    [self.personTopL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
    }];
    
    [self.totalBottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.totalTopL.mas_bottom).offset(4);
        make.size.top.mas_equalTo(self.PersonBottomL);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.PersonBottomL.mas_left);
        make.height.mas_equalTo(radio_height(14));
    }];
    [self.PersonBottomL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);

    }];
    
    self.line2 = [[UIView alloc] init];
    self.line2.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
    [self.scrollView addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(self.PersonBottomL.mas_bottom).offset(12);
    }];
    
    
    HJCoverFlowLayout *flowLayout = [[HJCoverFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 20;
    flowLayout.itemSize = CGSizeMake((240), (240));
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:(CGRectZero) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
//    self.collectionView.pagingEnabled = true;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[HJCollectionViewCell1 class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem: 8 inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:false];
    [self.scrollView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.line2.mas_bottom);
        make.height.mas_equalTo((281));
    }];
    
    self.line3 = [[UIView alloc] init];
    self.line3.backgroundColor = [UIColor colorWithR:242 G:242 B:242];
    [self.scrollView addSubview:self.line3];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
    }];

    self.descriL = ({
        UILabel *object = [[UILabel alloc] init];
        object.text = @"严格把控, 项目精选";
        object.textColor = [UIColor colorFromRGBValue:0x000000];
        //        object.font = [UIFont systemFontOfSize:14];
        object.font =[UIFont fontWithName:@"PingFangSC-Light" size:16];
        object.textAlignment = NSTextAlignmentCenter;
        object;
    });
    [self.scrollView addSubview:self.descriL];
    [self.descriL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_greaterThanOrEqualTo(self.line3.mas_bottom).offset(12);
        make.height.mas_equalTo(radio_height(16));
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-12);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-12);
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma - mark UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        CGPoint pointInView = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointInView];
        NSInteger index = indexPath.row % 10;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem: 3 * 10 / 2 + index inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:false];
        
    }
//     collectionView.scrollToItem(at: NSIndexPath.init(item: groupCount / 2 * imageArr.count + index, section: 0) as IndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem: 3 * 10 / 2 inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:false];
}
@end
