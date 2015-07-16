//
//  ViewController.m
//  粒子效果
//
//  Created by 孙硕磊 on 7/16/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CADisplayLink * _gameTimer;      //游戏时钟
    int    _step;                    //步长
    
    
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    _gameTimer=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //加入主运行循环
    [_gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _step=0;
}

-(void) step
{
    _step++;
    //[self snow];
    if (_step%6==0)
    {
        [self snow];
    }
    if (_step==3600)
    {
        _step=0;
    }
}

-(void) snow
{
    for (int i=0; i<1; i++)
    {
        UIImageView * imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"雪花"]];
        //雪花大小
        CGFloat r=arc4random_uniform(10)+10.0f;
        imageView.bounds=CGRectMake(0, 0, r, r);
        
        CGFloat centerX=arc4random_uniform(self.view.frame.size.width)+1;
        CGFloat centerY=-r;
        imageView.center=CGPointMake(centerX, centerY);
        [self.view addSubview:imageView];
        
        [UIView animateWithDuration:6.0f animations:^{
            imageView.center=CGPointMake(arc4random_uniform(self.view.frame.size.width)+1,self.view.frame.size.height+arc4random_uniform(100));
            //旋转180度
            imageView.transform=CGAffineTransformMakeRotation(M_PI);
            //逐渐变暗
            imageView.alpha=0.2f;
        } completion:^(BOOL finished)
        {
            [imageView removeFromSuperview];
        }];
    }
}

-(BOOL) prefersStatusBarHidden
{
    return YES;
}


@end
