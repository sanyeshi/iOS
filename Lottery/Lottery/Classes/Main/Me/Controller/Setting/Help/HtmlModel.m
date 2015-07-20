//
//  HtmlModel.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HtmlModel.h"

@implementation HtmlModel
+(instancetype) htmlModelWithDict:(NSDictionary *)dict
{
    HtmlModel * model=[[HtmlModel alloc] init];
    model.title=[dict valueForKey:@"title"];
    model.htmlName=[dict valueForKey:@"html"];
    model.ID=[dict valueForKey:@"id"];
    return model;
}
@end
