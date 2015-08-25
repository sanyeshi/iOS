//
//  MainViewController.m
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//


#import "CategoryRootViewController.h"
#import "CategoryHeaderView.h"
#import "JobCell.h"
#import "CategoryJobTableViewController.h"
#import "CategoryInternTableViewController.h"
#import "PositionCategory.h"
#import "MJRefresh.h"
#import "JobHttp.h"
#import "InternHttp.h"


@interface CategoryRootViewController () <CategoryHeaderViewDelegate>
{
    UISegmentedControl                * _segmentedControl;
    CategoryHeaderView                * _categoryHeaderView;
    CategoryJobTableViewController    * _categoryJobTableViewController;
    CategoryInternTableViewController * _categoryInternTableViewController;
    
    //数据
    NSArray  *  _jobAllTypeArray;
    NSArray  *  _internAllTypeArray;
    NSArray  *  _orderAllTypeArray;
    NSString *  _orderType;
    NSUInteger  _category;
}
@end
@implementation CategoryRootViewController

-(void) viewDidLoad
{
    _orderType=@"newest";
    _category=0;
    self.title=@"分类";
    //导航栏标题
    _segmentedControl=[[UISegmentedControl alloc] initWithItems:@[@"兼职",@"实习"]];
    _segmentedControl.frame=CGRectMake(0, 0, 140, 25);
    _segmentedControl.selectedSegmentIndex=0;
    [_segmentedControl addTarget:self action:@selector(indexChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView=_segmentedControl;
    self.navigationController.navigationBar.tintColor=GlobalNavigationBarTextColor;
    [self createSubViews];
}

#pragma mark - 创建子控件
-(void) createSubViews
{
    self.view.backgroundColor=GlobalTableViewBackgroundColor;
    CGFloat width=self.view.frame.size.width;
    CGFloat height=self.view.frame.size.height;
    CGFloat statusBarHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navigationBarHeight=self.navigationController.navigationBar.frame.size.height;
    CGFloat tarBarHeight=self.tabBarController.tabBar.frame.size.height;
    //分类
    CGFloat categoryHeaderViewX=0;
    CGFloat categoryHeaderViewY=statusBarHeight+navigationBarHeight;
    CGFloat categoryHeaderViewW=width;
    CGFloat categoryHeaderViewH=kCategoryHeaderViewHeight;
    CGRect  categoryHeaderViewFrame=CGRectMake(categoryHeaderViewX,categoryHeaderViewY,categoryHeaderViewW,categoryHeaderViewH);
    _categoryHeaderView=[[CategoryHeaderView alloc] init];
    _categoryHeaderView.delegate=self;
    _categoryHeaderView.frame=categoryHeaderViewFrame;
    [self.view addSubview:_categoryHeaderView];
    
    //表格
    CGFloat categoryTableViewX=0;
    CGFloat categoryTableViewY=CGRectGetMaxY(categoryHeaderViewFrame);
    CGFloat categoryTableViewW=width;
    CGFloat categoryTableViewH=height-categoryTableViewY-tarBarHeight;
    CGRect  categoryTableViewFrame=CGRectMake(categoryTableViewX,categoryTableViewY,categoryTableViewW,categoryTableViewH);
    
    //兼职
    _categoryJobTableViewController=[[CategoryJobTableViewController alloc] init];
    _categoryJobTableViewController.tableView.frame=categoryTableViewFrame;
    _categoryJobTableViewController.tableView.contentInset=UIEdgeInsetsMake(10, 0, 0, 0);
    [self addChildViewController:_categoryJobTableViewController];
    [self.view addSubview:_categoryJobTableViewController.tableView];
    
    //实习
    _categoryInternTableViewController=[[CategoryInternTableViewController alloc] init];
    _categoryInternTableViewController.tableView.frame=_categoryJobTableViewController.tableView.frame;
    _categoryInternTableViewController.tableView.contentInset=UIEdgeInsetsMake(10, 0, 0, 0);
    [self addChildViewController:_categoryInternTableViewController];
    
    //请求数据
    [self requestData];
}

#pragma mark -请求数据
-(void) requestData
{
    [JobHttp getJobCategoryWithOrderType:nil success:^(NSArray *array)
    {
        NSMutableArray * types=[[NSMutableArray alloc] initWithObjects:[PositionCategory positionCategoryWithId:0 name:@"全部兼职"], nil];
        [types addObjectsFromArray:array];
        _jobAllTypeArray=[types copy];
        _categoryHeaderView.jobAllTypeArray=_jobAllTypeArray;
        _categoryHeaderView.orderAllTypeArray=@[[PositionCategory positionCategoryWithId:0 name:@"最新"],[PositionCategory positionCategoryWithId:1 name:@"最热"]];
    } fail:^
    {
    }];
    
    [InternHttp getInterCategoryWithOrderType:nil success:^(NSArray *array)
     {
         NSMutableArray * types=[[NSMutableArray alloc] initWithObjects:[PositionCategory positionCategoryWithId:0 name:@"全部实习"], nil];
         [types addObjectsFromArray:array];
         _internAllTypeArray=[types copy];
         _categoryHeaderView.internAllTypeArray=_internAllTypeArray;
     } fail:^
     {
     }];
}

#pragma mark - 切换实习和兼职
-(void) indexChanged:(UISegmentedControl *)segmentedControl
{
    _orderType=@"newest";
    _category=0;
    if (segmentedControl.selectedSegmentIndex==0)
    {
       //兼职
        [_categoryHeaderView setCategoryType:CategoryTypeParttimeJob];
        _categoryJobTableViewController.tableView.hidden=NO;
        _categoryInternTableViewController.tableView.hidden=YES;
    }
    else
    {
        //实习
        [_categoryHeaderView setCategoryType:CategoryTypeInternship];
        _categoryInternTableViewController.tableView.hidden=NO;
        if (_categoryInternTableViewController.tableView.superview!=self.view)
        {
          [self.view addSubview:_categoryInternTableViewController.tableView];
        }
        _categoryJobTableViewController.tableView.hidden=YES;
    }
}

#pragma mark -点击兼职或实习类型
-(void) categoryHeaderView:(CategoryHeaderView *)categoryHeaderView didSelectSection:(NSUInteger)section
{
    if (categoryHeaderView.popupListView==nil)
    {
        [_categoryHeaderView showPopupListView];
    }
    else
    {
        [categoryHeaderView removePopupListViewWithAnimationCompletion:nil];
    }
}

-(void) categoryHeaderView:(CategoryHeaderView *)categoryHeaderView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (_segmentedControl.selectedSegmentIndex==0)
        {
            PositionCategory * positionCategory=_jobAllTypeArray[indexPath.row];
            _category=positionCategory.Id;
        }
        else
        {
            PositionCategory * positionCategory=_internAllTypeArray[indexPath.row];
            _category=positionCategory.Id;
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            _orderType=@"newest";
        }
        else
        {
            _orderType=@"hot";
        }
    }
    
    [categoryHeaderView removePopupListViewWithAnimationCompletion:^(BOOL finished)
    {
        
        if (_segmentedControl.selectedSegmentIndex==0)
        {
            //兼职
            [_categoryJobTableViewController setOrderType:_orderType];
            [_categoryJobTableViewController setCategory:_category];
            [_categoryJobTableViewController beginHeaderRefreshing];
            
        }
        else
        {
            //实习
            [_categoryInternTableViewController setOrderType:_orderType];
            [_categoryInternTableViewController setCategory:_category];
            [_categoryInternTableViewController beginHeaderRefreshing];
        }
        
    }];
}


-(void) viewDidDisappear:(BOOL)animated
{
    [_categoryHeaderView removePopupListView];
}
@end
