//
//  Job.m
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Job.h"
#import "PositionCategory.h"
#import "PositionState.h"
#import "Company.h"
#import "NSDate+Format.h"

@implementation Job

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        [self parseJobWithDict:dict];
    }
    return self;
}

-(void) parseJobWithDict:(NSDictionary *) dict
{
    if (dict)
    {
        self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
        self.title=[dict valueForKey:@"title"];
        NSDictionary * jobTypeDict=[dict valueForKey:@"jobType"];
        self.type=[jobTypeDict valueForKey:@"name"];
        self.name=[dict valueForKey:@"jobName"];
        self.salary=[[dict valueForKey:@"money"] unsignedIntegerValue];
        self.amount=[[dict valueForKey:@"amount"] unsignedIntegerValue];
        self.appliedAmount=[[dict valueForKey:@"hasAppliedAmount"] unsignedIntegerValue];
        self.limitApplyAmount=[[dict valueForKey:@"limitApplyAmount"] unsignedIntegerValue];
        self.genderRequiredType=[self parseGenderRequiredTypeWithString:[dict valueForKey:@"maleOrFemale"]];
        NSDictionary * enterprise=[dict valueForKey:@"enterprise"];
        self.companyName=[enterprise valueForKey:@"name"];
        self.checkerName=[dict valueForKey:@"checker"];
        self.contactName=[dict valueForKey:@"contactor"];
        self.contactPhone=[dict valueForKey:@"contactorPhone"];
        self.createTime=[NSDate stringFromDateWithMilliSecondsSince1970:[[dict valueForKey:@"createTime"] unsignedLongLongValue]];
        self.publishTime=[NSDate stringFromDateWithMilliSecondsSince1970:[[dict valueForKey:@"publishTime"] unsignedLongLongValue]];
        self.deadlineTime=[NSDate stringFromDateWithDateFormat:@"MM月dd日" milliSecondsSince1970:[[dict valueForKey:@"deadline"] unsignedLongLongValue]];
        
        self.workTime=[dict valueForKey:@"workTime"];
        self.address=[dict valueForKey:@"workplace"];
        self.info=[dict valueForKey:@"description"];
        
        self.category=[[PositionCategory alloc] initWithDict:[dict valueForKey:@"jobType"]];
        self.state=[[PositionState alloc] initWithDict:[dict valueForKey:@"jobProp"]];
        self.company=[[Company alloc] initWithDict:[dict valueForKey:@"enterprise"]];
    }
}

-(GenderRequiredType) parseGenderRequiredTypeWithString:(NSString *) string
{
    GenderRequiredType type;
    if (string==nil)
    {
        type=GenderRequiredTypeBoth;
    }
    else if ([@"female" isEqualToString:string])
    {
        type=GenderRequiredTypeFemale;
    }
    else if([@"male" isEqualToString:string])
    {
        type=GenderRequiredTypeMale;
    }
    return type;
}

@end
