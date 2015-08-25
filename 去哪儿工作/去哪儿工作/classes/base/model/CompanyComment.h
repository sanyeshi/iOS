//
//  CompanyComment.h
//  parttime
//
//  Created by 孙硕磊 on 4/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyComment : NSObject

@property(nonatomic,copy)   NSString     * name;
@property(nonatomic,assign) NSUInteger     score;
@property(nonatomic,copy)   NSString     * word;
@property(nonatomic,copy)   NSString     * postTime;

- (instancetype)initWithDict:(NSDictionary *) dict;

@end
