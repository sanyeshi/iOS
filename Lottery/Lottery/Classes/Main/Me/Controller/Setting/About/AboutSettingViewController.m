//
//  AboutSettingViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AboutSettingViewController.h"
#import "AboutSettingHeaderView.h"

@interface AboutSettingViewController ()

@end

@implementation AboutSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"关于";
    //模型数据
    SettingArrowItem * remark=[SettingArrowItem settingItemWithTtitle:@"评分支持"];
    SettingArrowItem * phone=[SettingArrowItem settingItemWithTtitle:@"客户电话" subTitle:@"020-83568090"];
   
    SettingGroup * group=[[SettingGroup alloc] init];
    group.settingItems=@[remark,phone];
    _groups=@[group];
    
    self.tableView.tableHeaderView=[AboutSettingHeaderView headerView];
}

@end
