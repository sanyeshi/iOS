//
//  Model.h
//  自动布局
//
//  Created by 孙硕磊 on 7/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
-(void) sayHello;   //方法名是syaHello
-(void) sayHello:(NSString *) str;   //方法名是sayHello:,与sayHello不同
/*
-(void) sayHello:(NSUInteger) age;
  //方法名为sayHello:导致重定义
 */
@end
