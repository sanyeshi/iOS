//
//  ShareSettingViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ShareSettingViewController.h"

@interface ShareSettingViewController ()

@end

@implementation ShareSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"分享设置";
    //模型数据
    SettingArrowItem * weibo=[SettingArrowItem settingItemWithIconName:@"WeiboSina" title:@"新浪微博"];
    SettingArrowItem * mes=[SettingArrowItem settingItemWithIconName:@"SmsShare" title:@"短信分享"];
    SettingArrowItem * email=[SettingArrowItem settingItemWithIconName:@"MailShare" title:@"邮件分享"];
    
    SettingGroup * group=[[SettingGroup alloc] init];
    group.settingItems=@[weibo,mes,email];
    _groups=@[group];
}


@end
