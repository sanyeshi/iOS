//
//  SchoolViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ResumeBasicViewController.h"
#import "Experience.h"

@interface ExperienceViewController : ResumeBasicViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign) ExperienceType experienceType;
@end
