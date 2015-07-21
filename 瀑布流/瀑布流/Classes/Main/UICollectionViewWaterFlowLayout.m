//
//  UICollectionViewWaterFlowLayout.m
//  瀑布流
//
//  Created by 孙硕磊 on 7/21/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "UICollectionViewWaterFlowLayout.h"

static const CGFloat MARGIN=10.0f;
static const NSInteger COLUM_NUM=3;


struct ColumItem
{
    NSInteger colum;
    CGFloat   height;
};


@interface UICollectionViewWaterFlowLayout ()
{
    NSArray * _attrs;
    NSMutableArray * _heights;
}
@end

@implementation UICollectionViewWaterFlowLayout

/*
   准备布局时调用，一般情况下当调用collectionView的reloadData刷新时调用。可以在该方法中初始化一些必要的数据
 */
-(void) prepareLayout
{
    [super prepareLayout];
    
    //初始化数据
    _heights=[NSMutableArray arrayWithCapacity:COLUM_NUM];
    for (int i=0; i<COLUM_NUM; i++)
    {
        _heights[i]=@0.0f;
    }
    
    //获取collectionView中子控件个数,默认只有一组
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:count];
    //将每个子控件的排布属性添加到数组中
    for (int i=0; i<count; i++)
    {
        NSIndexPath * indexPath=[NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * attr=[self layoutAttributesForItemAtIndexPath:indexPath];
        [arr addObject:attr];
    }
    _attrs=arr;
}



/*
   返回collectionView上所有子控件的排布(cell,补充视图，装饰视图)属性
   该方法会频繁调用，应该先计算好所有的布局属性
 */
-(NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{
       return _attrs;
}
/*
   返回指定位置的子控件布局属性，一个子控件对应一个排布属性
 */
-(UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*此处不能采用alloc、init生成实例对象，因为控件可能为cell，补充视图或装饰视图;
     若通过alloc、init方法创建实例，系统并不知道该熟悉为那种控件类型s
     */
    UICollectionViewLayoutAttributes * attr=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width=(self.collectionView.frame.size.width-(COLUM_NUM+1)*MARGIN)/COLUM_NUM;
    CGFloat height=100+arc4random_uniform(100);
    
    struct ColumItem item=[self getMinCloumHeight];
    CGFloat x=(item.colum+1)*MARGIN+item.colum*width;
    CGFloat y=item.height+MARGIN;
    
    attr.frame=CGRectMake(x,y,width,height);
    //更新
    _heights[item.colum]=@(item.height+MARGIN+height);
    return attr;
}


/*
  返回collectionView的滚动区域
 */
-(CGSize) collectionViewContentSize
{
    struct ColumItem item=[self getMaxCloumHeight];
    return CGSizeMake(0, item.height);
}

/*
   辅助函数
 */
-(struct ColumItem) getMinCloumHeight
{
    struct ColumItem item;
    item.colum=0;
    item.height=0.0f;
    
    NSInteger count=_heights.count;
    item.height=[_heights[0] floatValue];
    for (int i=1; i<count; i++)
    {
        CGFloat height=[_heights[i] floatValue];
        if (item.height>height)
        {
            item.height=height;
            item.colum=i;
        }
    }
    return item;
}


-(struct ColumItem) getMaxCloumHeight
{
    struct ColumItem item;
    item.colum=0;
    item.height=0.0f;
   
    NSInteger count=_heights.count;
    item.height=[_heights[0] floatValue];
    for (int i=1; i<count; i++)
    {
        CGFloat height=[_heights[i] floatValue];
        if (item.height<height)
        {
            item.height=height;
            item.colum=i;
        }
    }
    return item;
}


@end
