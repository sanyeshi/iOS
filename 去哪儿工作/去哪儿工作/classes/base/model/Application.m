//
//  Application.m
//  parttime
//
//  Created by 孙硕磊 on 5/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Application.h"
#import "Job.h"
#import "NSDate+Format.h"

@implementation Application

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
        self.applyTime=[NSDate stringFromDateWithDateFormat:@"yyyy.MM.dd hh:mm:ss" milliSecondsSince1970:[[dict valueForKey:@"applyTime"] longLongValue]];
        self.isPass=[[dict valueForKey:@"doesPass"] boolValue];
        self.job=[[Job alloc] initWithDict:[dict valueForKey:@"job"]];
        self.state=[dict valueForKey:@"state"];
    }
    return self;
}

@end
