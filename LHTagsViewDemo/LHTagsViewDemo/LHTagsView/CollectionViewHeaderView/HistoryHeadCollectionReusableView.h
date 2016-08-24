//
//  HistoryHeadCollectionReusableView.h
//  HappyStudy
//
//  Created by Lin on 16/8/22.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionReusableViewButtonDelegate<NSObject>
- (void) delectData;
@end

@interface HistoryHeadCollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) id<UICollectionReusableViewButtonDelegate> delectDelegate;

- (void) setText:(NSString*)text;
- (void) setImage:(NSString *)image;

@end
