//
//  BaseSettingViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "BaseSettingViewController.h"


@interface BaseSettingViewController ()

@end

@implementation BaseSettingViewController


-(void) loadView
{
    UITableView * tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.backgroundView=nil;
    //平铺背景
    //tableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    tableView.backgroundColor=LotteryBackgroundColor;
    //tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    /*
    在iOS7中，为了全屏显示，系统会自动设置tableView的contentInset属性
    显示设置sectionFooterHeight或sectionHeaderHeight的值，需要调整contentInset的top值
    tableView.sectionFooterHeight=0;
    tableView.sectionHeaderHeight=20;
     */
    self.view=tableView;
    _tableView=tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup * group=_groups[section];
    return group.settingItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell =[SettingCell settingCellWithTableView:tableView];
    //覆盖数据要完全
    SettingGroup * group=_groups[indexPath.section];
    SettingItem * item=group.settingItems[indexPath.row];
    cell.settingItem=item;
    cell.indexPath=indexPath;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SettingGroup * group=_groups[indexPath.section];
    SettingItem * item=group.settingItems[indexPath.row];
    if (item.operation)
    {
        item.operation();
        return;
    }
    if ([item isKindOfClass:[SettingArrowItem class]])
    {
        SettingArrowItem * arrowItem=(SettingArrowItem *)item;
        if (arrowItem.showViewControllerClass)
        {
            [self.navigationController pushViewController:[[arrowItem.showViewControllerClass alloc] init] animated:YES];
        }
    }
   
}

#pragma mark - 表格头部、尾部
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup * group=_groups[section];
    return group.headerTitle;
}

-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SettingGroup * group=_groups[section];
    return group.footerTitle;
}


@end
