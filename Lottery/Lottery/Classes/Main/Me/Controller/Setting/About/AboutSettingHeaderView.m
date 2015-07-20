//
//  AboutSettingHeaderView.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AboutSettingHeaderView.h"

#define kMargin 10

@interface AboutSettingHeaderView ()
{
    UIImageView * _imageView;
    UILabel     * _versionLabel;
    UILabel     * _urlLabel;
    UILabel     * _copyrightLabel;
}
@end

@implementation AboutSettingHeaderView

+(instancetype) headerView
{
    AboutSettingHeaderView * headerView=[[AboutSettingHeaderView alloc] init];
    return headerView;
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.bounds=CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 200);
        _imageView=[[UIImageView alloc] init];
        _imageView.image=[UIImage imageNamed:@"about_logo"];
        _imageView.contentMode=UIViewContentModeCenter;
        _imageView.frame=CGRectMake(0, 0, self.frame.size.width, 100);
        [self addSubview:_imageView];
        
        CGFloat viewW=self.frame.size.width;
        CGFloat imageW=_imageView.image.size.width;
        CGFloat labelX=(viewW-imageW)*0.5+kMargin;
        CGFloat labelY=CGRectGetMaxY(_imageView.frame);
        CGFloat labelW=imageW-labelX+2*kMargin;
        CGFloat labelH=20;
        _versionLabel=[self label];
        _versionLabel.text=@"版本: 3.20 build 181";
        _versionLabel.frame=CGRectMake(labelX,labelY,labelW,labelH);
        [self addSubview:_versionLabel];
        
        labelY+=labelH+kMargin;
        _urlLabel=[self label];
        _urlLabel.text=@"官网: http://cp.163.com";
        _urlLabel.frame=CGRectMake(labelX,labelY,labelW,labelH);
        [self addSubview:_urlLabel];
        
        labelY+=labelH+kMargin;
        _copyrightLabel=[self label];
        _copyrightLabel.text=@"版权: 网易公司";
        _copyrightLabel.frame=CGRectMake(labelX,labelY,labelW,labelH);
        [self addSubview:_copyrightLabel];

    }
    return self;
}


-(UILabel *) label
{
    UILabel * label=[[UILabel alloc] init];
    label.font=[UIFont systemFontOfSize:14.0f];
    label.textColor=[UIColor lightGrayColor];
    return label;
}
@end
