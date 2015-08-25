//
//  CardCenterViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CardCenterViewController.h"
#import "SegmentedControl.h"
#import "MyCardTableViewController.h"

#define kSegmentedControlHeight  40.0f
#define kMargin                  10.0f


@interface CardCenterViewController ()<SegmentedControlDelegate>
{
    MyCardTableViewController * _myCardTableViewController;
}
@end

@implementation CardCenterViewController

/**
 *  页面加载，初始化子空间
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的打卡";
    //控件
    self.view.backgroundColor=GlobalTableViewBackgroundColor;
    CGFloat statusBarHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navigationBarHeight=self.navigationController.navigationBar.frame.size.height;
    //头部
    CGFloat segmentedControlX=0;
    CGFloat segmentedControlY=statusBarHeight+navigationBarHeight;
    CGFloat segmentedControlW=self.view.frame.size.width;
    CGFloat segmentedControlH=kSegmentedControlHeight;
    
    SegmentedControl * segmentedControl=[[SegmentedControl alloc] initWithItems:@[@"待打卡",@"已打卡"]];
    segmentedControl.frame=CGRectMake(segmentedControlX, segmentedControlY,segmentedControlW,segmentedControlH);
    segmentedControl.delegate=self;
    [self.view addSubview:segmentedControl];
    
    //表格
    CGFloat tableViewX=0;
    CGFloat tableViewY=statusBarHeight+navigationBarHeight+kSegmentedControlHeight;
    CGFloat tableViewWidth=self.view.frame.size.width;
    CGFloat tableViewHeight=self.view.frame.size.height-tableViewY;
    _myCardTableViewController=[[MyCardTableViewController alloc] init];
    _myCardTableViewController.tableView.frame=CGRectMake(tableViewX,tableViewY,tableViewWidth,tableViewHeight);
    [self addChildViewController:_myCardTableViewController];
    [self.view addSubview:_myCardTableViewController.tableView];
    
}

#pragma mark - 选择Card类型
-(void) segmentedControl:(SegmentedControl *)segmentedControl clickedItemAtIndex:(NSInteger)itemIndex
{
    _myCardTableViewController.myCardType=itemIndex;
    [_myCardTableViewController reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
      
}

@end
