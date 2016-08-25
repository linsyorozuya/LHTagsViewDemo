//
//  ViewController.m
//  LHTagsViewDemo
//
//  Created by Lin on 16/8/23.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<LHTagsViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tagsView.dataSource = [@[@"less is more less is morelessless is moreless"] mutableCopy];
    _tagsView.isShowHeader = NO;

}

#pragma mark - LHTagsViewDelegate
- (void)tapTagAtIndex:(NSInteger)tagIndex
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你点击了" message:@(tagIndex).stringValue  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (void)clearDataSourse
{
    //清空所有数据
}

- (IBAction)addClick:(id)sender
{
    [_tagsView insertCellAtLast:_tagsView.dataSource.count %2 == 0? @"tag" :@"less is moreless less is moreless"];
}

- (IBAction)deleteClick:(id)sender
{
    [_tagsView deleteLastCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
