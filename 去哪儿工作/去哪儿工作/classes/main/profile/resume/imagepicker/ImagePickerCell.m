//
//  ImagePickerCell.m
//  parttime
//
//  Created by 孙硕磊 on 5/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ImagePickerCell.h"


@interface ImagePickerCell ()
{
    
}
@end
@implementation ImagePickerCell



-(void) loadImageView
{
    _imageView=[[UIImageView alloc] init];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setClipsToBounds:YES];
    [self.contentView addSubview:_imageView];
    
    _coverImageView=[[UIImageView alloc] init];
    _coverImageView.image=[UIImage imageNamed:@"imagepicker.png"];
    [_coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    [_coverImageView setClipsToBounds:YES];
    
    _coverImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_coverImageView addGestureRecognizer:tap];
    [self.contentView addSubview:_coverImageView];

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
    _coverImageView.frame=_imageView.frame;
}

-(void) tap:(UITapGestureRecognizer *) tapGestureRecognizer
{
    _isSelected=!_isSelected;
    if (_isSelected)
    {
        _coverImageView.image=[UIImage imageNamed:@"imagepicker_sel.png"];
    }
    else
    {
        _coverImageView.image=[UIImage imageNamed:@"imagepicker.png"];
    }
    if (_delegate)
    {
        if ([_delegate conformsToProtocol:@protocol(ImagePickCellDelegate)])
        {
            [_delegate imagePickerCell:self didSelectedAtIndexPath:_indexPath];
        }
    }
}
@end
