//
//  HistoryCollectionViewCell.m
//  HappyStudy
//
//  Created by Lin on 16/8/22.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "HistoryCollectionViewCell.h"

@implementation HistoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_tagLabel.layer setMasksToBounds:YES];
    [_tagLabel.layer setCornerRadius:12.0];
    [_tagLabel setBackgroundColor:[UIColor colorWithWhite:0.957 alpha:1.000]];
}

- (void)setContent:(NSString *)content
{
    _content = content;
    [_tagLabel setText:content];
}

+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize size = [content boundingRectWithSize:CGSizeMake(maxWidth-20, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, 24);
}


@end
