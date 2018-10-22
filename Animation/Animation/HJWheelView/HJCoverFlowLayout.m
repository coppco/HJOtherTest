//
//  HJCoverFlowLayout.m
//  DevoutCat
//
//  Created by apple on 2017/3/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HJCoverFlowLayout.h"

@implementation HJCoverFlowLayout
- (instancetype)init {
    self = [super init];
    if (self) {
        self.verticalCoefficient = 400;
        self.scaleCoefficient = .1;
    }
    return self;
}

//滑动放大缩小时, 是否实时刷新
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

//布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:true];
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat zoom = 1 - fabs((visibleRect.origin.x + visibleRect.size.width / 2 - attributes.center.x) / _verticalCoefficient) * _scaleCoefficient;
        attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1);
        attributes.zIndex = 1;
    }
    return array;
}

//返回最终停留位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    //目标区域包含的cell
    NSArray *array = [[NSArray alloc] initWithArray:[self layoutAttributesForElementsInRect:targetRect] copyItems:true];
    
    // collectionView落在屏幕中点的x坐标
    CGFloat horizontalCenterX = proposedContentOffset.x + (self.collectionView.bounds.size.width / 2.0);
    
    CGFloat offsetAdjustment = MAXFLOAT;
    //离中心最近的view
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (fabs(attributes.center.x - horizontalCenterX) < fabs(offsetAdjustment)) {
            offsetAdjustment = attributes.center.x - horizontalCenterX;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
