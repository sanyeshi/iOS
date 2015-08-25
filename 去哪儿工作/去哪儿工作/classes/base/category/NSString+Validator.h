//
//  NSString+Validator.h
//  parttime
//
//  Created by 孙硕磊 on 5/13/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validator)
-(BOOL) isEmpty;
-(BOOL) isPhoneNumber;
-(BOOL) isEmailAddress;
@end
