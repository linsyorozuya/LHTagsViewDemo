//
//  TagTableViewCell.h
//  LHTagsViewDemo
//
//  Created by Lin on 2016/11/4.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHTagsView.h"

@interface TagTableViewCell : UITableViewCell<LHTagsViewDelegate>

@property (weak, nonatomic) IBOutlet LHTagsView *tagsView;
@property (nonatomic,strong) NSMutableArray *tags_array;

@end
