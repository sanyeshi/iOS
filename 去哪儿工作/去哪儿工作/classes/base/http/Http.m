//
//  Http.m
//  parttime
//
//  Created by 孙硕磊 on 4/10/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Http.h"
#import <UIKit/UIKit.h>
#import "AlertView.h"
#import "AFNetworking.h"
#import "PositionCategory.h"

#import "HomeHeaderBanner.h"
#import "HomeContent.h"
#import "News.h"
#import "PageCollection.h"




@implementation Http


#pragma mark -网络是否可用
+(BOOL) isNetWorkingAvaliable
{
    /*
    AFNetworkReachabilityStatusUnknown          = -1,  // 未知
    AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
    AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
    AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络
     */
    //网络状态
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
       // NSLog(@"%d", status);
    }];
    return false;
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
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             if (success)
             {
                success(responseObject);
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

#pragma mark - post请求数据
+(void) postJsonDataWithUrl:(NSString *) url parameters:(NSDictionary *) parameters success:(void (^)(id json))success fail:(void (^)())fail;
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
             success(responseObject);
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


+ (void)uploadImageWithImage:(UIImage * ) image success:(void (^)(NSString * md5))success fail:(void (^)())fail
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:kUploadImageURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         NSData        * data;
         if (UIImagePNGRepresentation(image) == nil)
         {
             data = UIImageJPEGRepresentation(image, 1);
         }
         else
         {
             data = UIImagePNGRepresentation(image);
         }
         
        [formData appendPartWithFormData:data name:@"userfile"];
    }
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (success)
        {
            NSString  *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSInteger  index=[aString rangeOfString:@":"].location;
            NSRange    range;
            range.location=index+2;
            range.length=[aString length]-range.location-2;
            NSString  *md5=[aString substringWithRange:range];
            success(md5);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        if (fail)
        {
            fail();
        }
    }];
}

+(void) uploadImagesWithImages:(NSArray *)images success:(void (^)(NSArray *))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:kUploadImageURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         for (UIImage * image in images)
         {
             NSData  * data;
             if (UIImagePNGRepresentation(image) == nil)
             {
                 data = UIImageJPEGRepresentation(image, 1);
             }
             else
             {
                 data = UIImagePNGRepresentation(image);
             }
             [formData appendPartWithFormData:data name:@"userfile"];
         }
     }
     success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (success)
         {
             NSString  *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSInteger  index=[aString rangeOfString:@":"].location;
             NSRange    range;
             range.location=index+2;
             range.length=[aString length]-range.location-2;
             NSString *value=[aString substringWithRange:range];
             NSArray  *values =[value componentsSeparatedByString:@"\""];
             NSMutableArray * md5s=[NSMutableArray array];
             for (NSString * string in values)
             {
                 if (![string isEqualToString:@""])
                 {
                     [md5s addObject:string];
                 }
             }
             success(md5s);
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if (fail)
         {
             fail();
         }
     }];
}

#pragma mark - 分页获取数据
+(void) getPageCollectionWithUrl:(NSString *) url parameters:(NSDictionary *) parameters Class:class dictName:(NSString *)dictName oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    [Http getJsonDataWithUrl:url parameters:parameters success:^(id json)
     {
         NSDictionary * object=[json valueForKey:@"object"];
         NSArray * recordList=nil;
         if (object==nil)
         {
             recordList=[json valueForKey:@"recordList"];
         }
         else
         {
            recordList=[object valueForKey:@"recordList"];
         }
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

+(void) getPositionCategoryWithUrl:(NSString *) url orderType:(NSString *)orderType success:(void (^)(NSArray *))success fail:(void (^)())fail
{
    [Http getJsonDataWithUrl:url parameters:nil success:^(id json)
     {
         NSMutableArray * array=[[NSMutableArray alloc] initWithCapacity:[(NSDictionary *)json count]];
         for (NSDictionary * dict in json)
         {
             PositionCategory * category=[[PositionCategory alloc] initWithDict:dict];
             [array addObject:category];
         }
         success(array.copy);
     } fail:fail];
}


#pragma mark 获取首页顶部banner
+(void) getHomeHeaderBanner:(void (^)(NSArray *))success fail:(void (^)())fail;
{
    [Http getJsonDataWithUrl:kHomeHeaderBannerUrl parameters:nil success:^(id json)
     {
        //解析数据
        NSArray * dictArray=json;
        NSMutableArray * mutableArray=[[NSMutableArray alloc] initWithCapacity:dictArray.count];
        for (NSDictionary * dict in dictArray)
        {
            HomeHeaderBanner * model=[[HomeHeaderBanner alloc] initWithDict:dict];
            [mutableArray addObject:model];
        }
        success(mutableArray.copy);
    } fail:fail];
}

#pragma mark 获取首页数据

+(void) getHomeContent:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    [Http getPageCollectionWithUrl:kHomeContentUrl  parameters:parameters Class:[HomeContent class]  dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}



#pragma mark - 资讯
+(void) getNews:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail
{
    NSDictionary * parameters=@{@"cpage":[NSNumber numberWithUnsignedInteger:oldPageCollection.currentPage],
                                @"pageSize":[NSNumber numberWithUnsignedInteger:oldPageCollection.pageSize]};
    [Http getPageCollectionWithUrl:kNewsUrl  parameters:parameters Class:[News class]  dictName:nil oldPageCollection:oldPageCollection isAppended:isAppended success:success fail:fail];
}


#pragma mark -验证码
+(void) sendRegisterCheckCodeWithPhone:(NSString *)phone
{
    NSDictionary * parameters=@{@"phone":phone,
                                @"type":@"Register"};
    [Http getJsonDataWithUrl:kSendCheckCodeUrl parameters:parameters success:^(id json)
    {
    } fail:nil];
}

+(void) sendResetPasswordCheckCodeWithPhone:(NSString *)phone
{
    NSDictionary * parameters=@{@"phone":phone,
                                @"type":@"Getback"};
    [Http getJsonDataWithUrl:kSendCheckCodeUrl parameters:parameters success:^(id json)
     {
     } fail:nil];

}
@end
