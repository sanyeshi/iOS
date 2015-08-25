//
//  HomeTopBannerModel.m
//  parttime
//
//  Created by 孙硕磊 on 4/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HomeHeaderBanner.h"
#import "Http.h"
@implementation HomeHeaderBanner
- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        self.title=[dict valueForKey:@"description"];
        self.imageUrl=ImageURL([dict valueForKey:@"imageId"]);
        self.jobId=[[dict valueForKey:@"jobId"] integerValue];
        
        #warning 参数为空
        self.title=@"职位推荐";
    }
    return self;
}
@end
