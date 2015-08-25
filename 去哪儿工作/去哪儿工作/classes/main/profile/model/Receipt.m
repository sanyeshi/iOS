//
//  Receipt.m
//  parttime
//
//  Created by 孙硕磊 on 5/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Receipt.h"
#import "Job.h"

@implementation Receipt
- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        [self parseReceiptWithDict:dict];
    }
    return self;
}

-(void) parseReceiptWithDict:(NSDictionary *) dict
{
    if (dict)
    {
        self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
        self.isPayed=[[dict valueForKey:@"doesMoneyPay"] boolValue];
        self.price=[[dict valueForKey:@"price"] unsignedIntegerValue];
        self.job=[[Job alloc] initWithDict:[dict valueForKey:@"parttime"]];
    }
}

@end
