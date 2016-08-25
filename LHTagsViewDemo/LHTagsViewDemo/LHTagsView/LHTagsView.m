//
//  LHTagsView.m
//  LHTagsViewDemo
//
//  Created by Lin on 16/8/23.
//  Copyright © 2016年 Lin. All rights reserved.
//

#import "LHTagsView.h"
#import "HistoryCollectionViewCell.h"
#import "HistoryHeadCollectionReusableView.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface LHTagsView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionReusableViewButtonDelegate>

@property (strong ,nonatomic) UICollectionView *tags_CollectionView;

@end

@implementation LHTagsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setUp];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

/** 初始化配置 */
- (void) setUp
{
    _isShowHeader = YES;
    [self addSubview:self.tags_CollectionView];
}

/** 适应布局变换 */
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _tags_CollectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_tags_CollectionView.collectionViewLayout;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, !_isShowHeader? 0:50);
    [layout invalidateLayout];
}

/** 添加 */
- (void) insertCellAtLast:(NSString *)tag
{
    [_dataSource addObject:tag];
    // 处理没有 cell 数据的情况
    if (_dataSource.count == 1)
    {
        [_tags_CollectionView insertSections:[NSIndexSet indexSetWithIndex:0]];
    }else
    {
        [_tags_CollectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_dataSource.count-1 inSection:0]]];
    }
}

/** 删除 */
- (void) deleteLastCell
{
    if (_dataSource.count == 0) {
        return;
    }
    
    NSIndexPath *lastIndex = [NSIndexPath indexPathForItem:_dataSource.count-1 inSection:0];
    [_dataSource removeLastObject];

    // 处理删除最后一个 cell 的情况
    if (_dataSource.count == 0)
    {
        [_tags_CollectionView deleteSections:[NSIndexSet indexSetWithIndex:lastIndex.section]];
    }else
    {
        [_tags_CollectionView deleteItemsAtIndexPaths:@[lastIndex]];
    }
    
}

#pragma mark - setter & getter
- (void) setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [_tags_CollectionView reloadData];
}

- (UICollectionView *) tags_CollectionView
{
    if (!_tags_CollectionView) {
        // collectionview
        _tags_CollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:[[UICollectionViewLeftAlignedLayout alloc] init]];
        _tags_CollectionView.dataSource = self;
        _tags_CollectionView.delegate = self;
        _tags_CollectionView.backgroundColor = self.backgroundColor;
        [_tags_CollectionView registerNib:[UINib nibWithNibName:@"HistoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HistoryCollectionViewCell"];
        [_tags_CollectionView registerClass:[HistoryHeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HistoryHeadCollectionReusableView"];
    }
    return _tags_CollectionView;
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
//返回section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count == 0? 0:1;
}

//返回section中的cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HistoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HistoryCollectionViewCell" forIndexPath:indexPath];
    cell.content = _dataSource[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//返回cell的宽和高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [HistoryCollectionViewCell getSizeWithContent:_dataSource[indexPath.row]];
}

//返回头尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HistoryHeadCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HistoryHeadCollectionReusableView" forIndexPath:indexPath];
        [view setText:@"搜索历史"];
        [view setImage:@"searchHistory"];
        view.delectDelegate = self;
        reusableview = view;
    }
    return reusableview;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate tapTagAtIndex:indexPath.row];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData
{
    [_dataSource removeAllObjects];
    [_tags_CollectionView reloadData];
    [self.delegate clearDataSourse];
}

@end
