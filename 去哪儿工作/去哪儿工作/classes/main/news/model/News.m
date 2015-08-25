//
//  News.m
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "News.h"
#import "NewsItem.h"
#import "NSDate+Format.h"
#import "Http.h"

@implementation News
- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        [self parseNewsWithDict:dict];
    }
    return self;
}

-(void) parseNewsWithDict:(NSDictionary *) dict
{
    if (dict==nil)
    {
        return;
    }
    self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
    self.title=[dict valueForKey:@"title"];
    self.postTime=[NSDate stringFromDateWithDateFormat:@"yyyy.MM.dd HH:mm" milliSecondsSince1970:[[dict valueForKey:@"postTime"] unsignedLongLongValue]];
    self.imageUrlStr= ImageURL([dict valueForKey:@"imageId"]);
    NSString  * details=[dict valueForKey:@"details"];
    [self parseItemsWithString:details];
}

-(void) parseItemsWithString:(NSString *) string
{
    NSArray * array=[NSJSONSerialization JSONObjectWithData: [string dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSMutableArray * items=[[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary * itemDict in array)
    {
        NewsItem * newItem=[[NewsItem alloc] initWithDict:itemDict];
        [items addObject:newItem];
    }
    self.items=[items copy];
}
@end
