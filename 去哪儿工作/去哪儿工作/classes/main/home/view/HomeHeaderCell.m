//
//  HomeHeaderCell.m
//  parttime
//
//  Created by 孙硕磊 on 3/29/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HomeHeaderCell.h"
#import "HomeHeaderBanner.h"
#import "UIImageView+WebCache.h"

#define kHomeHeaderCellImageHeight 160
#define kHomeHeaderCellTitleViewHeight 40
#define kPageControllerWidth 40
#define kMargin 10

#define kAnimationDuration 0.3f
#define kTimerInterval     5.0f

@interface HomeHeaderCell ()
{
    NSArray       * _models;
    
    UIScrollView  * _scrollImageView;
    UIView        * _titleView;
    UILabel       * _titleLabel;
    UIPageControl * _pageControll;
    NSTimer       * _timer;
    
}
@end

@implementation HomeHeaderCell

- (instancetype)initWithModels:(NSArray *)models
{
    self = [super init];
    if (self)
    {
        _models=models;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createSubViews];
        [self createImageViews:models];
        [self setImages:models];
        [self startTimer];
    }
    return self;
}

#pragma mark 创建子控件
-(void) createSubViews
{
    //创建滚动视图
    _scrollImageView=[[UIScrollView alloc] init];
    _scrollImageView.pagingEnabled=YES;
    _scrollImageView.bounces=NO;
    _scrollImageView.showsHorizontalScrollIndicator=NO;
    _scrollImageView.showsVerticalScrollIndicator=NO;
    _scrollImageView.delegate=self;
    
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_scrollImageView addGestureRecognizer:tap];
    [self addSubview:_scrollImageView];

    //标题栏
    _titleView=[[UIView alloc] init];
    _titleView.backgroundColor=[UIColor whiteColor];
    _titleView.clipsToBounds=YES;
    [self addSubview:_titleView];
    
    _titleLabel=[[UILabel alloc] init];
    _titleLabel.textColor=[UIColor blackColor];
    _titleLabel.font=GlobalFont;
    [_titleView addSubview:_titleLabel];
    //分页控件
    _pageControll=[[UIPageControl alloc] init];
    _pageControll.currentPageIndicatorTintColor=[UIColor blackColor];
    _pageControll.pageIndicatorTintColor=[UIColor lightGrayColor];
    _pageControll.clipsToBounds=YES;
    [_titleView addSubview:_pageControll];
}
#pragma mark --创建图片控件
-(void) createImageViews:(NSArray *)models
{
    NSInteger imageCount=models.count;
    //为了支持循环滚动播放图片需要在头部和尾部分别插入一张图片
    UIImageView  * firstImageView=[[UIImageView alloc] init];
    firstImageView.contentMode=UIViewContentModeScaleAspectFill;
    [_scrollImageView addSubview:firstImageView];
    
    for (int i=0; i<imageCount; i++)
    {
        UIImageView  * imageView=[[UIImageView alloc] init];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        [_scrollImageView addSubview:imageView];
    }
    
    UIImageView  * lastImageView=[[UIImageView alloc] init];
    lastImageView.contentMode=UIViewContentModeScaleAspectFill;
    [_scrollImageView addSubview:lastImageView];
    
}
#pragma mark --设置图片
-(void) setImages:(NSArray *)models
{
    NSUInteger count=[models count];
    if (count>0)
    {
        NSArray * imageViews=_scrollImageView.subviews;
        HomeHeaderBanner * model=models[count-1];
        UIImageView * imageView=imageViews[0];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        for (int i=1; i<=count; i++)
        {
            model=models[i-1];
            imageView=imageViews[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        }
        model=models[0];
        imageView=imageViews[count+1];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder_big.png"]];
        _titleLabel.text=model.title;
    }
}

#pragma mark --调整子控件位置
-(void) layoutSubviews
{
    //滚动视图
    _scrollImageView.frame=CGRectMake(0, 0, self.frame.size.width, kHomeHeaderCellImageHeight);
    
    NSArray * imageViews=_scrollImageView.subviews;
     //图片视图
     CGFloat imageViewX=0;
     CGFloat imageViewY=0;
     CGFloat imageViewWidth=self.frame.size.width;
     CGFloat imageViewHeight=kHomeHeaderCellImageHeight;
     NSInteger imageCount=imageViews.count;
     for (int i=0; i<imageCount; i++)
     {
         imageViewX=i*imageViewWidth;
         UIImageView * imageView=imageViews[i];
         imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
     }
     _scrollImageView.contentSize=CGSizeMake(imageViewWidth*imageCount, imageViewHeight);
     _scrollImageView.contentOffset=CGPointMake(imageViewWidth, 0);
     _pageControll.numberOfPages=imageCount-2;
    
    //标题栏
    
    _titleView.frame=CGRectMake(0, CGRectGetMaxY(_scrollImageView.frame), self.frame.size.width, kHomeHeaderCellTitleViewHeight);
    _titleLabel.frame=CGRectMake(kMargin, 0, self.frame.size.width-kPageControllerWidth-kMargin, kHomeHeaderCellTitleViewHeight);
    
    //分页
    CGFloat pageControllWidth=kPageControllerWidth;
    CGFloat pageControllHeight=20;
    CGFloat pageControllX=self.frame.size.width-pageControllWidth-kMargin;
    CGFloat pageControlY=10;
    _pageControll.frame=CGRectMake(pageControllX, pageControlY, pageControllWidth, pageControllHeight);
}

#pragma mark --监听滑动事件
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width=self.frame.size.width;
    CGFloat offsetX=scrollView.contentOffset.x;
    //到最后一张，应切换到第二张
    if (offsetX+width==scrollView.contentSize.width)
    {
        offsetX=width;
    }
    else if(offsetX==0)
    {
        //到第一张，应切换回最后一张
        offsetX=scrollView.contentSize.width-width*2;
    }
    scrollView.contentOffset=CGPointMake(offsetX, 0);
    NSInteger index=offsetX/(width)-1;
    _pageControll.currentPage=index;
    HomeHeaderBanner * model=_models[index];
    _titleLabel.text=model.title;
}

