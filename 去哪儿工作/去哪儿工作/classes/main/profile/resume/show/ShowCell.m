//
//  ShowCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ShowCell.h"

@implementation ShowCell
-(void) loadImageView
{
    _imageView=[[UIImageView alloc] init];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setClipsToBounds:YES];
    [self.contentView addSubview:_imageView];
}

-(UIImageView *) imageView
{
    if (_imageView==nil)
    {
        [self loadImageView];
    }
    return _imageView;
}

-(void) layoutSubviews
{
    CGFloat imageViewX=0;
    CGFloat imageViewY=0;
    CGFloat imageViewW=self.frame.size.width;
    CGFloat imageViewH=self.frame.size.height;
    _imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
}
@end
