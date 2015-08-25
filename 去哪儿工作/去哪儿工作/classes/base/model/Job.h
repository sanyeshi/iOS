//
//  Job.h
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PositionCategory;
@class PositionState;
@class Company;

typedef enum : NSUInteger
{
    GenderRequiredTypeBoth,
     GenderRequiredTypeMale,
     GenderRequiredTypeFemale
} GenderRequiredType;

@interface Job : NSObject
@property(nonatomic,assign) NSUInteger           Id;                  //id
@property(nonatomic,copy)   NSString           * title;               //标题
@property(nonatomic,copy)   NSString           * type;                //工作类型
@property(nonatomic,copy)   NSString           * name;                //职位名称
@property(nonatomic,assign) NSUInteger           salary;              //薪资
@property(nonatomic,assign) GenderRequiredType   genderRequiredType;  //性别要求
@property(nonatomic,assign) NSUInteger           amount;              //人数
@property(nonatomic,assign) NSUInteger           appliedAmount;       //申请人数
@property(nonatomic,assign) NSUInteger           limitApplyAmount;    //限制申请人数
@property(nonatomic,copy)   NSString           * companyName;         //公司名
@property(nonatomic,copy)   NSString           * checkerName;         //审查人员
@property(nonatomic,copy)   NSString           * contactName;         //联系人
@property(nonatomic,copy)   NSString           * contactPhone;        //联系电话
@property(nonatomic,copy)   NSString           * createTime;          //创建日期
@property(nonatomic,copy)   NSString           * publishTime;         //发布日期
@property(nonatomic,copy)   NSString           * deadlineTime;        //截止日期
@property(nonatomic,copy)   NSString           * workTime;            //工作日期
@property(nonatomic,copy)   NSString           * address;             //工作地点
@property(nonatomic,copy)   NSString           * info;                //工作描述

@property(nonatomic,strong) PositionCategory   * category;            //类别
@property(nonatomic,strong) PositionState      * state;               //状态
@property(nonatomic,strong) Company            * company;             //公司详情


- (instancetype)initWithDict:(NSDictionary *) dict;
@end
