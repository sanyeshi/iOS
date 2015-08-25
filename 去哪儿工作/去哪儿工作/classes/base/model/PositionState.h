//
//  PositionState.h
//  parttime
//
//  Created by 孙硕磊 on 5/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionState : NSObject
@property(nonatomic,assign) NSUInteger Id;
@property(nonatomic,assign) NSUInteger state;
@property(nonatomic,copy)   NSString  *  name;
- (instancetype)initWithDict:(NSDictionary *) dict;
@end
