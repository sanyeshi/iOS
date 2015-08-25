//
//  CategoryHeaderView.m
//  parttime
//
//  Created by 孙硕磊 on 4/6/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CategoryHeaderView.h"
#import "PositionCategory.h"
#import "Index.h"

#define kSeparatorMargin 5.0f
#define kSeparatorWidth 1.0f
#define kSeparatorLineHeight 1.0f

#define kItemButtonHeight 40.0f
#define kVisibleItemButtonCount 6

#define kAnimationDuration 0.2

@interface CategoryHeaderView ()
{
    UIView         *   _coverView;
    UIView         *   _separator;
    UIView         *   _separatorLine;
    UIButton       *   _selectedSectionButton;
    UIButton       *   _selectedItemButton;
    NSArray        *   _selectedIndexs;
}
@end

@implementation CategoryHeaderView
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _selectedIndexs=@[[Index indexWithRow:0],
                          [Index indexWithRow:0],
                          [Index indexWithRow:0],
                          [Index indexWithRow:0]];
        //创建子控件
        [self createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    //全部类型
     _allTypeButton=[self createHeaderButtonWithTitle:@"全部兼职"];
     _allTypeButton.tag=0;
     [self addSubview:_allTypeButton];
     _selectedSectionButton=_allTypeButton;
    //分割符
    _separator=[[UIView alloc] init];
    _separator.backgroundColor=GlobalSeparatorColor;
    [self addSubview:_separator];
    //排行
    _orderTypeButton=[self createHeaderButtonWithTitle:@"最新"];
    _orderTypeButton.tag=1;
    [self addSubview:_orderTypeButton];
    //底部分割线
    _separatorLine=[[UIView alloc] init];
    _separatorLine.backgroundColor=GlobalSeparatorColor;
    [self addSubview:_separatorLine];
}

-(UIButton *) createHeaderButtonWithTitle:(NSString *) title
{
    UIButton * button=[[UIButton alloc] init];
    button.backgroundColor=GlobalBackgroundColor;
    button.titleLabel.font=GlobalFont;
    button.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:@"down_btn.png"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:GlobalBlackTextColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectSection:) forControlEvents:UIControlEventTouchDown];
    return button;
}

-(void) layoutSubviews
{
    CGFloat width=self.frame.size.width;
    CGFloat buttonWidth=(width-kSeparatorWidth)*0.5;
    CGFloat buttonHeight=kCategoryHeaderViewHeight-kSeparatorLineHeight;
    //全部类型
    _allTypeButton.frame=CGRectMake(0, 0, buttonWidth, buttonHeight);
    [self adjustButtonTextAndImageEdgeInset:_allTypeButton];
    
    //分隔符
    _separator.frame=CGRectMake(buttonWidth,kSeparatorMargin, kSeparatorWidth,kCategoryHeaderViewHeight-2*kSeparatorMargin);
    //排行
    _orderTypeButton.frame=CGRectMake(buttonWidth+kSeparatorWidth, 0, buttonWidth, buttonHeight);
    [self adjustButtonTextAndImageEdgeInset:_orderTypeButton];
    //底部分割线
    _separatorLine.frame=CGRectMake(0,buttonHeight, width, kSeparatorLineHeight);
}

-(void) updateHeaderButtons
{
    //更新按钮文字
    NSString   * positionTypeName=nil;
    NSString   * orderTypeName=nil;
    if (_categoryType==CategoryTypeParttimeJob)
    {
        positionTypeName=[_jobAllTypeArray[[_selectedIndexs[0] row]] name];
        orderTypeName=[_orderAllTypeArray[[_selectedIndexs[1] row]] name];
    }
    else
    {
        positionTypeName=[_internAllTypeArray[[_selectedIndexs[2] row]] name];
        orderTypeName=[_orderAllTypeArray[[_selectedIndexs[3] row]] name];
    }
    [_allTypeButton setTitle:positionTypeName forState:UIControlStateNormal];
    [self adjustButtonTextAndImageEdgeInset:_allTypeButton];
    [_orderTypeButton setTitle:orderTypeName forState:UIControlStateNormal];
    [self adjustButtonTextAndImageEdgeInset:_orderTypeButton];
}

