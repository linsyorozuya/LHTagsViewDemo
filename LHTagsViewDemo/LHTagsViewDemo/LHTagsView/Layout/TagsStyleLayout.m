//
//  TagsStyleLayout.m
//  HappyStudy
//
//  Created by Lin on 16/8/22.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "TagsStyleLayout.h"

@implementation TagsStyleLayout

- (void) prepareLayout
{
    [super prepareLayout];
//    self.sectionInset = UIEdgeInsetsMake(0, 14, 0, 14);
    self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, !_isShowHeader? 0:50);
//    self.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 60);
    self.minimumInteritemSpacing = 15;
}

- (void) setIsShowHeader:(BOOL)isShowHeader
{
    _isShowHeader = isShowHeader;
    [self prepareLayout];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获取所有元素的 layout 属性
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

    // 根据元素个数处理位置
    switch (attributes.count)
    {
        case 0:
            break;
            
        case 1: // 处理没有 header 和 footer 且只有一个的 cell 的情况
        {
            UICollectionViewLayoutAttributes *currentAttribute = attributes[0];
            CGRect frame = currentAttribute.frame;
            frame.origin.x = 0;
            currentAttribute.frame = frame;
            break;
        }

        default: // 处理两个以上 cell 的情况
        {
            for (int i = 1; i < attributes.count; i++) {
                UICollectionViewLayoutAttributes *preLayoutAttribute = attributes[i-1];
                UICollectionViewLayoutAttributes *currentLayoutAttribute = attributes [i];
                CGFloat preY = CGRectGetMaxY(preLayoutAttribute.frame);
                CGFloat currentY = CGRectGetMaxY(currentLayoutAttribute.frame);
                
                // 对第一行做左对齐处理
                if (i == 1)
                {
                    if ( preY != currentY )
                    {
                        CGRect frame = preLayoutAttribute.frame;
                        frame.origin.x = 0;
                        preLayoutAttribute.frame = frame;
                    }
                }
                
                // 处理一行一个 cell 的情况，左对齐
                if (i +1 < attributes.count )
                {
                    UICollectionViewLayoutAttributes *nextLayoutAttribute = attributes [i+1];
                    CGFloat nextY = CGRectGetMaxY(nextLayoutAttribute.frame);
                    
                    // 如果最后一个是 header
                    if (nextY < currentY) nextY = currentY +100;
                    
                    if (preY < currentY && currentY < nextY) {
                        CGRect frame = currentLayoutAttribute.frame;
                        frame.origin.x = 0;
                        currentLayoutAttribute.frame = frame;
                    }
                }
                
                // 同一行多个 cell
                if (preLayoutAttribute.indexPath.section == currentLayoutAttribute.indexPath.section)
                {
                    CGFloat minimumInteritemSpacing = 15;
                    CGFloat originX = CGRectGetMaxX(preLayoutAttribute.frame);
                    CGFloat currentLayoutWidth = CGRectGetWidth(currentLayoutAttribute.frame);
                    if (originX + minimumInteritemSpacing + currentLayoutWidth < self.collectionViewContentSize.width ) {
                        CGRect frame = currentLayoutAttribute.frame;
                        frame.origin.x = originX + minimumInteritemSpacing;
                        currentLayoutAttribute.frame = frame;
                    }
                }
            }
        }
        break;
    }
    
    return attributes;
}

@end
