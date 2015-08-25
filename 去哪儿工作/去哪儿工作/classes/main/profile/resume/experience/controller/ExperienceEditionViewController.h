//
//  AddSchoolViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Experience.h"

@class ExperienceViewController;

@interface ExperienceEditionViewController : UITableViewController

@property(nonatomic,assign) NSInteger                 index;
@property(nonatomic,strong) ExperienceViewController  *parent;
@property(nonatomic,assign) ExperienceType             experienceType;
@property(nonatomic,assign) ExperienceAccessType       experienceAccessType;

//数据
@property(nonatomic,strong) NSArray     *experiences;

@end
