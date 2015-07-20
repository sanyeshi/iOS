//
//  AwardSettingViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AwardSettingViewController.h"

@interface AwardSettingViewController ()

@end

@implementation AwardSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //模型数据
    self.title=@"开奖推送设置";
    SettingSwitchItem * ball=[SettingSwitchItem settingItemWithTtitle:@"双色球"];
    SettingSwitchItem * letou=[SettingSwitchItem settingItemWithTtitle:@"大乐透"];
    
    SettingGroup * group=[[SettingGroup alloc] init];
    group.headerTitle=@"打开设置即可在开奖后获取推送信息，获知开奖号码";
    group.settingItems=@[ball,letou];
    _groups=@[group];
}

@end
