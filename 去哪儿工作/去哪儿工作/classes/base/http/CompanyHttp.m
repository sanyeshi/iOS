//
//  CompanyHttp.m
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyHttp.h"
#import "PageCollection.h"
#import "Company.h"
#import "CompanyComment.h"
#import "Job.h"
#import "Intern.h"


@implementation CompanyHttp
#pragma mark -公司
+(void) getCompany:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    [Http getPageCollectionWithUrl:kCompanyUrl parameters:parameters Class:[Company class] dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}

+(void) getCompanyWithId:(NSUInteger)Id success:(void (^)(Company *))success fail:(void (^)())fail;
{
    
    [Http getJsonDataWithUrl:kCompanyDetailUrl parameters:@{@"id":[NSNumber numberWithUnsignedInteger:Id]} success:^(id json)
     {
         success([[Company alloc] initWithDict:json]);
     } fail:fail];
}

#pragma mark 获取公司评价
+(void) getCompanyCommentWithId:(NSUInteger)Id oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"eId":[NSNumber numberWithUnsignedInteger:Id],
                                @"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    [Http getPageCollectionWithUrl:kCompanyCommentUrl parameters:parameters Class:[CompanyComment class] dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}
#pragma mark -获取公司兼职
+(void)getCompanyJobWithId:(NSUInteger)Id oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"eId":[NSNumber numberWithUnsignedInteger:Id],
                                @"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    [Http getPageCollectionWithUrl:kCompanyJobUrl parameters:parameters Class:[Job class] dictName:nil  oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}

#pragma mark - 获取公司实习
+(void) getCompanyInternWithId:(NSUInteger)Id oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"eId":[NSNumber numberWithUnsignedInteger:Id],
                                @"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    [Http getPageCollectionWithUrl:kCompanyInternUrl parameters:parameters Class:[Intern class] dictName:nil  oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}

@end
