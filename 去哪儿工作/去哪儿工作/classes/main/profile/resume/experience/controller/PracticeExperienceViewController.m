//
//  PracticeExperienceViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PracticeExperienceViewController.h"

@interface PracticeExperienceViewController ()

@end

@implementation PracticeExperienceViewController
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.title=@"实践经历";
        self.experienceType=ExperienceTypePractice;
    }
    return self;
}
@end
