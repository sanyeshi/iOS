//
//  Experience.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Experience.h"
#import "NSDate+Format.h"

@implementation Experience

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        [self parseJobWithDict:dict];
    }
    return self;
}

-(void) parseJobWithDict:(NSDictionary *) dict
{
    if (dict)
    {
        self.title=[dict valueForKey:@"what"];
        self.detail=[dict valueForKey:@"where"];
        self.startTime=[NSDate stringFromDateWithDateFormat:@"yyyy.MM.dd" milliSecondsSince1970:[[dict valueForKey:@"from"] longLongValue]];
        self.endTime=[NSDate stringFromDateWithDateFormat:@"yyyy.MM.dd" milliSecondsSince1970:[[dict valueForKey:@"to"] longLongValue]];
    }
}

-(NSString *) toJson
{
    
    NSDictionary * dict=@{@"from":[NSNumber numberWithLongLong:[NSDate milliSecondsFromData:[NSDate dateFromString:self.startTime format:@"yyyy.MM.dd"]]],
                          @"to":[NSNumber numberWithLongLong:[NSDate milliSecondsFromData:[NSDate dateFromString:self.endTime format:@"yyyy.MM.dd"]]],
                          @"where":self.detail,
                          @"what":self.title
                          };
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                       error:&error];
    if (! jsonData)
    {
        Log(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+(NSString *) toJsonWithArray:(NSArray *)array
{
    
    NSInteger count=[array count];
    NSMutableString * jsonString=[NSMutableString string];
    [jsonString appendString:@"["];
    for (int i=0; i<count; i++)
    {
        Experience * experience=array[i];
        [jsonString appendString:[experience toJson]];
        if (i+1!=count)
        {
            [jsonString appendString:@","];
        }
    }
    [jsonString appendString:@"]"];
    return [jsonString copy];
}
@end
