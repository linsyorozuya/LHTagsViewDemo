//
//  LHTagsView.h
//  LHTagsViewDemo
//
//  Created by Lin on 16/8/23.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHTagsViewDelegate <NSObject>

- (void) tapTagAtIndex:(NSInteger)tagIndex;
- (void) clearDataSourse;

@end

@interface LHTagsView : UIView

@property (nonatomic,weak) id<LHTagsViewDelegate> delegate;
@property (nonatomic,assign) BOOL isShowHeader;
@property (nonatomic,strong) NSMutableArray *dataSource;

- (void) insertCellAtLast:(NSString *)tag;
- (void) deleteLastCell;

@end
