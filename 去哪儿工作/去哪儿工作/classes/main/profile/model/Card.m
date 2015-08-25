//
//  Card.m
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Card.h"
#import "Job.h"

@implementation Card
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
        self.isRegisted=[[dict valueForKey:@"doesRegisted"] boolValue];
        //job
        self.job=[[Job alloc] initWithDict:[dict valueForKey:@"parttime"]];
    }
}

@end
