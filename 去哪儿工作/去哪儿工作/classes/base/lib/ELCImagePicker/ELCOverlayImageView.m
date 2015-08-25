//
//  ELCOverlayImageView.m
//  ELCImagePickerDemo
//
//  Created by Seamus on 14-7-11.
//  Copyright (c) 2014年 ELC Technologies. All rights reserved.
//

#define kOverlayImageViewIndicatorBackgroundColor  GlobalTintColor
#define kOverlayImageViewIndicatorTextColor        [UIColor whiteColor]
#define kOverlayImageViewIndicatorTextFont         [UIFont boldSystemFontOfSize:13]
#define kOverlayImageViewIndicatorCheckImage

#import "ELCOverlayImageView.h"
#import "ELCConsole.h"

@interface ELCOverlayImageView ()
{
    UIImageView * _imageView;
}
@end
@implementation ELCOverlayImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)setIndex:(NSUInteger)index
{
    self.labIndex.text = [NSString stringWithFormat:@"%ld",index];
}

- (void)dealloc
{
    self.labIndex = nil;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds=YES;
        [self addSubview:_imageView];
        
        if ([[ELCConsole mainConsole] onOrder])
        {
            self.labIndex = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 16, 16)];
            self.labIndex.backgroundColor =kOverlayImageViewIndicatorBackgroundColor;
            self.labIndex.clipsToBounds = YES;
            self.labIndex.textAlignment = NSTextAlignmentCenter;
            self.labIndex.textColor = kOverlayImageViewIndicatorTextColor;
            self.labIndex.layer.cornerRadius = 8;
            self.labIndex.layer.shouldRasterize = YES;
            self.labIndex.font =kOverlayImageViewIndicatorTextFont;
            [self addSubview:self.labIndex];
        }
    }
    return self;
}


-(void) layoutSubviews
{
    _imageView.frame=self.bounds;
}

@end
