//
//  CompanyDetailViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyDetailCell.h"
@class Company;
@interface CompanyDetailViewController : UITableViewController
- (instancetype)initWithCompany:(Company *)company;
@end
