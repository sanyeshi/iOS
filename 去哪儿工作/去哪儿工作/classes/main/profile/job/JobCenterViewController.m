//
//  ProfileJobCenterViewController.m
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "JobCenterViewController.h"
#import "SegmentedControl.h"
#import "JobCell.h"
#import "MyJobTableViewController.h"

#define kSegmentedControlHeight  40.0f
#define kMargin                  10.0f
@interface JobCenterViewController ()<SegmentedControlDelegate>
{
    MyJobTableViewController * _myJobTableViewController;
}
@end
@implementation JobCenterViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

/**
 *  页面加载，初始化子空间
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的职位";
    //控件
    self.view.backgroundColor=GlobalTableViewBackgroundColor;
    CGFloat statusBarHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navigationBarHeight=self.navigationController.navigationBar.frame.size.height;
    //头部
    CGFloat segmentedControlX=0;
    CGFloat segmentedControlY=statusBarHeight+navigationBarHeight;
    CGFloat segmentedControlW=self.view.frame.size.width;
    CGFloat segmentedControlH=kSegmentedControlHeight;
    
    SegmentedControl * segmentedControl=[[SegmentedControl alloc] initWithItems:@[@"申请中",@"已接受",@"已回绝"]];
    segmentedControl.frame=CGRectMake(segmentedControlX, segmentedControlY,segmentedControlW,segmentedControlH);
    segmentedControl.delegate=self;
    [self.view addSubview:segmentedControl];
    
    //表格
    CGFloat tableViewX=0;
    CGFloat tableViewY=statusBarHeight+navigationBarHeight+kSegmentedControlHeight+kMargin;
    CGFloat tableViewWidth=self.view.frame.size.width;
    CGFloat tableViewHeight=self.view.frame.size.height-tableViewY;
    _myJobTableViewController=[[MyJobTableViewController alloc] init];
    _myJobTableViewController.tableView.frame=CGRectMake(tableViewX,tableViewY,tableViewWidth,tableViewHeight);
    [self addChildViewController:_myJobTableViewController];
    [self.view addSubview:_myJobTableViewController.tableView];
}

#pragma mark - 选择Job类型
-(void) segmentedControl:(SegmentedControl *)segmentedControl clickedItemAtIndex:(NSInteger)itemIndex
{
    _myJobTableViewController.myJobType=itemIndex;
    [_myJobTableViewController reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    
}

@end
