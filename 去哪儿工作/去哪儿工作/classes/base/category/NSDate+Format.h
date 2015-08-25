//
//  NSDate+Format.h
//  parttime
//
//  Created by 孙硕磊 on 5/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)
+(NSString *) stringFromDate:(NSDate *)date;
+(NSString *) stringFromDateWithMilliSecondsSince1970:(unsigned long long) milliSeconds;
+(NSString *) stringFromDateWithDateFormat:(NSString *) format milliSecondsSince1970:(unsigned long long) milliSeconds;

+(NSDate *) dateFromString:(NSString *) dateString format:(NSString *) format;
+(unsigned long long) milliSecondsFromData:(NSDate *) date;
@end
