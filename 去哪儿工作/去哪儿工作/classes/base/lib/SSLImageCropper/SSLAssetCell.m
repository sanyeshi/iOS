//
//  AssetCell.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "SSLAssetCell.h"
#import "SSLAsset.h"
#import "SSLImageCropper.h"

#define kMargin 2

@interface SSLAssetCell ()

@property (nonatomic, strong) NSMutableArray * imageViewArray;

@end

@implementation SSLAssetCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if (self)
    {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        [self addGestureRecognizer:tapRecognizer];
        //适配iPhone5、6、6 plus
        NSUInteger capacity=4;
        if (iPhone6Plus)
        {
            capacity=5;
        }
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:capacity];
        self.imageViewArray = mutableArray;
	}
	return self;
}

- (void)setAssets:(NSArray *)assets
{
    _assets= assets;
	for (UIImageView *view in _imageViewArray)
    {
        [view removeFromSuperview];
	}
    for (int i = 0; i < [_assets count]; ++i)
    {
        SSLAsset *asset = [_assets objectAtIndex:i];
        if (i < [_imageViewArray count])
        {
            UIImageView *imageView = [_imageViewArray objectAtIndex:i];
            imageView.image = [UIImage imageWithCGImage:asset.asset.thumbnail];
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:asset.asset.thumbnail]];
            [_imageViewArray addObject:imageView];
        }
     }
}

- (void)cellTapped:(UITapGestureRecognizer *)tapRecognizer
{
    NSInteger index=0;
    CGPoint point = [tapRecognizer locationInView:self];
    NSUInteger count=kELCAssetItemCount;
    CGFloat width=(self.bounds.size.width-(count+1)*kMargin)/count;
    CGFloat startX=kMargin;
    CGRect frame = CGRectMake(startX,kMargin,width,75);
	
	for (int i = 0; i < [_assets count]; ++i)
    {
        if (CGRectContainsPoint(frame, point))
        {
            index=i;
            break;
        }
        frame.origin.x = frame.origin.x + frame.size.width +kMargin;
    }
    [_delegate sslAssetCell:self didSelectAtIndex:index];
}



- (void)layoutSubviews
{
    NSUInteger count=kELCAssetItemCount;
    CGFloat width=(self.bounds.size.width-(count+1)*kMargin)/count;
    CGFloat startX=kMargin;
    CGRect frame = CGRectMake(startX,kMargin,width,75);
	
	for (int i = 0; i < [_assets count]; ++i)
    {
		UIImageView *imageView = [_imageViewArray objectAtIndex:i];
		[imageView setFrame:frame];
		[self addSubview:imageView];
        frame.origin.x = frame.origin.x + frame.size.width +kMargin;
	}
}


@end
