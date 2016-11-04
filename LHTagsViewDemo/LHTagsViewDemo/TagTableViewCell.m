//
//  TagTableViewCell.m
//  LHTagsViewDemo
//
//  Created by Lin on 2016/11/4.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "TagTableViewCell.h"

@implementation TagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _tagsView.delegate = self;
    _tagsView.isShowHeader = NO;
}

- (void) setTags_array:(NSMutableArray *)tags_array
{
    _tags_array = tags_array;
    _tagsView.dataSource = tags_array;
}

- (void) tapTagAtIndex:(NSInteger)tagIndex
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你点击了" message:@(tagIndex).stringValue  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
