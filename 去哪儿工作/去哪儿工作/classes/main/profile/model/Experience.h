//
//  Experience.h
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger
{
    ExperienceTypeEducation,
    ExperienceTypeCampus,
    ExperienceTypePractice
}ExperienceType;

typedef enum : NSUInteger
{
    ExperienceAccessTypeWrite,
    ExperienceAccessTypeUpdate
} ExperienceAccessType;


@interface Experience : NSObject
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * detail;
@property(nonatomic,copy) NSString * startTime;
@property(nonatomic,copy) NSString * endTime;

- (instancetype)initWithDict:(NSDictionary *) dict;
-(NSString *) toJson;
+(NSString *) toJsonWithArray:(NSArray *) array;
@end
