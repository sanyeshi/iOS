//
//  CompanyHttp.h
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Http.h"

//公司
#define kCompanyUrl              DataURL(@"enterprise/getAllVerified")
#define kCompanyDetailUrl        DataURL(@"enterprise/get")
#define kCompanyCommentUrl       DataURL(@"comment/listByEId")
#define kCompanyJobUrl           DataURL(@"job/sget")
#define kCompanyInternUrl        DataURL(@"intern/sget")

@class Company;

@interface CompanyHttp : NSObject
//公司
+(void) getCompany:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;
+(void) getCompanyWithId:(NSUInteger)Id success:(void (^)(Company * company))success fail:(void (^)())fail;
+(void) getCompanyCommentWithId:(NSUInteger)Id  oldPageCollection:(PageCollection *) oldPageCollection isAppended:(BOOL) isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;
+(void) getCompanyJobWithId:(NSUInteger)Id  oldPageCollection:(PageCollection *) oldPageCollection isAppended:(BOOL) isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;
+(void) getCompanyInternWithId:(NSUInteger)Id  oldPageCollection:(PageCollection *) oldPageCollection isAppended:(BOOL) isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;
@end
