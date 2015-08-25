//
//  ProfileMainViewController.h
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProfileHeaderView;

@interface ProfileRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) ProfileHeaderView *profileHeaderView;
@property(nonatomic,strong) UITableView      *tableView;       //数据表格
@property(nonatomic,assign) BOOL             isEnterJobCenterViewController;
@end
