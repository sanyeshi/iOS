//
//  JobHttpUtil.h
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Http.h"

//job
#define kJobUrl                  DataURL(@"job/getVerified")
#define kJobDetailUrl            DataURL(@"job/detail")
#define kJobAllTypeUrl           DataURL(@"jobtype/list")

@class Job;
@interface JobHttp : NSObject
//job
+(void) getJobWithCategory:(NSUInteger)category orderBy:(NSString *) orderType  oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;
+(void) getJobWithId:(NSUInteger)Id success:(void (^)(Job * job))success fail:(void (^)())fail;
+(void) getJobCategoryWithOrderType:(NSString *)orderType  success:(void (^)(NSArray * array))success fail:(void (^)())fail;

@end
