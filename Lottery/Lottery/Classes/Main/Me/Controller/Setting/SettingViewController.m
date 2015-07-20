//
//  SettingViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingViewController.h"
#import "PushSettingViewController.h"
#import "ShareSettingViewController.h"
#import "HelpViewController.h"
#import "ProductViewController.h"
#import "AboutSettingViewController.h"

#import "SettingItemTool.h"
#import "SettingItemKeys.h"

@interface SettingViewController ()
{
    
}
@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"设置";
    //模型数据
    SettingArrowItem * push=[SettingArrowItem settingItemWithIconName:@"MorePush" title:@"推送和提醒" showViewControllerClass:[PushSettingViewController class]];
    //copy状态下的block(堆内存)会对block内使用的外界变量产生强引用，而造成循环引用
    /*
     __weak SettingViewController  * settingViewController=self;
    #warning 循环引用，内存泄露
    push.operation=^{
        PushSettingViewController * pushSettingViewController=[[PushSettingViewController alloc] init];
        [settingViewController.navigationController pushViewController:pushSettingViewController animated:YES];
    };
    */
    
    SettingSwitchItem * shake=[SettingSwitchItem settingItemWithIconName:@"HandShake" title:@"摇一摇机选"];
    shake.key=SettingShake;
    shake.on=[SettingItemTool boolForKey:SettingShake];
    SettingSwitchItem * sound=[SettingSwitchItem settingItemWithIconName:@"SoundEffect" title:@"声音效果"];
    
    SettingArrowItem * update=[SettingArrowItem settingItemWithIconName:@"MoreUpdate" title:@"检查新版本" ];
    update.operation=^{
        UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil message:@"目前已是最新版本了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
    };
    SettingArrowItem * help=[SettingArrowItem settingItemWithIconName:@"MoreHelp" title:@"帮助" showViewControllerClass:[HelpViewController class]];
    SettingArrowItem * share=[SettingArrowItem settingItemWithIconName:@"MoreShare" title:@"分享" showViewControllerClass:[ShareSettingViewController class]];
    SettingArrowItem * message=[SettingArrowItem settingItemWithIconName:@"MoreMessage" title:@"查看消息" ];
    SettingArrowItem * recommend=[SettingArrowItem settingItemWithIconName:@"MoreNetease" title:@"产品推荐" showViewControllerClass:[ProductViewController class]];
    SettingArrowItem * about=[SettingArrowItem settingItemWithIconName:@"MoreAbout" title:@"关于" showViewControllerClass:[AboutSettingViewController class]];
    
    SettingGroup * base=[[SettingGroup alloc] init];
    base.settingItems=@[push,shake,sound];
    
    SettingGroup * advance=[[SettingGroup alloc] init];
    advance.settingItems=@[update,help,share,message,recommend,about];
    _groups=@[base,advance];
}


@end
