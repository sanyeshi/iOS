//
//  PhotoBowserViewController.m
//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "PhotoBowserViewController.h"
#define kIndicatorHeight 64
@interface PhotoBowserViewController () <UIScrollViewDelegate>
{
    UIViewController    * _rootViewController;   //窗口根视图控制器
    UIImage             * _screenImage;          //窗口截图
    BOOL                  _statusBarhidden;      //是否隐藏状态栏
    UILabel             * _indicatorLabel;       //显示提示
    UIScrollView        * _scrollView;           //滚动视图
    NSMutableSet        *_reusablePhotoViewSet;  //可重用视图集合
    NSMutableDictionary *_visiblePhotoViewDict;  // 屏幕上可见的视图字典
}

@end

@implementation PhotoBowserViewController
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _currentIndex=-1;
        _statusBarhidden=YES;
        _reusablePhotoViewSet = [NSMutableSet set];
        _visiblePhotoViewDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)loadView
{
    //self.view
    self.view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 实例化UIScrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [ _scrollView setBackgroundColor:[UIColor blackColor]];
    [ _scrollView setShowsHorizontalScrollIndicator:NO];
    [ _scrollView setShowsVerticalScrollIndicator:NO];
    [ _scrollView setPagingEnabled:YES];
    [ _scrollView setDelegate:self];
    [self.view addSubview:_scrollView];
    //indicator
    CGFloat indicatorLabelX=0;
    CGFloat indicatorLabelY=0;
    CGFloat indicatorLabelW=self.view.frame.size.width;
    CGFloat indicatorLabelH=kIndicatorHeight;
    _indicatorLabel=[[UILabel alloc] init];
    _indicatorLabel.frame=CGRectMake(indicatorLabelX, indicatorLabelY, indicatorLabelW, indicatorLabelH);
    _indicatorLabel.font=[UIFont boldSystemFontOfSize:14.0f];
    _indicatorLabel.textColor=[UIColor whiteColor];
    _indicatorLabel.backgroundColor=[UIColor clearColor];
    _indicatorLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:_indicatorLabel];

   
}

#pragma mark - show
- (void)show
{
    _screenImage=[self getScreenImage];
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    _rootViewController=window.rootViewController;
    window.rootViewController=self;
    // 显示照片视图
    [self showPhotos];
}

#pragma mark -showPhotos
- (void)showPhotos
{
   
    // 1. 前后两个视图的索引
    NSInteger firstIndex = _scrollView.bounds.origin.x / _scrollView.bounds.size.width;
    NSInteger nextIndex = firstIndex + 1;
    
    // 2. 数值处理
    if (firstIndex < 0) firstIndex = 0;
    if (nextIndex > _photoList.count - 1) nextIndex = _photoList.count - 1;
    
    // 3. 循环加载照片
    for (NSInteger i = firstIndex; i <= nextIndex; i++)
    {
        [self showPhotoAtIndex:i];
    }
}

#pragma mark -使用指定索引显示照片
- (void)showPhotoAtIndex:(NSInteger)index
{
    
    //判断指定index的照片视图，是否在屏幕上
    PhotoView *photoView = _visiblePhotoViewDict[@(index)];
    
    if (photoView == nil)
    {
        //判断是否需要实例化照片
        photoView = [self dequeueReusablePhotoView];
        if (photoView == nil)
        {
            photoView = [[PhotoView alloc]init];
           [photoView setPhotoDelegate:self];
        }
        // 设置照片视图属性
        PhotoModel *photoModel = _photoList[index];
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = self.view.bounds.size.height;
        [photoView setFrame:CGRectMake(index * w, 0, w, h)];
        [photoView setPhoto:photoModel];
        [_scrollView addSubview:photoView];
        [_visiblePhotoViewDict setObject:photoView forKey:@(index)];
    }
}

#pragma mark -查询可重用照片视图
- (PhotoView *)dequeueReusablePhotoView
{
    // 1. 从缓存集合中查找照片可重用视图
    PhotoView *photoView = [_reusablePhotoViewSet anyObject];
    
    // 2. 如果找到，从缓存中删除，并返回照片视图
    if (photoView)
    {
        [_reusablePhotoViewSet removeObject:photoView];
    }
    return photoView;
}


#pragma mark - 照片视图代理方法
- (void)photoViewSingleTap:(PhotoView *)photoView
{
    _statusBarhidden=NO;
    [self setNeedsStatusBarAppearanceUpdate];
    _indicatorLabel.hidden=YES;
    [_scrollView setBackgroundColor:[UIColor clearColor]];
    /*
    for (UIView * view in _scroll.subviews)
    {
        if ([view isKindOfClass:[PhotoView class]])
        {
            [self.view addSubview:view];
        }
       // [self.view addSubview:view];
       // Log(@"%@",view);
    }
    [_scroll removeFromSuperview];
     */
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:_screenImage]];
    
}
#pragma mark -退出
- (void)photoViewZoomOut:(PhotoView *)photoView
{
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    window.rootViewController=_rootViewController;
}

#pragma mark - 滚动视图代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self showPhotos];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 通过contentOffset计算出当前照片的索引
    NSInteger index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    
    if (index != _currentIndex)
    {
        _indicatorLabel.text=[NSString stringWithFormat:@"%lu/%lu",index+1,_photoList.count];
        // 没有显示的照片视图的索引是_currentIndex
        PhotoView *photoView = _visiblePhotoViewDict[@(_currentIndex)];
        
        // 将可见字典中的内容删除
        [_visiblePhotoViewDict removeObjectForKey:@(_currentIndex)];
        // 将视图从界面上删除
        [photoView removeFromSuperview];
        
        // 将视图添加到可重用集合
        [_reusablePhotoViewSet addObject:photoView];
        
        // 设置当前的索引
         _currentIndex = index;
    }
}

-(void) setPhotoList:(NSArray *)photoList
{
    _photoList=photoList;
    // 设置滚动视图的滚动范围
    CGSize  contentSize=CGSizeMake(self.view.bounds.size.width *_photoList.count,self.view.bounds.size.height);
    [_scrollView setContentSize:contentSize];
    if (_currentIndex>=0)
    {
        PhotoModel * photoModel=_photoList[_currentIndex];
        photoModel.firstShow=YES;
        _indicatorLabel.text=[NSString stringWithFormat:@"%lu/%lu",_currentIndex+1,_photoList.count];
    }
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    PhotoModel * photoModel=_photoList[_currentIndex];
    photoModel.firstShow=YES;
    // 设置滚动视图的偏移位置
    CGPoint offset=CGPointMake(currentIndex * self.view.bounds.size.width, 0);
    [_scrollView setContentOffset:offset];
    _indicatorLabel.text=[NSString stringWithFormat:@"%lu/%lu",_currentIndex+1,_photoList.count];

}

#pragma mark -屏幕截图
- (UIImage *)getScreenImage
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(size,NO, 0.0);
    UIWindow * window=[UIApplication sharedApplication].keyWindow;
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -状态栏
-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(BOOL) prefersStatusBarHidden
{
   return  _statusBarhidden;
}
@end
