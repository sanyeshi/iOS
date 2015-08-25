//
//  HomeContentCellModel.m
//  parttime
//
//  Created by 孙硕磊 on 4/10/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HomeContent.h"
#import "Http.h"
#import "Company.h"

@implementation HomeContent

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
        self.fId=[[dict valueForKey:@"fid"] unsignedIntegerValue];
        self.title=[dict valueForKey:@"title"];
        self.content=[dict valueForKey:@"content"];
        self.imageUrlStr=ImageURL([dict valueForKey:@"imageId"]);
        self.type=[self homeCententCellType:[dict valueForKey:@"type"]];
        self.company=[[Company alloc] initWithDict:[dict valueForKey:@"enterprise"]];
    }
    return self;
}

#pragma mark -- 获取cell类型
-(HomeContentCellType) homeCententCellType:(NSString *) type
{
    HomeContentCellType homeContentCellType=HomeContentCellTypeJob;
    if ([@"intern" isEqualToString:type])
    {
        homeContentCellType=HomeContentCellTypeIntern;
    }
    else if([@"company" isEqualToString:type])
    {
        homeContentCellType=HomeContentCellTypeCompany;
    }
    return homeContentCellType;
}

@end
