//
//  PositionCategory.h
//  parttime
//
//  Created by 孙硕磊 on 5/1/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PositionCategory : NSObject
@property(nonatomic,assign) NSUInteger Id;        //职位类型ID
@property(nonatomic,copy)   NSString  *  name;    //职位名称

+(instancetype) positionCategoryWithId:(NSUInteger) Id  name:(NSString *) name;
- (instancetype)initWithDict:(NSDictionary *) dict;
@end
