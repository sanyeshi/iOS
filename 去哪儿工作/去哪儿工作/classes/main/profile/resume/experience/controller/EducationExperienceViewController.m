//
//  EducationExperienceViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "EducationExperienceViewController.h"

@interface EducationExperienceViewController ()

@end

@implementation EducationExperienceViewController
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title=@"教育经历";
        self.experienceType=ExperienceTypeEducation;
    }
    return self;
}



@end
