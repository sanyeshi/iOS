//
//  PhotoModel.m
//
//  Created by apple on 13-10-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

+ (id)photoWithURL:(NSURL *)url index:(NSInteger)index srcFrame:(CGRect)srcFrame
{
    PhotoModel *p = [[PhotoModel alloc]init];
    
    p.imageUrl = url;
    p.index = index;
    p.srcFrame = srcFrame;
    return p;
}

@end
