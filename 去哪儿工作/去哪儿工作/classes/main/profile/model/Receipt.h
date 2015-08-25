//
//  Receipt.h
//  parttime
//
//  Created by 孙硕磊 on 5/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Job;

@interface Receipt : NSObject
@property(nonatomic,assign) NSUInteger  Id;
@property(nonatomic,assign) BOOL        isPayed;
@property(nonatomic,assign) NSUInteger  price;
@property(nonatomic,strong) Job        *job;

- (instancetype)initWithDict:(NSDictionary *) dict;
@end
