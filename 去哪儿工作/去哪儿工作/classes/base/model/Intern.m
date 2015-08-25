//
//  InternModel.m
//  parttime
//
//  Created by 孙硕磊 on 4/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Intern.h"
#import "PositionCategory.h"
#import "Company.h"
#import "NSDate+Format.h"

@implementation Intern

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
        self.title=[dict valueForKey:@"name"];
        NSDictionary * typeDict=[dict valueForKey:@"internType"];
        self.type=[typeDict valueForKey:@"name"];
        self.salary=[[dict valueForKey:@"monthSalary"] unsignedIntegerValue];
        self.amount=[[dict valueForKey:@"amount"] unsignedIntegerValue];
        self.appliedAmount=[[dict valueForKey:@"hasAppliedAmount"] unsignedIntegerValue];
        NSDictionary * enterprise=[dict valueForKey:@"enterprise"];
        self.companyName=[enterprise valueForKey:@"name"];
        self.contactName=[dict valueForKey:@"contactor"];
        self.contactPhone=[dict valueForKey:@"contactorPhone"];
        self.publishTime=[NSDate stringFromDateWithMilliSecondsSince1970:[[dict valueForKey:@"publishTime"] unsignedLongLongValue]];
        self.workTime=[dict valueForKey:@"workTime"];
        self.address=[dict valueForKey:@"workPlace"];
        self.info=[dict valueForKey:@"description"];
        //类别
        self.category=[[PositionCategory alloc] initWithDict:[dict valueForKey:@"internType"]];
        //company
        self.company=[[Company alloc] initWithDict:[dict valueForKey:@
                                                    "enterprise"]];
    }
}

@end
