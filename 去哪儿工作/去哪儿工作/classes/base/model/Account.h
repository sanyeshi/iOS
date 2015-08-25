//
//  Account.h
//  去哪儿工作
//
//  Created by 孙硕磊 on 5/9/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Employee;

@interface Account : NSObject<NSObject>
@property(nonatomic,assign) BOOL       isLogin;
@property(nonatomic,copy) NSString   * phone;
@property(nonatomic,copy) NSString   * password;
@property(nonatomic,strong) Employee * employee;
+ (instancetype )shareInstance;

-(void) update;
-(void) archivedToDocument;
-(void) unarchiveFromDocument;
@end
