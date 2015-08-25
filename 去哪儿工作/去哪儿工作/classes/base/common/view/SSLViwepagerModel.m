//
//  SSLViwepagerModel.m
//  parttime
//
//  Created by 孙硕磊 on 5/30/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SSLViwepagerModel.h"

@implementation SSLViwepagerModel
+(instancetype) sslViwepagerModelWithTitle:(NSString *)title imageUrlStr:(NSString *)imageUrlStr
{
    SSLViwepagerModel *  model=[[SSLViwepagerModel alloc] init];
    if (model)
    {
        model.title=title;
        model.imageUrlStr=imageUrlStr;
    }
    return model;
}
@end
