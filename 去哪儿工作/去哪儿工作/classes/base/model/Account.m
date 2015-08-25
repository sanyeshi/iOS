//
//  Account.m
//  去哪儿工作
//
//  Created by 孙硕磊 on 5/9/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Account.h"

static Account * instance;

@implementation Account


+ (instancetype )shareInstance
{
    //确保执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
       instance=[[Account alloc] init];
    });
    return instance;
}

-(void) update
{
    [self archivedToDocument];
}
-(void) archivedToDocument
{
    NSString * docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * filePath=[docPath stringByAppendingPathComponent:@"account.data"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[Account shareInstance]];
   [data writeToFile:filePath atomically:YES];
}

-(void) unarchiveFromDocument
{
    NSString * docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString * filePath=[docPath stringByAppendingPathComponent:@"account.data"];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if ([fileManage fileExistsAtPath:filePath])
    {
        Account * account= [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        instance.isLogin=account.isLogin;
        instance.phone=account.phone;
        instance.password=account.password;
        instance.employee=account.employee;
    }
}
//解档时调用
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self)
    {
        self.isLogin=[aDecoder decodeBoolForKey:@"isLogin"];
        self.phone=[aDecoder decodeObjectForKey:@"phone"];
        self.password=[aDecoder decodeObjectForKey:@"password"];
        self.employee=[aDecoder decodeObjectForKey:@"employee"];
    }
    return self;
}
//归档时调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //将对象的数据编码
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.employee forKey:@"employee"];
}
@end
