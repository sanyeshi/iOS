//
//  CompanyModel.m
//  parttime
//
//  Created by 孙硕磊 on 4/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Company.h"
#import "Http.h"
#import "NSDate+Format.h"

@implementation Company
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
        self.companyName=[dict valueForKey:@"name"];
        self.address=[dict valueForKey:@"address"];
        self.contactName=[dict valueForKey:@"contact"];
        self.email=[dict valueForKey:@"email"];
        self.phone=[dict valueForKey:@"phone"];
        self.info=[dict valueForKey:@"description"];
        self.createTime=[NSDate stringFromDateWithMilliSecondsSince1970:[[dict valueForKey:@"createTime"] unsignedLongLongValue]];
        self.imageUrlStr=ImageURL([dict valueForKey:@"imageId"]);
        self.isVerified=[[dict valueForKey:@"verified"] boolValue];
    }
}
@end
