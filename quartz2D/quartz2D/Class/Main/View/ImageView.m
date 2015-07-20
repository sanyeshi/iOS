//
//  ImageView.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

- (void)drawRect:(CGRect)rect
{
    UIImage * image=[UIImage imageNamed:@"icon"];
    //[image drawAtPoint:CGPointMake(0, 0)];
    //拉伸
    [image drawInRect:rect];
    //平铺
    //[image drawAsPatternInRect:rect];
}


@end
