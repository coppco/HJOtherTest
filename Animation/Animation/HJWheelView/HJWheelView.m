//
//  HJWheelView.m
//  HJOrange
//
//  Created by apple on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJWheelView.h"
#import "UIImageView+WebCache.h"
//#import "HJCoverFlowLayout.h"

//CollectionView重用标示符
NSString *const kReusedCollectionViewCell_identifier = @"reusedCollectionViewCell_identifier";
//默认轮播图时间
NSTimeInterval defaultTimeInterval = 3.0;
@interface HJWheelView ()<UICollectionViewDelegate, UICollectionViewDataSource>
/*集合视图*/
@property(nonatomic, strong)UICollectionView *collectionView;
/*layout*/
@property(nonatomic, strong)UICollectionViewFlowLayout *layout;
/*customerFlow*/
//@property(nonatomic, strong)HJCoverFlowLayout *customerFlow;
/*pageControl*/
@property(nonatomic, strong)UIPageControl *pageControl;
/*timer*/
@property(nonatomic, strong)NSTimer *timer;
@end

@implementation HJWheelView
#pragma - mark init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.imagesA = [NSMutableArray array];
    [self addSubview:self.collectionView];
    self.pageControl.frame = CGRectMake(0, 0, self.frame.size.width / 2, 20);
    [self addSubview:self.pageControl];

}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = ({
            UICollectionView *object = [[UICollectionView alloc] initWithFrame:(CGRectZero) collectionViewLayout:self.layout];
            object.pagingEnabled = true;
            object.showsVerticalScrollIndicator = false;
            object.showsHorizontalScrollIndicator = false;
            object.delegate = self;
            object.dataSource = self;
            object.backgroundColor = [UIColor whiteColor];
            [object registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReusedCollectionViewCell_identifier];
            object.contentInset = UIEdgeInsetsZero;
            object;
        });
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = ({
            UICollectionViewFlowLayout *object = [[UICollectionViewFlowLayout alloc] init];
            object.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//            object.itemSize = self.frame.size;
            object.itemSize = CGSizeMake(1, 1);
            object.minimumLineSpacing = 0;
            object.minimumInteritemSpacing = 0;
            object.sectionInset = UIEdgeInsetsZero;
            object;
        });
    }
    return _layout;
}

#pragma - mark UICollectionViewDelegate、UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesA.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusedCollectionViewCell_identifier forIndexPath:indexPath];
    UIImageView *imageV = nil;
    if ([cell.backgroundView isKindOfClass:[UIImageView class]]) {
        imageV = (UIImageView *)cell.backgroundView;
    } else {
        imageV = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        cell.backgroundView = imageV;
    }
    NSString *imageURL = self.imagesA[indexPath.item];
    
    if ([imageURL hasPrefix:@"http"]) {
        [imageV sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"home_banner"]];
    } else {
        imageV.image = [UIImage imageNamed:imageURL];
    }
    
    return cell;
}

#pragma - mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isAutoPlay) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isAutoPlay) {
        [self startTimer];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat page = (scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width;
    if (self.isAutoPlay) {
        return;
    }
    if (page < 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages - 1;
    } else {
        self.pageControl.currentPage = page;
    }

    if (page < -0.5) {
        [scrollView setContentOffset:(CGPointMake((self.imagesA.count - 1) * scrollView.frame.size.width, scrollView.contentOffset.y)) animated:false];
    } else if (page > self.imagesA.count - 1.5) {
        [scrollView setContentOffset:(CGPointMake(0, scrollView.contentOffset.y)) animated:false];
    }
}

#pragma - mark getter、setter
- (void)setIsCustomer:(BOOL)isCustomer {
    if (_isCustomer != isCustomer) {
        _isCustomer = isCustomer;
        if (_isCustomer) {
            
        } else {
            
        }
    }
}
- (void)setImagesA:(NSMutableArray *)imagesA {
    if (_imagesA != imagesA) {
        _imagesA = imagesA;
        if (imagesA.count != 0 && imagesA != nil) {
            [_imagesA insertObject:imagesA.lastObject atIndex:0];
        }
        self.pageControl.numberOfPages = _imagesA.count - 1;
        self.pageControl.currentPage = 0;
        [self.collectionView reloadData];
    }
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = ({
            UIPageControl *object = [[UIPageControl alloc] init];
            object.currentPage = 0;
            object.currentPageIndicatorTintColor = [UIColor greenColor];
            object.pageIndicatorTintColor = [UIColor blueColor];
            object;
        });
    }
    return _pageControl;
}
- (NSTimer *)timer {
    if (!_timer) {
        _timer = ({
            NSTimer *object = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval != 0 ?: defaultTimeInterval  target:self selector:@selector(timer:) userInfo:nil repeats:true];
            [[NSRunLoop currentRunLoop] addTimer:object forMode:NSRunLoopCommonModes];
            object;
        });
    }
    return _timer;
}
//- (HJCoverFlowLayout *)customerFlow {
//    if (!_customerFlow) {
//        _customerFlow = ({
//            HJCoverFlowLayout *object = [[HJCoverFlowLayout alloc] init];
//            object;
//        });
//    }
//    return _customerFlow;
//}
- (void)setIsAutoPlay:(BOOL)isAutoPlay {
    _isAutoPlay = isAutoPlay;
    if (_isAutoPlay) {
        [self.timer invalidate];
        self.timer = nil;
        [self startTimer];
    } else {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    if (self.isAutoPlay) {
        [self.timer invalidate];
        self.timer = nil;
        [self startTimer];
    }
}
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval != 0 ?: defaultTimeInterval  target:self selector:@selector(timer:) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 定时器执行方法
 */
- (void)timer:(NSTimer *)timer {
    CATransition *animation = [CATransition animation];
    animation.duration = 1;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromRight;
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.collectionView.layer addAnimation:animation forKey:@"animation"];

    
    CGPoint offset = self.collectionView.contentOffset;
    if (offset.x >= (self.imagesA.count - 1) * self.collectionView.frame.size.width) {
        [self.collectionView setContentOffset:CGPointMake(0, offset.y) animated:false];
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width, offset.y) animated:false];
        self.pageControl.currentPage = 0;
    } else {
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width + offset.x, offset.y) animated:false];
        self.pageControl.currentPage = self.pageControl.currentPage + 1;
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.layout.itemSize = self.bounds.size;
    self.pageControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 20);
    self.collectionView.contentOffset = CGPointMake(self.collectionView.frame.size.width, 0);
}
@end
