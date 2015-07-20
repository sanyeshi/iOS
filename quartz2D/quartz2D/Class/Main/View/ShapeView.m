
//
//  ShapeView.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

- (void)drawRect:(CGRect)rect
{
   // [self drawRectangle];
   // [self drawCircle];
    [self drawArc];
}


-(void) drawRectangle
{
    /*
       在开发中，无论什么样的形状，其本质上还是矩形，所以UIkit封装了绘制矩形的方法
     */
    CGRect rect=CGRectMake(10, 10, 100, 100);
    [[UIColor redColor] set];
    UIRectFill(rect);
}

-(void) drawCircle
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    [[UIColor redColor] set];
    CGRect rect=CGRectMake(10, 10, 200, 200);
    UIRectFrame(rect);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathStroke);
}

-(void) drawArc
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    /*
       1)context:设备上下文
       2)(x,y)圆弧所在圆的圆心坐标
       3）圆弧所在圆半径
       4）起始角度，和终止角度，单位为弧度值，最右边点为0，以顺时针方向递增
     */
    CGContextAddArc(context, 100, 100, 50, -M_PI_2, M_PI_2, 0);
    CGContextDrawPath(context, kCGPathFill);
}

@end
