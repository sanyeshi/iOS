//
//  NSLayoutConstraint+Mutil.m
//  自动布局
//
//  Created by 孙硕磊 on 7/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NSLayoutConstraint+Mutil.h"

@implementation NSLayoutConstraint (Mutil)

+(NSArray *) constraintsWithVisualFormats:(NSArray *)formats options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    if (formats==nil||formats.count==0||views==nil||views.count==0)
    {
        return nil;
    }
    NSMutableArray * constrants=[NSMutableArray array];
    for (NSString * format in formats)
    {
        NSArray * arr=[self constraintsWithVisualFormat:format options:opts metrics:metrics views:views];
        [constrants addObjectsFromArray:arr];
    }
    return [constrants copy];
}

+(NSArray *) constraintsWithVisualFormats:(NSArray *)formats views:(NSDictionary *)views
{
   return  [self constraintsWithVisualFormats:formats options:0 metrics:nil views:views];
}

@end
