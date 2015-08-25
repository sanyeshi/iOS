//
//  UserHttp.m
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AFNetworking.h"
#import <UIKit/UIKit.h>
#import "EmployeeHttp.h"
#import "AlertView.h"



#import "Employee.h"
#import "Account.h"
#import "Job.h"
#import "Intern.h"
#import "Company.h"
#import "Card.h"
#import "Resume.h"
#import "Receipt.h"
#import "Application.h"

#import "PageCollection.h"

#warning 参数为空
@implementation EmployeeHttp


#pragma mark - 登录
+(void) employeeLoginWithPhone:(NSString *)phone password:(NSString *)password success:(void (^)(NSDictionary * dict))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"phone":phone,
                                @"password":password
                               };
    
    [Http postJsonDataWithUrl:kEmployeeLoginUrl parameters:parameters success:^(id json)
     {
         success(json);
     }fail:fail];
}



#pragma mark -注册
+(void) employeeRegisterWithPhone:(NSString *)phone password:(NSString *)password checkcode:(NSString *)checkcode success:(void (^)(NSDictionary *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"phone":phone,
                                @"password":password,
                                @"code":checkcode};
    
    [Http getJsonDataWithUrl:kEmployeeRegisterUrl parameters:parameters success:^(id json)
     {
         if (success)
         {
             success(json);
         }
     } fail:fail];
}

#pragma mark -重置密码
+(void) employeeResetPasswordWithPhone:(NSString *)phone password:(NSString *)password checkcode:(NSString *)checkcode success:(void (^)(NSDictionary *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"phone":phone,
                                @"password":password,
                                @"code":checkcode};
    
    [Http getJsonDataWithUrl:kEmployeeResetPasswordUrl parameters:parameters success:^(id json)
     {
         if (success)
         {
             success(json);
         }
     } fail:fail];
}


+(void) getEmployeeWithPhone:(NSString *)phone password:(NSString *)password success:(void (^)(Employee *))success fail:(void (^)())fail
{
    void(^ NeedLogin)();
    NeedLogin=^()
    {
        [EmployeeHttp employeeLoginWithPhone:phone password:password success:^(NSDictionary *dict)
         {
             NSInteger code=[[dict valueForKey:@"code"] integerValue];
             if (code==1)
             {
                 NSDictionary * parameters=@{@"phone":phone,
                                             @"password":password
                                             };
                 [Http postJsonDataWithUrl:kEmployeeLookupUrl parameters:parameters success:^(id json)
                  {
                      Employee * employee=[[Employee alloc] initWithDict:[json valueForKey:@"object"]];
                      success(employee);
                  } fail:fail];
             }
             else
             {
                 success(nil);
                 if (fail)
                 {
                     fail();
                 }
             }
         }
         fail:fail];
    };
    NeedLogin();
}

#pragma mark -更新用户
+(void) updateEmployeeWithParas:(NSDictionary *)paras success:(void (^)( Employee *employee))success fail:(void (^)())fail
{
    
    [EmployeeHttp postJsonDataWithUrl:kEmployeeUpdateUrl parameters:paras success:^(id json)
     {
         NSString * info=[json valueForKey:@"info"];
         if ([info isEqualToString:@"success"])
         {
             Employee * employee=[[Employee alloc] initWithDict:[json valueForKey:@"object"]];
             success(employee);
         }
         else
         {
             success(nil);
         }
     } fail:fail];
    
}

#pragma mark -更新用户头像
+(void) updateEmployeeIconWithMD5:(NSString *)md5 success:(void (^)(BOOL))success fail:(void (^)())fail
{
     NSDictionary * paras=@{@"image":md5};
    [EmployeeHttp postJsonDataWithUrl:kEmployeeIconUpdateUrl parameters:paras success:^(id json)
    {
        NSString * info=[json valueForKey:@"info"];
        if ([info isEqualToString:@"success"])
        {
            success(YES);
        }
        else
        {
            success(NO);
        }
        
    } fail:fail];
}


