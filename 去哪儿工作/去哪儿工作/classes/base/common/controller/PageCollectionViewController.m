//
//  PageCollectionViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PageCollectionViewController.h"
#import "PageCollection.h"

@interface PageCollectionViewController ()

@end

@implementation PageCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //请求数据
    [self beginHeaderRefreshing];
    
}

#pragma mark - 头部刷新全部数据
-(void) didHeaderRefresh
{
    PageCollection *pageCollection=[[PageCollection alloc] init];
    [self requestData:pageCollection];
    [NSThread sleepForTimeInterval:0.2];
    [self endHeaderRefreshing];
    [self setFooterEnabled:YES];
    [self setFooterTitle:@"加载更多数据" forState: FooterRefreshStateIdle];
}

#pragma mark - 底部刷新
-(void) didFooterRefresh
{
    if (_pageCollection.hasNextPage)
    {
        _pageCollection.currentPage=_pageCollection.nextPage;
        [self requestData:_pageCollection];
    }
    else
    {
        [self setFooterEnabled:NO];
        [self setFooterTitle:@"没有更多数据" forState: FooterRefreshStateIdle];
        [self endFooterRefreshing];
    }
}

#pragma mark - 请求数据
-(void) requestData:(PageCollection *)pageCollection
{
    
}
@end


