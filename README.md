# LHTagsViewDemo

利用 CollectionView 实现标签视图

详情见 [这里](http://linbling.com/uicollectionview-shi-xian-biao-qian-gong-neng/)


![gif](https://github.com/linsyorozuya/LHTagsViewDemo/blob/master/LHTagsViewDemo/2016-08-24%2009_22_04.gif)

#### 使用

    _tagsView.dataSource = [@[@"tag",@"tag",@"tag",@"tag",@"tag"] mutableCopy]; // 设置数据源并更新显示
    _tagsView.isShowHeader = NO;// 是否显示头部视图
    [_tagsView insertCellAtLast:@"less is more"]; // 尾部最后插入数据
    [_tagsView deleteLastCell]; // 删除尾部的最后一个数据
