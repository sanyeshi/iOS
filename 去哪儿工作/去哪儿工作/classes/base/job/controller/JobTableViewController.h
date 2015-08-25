//
//  JobTableViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageCollectionViewController.h"
@interface JobTableViewController : PageCollectionViewController

@property(nonatomic,copy)   NSString   * orderType;
@property(nonatomic,assign) NSUInteger   category;
@property(nonatomic,assign) BOOL         companyDetailViewControllerHidden;
@end