+(void) updateEmployeeEvaluationWithString:(NSString *)string success:(void (^)(BOOL))success fail:(void (^)())fail
{
    NSDictionary * paras=@{@"str":string};
    [EmployeeHttp postJsonDataWithUrl:kUpdateEvaluationUrl parameters:paras success:^(id json)
     {
         NSString * info=[json valueForKey:@"info"];
         if ([info isEqualToString:@"success"])
         {
             success(YES);
         }
         else
         {
             success(NO);
         }
     } fail:fail];

}
#pragma mark -更新经历

+(void) updateExperienceWithExperienceType:(ExperienceType)type json:(NSString *)json success:(void (^)(BOOL))success fail:(void (^)())fail
{
    NSString * url=nil;
    if (type==ExperienceTypeEducation)
    {
        url=kUpdateEducationExperienceUrl;
    }
    else if (type==ExperienceTypeCampus)
    {
        url=kUpdateCampusExperienceUrl;
    }
    else
    {
        url=kUpdatePracticeExperienceUrl;
    }
    
    NSDictionary * paras=@{@"jsonlist":json};
    [EmployeeHttp postJsonDataWithUrl:url parameters:paras success:^(id json)
     {
         NSString * info=[json valueForKey:@"info"];
         if ([info isEqualToString:@"success"])
         {
             success(YES);
         }
         else
         {
             success(NO);
         }
     } fail:fail];
}


#pragma mark -更新标签
+(void) updateTagsWithTags:(NSString *) tags success:(void (^)(BOOL isSuccess))success fail:(void (^)())fail
{
    NSDictionary * paras=@{@"tags":tags};
    [EmployeeHttp postJsonDataWithUrl:kUpdateTagsUrl parameters:paras success:^(id json)
     {
         NSString * info=[json valueForKey:@"info"];
         if ([info isEqualToString:@"success"])
         {
             success(YES);
         }
         else
         {
             success(NO);
         }
     } fail:fail];
}

#pragma mark - 更新图片
+(void) updateEmployeeShowWithImages:(NSString *)images success:(void (^)(BOOL))success fail:(void (^)())fail
{
    NSDictionary * paras=@{@"images":images};
    [EmployeeHttp postJsonDataWithUrl:kUpdateShowUrl parameters:paras success:^(id json)
     {
         NSString * info=[json valueForKey:@"info"];
         if ([info isEqualToString:@"success"])
         {
             success(YES);
         }
         else
         {
             success(NO);
         }
     } fail:fail];
}


#pragma mark -请求处理
+(void) requestHandlerWithUrl:(NSString *) url parameters:(NSDictionary *) parameters responseObject:(id) responseObject success:(void (^)(id json))success fail:(void (^)())fail
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     NSInteger code=[[responseObject valueForKey:@"code"] integerValue];
     if (code==1)
      {
        success(responseObject);
      }
      else if (code==0)
      {
         if (fail)
         {
             NSString * info=[responseObject valueForKey:@"info"];
             AlertView * alertView=[[AlertView alloc] init];
             alertView.title=info;
             [alertView show];
             fail();
         }
            
     }
     else if(code==-1)
     {
          //登录验证
           Account * account=[Account shareInstance];
           NSString * phone=account.phone;
           NSString * password=account.password;
           [EmployeeHttp employeeLoginWithPhone:phone password:password success:^(NSDictionary *dict)
            {
                 NSInteger isLogin=[[dict valueForKey:@"code"] unsignedIntegerValue];
                 if (isLogin==1)
                 {
                     [EmployeeHttp getJsonDataWithUrl:url parameters:parameters success:success fail:fail];
                 }
                 else
                 {
                     AlertView * alertView=[[AlertView alloc] init];
                     alertView.title=@"登陆失效，请重新登陆";
                     [alertView show];
                     if (fail)
                     {
                         fail();
                     }
                 }
             } fail:fail];
        }
        else if(code==-2)
        {
            //fail为空，表示不显示提示信息
            if (fail)
            {
                //没有权限
                AlertView * alertView=[[AlertView alloc] init];
                alertView.title=@"暂无权限，请等待审核";
                [alertView show];
                fail();
            }
       }
}
#pragma mark -get请求获取数据
+(void) getJsonDataWithUrl:(NSString *) url parameters:(NSDictionary *) parameters success:(void (^)(id json))success fail:(void (^)())fail
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //获取网络数据
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    //异步访问网络，回调是主线程，更新UI
    [manager GET:url parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success)
         {
             [EmployeeHttp requestHandlerWithUrl:url parameters:parameters responseObject:responseObject success:success fail:fail];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         AlertView * alertView=[[AlertView alloc] init];
         alertView.title=@"网络不给力,请刷新重试";
         [alertView show];
         if (fail)
         {
             fail();
         }
     }
     ];
}


