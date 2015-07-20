//
//  WatermarkViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "WatermarkViewController.h"

@interface WatermarkViewController ()

@end

@implementation WatermarkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"水印";
    
    UIImageView * imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake(0, 0, self.view.frame.size.width, 200);
    imageView.image=[self wastermask:[UIImage imageNamed:@"NatGeo"] title:@"sina图片"];
    [self.view addSubview:imageView];
}

-(UIImage *) wastermask:(UIImage *) image title:(NSString *) title;
{
    //建立图像上下文，需要指定新生成图像的大小
    UIGraphicsBeginImageContext(image.size);
    //获取图像上下文
    //CGContextRef context=UIGraphicsGetCurrentContext();
    
    //绘制内容
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印
    UIFont * font=[UIFont systemFontOfSize:20.0f];
    [title drawAtPoint:CGPointMake(image.size.width*0.5, 0) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]}];
    //获取新的图像
    UIImage * newImage=UIGraphicsGetImageFromCurrentImageContext();
    //关闭图像上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
