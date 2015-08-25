//
//  InternHttpUtil.m
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "InternHttp.h"
#import "Intern.h"
#import "PageCollection.h"


@implementation InternHttp

#pragma mark - 实习
+(void) getInternWithId:(NSUInteger)Id success:(void (^)(Intern *))success fail:(void (^)())fail;
{
    [Http getJsonDataWithUrl:kInternDetailUrl parameters:@{@"id":[NSNumber numberWithUnsignedInteger:Id]} success:^(id json)
     {
         success([[Intern alloc] initWithDict:json]);
     } fail:fail];
}


+(void) getInternWithCategory:(NSUInteger)category orderBy:(NSString *)orderType oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
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
                     @"internType":[NSNumber numberWithUnsignedInteger:category]
                     };
    }
    [Http getPageCollectionWithUrl:kInternUrl parameters:parameters Class:[Intern class]  dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}

+(void) getInterCategoryWithOrderType:(NSString *)orderType success:(void (^)(NSArray *))success fail:(void (^)())fail
{
    [Http getPositionCategoryWithUrl:kInternAllTypeUrl orderType:nil success:success fail:fail];
}

@end
