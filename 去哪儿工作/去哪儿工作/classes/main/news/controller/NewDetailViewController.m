//
//  NewDetailViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NewDetailViewController.h"
#import "NewsDetailView.h"

@interface NewDetailViewController ()
{
    NewsDetailView * _newsDetailView;
}
@end

@implementation NewDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO; 
    }
    CGFloat x=0;
    CGFloat y=[UIApplication sharedApplication].statusBarFrame.size.height+self.navigationController.navigationBar.frame.size.height;
    CGFloat w=self.view.frame.size.width;
    CGFloat h=self.view.frame.size.height-y;
    _newsDetailView=[[NewsDetailView alloc] init];
    _newsDetailView.frame=CGRectMake(x, y, w, h);
    _newsDetailView.news=_news;
    [self.view addSubview:_newsDetailView];
    
}

@end
