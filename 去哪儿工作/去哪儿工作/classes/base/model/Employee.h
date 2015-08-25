//
//  Employee.h
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Employee : NSObject<NSCoding>
@property(nonatomic,assign) NSUInteger   Id;
@property(nonatomic,assign) NSUInteger   age;
@property(nonatomic,copy)   NSString *   gender;
@property(nonatomic,copy)   NSString *   email;
@property(nonatomic,copy)   NSString *   grade;
@property(nonatomic,copy)   NSString *   imageUrlStr;
@property(nonatomic,assign) BOOL         isLocked;
@property(nonatomic,assign) BOOL         isVerified;
@property(nonatomic,copy)   NSString *   major;
@property(nonatomic,copy)   NSString *   school;
@property(nonatomic,copy)   NSString *   name;
@property(nonatomic,copy)   NSString *   phone;
@property(nonatomic,copy)   NSString *   password;
@property(nonatomic,copy)   NSString *   rejectReason;

- (instancetype)initWithDict:(NSDictionary *) dict;
+(NSString *) parseGenderFromCode:(NSUInteger) code;
+(NSUInteger) parseGenderToCodeFromString:(NSString *) string;

@end
