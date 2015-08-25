//
//  CompanyModel.h
//  parttime
//
//  Created by 孙硕磊 on 4/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
@property(nonatomic,assign) NSUInteger Id;
@property(nonatomic,copy)   NSString * companyName;
@property(nonatomic,copy)   NSString * address;
@property(nonatomic,copy)   NSString * contactName;
@property(nonatomic,copy)   NSString * email;
@property(nonatomic,copy)   NSString * phone;
@property(nonatomic,copy)   NSString * info;
@property(nonatomic,copy)   NSString * createTime;
@property(nonatomic,copy)   NSString * imageUrlStr;
@property(nonatomic,assign) BOOL       isVerified;

- (instancetype)initWithDict:(NSDictionary *) dict;
@end
