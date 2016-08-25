//
//  HistoryCollectionViewCell.h
//  HappyStudy
//
//  Created by Lin on 16/8/22.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HistoryCollectionViewCell : UICollectionViewCell

@property (nonatomic,copy) NSString *content;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

+ (CGSize) getSizeWithContent:(NSString *) content maxWidth:(CGFloat)maxWidth;

@end