#pragma mark -post请求获取数据
+(void) postJsonDataWithUrl:(NSString *) url parameters:(NSDictionary *) parameters success:(void (^)(id json))success fail:(void (^)())fail
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //获取网络数据
    AFHTTPRequestOperationManager * manager=[AFHTTPRequestOperationManager manager];
    //异步访问网络，回调是主线程，更新UI
    [manager POST:url parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         if (success)
         {
             [EmployeeHttp requestHandlerWithUrl:url parameters:parameters responseObject:responseObject success:success fail:fail];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         AlertView * alertView=[[AlertView alloc] init];
         alertView.title=@"网络不给力,请刷新重试";
         [alertView show];
         if (fail)
         {
             fail();
         }
     }
     ];
}




#pragma mark - 分页获取数据
+(void) getPageCollectionWithUrl:(NSString *) url parameters:(NSDictionary *) parameters Class:class dictName:(NSString *)dictName oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
  {
    [EmployeeHttp getJsonDataWithUrl:url parameters:parameters success:^(id json)
     {
             NSDictionary * object=[json valueForKey:@"object"];
             NSArray * recordList=[object valueForKey:@"recordList"];;
             //解析新的pageCollection
             PageCollection * newPageCollection=[[PageCollection alloc] init];
             [newPageCollection parsePageCollectionWithDict:object];
             //将原有的数据追加到新的后面或插入到前面
             if (isAppended)
             {
                 newPageCollection.array=[NSMutableArray arrayWithArray:oldPageCollection.array];
             }
             else
             {
                 newPageCollection.array=[NSMutableArray array];
             }
             NSMutableArray * array=newPageCollection.array;
             for (NSDictionary * dict in recordList)
             {
                 if (dictName)
                 {
                     [array addObject:[[class alloc] initWithDict:[dict valueForKey:dictName]]];
                 }
                 else
                 {
                     [array addObject:[[class alloc] initWithDict:dict]];
                 }
             }
             if (!isAppended)
             {
                 [array arrayByAddingObjectsFromArray:oldPageCollection.array];
             }
             success(newPageCollection);
       } fail:fail];
}


#pragma mark -兼职
+(void) getEmployeeJobWithType:(NSString *)type oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"type":type,
                                @"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    [EmployeeHttp getPageCollectionWithUrl:kEmployeeJobUrl parameters:parameters Class:[Application class]  dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}


+(void) applicationJobWithJobId:(NSUInteger)jobId success:(void (^)(NSDictionary *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"jId":[NSNumber numberWithUnsignedInteger:jobId]};
    [EmployeeHttp getJsonDataWithUrl:kEmployeeJobApplicationUrl parameters:parameters success:^(id json)
     {
         success(json);
     } fail:fail];
}


+(void) isJobAppliedWithJobId:(NSUInteger)jobId success:(void (^)(BOOL))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"id":[NSNumber numberWithUnsignedInteger:jobId]};
    [EmployeeHttp getJsonDataWithUrl:kIsJobAppliedUrl parameters:parameters success:^(id json)
     {
         NSInteger code=[[json valueForKey:@"code"] integerValue];
         if (code==1)
         {
             success(YES);
         }
         else
         {
             success(NO);
         }
    } fail:nil];
}

#pragma mark -收款
+(void) getEmployeePaymentWithType:(NSUInteger)type oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    NSString * url=kEmployeeUnpayedUrl;
    if (type==1)
    {
        url=kEmployeePayedUrl;
    }
    [EmployeeHttp getPageCollectionWithUrl:url parameters:parameters Class:[Receipt class]  dictName:nil oldPageCollection:   oldPageCollection isAppended:isAppended success:success fail:fail];
}


