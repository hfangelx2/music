//
//  HotsHeaderFlowLayout.m
//  MusicSound
//
//  Created by 大泽 on 15/6/21.
//  Copyright (c) 2015年 刘洪泽. All rights reserved.
//

#import "HotsHeaderFlowLayout.h"

#define itemW 100
#define itemH 100

@implementation HotsHeaderFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


- (void)prepareLayout
{
    [super prepareLayout];
        
    self.itemSize = CGSizeMake(itemW, itemH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat inset = (self.collectionView.frame.size.width - itemW) * 0.5;
    
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    self.minimumLineSpacing = itemW * 0.8;
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.frame.size;
    
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        CGFloat itemCenterX = attr.center.x;
        
        if (!CGRectIntersectsRect(visibleRect, attr.frame)) continue;
        
        CGFloat scale = 1 + 0.3 * (1 - (ABS(centerX - itemCenterX) / 150));
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGRect lastRect;
    
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in array) {
        
        if (ABS(centerX - attr.center.x) < ABS(adjustOffsetX)) {
            adjustOffsetX = attr.center.x - centerX;
        }
        
    }
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}

@end
