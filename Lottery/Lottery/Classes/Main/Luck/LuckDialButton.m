//
//  LuckDialButton.m
//  Lottery
//
//  Created by 孙硕磊 on 7/21/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LuckDialButton.h"

@implementation LuckDialButton


//设置按钮图片的位置和大小
-(CGRect) imageRectForContentRect:(CGRect)contentRect
{
    /*
       图像的像素=image.size*image.scale
     */
    
    UIImage * image=[self imageForState:UIControlStateNormal];
    CGSize size=image.size;
    CGFloat scale=[UIScreen mainScreen].scale;
    
    //点坐标系
    CGFloat w=(size.width*image.scale)/scale;
    CGFloat h=(size.height*image.scale)/scale;
    
    CGFloat x=(contentRect.size.width-w)*0.5;
    CGFloat y=(contentRect.size.height-h)*0.5-25;
    
    return CGRectMake(x,y,w,h);
}
@end
