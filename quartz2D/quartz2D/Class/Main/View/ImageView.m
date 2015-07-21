//
//  ImageView.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ImageView.h"

@interface ImageView ()
{
    UIWebView * _webView;
}
@end
@implementation ImageView

/*
    有时候，为了提高效率，可以直接把图片画在view上当作背景
 */
- (void)drawRect:(CGRect)rect
{
    UIImage * image=[self cropImage];
    
    NSLog(@"%@",NSStringFromCGSize(image.size));
    NSLog(@"%f",image.scale);
    
    [image drawAtPoint:CGPointZero];
    //[self drawBg:rect];
}

/*
   画背景
 */

-(void) drawBg:(CGRect) rect
{
    
    NSURL * url=[NSURL URLWithString:@"http://itunes.apple.com/app/id415424368?mt=8"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //保存一份上下文到栈中
    CGContextSaveGState(ctx);
    CGContextRotateCTM(ctx, M_PI/6);
    //添加路径
    CGContextAddRect(ctx, CGRectMake(100.0f, 0.0f, 100.0f, 100.0f));
    [[UIColor redColor] setStroke];
    //画
    CGContextDrawPath(ctx,kCGPathStroke);
    
    //恢复上下文信息
    CGContextRestoreGState(ctx);
    CGContextAddEllipseInRect(ctx, CGRectMake(0.0f, 200.0f, 100.0f, 100.0f));
    CGContextDrawPath(ctx, kCGPathStroke);

    
    
    //CGContextDrawPath(ctx,kCGPathStroke);
    
    //UIImage * image=[UIImage imageNamed:@"icon"];
    //NSLog(@"%@",NSStringFromCGSize(image.size));
    //[image drawInRect:(CGRect){CGPointZero,CGSizeMake(100.0f, 100.0f)}];
    
    
   // UIImage * croppedImage=[self cropImage];
   // NSLog(@"%@",NSStringFromCGSize(croppedImage.size));
    //[croppedImage drawInRect:(CGRect){CGPointZero,CGSizeMake(100.0f, 100.0f)}];
    

    /*
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx,(CGRect){CGPointZero,CGSizeMake(100.0f, 100.0f)});
    CGContextClip(ctx);
    UIImage * image=[UIImage imageNamed:@"icon"];
    [image drawInRect:(CGRect){CGPointZero,CGSizeMake(100.0f, 100.0f)}];
     */
    
    //UIImage * croppedImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //[image drawAtPoint:CGPointMake(0, 0)];
    //拉伸
    //[image drawInRect:(CGRect){CGPointZero,CGSizeMake(100.0f, 100.0f)}];
    //平铺
    //[image drawAsPatternInRect:rect];
    
}


/*
   图像裁剪
 */
-(UIImage *) cropImage
{    //开启图像上下文,指定画布大小为50*50
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(50.0f, 50.0f), NO, 0.0f);
    UIImage * image=[UIImage imageNamed:@"icon"];
    [image drawInRect:(CGRect){CGPointMake(-50, -50),CGSizeMake(100.0f, 100.0f)}];
    UIImage * croppedImage=UIGraphicsGetImageFromCurrentImageContext();
    //关闭图像上下文
    UIGraphicsEndImageContext();
    return croppedImage;
}
@end
