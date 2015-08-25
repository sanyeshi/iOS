//
//  NSDate+Format.m
//  parttime
//
//  Created by 孙硕磊 on 5/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

+(NSString *) stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:date];
}

+(NSString *) stringFromDateWithMilliSecondsSince1970:(unsigned long long) milliSeconds
{
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:milliSeconds/1000];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    return [dateFormatter stringFromDate:date];
}

+(NSString *) stringFromDateWithDateFormat:(NSString *) format milliSecondsSince1970:(unsigned long long) milliSeconds
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:milliSeconds/1000];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}


+(NSDate *) dateFromString:(NSString *) dateString format:(NSString *) format
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date=[dateFormatter dateFromString:dateString];
    return date;
}

+(unsigned long long) milliSecondsFromData:(NSDate *)date
{
    unsigned long long milliSeconds=[date timeIntervalSince1970]*1000;
    return milliSeconds;
}

@end
