//
//  HomeContentCellModel.h
//  parttime
//
//  Created by 孙硕磊 on 4/10/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Company;
typedef enum : NSUInteger
{
    HomeContentCellTypeJob,
    HomeContentCellTypeIntern,
    HomeContentCellTypeCompany
} HomeContentCellType;
@interface HomeContent : NSObject

@property(nonatomic,assign) NSUInteger  Id;
@property(nonatomic,assign) NSUInteger  fId;     //公司、实习、工作的id
@property(nonatomic,copy)   NSString  * title;
@property(nonatomic,copy)   NSString  * content;
@property(nonatomic,copy)   NSString  * imageUrlStr;
@property(nonatomic,assign) HomeContentCellType type;
@property(nonatomic,strong) Company *company;

- (instancetype)initWithDict:(NSDictionary *) dict;

@end
