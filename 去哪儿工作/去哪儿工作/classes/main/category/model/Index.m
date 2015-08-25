//
//  Index.m
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Index.h"

@implementation Index
+ (instancetype)indexWithRow:(NSUInteger) row
{
    Index * index=[[Index alloc] init];
    index.row=row;
    return index;
}
@end