-(void) adjustButtonTextAndImageEdgeInset:(UIButton *) button
{
    CGSize imageSize=button.imageView.image.size;
    CGSize textSize = [button.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName:GlobalFont}];
    CGFloat leftEdgeInset=(button.frame.size.width-textSize.width)*0.5-imageSize.width;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, leftEdgeInset, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, leftEdgeInset+textSize.width+imageSize.width, 0, 0)];
}

#pragma mark -- 设置类型兼职或实习
-(void) setCategoryType:(CategoryType) categoryType
{
    if (categoryType==_categoryType)
    {
        return;
    }
    _categoryType=categoryType;
    _selectedSection=0;
    _selectedSectionButton=_allTypeButton;
    [self updateHeaderButtons];
    [self removePopupListView];
}

#pragma mark -- 弹出列表

-(void) createPopupListView
{
    NSArray    * array=nil;
    if (_categoryType==CategoryTypeParttimeJob)
    {
        if (_selectedSection==0)
        {
            array=_jobAllTypeArray;
        }
        else
        {
            array=_orderAllTypeArray;
        }
    }
    else
    {
        if (_selectedSection==0)
        {
            array=_internAllTypeArray;
        }
        else
        {
            array=_orderAllTypeArray;
        }
    }
    //coverView
    CGFloat coverViewX=0;
    CGFloat coverViewY=CGRectGetMaxY(self.frame);
    CGFloat coverViewWidth=[UIScreen mainScreen].bounds.size.width;
    CGFloat coverViewHeight=[UIScreen mainScreen].bounds.size.height-coverViewY;
    _coverView=[[UIView alloc] init];
    _coverView.frame=CGRectMake(coverViewX, coverViewY, coverViewWidth, coverViewHeight);
    _coverView.backgroundColor=[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_coverView addGestureRecognizer:tap];
    
    
    //选项数
    NSInteger count=array.count;
    //计算弹出列表frame
    CGFloat popupListViewHeight=count*kItemButtonHeight+(count-1)*kSeparatorLineHeight;
    CGFloat popupListViewWidth=(self.frame.size.width-kSeparatorWidth)*0.5;
    CGFloat popupListViewX=0;
    CGFloat popupListViewY=0;
    if (_selectedSection==1)
    {
        popupListViewX=popupListViewWidth+kSeparatorWidth;
    }
    _popupListView=[[UIScrollView alloc] init];
    _popupListView.backgroundColor=GlobalBackgroundColor;
    _popupListView.clipsToBounds=YES;
    _popupListView.showsHorizontalScrollIndicator=NO;
    _popupListView.frame=CGRectMake(popupListViewX,popupListViewY, popupListViewWidth,popupListViewHeight);
    if (count>kVisibleItemButtonCount)
    {
        _popupListView.showsVerticalScrollIndicator=YES;
        _popupListView.contentSize=CGSizeMake(0,popupListViewHeight);
        popupListViewHeight=kVisibleItemButtonCount*kItemButtonHeight+(kVisibleItemButtonCount-1)*kSeparatorLineHeight;
        _popupListView.frame=CGRectMake(popupListViewX,popupListViewY, popupListViewWidth,popupListViewHeight);
    }
    CGFloat itemButtonY=0.0f;
    CGFloat separatorY=0.0f;
    for(int i=0;i<count;i++)
    {
        PositionCategory * category=array[i];
        //选项按钮
        itemButtonY=i*(kItemButtonHeight+kSeparatorLineHeight);
        UIButton * itemButton=[[UIButton alloc] init];
        itemButton.tag=i;
        itemButton.titleLabel.font=GlobalFont;
        [itemButton setTitle:category.name forState:UIControlStateNormal];
        [itemButton setTitleColor:GlobalBlackTextColor forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchDown];
        itemButton.frame=CGRectMake(0,itemButtonY,popupListViewWidth, kItemButtonHeight);
        [_popupListView addSubview:itemButton];
        Index * index=_selectedIndexs[_categoryType*2+_selectedSection];
        if (i==index.row)
        {
            _selectedItemButton=itemButton;
        }
        //分割线
        if (i+1!=count)
        {
            separatorY=(i+1)*kItemButtonHeight+i*kSeparatorLineHeight;
            UIView * separator=[[UIView alloc] init];
            separator.backgroundColor=GlobalSeparatorColor;
            separator.frame=CGRectMake(0, separatorY, popupListViewWidth, kSeparatorLineHeight);
            [_popupListView addSubview:separator];
        }
    }
    //默认选中项
    [self  highlightButton:_selectedItemButton];
    [_coverView addSubview:_popupListView];
}

