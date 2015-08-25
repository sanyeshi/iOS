//
//  InternHttpUtil.h
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Http.h"

//intern
#define kInternUrl               DataURL(@"intern/getVerified")
#define kInternDetailUrl         DataURL(@"intern/detail")
#define kInternAllTypeUrl        DataURL(@"interntype/list")

@class Intern;
@interface InternHttp : NSObject
//实习
+(void) getInternWithId:(NSUInteger)Id success:(void (^)(Intern * intern))success fail:(void (^)())fail;
+(void) getInternWithCategory:(NSUInteger)category orderBy:(NSString *) orderType  oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;
+(void) getInterCategoryWithOrderType:(NSString *)orderType  success:(void (^)(NSArray * array))success fail:(void (^)())fail;

@end