#pragma mark - 打卡
+(void) getEmployeeCardWithType:(MyCardType)myCardType oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    NSString * urlStr=kEmployeeUnPunchCardUrl;
    if (myCardType==MyCardTypeDid)
    {
        urlStr=kEmployeeDidPunchCardUrl;
    }
    [EmployeeHttp getPageCollectionWithUrl:urlStr parameters:parameters Class:[Card class]  dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}

#pragma mark- 简历
+(void) getEmployeeResumeSuccess:(void (^)(Resume *))success fail:(void (^)())fail
{
     [EmployeeHttp getJsonDataWithUrl:kEmployeeeResumeUrl parameters:nil success:^(id json)
     {
         NSDictionary * object=[json valueForKey:@"object"];
         Resume * resume=[[Resume alloc] initWithDict:object];
         success(resume);
     } fail:fail];
}


#pragma mark - 收藏
+(void) getEmployeeFavoriteWithType:(MyFavoriteType)myFavoriteType oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSString * type=@"job";
    Class class=[Job class];
    if (myFavoriteType==MyFavoriteIntern)
    {
        type=@"intern";
        class=[Intern class];
    }
    else if(myFavoriteType==MyFavoriteTypeRecruitment)
    {
        type=@"company";
        class=[Company class];
    }
    NSDictionary * parameters=@{@"type":type,
                                @"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
     [EmployeeHttp getPageCollectionWithUrl:kEmployeeFavoriteUrl parameters:parameters Class:class dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}


+(void) employeeIsFavoriteWithType:(NSString *)type typeId:(NSInteger)typeId success:(void (^)(BOOL isFavorite))success fail:(void (^)())fail
{
    //参数
    NSDictionary * parameters=@{@"type":type,
                                @"id":[NSNumber numberWithInteger:typeId]};
    
    [EmployeeHttp getJsonDataWithUrl:kEmployeeIsFavoriteUrl parameters:parameters success:^(id json)
     {
         NSString * info=[json valueForKey:@"info"];
         if (info!=nil&&[info isEqualToString:@"已关注"])
         {
             success(YES);
         }
         else
         {
             success(NO);
         }
     } fail:fail];
    
}

+(void) employeeAddFavoriteWithType:(NSString *)type typeId:(NSInteger)typeId success:(void (^)(NSDictionary *))success fail:(void (^)())fail
{
    //参数
    NSDictionary * parameters=@{@"type":type,
                                @"id":[NSNumber numberWithInteger:typeId]};
    [EmployeeHttp getJsonDataWithUrl:kEmployeeAddFavoriteUrl parameters:parameters success:^(id json)
     {
         success(json);
     } fail:fail];

}

+(void) employeeDeleteFavoriteWithType:(NSString *)type typeId:(NSInteger)typeId success:(void (^)(NSDictionary *))success fail:(void (^)())fail
{
    //参数
    NSDictionary * parameters=@{@"type":type,
                                @"id":[NSNumber numberWithInteger:typeId]};
    [EmployeeHttp getJsonDataWithUrl:kEmployeeDeleteFavoriteUrl parameters:parameters success:^(id json)
     {
         success(json);
     } fail:fail];
}



#pragma mark -积分和金库
+(void) employeeScoreSuccess:(void (^)(NSUInteger score))success fail:(void (^)())fail
{
    [EmployeeHttp getJsonDataWithUrl:kEmployeeScoreUrl parameters:nil success:^(id json)
     {
         NSUInteger score=[[json valueForKey:@"object"] unsignedIntegerValue];
         success(score);
     } fail:fail];
    
}

+(void) employeeMoneySuccess:(void (^)(NSUInteger))success fail:(void (^)())fail
{
    [EmployeeHttp getJsonDataWithUrl:kEmployeeMoneyUrl parameters:nil success:^(id json)
     {
         NSUInteger money=[[json valueForKey:@"object"] unsignedIntegerValue];
         success(money);
     } fail:fail];
}

@end
