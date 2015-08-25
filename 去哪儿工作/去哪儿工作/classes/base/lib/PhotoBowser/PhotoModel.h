//
//  PhotoModel.h

//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
//  照片浏览器数据模型
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface PhotoModel : NSObject

+ (id)photoWithURL:(NSURL *)url index:(NSInteger)index srcFrame:(CGRect)srcFrame;

// 图片的URL
@property (strong, nonatomic) NSURL *imageUrl;
// 图片的索引
@property (assign, nonatomic) NSInteger index;

// 上级视图的图像边框，以保证动画效果（展开，收缩）的实现
@property (assign, nonatomic) CGRect srcFrame;

// 实际的图像
@property (strong, nonatomic) UIImage *image;
// 第一次显示标记
@property (assign, nonatomic) BOOL firstShow;


@end
