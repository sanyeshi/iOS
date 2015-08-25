//
//  NewsItem.m
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NewsItem.h"
#import "Http.h"
@implementation NewsItem

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        self.content=[dict valueForKey:@"detail"];
        NSString * urlStr=[dict valueForKey:@"image"];
        if (urlStr)
        {
            //截取字符串
            NSRange range=[urlStr rangeOfString:@"_"];
            self.imageUrlStr=ImageURL([urlStr substringToIndex:range.location]);
        }
    }
    return self;
}
@end