#pragma mark -- 开启定时器
-(void) startTimer
{
    _timer =  [NSTimer scheduledTimerWithTimeInterval:kTimerInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    //多线程UI IOS程序默认只有一个主线程，处理UI的只有主线程。如果拖动第二个UI，则第一个UI事件则会失效。
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void) closeTimer
{
    if (_timer)
    {
         //移除定时器
        [_timer invalidate];
         _timer=nil;
    }
}

#pragma mark --自动滑动
-(void) autoScroll
{
    CGFloat imageViewWidth=self.frame.size.width;
    CGFloat offsetX=_scrollImageView.contentOffset.x;
    NSInteger index=_pageControll.currentPage;
    offsetX+=imageViewWidth;
    //下一个将要切换的是最后一张
    if (offsetX==_scrollImageView.contentSize.width-imageViewWidth)
    {
        index=0;
    }
    else
    {
        index++;
        if (index>=_models.count)
        {
            index=0;
        }
    }
    [UIView animateWithDuration:kAnimationDuration animations:^
    {
        _scrollImageView.contentOffset=CGPointMake(offsetX, 0);
        _pageControll.currentPage=index;
    }
    completion:^(BOOL finished)
    {
        if (index<_models.count)
        {
            HomeHeaderBanner * model=_models[index];
            _titleLabel.text=model.title;
        }
        //到最后一张x
        if(offsetX+imageViewWidth==_scrollImageView.contentSize.width)
        {
            _scrollImageView.contentOffset=CGPointMake(imageViewWidth, 0);
        }
    }];
}

-(void) tap:(UITapGestureRecognizer *) tapGestureRecognizer
{
    if (_homeHeaderCellDelegate&&[_homeHeaderCellDelegate conformsToProtocol:@protocol(HomeHeaderCellDelegate)])
    {
        [_homeHeaderCellDelegate homeHeaderCell:self didSelectAtIndex:_pageControll.currentPage];
    }
}

- (void)dealloc
{
    [self closeTimer];
}

@end
