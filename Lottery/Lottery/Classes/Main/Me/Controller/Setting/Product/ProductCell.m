//
//  ProductCell.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ProductCell.h"
#import "ProductModel.h"

@interface ProductCell ()
{
    UIImageView * _imageView;
    UILabel     * _label;
}
@end

@implementation ProductCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageView=[[UIImageView alloc] init];
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        _imageView.layer.cornerRadius=8.0f;
        _imageView.clipsToBounds=YES;
        [self.contentView addSubview:_imageView];
        
        _label=[[UILabel alloc] init];
        _label.font=[UIFont systemFontOfSize:12.0f];
        _label.textColor=[UIColor blackColor];
        _label.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return self;
}


-(void) layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame=CGRectMake(10,0, 60, 60);
    _label.frame=CGRectMake(0, 60, 80, 20);
}

-(void)setProductModel:(ProductModel *)productModel
{
    _productModel=productModel;
    _imageView.image=[UIImage imageNamed:productModel.icon];
    _label.text=productModel.title;
}

@end
