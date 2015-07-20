//
//  Ticket.m
//  线程
//
//  Created by 孙硕磊 on 7/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Ticket.h"

static Ticket * instance=nil;

@implementation Ticket

/*
   使用内存地址实例化对象，所有实例方法，最终都会调用此方法
 */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    //确保执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //记录实例化对象
        instance=[super allocWithZone:zone];
    });
    return instance;
}

+(instancetype) sharedTicket
{
    //确保执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[Ticket alloc] init];
    });
    return instance;
}
@end
