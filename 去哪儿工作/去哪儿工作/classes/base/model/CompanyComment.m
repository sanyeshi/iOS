//
//  CompanyComment.m
//  parttime
//
//  Created by 孙硕磊 on 4/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyComment.h"
#import "NSDate+Format.h"

@implementation CompanyComment
- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        [self parseCommentWithDict:dict];
    }
    return self;
}

-(void) parseCommentWithDict:(NSDictionary *) dict
{
    if (dict)
    {
        self.name=[dict valueForKey:@"user_id"];
        self.word=[dict valueForKey:@"word"];
        self.score=4;
        self.postTime=[NSDate stringFromDateWithMilliSecondsSince1970:[[dict valueForKey:@"postTime"] unsignedLongLongValue]];
    }
}
@end
