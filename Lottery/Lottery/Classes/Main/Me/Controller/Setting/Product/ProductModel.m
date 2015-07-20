//
//  ProductModel.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel
+(instancetype) productModelWithDict:(NSDictionary *)dict
{
    ProductModel * model=[[ProductModel alloc] init];
    model.title=[dict valueForKey:@"title"];
    model.ID=[dict valueForKey:@"id"];
    model.url=[dict valueForKey:@"url"];
    model.icon=[dict valueForKey:@"icon"];
    model.customUrl=[dict valueForKey:@"customUrl"];
    
    return model;
}
@end
