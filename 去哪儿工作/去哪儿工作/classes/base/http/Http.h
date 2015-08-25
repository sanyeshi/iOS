//
//  Http.h
//  parttime
//
//  Created by 孙硕磊 on 4/10/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kDataBaseUrl  @"http://pay.xywsc.com/parttime"
#define kImageBaseUrl @"http://123.56.91.1:4869"
#define DataURL(relativeUrl)  [NSString stringWithFormat:@"%@/%@",kDataBaseUrl,relativeUrl]
#define ImageURL(relativeUrl) [NSString stringWithFormat:@"%@/%@",kImageBaseUrl,relativeUrl]


#define kUploadImageURL          @"http://123.56.91.1:4869/upload"
//home
#define kHomeHeaderBannerUrl     DataURL(@"topbanner/list")
#define kHomeContentUrl          DataURL(@"headlines/list/")

//news
#define kNewsUrl                 DataURL(@"news/list")

//验证码
#define kSendCheckCodeUrl     DataURL(@"sms/send")

@class UIImage;
@class PageCollection;

@interface Http: NSObject
#pragma mark - get请求
+(void) getJsonDataWithUrl:(NSString *) url parameters:(NSDictionary *) parameters success:(void (^)(id json))success fail:(void (^)())fail;
#pragma mark - post请求
+(void) postJsonDataWithUrl:(NSString *) url parameters:(NSDictionary *) parameters success:(void (^)(id json))success fail:(void (^)())fail;

#pragma mark -上传图片
+ (void) uploadImageWithImage:(UIImage  *) image success:(void (^)(NSString * md5))success fail:(void (^)())fail;
+ (void) uploadImagesWithImages:(NSArray *) images success:(void (^)(NSArray * md5s))success fail:(void (^)())fail;


#pragma mark - 分页获取数据
+(void) getPageCollectionWithUrl:(NSString *) url parameters:(NSDictionary *) parameters Class:class dictName:(NSString *)dictName oldPageCollection:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection *))success fail:(void (^)())fail;

+(void) getPositionCategoryWithUrl:(NSString *) url orderType:(NSString *)orderType success:(void (^)(NSArray *))success fail:(void (^)())fail;


//首页
+(void) getHomeHeaderBanner:(void(^)(NSArray *banners))success fail:(void (^)())fail;
+(void) getHomeContent:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;

//资讯
+(void) getNews:(PageCollection *)oldPageCollection isAppended:(BOOL)isAppended success:(void (^)(PageCollection * newPageCollection))success fail:(void (^)())fail;

//验证码

+(void) sendRegisterCheckCodeWithPhone:(NSString *)phone;
+(void) sendResetPasswordCheckCodeWithPhone:(NSString *)phone;

@end
