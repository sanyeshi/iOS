//
//  NewsDetailViewController.h
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;
@interface NewsDetailView : UIScrollView
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *dateLabel;
@property(nonatomic,strong) News    *news;
@end