-(void) resetButton:(UIButton *) button
{
    [button setBackgroundColor:[UIColor whiteColor]];
}

-(void) highlightButton:(UIButton *) button
{
    [button setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0f]];
}

-(void) showPopupListView
{
    [self createPopupListView];
    [self.superview addSubview:_coverView];
    //淡入淡出
    _coverView.alpha=0.0;
    [UIView animateWithDuration:kAnimationDuration animations:^
    {
        _coverView.alpha=1.0f;
    }];
}

-(void) removePopupListView
{
    if (_popupListView==nil)
    {
        return;
    }
    [_selectedSectionButton setImage:[UIImage imageNamed:@"down_btn.png"] forState:UIControlStateNormal];
    [_popupListView removeFromSuperview];
    [_coverView removeFromSuperview];
    _selectedItemButton=nil;
    _coverView=nil;
    _popupListView=nil;

}

-(void) removePopupListViewWithAnimationCompletion:(void(^)(BOOL finished))completion
{
    if (_popupListView==nil)
    {
        return;
    }
    [_selectedSectionButton setImage:[UIImage imageNamed:@"down_btn.png"] forState:UIControlStateNormal];
    //淡入淡出
    [UIView animateWithDuration:kAnimationDuration animations:^
     {
         _coverView.alpha=0.0f;
     }
     completion:^(BOOL finished)
     {
         //动画结束，移除
         _selectedItemButton=nil;
        [_popupListView removeFromSuperview];
        [_coverView removeFromSuperview];
         _coverView=nil;
         _popupListView=nil;
         if(completion)
         {
           completion(finished);
         }
     }];
}

-(void) tap
{
    [self removePopupListViewWithAnimationCompletion:nil];
}

#pragma mark --选择最新排行或热门排行
-(void) selectSection:(UIButton *) button
{
    [_selectedSectionButton setImage:[UIImage imageNamed:@"down_btn.png"] forState:UIControlStateNormal];
    _selectedSection=button.tag;
    _selectedSectionButton=button;
    [_selectedSectionButton setImage:[UIImage imageNamed:@"up_btn.png"] forState:UIControlStateNormal];
    [_delegate categoryHeaderView:self didSelectSection:_selectedSection];
}
#pragma mark --选择最新排行或热门排行子选项
-(void) selectItem:(UIButton *) button
{
    if (_selectedItemButton!=button)
    {
        if(_selectedSection==0)
        {
            [_allTypeButton setTitle:button.titleLabel.text forState:UIControlStateNormal];
            [self adjustButtonTextAndImageEdgeInset:_allTypeButton];
        }
        else
        {
            [_orderTypeButton setTitle:button.titleLabel.text forState:UIControlStateNormal];
        }
        [self resetButton:_selectedItemButton];
        [self highlightButton:button];
        _selectedItemButton=button;
        Index * index=_selectedIndexs[_categoryType*2+_selectedSection];
        index.row=button.tag;
    }
    [_delegate categoryHeaderView:self didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:_selectedSection]];
}
@end
