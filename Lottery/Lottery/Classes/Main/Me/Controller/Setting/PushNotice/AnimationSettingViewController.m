//
//  AnimationSettingViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AnimationSettingViewController.h"

@interface AnimationSettingViewController ()

@end

@implementation AnimationSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"中奖动画设置";
    SettingSwitchItem * animation=[SettingSwitchItem settingItemWithTtitle:@"中奖动画"];
    
    SettingGroup * group=[[SettingGroup alloc] init];
    group.headerTitle=@"当您有新中奖订单，启动程序时通过动画提醒您。为避免过于频繁，高频彩不会提醒。";
    group.settingItems=@[animation];
    _groups=@[group];

}
@end
