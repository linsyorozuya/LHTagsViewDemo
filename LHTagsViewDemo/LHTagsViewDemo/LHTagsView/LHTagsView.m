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
#import "TagsStyleLayout.h"

static CGFloat kDefaultCellHeight = 24;

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
    _cell_height = kDefaultCellHeight;
    _cellBackgroud_color = [UIColor colorWithWhite:0.957 alpha:1.000];
    
    [self addSubview:self.tags_CollectionView];
}

/** 适应布局变换 */
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_tags_CollectionView.collectionViewLayout;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, !_isShowHeader? 0:50);
    [layout invalidateLayout];
    
    _tags_CollectionView.frame = self.bounds;
    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
        [self invalidateIntrinsicContentSize];
    }
}

- (CGSize)intrinsicContentSize
{
    NSLog(@"height---%f",_tags_CollectionView.collectionViewLayout.collectionViewContentSize.height);
    return _tags_CollectionView.collectionViewLayout.collectionViewContentSize;
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
    
    [self invalidateIntrinsicContentSize];
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
    [self invalidateIntrinsicContentSize];

}

#pragma mark - setter & getter
- (void)setIsShowHeader:(BOOL)isShowHeader
{
    _isShowHeader = isShowHeader;
    UICollectionViewLeftAlignedLayout *layout = (UICollectionViewLeftAlignedLayout *)_tags_CollectionView.collectionViewLayout;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, !_isShowHeader? 0:50);
    [layout invalidateLayout];
    [self invalidateIntrinsicContentSize];
}

- (void) setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [_tags_CollectionView reloadData];
    [self invalidateIntrinsicContentSize];
}

- (CGFloat) cell_height
{
    return (_cell_height == 0 ?kDefaultCellHeight:_cell_height);
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
    if (_cellText_color) {
        cell.tagLabel.textColor = _cellText_color;
    }
    
    CGFloat cornerRadius = _cell_height/2.0;
    
    // cell的背景view
    cell.backgroundView = [self drawConnerView:cornerRadius rect:cell.bounds backgroudColor:_cellBackgroud_color];
    
    return cell;
}

/** 绘画圆角 解决卡顿*/
-(UIView *)drawConnerView:(CGFloat)cornerRadius rect:(CGRect)frame backgroudColor:(UIColor *)backgroud_color
{
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(frame, 0, 0);
    // 初始起点为cell的左下角坐标
    CGPathMoveToPoint(pathRef, nil, CGRectGetMidX(bounds), CGRectGetMaxY(bounds));
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMinX(bounds), CGRectGetMinY(bounds), cornerRadius);
    // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
    //    CGPathAddLineToPoint(pathRef, nil, CGRectGetMidX(bounds), CGRectGetMaxY(bounds));
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = backgroud_color.CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    
    return roundView;
}

#pragma mark <UICollectionViewDelegate>
//返回cell的宽和高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [HistoryCollectionViewCell getSizeWithContent:_dataSource[indexPath.row] maxWidth:_tags_CollectionView.frame.size.width customHeight:self.cell_height];
}

//返回头尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HistoryHeadCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HistoryHeadCollectionReusableView" forIndexPath:indexPath];
//        view.backgroundColor = [UIColor lightGrayColor];
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
    [self invalidateIntrinsicContentSize];
}

@end
