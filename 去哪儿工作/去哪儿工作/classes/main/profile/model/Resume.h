//
//  Resume.h
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Employee;
@interface Resume : NSObject

@property(nonatomic,assign) NSUInteger   Id;
@property(nonatomic,strong) Employee   * employee;
@property(nonatomic,strong) NSArray    * campusExperiences;
@property(nonatomic,strong) NSArray    * educationExperiences;
@property(nonatomic,strong) NSArray    * practiceExperiences;
@property(nonatomic,copy)   NSString   * evaluation;
@property(nonatomic,strong) NSArray    * tags;
@property(nonatomic,strong) NSArray    * imageUrlStrs;

- (instancetype)initWithDict:(NSDictionary *) dict;
@end
