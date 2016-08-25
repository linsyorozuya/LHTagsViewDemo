//
//  TagsStyleLayout.m
//  HappyStudy
//
//  Created by Lin on 16/8/22.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "TagsStyleLayout.h"

@implementation TagsStyleLayout

- (NSArray <__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 获取所有元素的 layout 属性
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSMutableArray *attributesCopyArray = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        UICollectionViewLayoutAttributes* attributeCopy = [attribute copy];
        [attributesCopyArray addObject:attributeCopy];
    }
    
    // 根据元素个数处理位置
    switch (attributesCopyArray.count)
    {
        case 0:
            break;
            
        case 1: // 处理没有 header 和 footer 且只有一个的 cell 的情况
        {
            UICollectionViewLayoutAttributes *currentAttribute = attributesCopyArray[0];
            CGRect frame = currentAttribute.frame;
            frame.origin.x = 0;
            currentAttribute.frame = frame;
            break;
        }

        default: // 处理有 header 和 footer 的情况
        {
            for (int i = 1; i < attributesCopyArray.count; i++) {
                UICollectionViewLayoutAttributes *preLayoutAttribute = attributesCopyArray[i-1];
                UICollectionViewLayoutAttributes *currentLayoutAttribute = attributesCopyArray [i];
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
                
                // 对最后一行做左对齐处理
                if (i == attributesCopyArray.count - 1)
                {
                    if ( currentY != preY )
                    {
                        CGRect frame = currentLayoutAttribute.frame;
                        frame.origin.x = 0;
                        currentLayoutAttribute.frame = frame;
                    }
                }
                
                // 处理一行一个 cell 的情况，左对齐
                if (i +1 < attributesCopyArray.count )
                {
                    UICollectionViewLayoutAttributes *nextLayoutAttribute = attributesCopyArray [i+1];
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
                    if (originX + minimumInteritemSpacing + currentLayoutWidth < self.collectionViewContentSize.width)
                    {
                        CGRect frame = currentLayoutAttribute.frame;
                        frame.origin.x = originX + minimumInteritemSpacing;
                        currentLayoutAttribute.frame = frame;
                    }
                }
            }
        }
        break;
    }
    return attributesCopyArray;
}

@end
