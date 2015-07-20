//
//  PushSettingViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PushSettingViewController.h"
#import "AwardSettingViewController.h"
#import "AnimationSettingViewController.h"
#import "ScoreNoticeSettingViewController.h"
#import "NoticeSettingViewController.h"

@interface PushSettingViewController ()

@end

@implementation PushSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"推送和提醒";
    //模型数据
    SettingArrowItem * awardNum=[SettingArrowItem  settingItemWithTtitle:@"中奖号码推送" showViewControllerClass:[AwardSettingViewController class]];
    SettingArrowItem * awardAnimation=[SettingArrowItem settingItemWithTtitle:@"中奖动画" showViewControllerClass:[AnimationSettingViewController class]];
    SettingArrowItem * scoreLive=[SettingArrowItem settingItemWithTtitle:@"比分直播提醒" showViewControllerClass:[ScoreNoticeSettingViewController class]];
    SettingArrowItem * noticeTimer=[SettingArrowItem settingItemWithTtitle:@"购彩定时提醒" showViewControllerClass:[NoticeSettingViewController class]];
    
    SettingGroup * group=[[SettingGroup alloc] init];
    group.settingItems=@[awardNum,awardAnimation,scoreLive,noticeTimer];
    _groups=@[group];
}

@end
