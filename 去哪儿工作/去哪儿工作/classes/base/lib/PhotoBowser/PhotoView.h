//
//  PhotoView.h
//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
//  照片浏览器照片视图
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@class PhotoView;

@protocol PhotoViewDelegate <NSObject>

- (void)photoViewSingleTap:(PhotoView *)photoView;

- (void)photoViewZoomOut:(PhotoView *)photoView;

@end

@interface PhotoView : UIScrollView

@property (weak, nonatomic) id<PhotoViewDelegate> photoDelegate;

// 照片模型
@property (strong, nonatomic) PhotoModel *photo;

@end
