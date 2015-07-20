//
//  Ticket.h
//  线程
//
//  Created by 孙硕磊 on 7/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject
/*
   在多线程应用中，所有被抢夺的资源需要设置为原子属性，系统会在多线程抢夺时，保证该属性有且仅有一个线程能够访问。
   atomic必须与@synchronized一起使用
 */
@property(atomic,assign) NSUInteger ticketNum;

+(instancetype) sharedTicket;
@end
