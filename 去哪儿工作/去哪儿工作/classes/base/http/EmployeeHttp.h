//
//  UserHttp.h
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Http.h"
#import "Experience.h"

//用户
#define kEmployeeLoginUrl             DataURL(@"employeeLogin")
#define kEmployeeLogoutUrl            DataURL(@"user/logout")
#define kEmployeeRegisterUrl          DataURL(@"sms/smsregister")
#define kEmployeeResetPasswordUrl     DataURL(@"sms/getback")
#define kEmployeeLookupUrl            DataURL(@"user/look")

#define kEmployeeUpdateUrl            DataURL(@"user/update")
#define kEmployeeIconUpdateUrl        DataURL(@"user/updateImage")
#define kUpdateEvaluationUrl          DataURL(@"resume/updateEvaluation")

#define kUpdateEducationExperienceUrl   DataURL(@"resume/updateEducationExperiment")
#define kUpdateCampusExperienceUrl      DataURL(@"resume/updateCampusExperiment")
#define kUpdatePracticeExperienceUrl    DataURL(@"resume/updatePracticeExperiment")
#define kUpdateTagsUrl                  DataURL(@"resume/updateTags")
#define kUpdateShowUrl                  DataURL(@"resume/personShow")


//job
#define kEmployeeJobUrl               DataURL(@"application/getAppByType")
#define kEmployeeJobApplicationUrl    DataURL(@"application/add")
#define kIsJobAppliedUrl              DataURL(@"job/check")


#define kEmployeeUnPunchCardUrl       DataURL(@"jobregist/getNot")
#define kEmployeeDidPunchCardUrl      DataURL(@"jobregist/getDoes")

#define kEmployeeeResumeUrl           DataURL(@"resume/get")

#define kEmployeeFavoriteUrl          DataURL(@"myConcern/list")
#define kEmployeeIsFavoriteUrl        DataURL(@"myConcern/isConcern")
#define kEmployeeAddFavoriteUrl       DataURL(@"myConcern/add")
#define kEmployeeDeleteFavoriteUrl    DataURL(@"myConcern/delete2")

#define kEmployeeUnpayedUrl           DataURL(@"order/getToPayMoneyPay")
#define kEmployeePayedUrl             DataURL(@"order/getPayedMoneyPay")

#define kEmployeeScoreUrl             DataURL(@"count/score")
#define kEmployeeMoneyUrl             DataURL(@"count/money")


@class Employee;
@class Resume;

@interface EmployeeHttp:NSObject

#pragma mark -用户
+(void) employeeLoginWithPhone:(NSString *) phone password:(NSString *) password  success:(void (^)(NSDictionary * dict))success fail:(void (^)())fail;

+(void) employeeRegisterWithPhone:(NSString *) phone password:(NSString *) password checkcode:(NSString *) checkcode success:(void (^)(NSDictionary * dict))success fail:(void (^)())fail;

+(void) employeeResetPasswordWithPhone:(NSString *) phone password:(NSString *) password checkcode:(NSString *) checkcode success:(void (^)(NSDictionary * dict))success fail:(void (^)())fail;

+(void) getEmployeeWithPhone:(NSString *) phone password:(NSString *) password  success:(void (^)(Employee * employee))success fail:(void (^)())fail;

+(void) updateEmployeeWithParas:(NSDictionary *) paras success:(void (^)(Employee *employee))success fail:(void (^)())fail;
+(void) updateEmployeeIconWithMD5:(NSString *) md5 success:(void (^)(BOOL isSuccess))success fail:(void (^)())fail;

+(void) updateExperienceWithExperienceType:(ExperienceType) type json: (NSString *) json success:(void (^)(BOOL isSucess))success fail:(void (^)())fail;

+(void) updateTagsWithTags:(NSString *) tags success:(void (^)(BOOL isSuccess))success fail:(void (^)())fail;

+(void) updateEmployeeEvaluationWithString:(NSString *) string success:(void (^)(BOOL isSucess))success fail:(void (^)())fail;

+(void) updateEmployeeShowWithImages:(NSString *) images success:(void (^)(BOOL isSuccess))success fail:(void (^)())fail;

#pragma mark -job

+(void) getEmployeeJobWithType:(NSString *) type oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;

+(void) applicationJobWithJobId:(NSUInteger) jobId success:(void (^)(NSDictionary * dict))success fail:(void (^)())fail;
+(void) isJobAppliedWithJobId:(NSUInteger) jobId success:(void (^)(BOOL isApplied))success fail:(void (^)())fail;


#pragma mark -收款
+(void) getEmployeePaymentWithType:(NSUInteger) type oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;

#pragma mark -打卡
+(void) getEmployeeCardWithType:(MyCardType) myCardType oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;

#pragma mark -简历
+(void) getEmployeeResumeSuccess:(void (^)(Resume * resume))success fail:(void (^)())fail;


#pragma mark -收藏
+(void) getEmployeeFavoriteWithType:(MyFavoriteType) myFavoriteType oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;

+(void) employeeIsFavoriteWithType:(NSString *) type  typeId:(NSInteger) typeId  success:(void (^)(BOOL isFavorite))success fail:(void (^)())fail;

+(void) employeeAddFavoriteWithType:(NSString *)type typeId:(NSInteger) typeId  success:(void (^)(NSDictionary * dict))success fail:(void (^)())fail;

+(void) employeeDeleteFavoriteWithType:(NSString *)type typeId:(NSInteger) typeId  success:(void (^)(NSDictionary * dict))success fail:(void (^)())fail;

#pragma mark -金库、积分
+(void) employeeScoreSuccess:(void (^)(NSUInteger score))success fail:(void (^)())fail;
+(void) employeeMoneySuccess:(void (^)(NSUInteger money))success fail:(void (^)())fail;

@end
