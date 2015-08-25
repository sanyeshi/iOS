//
//  CampusExperienceViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CampusExperienceViewController.h"

@interface CampusExperienceViewController ()

@end

@implementation CampusExperienceViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title=@"校内经历";
        self.experienceType=ExperienceTypeCampus;
    }
    return self;
}
@end
