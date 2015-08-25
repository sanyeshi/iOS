//
//  ReceiptCenterViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ReceiptCenterViewController.h"
#import "SegmentedControl.h"
#import "MyReceiptTableViewController.h"

#define kSegmentedControlHeight  40.0f
#define kMargin                  10.0f

@interface ReceiptCenterViewController  ()<SegmentedControlDelegate>
{
    MyReceiptTableViewController * _myReceiptTableViewController;
}
@end

@implementation ReceiptCenterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的收款";
    //控件
    self.view.backgroundColor=GlobalTableViewBackgroundColor;
    CGFloat statusBarHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navigationBarHeight=self.navigationController.navigationBar.frame.size.height;
    //头部
    //头部
    CGFloat segmentedControlX=0;
    CGFloat segmentedControlY=statusBarHeight+navigationBarHeight;
    CGFloat segmentedControlW=self.view.frame.size.width;
    CGFloat segmentedControlH=kSegmentedControlHeight;
    
    SegmentedControl * segmentedControl=[[SegmentedControl alloc] initWithItems:@[@"待收款",@"已收款"]];
    segmentedControl.frame=CGRectMake(segmentedControlX, segmentedControlY,segmentedControlW,segmentedControlH);
    segmentedControl.delegate=self;
    [self.view addSubview:segmentedControl];
    

    //表格
    CGFloat tableViewX=0;
    CGFloat tableViewY=statusBarHeight+navigationBarHeight+kSegmentedControlHeight;
    CGFloat tableViewWidth=self.view.frame.size.width;
    CGFloat tableViewHeight=self.view.frame.size.height-tableViewY;
    _myReceiptTableViewController=[[MyReceiptTableViewController alloc] init];
    _myReceiptTableViewController.tableView.frame=CGRectMake(tableViewX,tableViewY,tableViewWidth,tableViewHeight);
    [self addChildViewController:_myReceiptTableViewController];
    [self.view addSubview:_myReceiptTableViewController.tableView];
    
}

#pragma mark - 选择Card类型
-(void) segmentedControl:(SegmentedControl *)segmentedControl clickedItemAtIndex:(NSInteger)itemIndex
{
    _myReceiptTableViewController.type=itemIndex;
    [_myReceiptTableViewController reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}
@end