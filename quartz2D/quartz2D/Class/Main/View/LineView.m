//
//  LineView.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LineView.h"

@implementation LineView


//C 语言框架
- (void)drawRect:(CGRect)rect
{
   // [self drawLineByPath];
    
    [self drawLineDefault];
}


#pragma mark -路径画图
-(void) drawLineByPath
{
    //1.获取对应的设备上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //2.创建可变路径
    /*
       开发动画的时候，通常需要指定对象的运动路线，然后由动画方法负责动画效果，因此，在动画开发中，需要熟练使用路径
     */
    CGMutablePathRef path=CGPathCreateMutable();
    //.画线，设置起点和终点
    CGPathMoveToPoint(path, NULL, 50.0f, 50.0f);
    CGPathAddLineToPoint(path, NULL, 200.0f, 200.0f);
    CGPathAddLineToPoint(path, NULL, 50.0f, 200.0f);
    //封闭路径
    //CGPathAddLineToPoint(path, NULL, 50.0f, 50.0f);
    //关闭路径方法
    CGPathCloseSubpath(path);
    
    //3. 将路径添加到设备上下文
    CGContextAddPath(context, path);
    //4. 设置上下文属性，context
    /*设置线条颜色,在设置RGB颜色时，最好不要同时制定RGB和Alpha，否则将会影响性能;
     设备上下文在渲染时，是一层层渲染的，若指定alpha为透明，则需要将下层的内容显示出来，将影响渲染性能
     */
    /*
     10,10.0f避免参数转换
     */
    //默认线条和填充都是黑色
    CGContextSetRGBStrokeColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    CGContextSetLineWidth(context, 1.0f);
    //设置定点样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 设置连接点样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    /*设置线条的虚线样式
     phase:相位，虚线的起始位置，一般从0开始
     lengths:数组
     count:数组长度
     虚线的线宽，要大于虚线的间隔
     */
    CGFloat lengths[3]={10.0f,20.0f,15.0f};
    CGContextSetLineDash(context, 0.0f,lengths, 3);
    
    
    //5. 绘制路径
    CGContextDrawPath(context, kCGPathStroke);
    //6. 释放路径
    CGPathRelease(path);
}


-(void) drawLineDefault
{
    //1 获取设备上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //2 画线
    CGContextMoveToPoint(context, 50.0f, 50.0f);
    CGContextAddLineToPoint(context, 200.0f, 200.0f);
    CGContextAddLineToPoint(context, 50.0f, 200.0f);
    CGContextClosePath(context);
    
    //3 设置属性
    //UIKit 会默认导入Core Graphics框架，UIKit对很多的CG方法做了封装
    [[UIColor redColor] setStroke];
    [[UIColor blueColor] setFill];
    //4 绘制路径，虽然没有显示指定路径，但第2步操作默认已在上下文中添加路径
    CGContextDrawPath(context, kCGPathStroke);
}

@end
