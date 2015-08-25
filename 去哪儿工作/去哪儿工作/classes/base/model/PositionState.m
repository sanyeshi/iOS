//
//  PositionState.m
//  parttime
//
//  Created by 孙硕磊 on 5/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PositionState.h"

@implementation PositionState
- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
        self.state=[[dict valueForKey:@"status"] unsignedIntegerValue];
        self.name=[dict valueForKey:@"name"];
    }
    return self;
}

@end
