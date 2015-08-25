//
//  PageCollection.m
//  parttime
//
//  Created by 孙硕磊 on 4/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PageCollection.h"

@implementation PageCollection
#define kPageSize 20

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.currentPage=1;
        self.pageSize=kPageSize;
    }
    return self;
}
-(void)parsePageCollectionWithDict:(NSDictionary *)dict
{
    if (dict)
    {
        self.recordCount=[[dict valueForKey:@"recordCount"] unsignedIntegerValue];
        self.pageCount=[[dict valueForKey:@"pageCount"] unsignedIntegerValue];
        self.pageSize=[[dict valueForKey:@"pageSize"] unsignedIntegerValue];
        self.currentPage=[[dict valueForKey:@"currentPage"] unsignedIntegerValue];
        self.prePage=[[dict valueForKey:@"prePage"] unsignedIntegerValue];
        self.nextPage=[[dict valueForKey:@"nextPage"] unsignedIntegerValue];
        self.hasPrePage=[[dict valueForKey:@"hasPrePage"] boolValue];
        self.hasNextPage=[[dict valueForKey:@"hasNextPage"] boolValue];
    }
}
@end
