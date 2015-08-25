//
//  Index.h
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Index : NSObject
@property(nonatomic,assign) NSUInteger row;
+ (instancetype)indexWithRow:(NSUInteger) row;
@end
