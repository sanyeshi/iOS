//
//  BaseSettingViewController.h
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SettingGroup.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"
#import "SettingCell.h"

@interface BaseSettingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
   NSArray * _groups;   
}

@property(nonatomic,weak,readonly) UITableView * tableView;
@end
