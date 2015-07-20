//
//  NoticeViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NoticeSettingViewController.h"

@interface NoticeSettingViewController ()

@end

@implementation NoticeSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"提醒设置";
    //模型数据
    SettingSwitchItem * notice=[SettingSwitchItem  settingItemWithTtitle:@"打开提醒"];
    SettingGroup  * base=[[SettingGroup alloc] init];
    base.headerTitle=@"您可以通过设置，提醒自己在开奖日不要忘记购买彩票";
    base.settingItems=@[notice];
    _groups=@[base];

}

@end
