//
//  FavoriteCenterViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "FavoriteCenterViewController.h"
#import "SegmentedControl.h"
#import "MyFavoriteTableViewController.h"

#define kSegmentedControlHeight  40.0f
#define kMargin                  10.0f

@interface FavoriteCenterViewController ()<SegmentedControlDelegate>
{
  MyFavoriteTableViewController * _myFavoriteTableViewController;
}
@end

@implementation FavoriteCenterViewController


/**
 *  页面加载，初始化子空间
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的收藏";
    //控件
    self.view.backgroundColor=GlobalTableViewBackgroundColor;
    CGFloat statusBarHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navigationBarHeight=self.navigationController.navigationBar.frame.size.height;
    //头部
    CGFloat segmentedControlX=0;
    CGFloat segmentedControlY=statusBarHeight+navigationBarHeight;
    CGFloat segmentedControlW=self.view.frame.size.width;
    CGFloat segmentedControlH=kSegmentedControlHeight;
    
    SegmentedControl * segmentedControl=[[SegmentedControl alloc] initWithItems:@[@"兼职",@"实习",@"招聘"]];
    segmentedControl.frame=CGRectMake(segmentedControlX, segmentedControlY,segmentedControlW,segmentedControlH);
    segmentedControl.delegate=self;
    [self.view addSubview:segmentedControl];

    //表格
    CGFloat tableViewX=0;
    CGFloat tableViewY=statusBarHeight+navigationBarHeight+kSegmentedControlHeight+kMargin;
    CGFloat tableViewWidth=self.view.frame.size.width;
    CGFloat tableViewHeight=self.view.frame.size.height-tableViewY;
    _myFavoriteTableViewController=[[MyFavoriteTableViewController alloc] init];
    _myFavoriteTableViewController.tableView.frame=CGRectMake(tableViewX,tableViewY,tableViewWidth,tableViewHeight);
    [self addChildViewController:_myFavoriteTableViewController];
    [self.view addSubview:_myFavoriteTableViewController.tableView];
}

#pragma mark - 选择收藏类型
-(void) segmentedControl:(SegmentedControl *)segmentedControl clickedItemAtIndex:(NSInteger)itemIndex
{
    _myFavoriteTableViewController.myFavoriteType=itemIndex;
    [_myFavoriteTableViewController reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    
}
@end

