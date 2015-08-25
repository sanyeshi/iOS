//
//  PhotoView.m
//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"

@interface PhotoView() <UIScrollViewDelegate>
{
    // 图像视图
    UIImageView *_imageView;
}

@end

@implementation PhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // 1. 设置imageView
        _imageView = [[UIImageView alloc]initWithFrame:frame];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_imageView];
        
        // 2. 设置scrollView属性
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setDelegate:self];
        
        // 3. 添加双击手势监听
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTap];
        
        // 4. 添加单击手势监听
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
        [singleTap setNumberOfTapsRequired:1];
        [self addGestureRecognizer:singleTap];
        
        //这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

#pragma mark 双击事件
- (void)doubleTap:(UITapGestureRecognizer *)recognizer
{
    // 如果图像视图放大到两倍，还原初始大小
    if (self.zoomScale == self.maximumZoomScale)
    {
        [self setZoomScale:1.0f animated:YES];
    }
    else
    {
        // 否则，从手势触摸位置开始放大
        CGPoint location = [recognizer locationInView:self];
        [self zoomToRect:CGRectMake(location.x, location.y, 1, 1) animated:YES];
    }
}

#pragma mark 单击事件
- (void)singleTap
{
    [self.photoDelegate photoViewSingleTap:self];
    //如果图像视图放大到两倍，还原初始大小
    if (self.zoomScale == self.maximumZoomScale)
    {
        [self setZoomScale:1.0f animated:YES];
    }
    // 缩小图像到初始位置
    [UIView animateWithDuration:0.5f animations:^
     {
         [_imageView setFrame:_photo.srcFrame];
     }
     completion:^(BOOL finished)
     {
         //关闭视图控制器
         [self.photoDelegate photoViewZoomOut:self];
     }];

}

#pragma mark - photo setter方法
- (void)setPhoto:(PhotoModel *)photo
{
    _photo = photo;
    if (photo.image)
    {
        [_imageView setImage:photo.image];
        [self adjustFrame];
    }
    else
    {
        UIImage *image = [[UIImage alloc]init];
        __unsafe_unretained PhotoView *photoView = self;
        // 提示占位图像不能使用nil
        [_imageView sd_setImageWithURL:photo.imageUrl placeholderImage:image options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize)
         {
         }
         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
         {
            photoView.photo.image = image;
            [photoView adjustFrame];
        }];
    }
}

#pragma mark - 缩放图像
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

#pragma mark - 调整图像边框
- (void)adjustFrame
{
    // 1. 定义计算参考值
    CGFloat viewW = self.bounds.size.width;
    CGFloat viewH = self.bounds.size.height;
    
    CGFloat imageW = _imageView.image.size.width;
    CGFloat imageH = _imageView.image.size.height;
    
    // 2. 调整图像的思路
    // 1) 如果图像的宽高都分别小于视图的宽高，将图像设置在屏幕中心位置即可
    // 2) 如果图像的宽度小于屏幕宽度，高度大于屏幕高度
    //    不调整图像大小，让图像的顶端与视图顶端对齐，并且设置滚动区域，保证能够滚动查看图像内容
    // 3) 宽度和高度都超过屏幕宽高
    //    缩放图像的宽度，与屏幕宽度一致，高度按比例调整
    //      调整后的高度如果小于屏幕高度，图像居中
    //      调整后的高度如果大于屏幕高度，图像置顶
    
    // 2. 计算缩放比例
    CGFloat scale = viewW / imageW;
    if (scale < 1.0)
    {
        imageH *= scale;
        imageW = viewW;
    }
    CGRect imageFrame = CGRectMake(0, 0, viewW, imageH);
    if (imageH < viewH)
    {
        imageFrame.origin.y = (viewH- imageH) / 2.0;
    }
    else
    {
        // 设置滚动区域
        [self setContentSize:CGSizeMake(viewW, imageH)];
    }
    
    if (_photo.firstShow)
    {
         _photo.firstShow=NO;
        [_imageView setFrame:_photo.srcFrame];
        
        [UIView animateWithDuration:0.3f animations:^
        {
            [_imageView setFrame:imageFrame];
        }];
    }
    else
    {
        [_imageView setFrame:imageFrame];
    }
    
    // 3. 设置缩放比例
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = 2.0;
}

@end
