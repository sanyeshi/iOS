//
//  RefreshableTableViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "RefreshableTableViewController.h"
#import "MJRefresh.h"

@interface RefreshableTableViewController ()

@end

@implementation RefreshableTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor=GlobalTableViewBackgroundColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self loadRefreshControl];
}

#pragma mark -- 添加刷新控件
-(void) loadRefreshControl
{
    [self loadHeaderRefreshControl];
    [self loadFooterRefreshControl];
}

#pragma mark -头部刷新控件
-(void) loadHeaderRefreshControl
{
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(didHeaderRefresh)];
    [self.tableView.legendHeader setUpdatedTimeHidden:YES];
    self.tableView.header.font =GlobalFont;
    self.tableView.header.textColor =GlobalBlackTextColor;
}

#pragma mark -底部刷新控件
-(void) loadFooterRefreshControl
{
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(didFooterRefresh)];
    self.tableView.footer.font =GlobalFont;
    self.tableView.footer.textColor =GlobalBlackTextColor;
}

#pragma mark -头部刷新
-(void) didHeaderRefresh
{
    
}

#pragma mark - 下拉整个刷新
-(void) didFooterRefresh
{
    
}

#pragma mark -停止头部刷新
-(void) endHeaderRefreshing
{
    [self.tableView.legendHeader endRefreshing];
}

#pragma mark -停止低部刷新
-(void) endFooterRefreshing
{
    [self.tableView.legendFooter endRefreshing];
}

-(void) endRefreshing
{
    [self.tableView.legendHeader endRefreshing];
    [self.tableView.legendFooter endRefreshing];
}

#pragma mark -开始刷新
-(void) beginHeaderRefreshing
{
    [self.tableView.legendHeader beginRefreshing];
}

-(void) beginFooterRefreshing
{
    [self.tableView.legendFooter beginRefreshing];
}
#pragma mark -设置刷新控件标题
-(void) setFooterTitle:(NSString *)title forState:(FooterRefreshState)state
{
    [self.tableView.legendFooter setTitle:title forState:(MJRefreshFooterState)state];
}
-(void) setFooterEnabled:(BOOL)enabled
{
    self.tableView.legendFooter.userInteractionEnabled=enabled;
}
-(void) viewDidAppear:(BOOL)animated
{
    
}

@end
