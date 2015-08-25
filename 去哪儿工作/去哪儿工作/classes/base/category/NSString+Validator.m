//
//  NSString+Validator.m
//  parttime
//
//  Created by 孙硕磊 on 5/13/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NSString+Validator.h"

@implementation NSString (Validator)


-(BOOL) isEmpty
{
    NSString * str=[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str length]==0)
    {
        return true;
    }
    return false;
}
-(BOOL) isPhoneNumber
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *mobileValidator = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [mobileValidator evaluateWithObject:self];
    /*
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
   
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
     */
}

-(BOOL) isEmailAddress
{
    NSString* emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* emailValidator = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailValidator evaluateWithObject:self];
}
@end
