//
//  PhotoBowserViewController.h
//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
//  照片浏览器视图控制器
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"
#import "PhotoView.h"


@interface PhotoBowserViewController : UIViewController <PhotoViewDelegate>

// 照片模型数组
@property (strong, nonatomic) NSArray *photoList;
// 当前显示照片的索引
@property (assign, nonatomic) NSInteger currentIndex;


#pragma mark - 显示照片浏览器视图
- (void)show;

@end
