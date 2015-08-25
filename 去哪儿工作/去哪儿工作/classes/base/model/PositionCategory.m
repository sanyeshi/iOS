//
//  PositionCategory.m
//  parttime
//
//  Created by 孙硕磊 on 5/1/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PositionCategory.h"

@implementation PositionCategory

+(instancetype) positionCategoryWithId:(NSUInteger) Id  name:(NSString *) name
{
    PositionCategory * category=[[PositionCategory alloc] init];
    category.Id=Id;
    category.name=name;
    return category;
}
- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
        self.name=[dict valueForKey:@"name"];
    }
    return self;
}
@end
