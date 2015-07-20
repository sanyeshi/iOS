//
//  ScoreNoticeViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ScoreNoticeSettingViewController.h"
#import "SettingItemTool.h"
#import "SettingItemKeys.h"



@interface ScoreNoticeSettingViewController ()
{
    SettingLabelItem * _startTimeLabelItem;
}
@end

@implementation ScoreNoticeSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"比分直播设置";
    //模型数据
    SettingSwitchItem * notice=[SettingSwitchItem  settingItemWithTtitle:@"提醒我关注的比赛"];
    SettingGroup  * base=[[SettingGroup alloc] init];
    base.footerTitle=@"当我关注的比赛比分发生变化时，通过小弹窗或推送进行提醒";
    base.settingItems=@[notice];
    
    __weak UIViewController * viewController=self;
    SettingLabelItem * startTime=[SettingLabelItem settingItemWithTtitle:@"起始时间" ];
    _startTimeLabelItem=startTime;
    startTime.key=ScoreNoticeStartTime;
    startTime.text=[SettingItemTool objectForKey:ScoreNoticeStartTime];
    if (startTime.text.length==0)
    {
      startTime.text=@"00:00";
    }
    startTime.operation=^{
        NSDateFormatter * fmt=[[NSDateFormatter alloc] init];
        fmt.dateFormat=@"HH:mm";
        NSDate * date=[fmt dateFromString:@"00:00"];
        
        UIDatePicker * datePicker=[[UIDatePicker alloc] init];
        datePicker.datePickerMode=UIDatePickerModeTime;
        datePicker.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        datePicker.date=date;
        [datePicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        
        //弹出键盘
        UITextField * textField=[[UITextField alloc] init];
        textField.inputView=datePicker;
        [viewController.view addSubview:textField];
        
        //成为第一响应者
        [textField becomeFirstResponder];
    };
    SettingLabelItem * endTime=[SettingLabelItem settingItemWithTtitle:@"结束时间" ];
    endTime.text=@"23:59";
    SettingGroup * advance=[[SettingGroup alloc] init];
    advance.settingItems=@[startTime,endTime];
    advance.headerTitle=@"只在以下时间接受比分直播";
    
    _groups=@[base,advance];
}


-(void) timeChange:(UIDatePicker *) datePicker
{
    NSDateFormatter * fmt=[[NSDateFormatter alloc] init];
    fmt.dateFormat=@"HH:mm";
    NSDate * date=datePicker.date;
    _startTimeLabelItem.text=[fmt stringFromDate:date];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    
}
@end
