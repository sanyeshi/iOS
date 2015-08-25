//
//  Card.h
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Job;

@interface Card : NSObject
@property(nonatomic,assign) NSUInteger   Id;
@property(nonatomic,assign) BOOL         isRegisted;
@property(nonatomic,strong) Job         *job;
- (instancetype)initWithDict:(NSDictionary *) dict;
@end

