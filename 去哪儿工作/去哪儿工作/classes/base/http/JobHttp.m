//
//  JobHttpUtil.m
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "JobHttp.h"
#import "Job.h"
#import "PageCollection.h"

@implementation JobHttp

#pragma mark - 兼职

+(void) getJobWithId:(NSUInteger)Id success:(void (^)(Job *))success fail:(void (^)())fail;
{
    [Http getJsonDataWithUrl:kJobDetailUrl parameters:@{@"id":[NSNumber numberWithUnsignedInteger:Id]} success:^(id json)
     {
         success([[Job alloc] initWithDict:json]);
     } fail:fail];
}

+(void) getJobWithCategory:(NSUInteger)category orderBy:(NSString *)orderType oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=nil;
    if (category==0)
    {
        parameters=@{@"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                     @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize],
                     @"orderBy":orderType
                     };
    }
    else
    {
        parameters=@{@"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                     @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize],
                     @"orderBy":orderType,
                     @"jobType":[NSNumber numberWithUnsignedInteger:category]};
    }
    [Http getPageCollectionWithUrl:kJobUrl parameters:parameters Class:[Job class]  dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}


+(void) getJobCategoryWithOrderType:(NSString *)orderType success:(void (^)(NSArray *))success fail:(void (^)())fail
{
    [Http getPositionCategoryWithUrl:kJobAllTypeUrl orderType:nil success:success fail:fail];
}


@end
