//
//  SettingCell.h
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingItem;

@interface SettingCell : UITableViewCell

@property(nonatomic,strong) NSIndexPath * indexPath;
@property(nonatomic,strong) SettingItem * settingItem;

+(instancetype) settingCellWithTableView:(UITableView *) tableView;

@end
