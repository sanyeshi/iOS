//
//  Application.h
//  parttime
//
//  Created by 孙硕磊 on 5/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Job;
@interface Application : NSObject

@property(nonatomic,assign) NSUInteger Id;
@property(nonatomic,copy)   NSString * applyTime;
@property(nonatomic,assign) BOOL       isPass;
@property(nonatomic,strong) Job      * job;
@property(nonatomic,copy)   NSString * state;

- (instancetype)initWithDict:(NSDictionary *) dict;
@end
