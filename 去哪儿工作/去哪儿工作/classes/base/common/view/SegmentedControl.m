//
//  SegmentedControl.m
//  parttime
//
//  Created by 孙硕磊 on 5/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SegmentedControl.h"
#define kIndicatorColor             GlobalTintColor
#define kItemBackgroundColor        GlobalBackgroundColor
#define kItemFont                   GlobalFont
#define kItemTextNormalColor        GlobalBackgroundTextColor
#define kItemTextSelectedColor      GlobalTintColor
#define kSeparatorColor             GlobalSeparatorColor

#define kSeparatowHeight       1.0f
#define kIndicatorHeight       2.0f

@interface SegmentedControl ()
{
    NSArray * _segmentItems;
    UIView  * _separator;     //水平分割线
    UIView  * _indicator;
}
@end
@implementation SegmentedControl
-(instancetype)initWithItems:(NSArray *)items
{
    self=[super init];
    if (self)
    {
        [self createItems:items];
    }
    return self;
}

-(void) createItems:(NSArray *) items
{
    //items
    NSInteger count=items.count;
    NSMutableArray * arrayM=[[NSMutableArray alloc] initWithCapacity:count];
    for (int i=0; i<count; i++)
    {
        UIButton * item=[self createItemWithTitle:items[i]];
        item.tag=i;
        [self addSubview:item];
        [arrayM addObject:item];
    }
    _segmentItems=[arrayM copy];
    //默认高亮
    UIButton * item=_segmentItems[0];
    [item setTitleColor:kItemTextSelectedColor forState:UIControlStateNormal];
    
    //separator
    _separator=[[UIView alloc] init];
    _separator.backgroundColor=kSeparatorColor;
    [self addSubview:_separator];
    
    //indicator
    _indicator=[[UIView alloc] init];
    _indicator.backgroundColor=kIndicatorColor;
    [self addSubview:_indicator];
}

-(UIButton *) createItemWithTitle:(NSString *) title
{
    UIButton * btn=[[UIButton alloc] init];
    btn.backgroundColor=kItemBackgroundColor;
    btn.titleLabel.font=kItemFont;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kItemTextNormalColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchDown];
    return btn;
}

/*
 点击切换按钮
 */
-(void)clickItem:(UIButton *) btn
{
    UIButton * selectedItem=_segmentItems[_selectedSegmentIndex];
    [selectedItem setTitleColor:kItemTextNormalColor forState:UIControlStateNormal];
    
    _selectedSegmentIndex=btn.tag;
    [btn setTitleColor:kItemTextSelectedColor forState:UIControlStateNormal];
    [self moveIndicator:btn.tag];
    [self.delegate segmentedControl:self clickedItemAtIndex:btn.tag];
}

/*
 移动指示器
 */
-(void) moveIndicator:(NSInteger) index
{
    CGRect frame=_indicator.frame;
    frame.origin.x=index*frame.size.width;
    [UIView animateWithDuration:0.3f animations:^
     {
         _indicator.frame=frame;
     }];
}

- (void)layoutSubviews
{
    NSInteger itemCount=_segmentItems.count;
    if (itemCount<=0)
    {
        return;
    }
    CGFloat itemX=0;
    CGFloat itemY=0;
    CGFloat itemW=itemW=self.frame.size.width/itemCount;
    CGFloat itemH=self.frame.size.height-kIndicatorHeight;
    
    for (int i=0; i<itemCount; i++)
    {
        itemX=i*itemW;
        UIButton * item=_segmentItems[i];
        item.frame=CGRectMake(itemX, itemY, itemW,itemH);
    }
    //水平分割符
    _separator.frame=CGRectMake(0,self.frame.size.height-kSeparatowHeight,self.frame.size.width,kSeparatowHeight);
    
    //指示器
    CGFloat indicatorW=itemW;
    CGFloat indicatorH=kIndicatorHeight;
    CGFloat indicatorX=0;
    CGFloat indicatorY=self.frame.size.height-indicatorH;
    _indicator.frame=CGRectMake(indicatorX, indicatorY, indicatorW, indicatorH);
}


@end
