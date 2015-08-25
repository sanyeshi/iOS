//
//  MyJobViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "JobTableViewController.h"

@interface MyJobTableViewController : JobTableViewController
@property(nonatomic,assign) MyJobType myJobType;
-(void) reloadData;
@end
