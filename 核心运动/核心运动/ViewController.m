//
//  ViewController.m
//  核心运动
//
//  Created by 孙硕磊 on 7/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>


@interface ViewController ()
{
    UIImageView * _ball;
    CADisplayLink * _gameTimer;
    //小球速度
    CGPoint         _ballVelocity;
    //运动管理器
    CMMotionManager  * _motionManager;
    NSOperationQueue * _queue;

}

@end

/*
    加速计默认是不工作的，工作是会耗电。当设置了采样频率，加速计开始工作，同时将采样获得的数据通过代理方法，发送给调用方
 
 */
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加小球
    _ball=[[UIImageView alloc] initWithImage:[UIImage  imageNamed:@"black"]];
    [self.view addSubview:_ball];
    //传统做法，加速计
    //[self acceelerometer];
    //核心运动框架
    [self coreMotion];
}

#pragma mark -传统加速计
-(void) acceelerometer
{
    //1.实例化加速计，单例（官方已停止对加速计的更新,而采用核心运动框架）
    UIAccelerometer *accelerometer=[UIAccelerometer sharedAccelerometer];
    //2.设置更新频率(采样频率)
    [accelerometer setUpdateInterval:1/30.0f];
    //3.设置代理
    [accelerometer setDelegate:self];
    
    //加速计只是负责采集数据，UI更新最好还是在时钟中更新
    _gameTimer=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //加入主运行循环
    [_gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

/*
UIAcceleration的说明
* timestamp    数据采样发生的时间
* x            x 方向的加速度
* y            y 方向的加速度
* z            z 方向的加速度
*/

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    // 使用加速度调整小球速度
    _ballVelocity.x += acceleration.x;
    _ballVelocity.y -= acceleration.y;
}


#pragma mark -核心运动

/*
    accelerometerAvailable         加速计是否可用
    accelerometerUpdateInterval    加速机采样频率
    acclerometerActive             加速计是否正在采样
    acclerometerData               取回末次采样数据，pull方式
    startAcclerometerUpdates       开始加速计更新
    startAccelerometerUpdatesToQueue: 使用多线程的加速计采样数据，push方法
    stopAccelerometerUpdates       停止采样
 */
-(void) coreMotion
{
    _queue=[[NSOperationQueue alloc] init];
    //实例化运动管理器，应采用单例模式
    _motionManager=[[CMMotionManager alloc] init];
    
    //采样过程
    //判断加速器是否可用
    if([_motionManager isAccelerometerAvailable])
    {
       //指定采样频率
        [_motionManager setAccelerometerUpdateInterval:1/30.0f];
        //采用push方法获取数据，主动获取数据方式,采样为较耗时的操作，最好放在辅助线程中
        [_motionManager startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             //NSLog(@"%@",accelerometerData);
             _ballVelocity.x += accelerometerData.acceleration.x;
             _ballVelocity.y -= accelerometerData.acceleration.y;
        }];
    }
    
    //加速计只是负责采集数据，UI更新最好还是在时钟中更新
    _gameTimer=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //加入主运行循环
    [_gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

-(void) step
{
    [self updateBallLocation];
}

#pragma mark - 更新小球位置
- (void)updateBallLocation
{
    // 根据小球位置调整中心点位置
    CGPoint center = _ball.center;
    
    // 判断小球的位置是否超出边界，如果超出边界，将小球的方向求反
    // 1) 水平方向
    // 如果小球的最小x值，小于0，表示左边出界
    // CGRectGetMinX(_ball.frame) = _ball.frame.origin.y
    // 如果小球的最大x值，大于viewW，表示右边边出界
    if (CGRectGetMinX(_ball.frame) < 0 || CGRectGetMaxX(_ball.frame) > self.view.bounds.size.width)
    {
        _ballVelocity.x *= -0.8;
        
        // 修复小球位置
        if (CGRectGetMinX(_ball.frame) < 0)
        {
            center.x = _ball.bounds.size.width / 2;
        }
        else
        {
            center.x = self.view.bounds.size.width - _ball.bounds.size.width / 2;
        }
    }
    
    // 2)垂直方向
    if (CGRectGetMinY(_ball.frame) < 0 || CGRectGetMaxY(_ball.frame) > self.view.bounds.size.height)
    {
        _ballVelocity.y *= -0.8;
        
        // 修复小球位置
        if (CGRectGetMinY(_ball.frame) < 0)
        {
            center.y = _ball.bounds.size.height / 2;
        }
        else
        {
            center.y = self.view.bounds.size.height - _ball.bounds.size.height / 2;
        }
    }
    
    center.x += _ballVelocity.x;
    center.y += _ballVelocity.y;
    
    //更新UI在主线程中完成
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       [_ball setCenter:center];
    }];
    
}


#pragma mark -触摸事件
/*
   点按屏幕停止更新
 */
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   if([_motionManager isAccelerometerActive])
   {
       //停止采样
       [_motionManager stopAccelerometerUpdates];
       //停止游戏时钟或将其从主运行循环移除
       //[_gameTimer invalidate];
       [_gameTimer removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
   }
    else
    {
        //开始采样
        [_motionManager startAccelerometerUpdatesToQueue:_queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             //NSLog(@"%@",accelerometerData);
             _ballVelocity.x += accelerometerData.acceleration.x;
             _ballVelocity.y -= accelerometerData.acceleration.y;
         }];
        
        //重新开启游戏时钟
        //加速计只是负责采集数据，UI更新最好还是在时钟中更新
        /*
        _gameTimer=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
        //加入主运行循环
        [_gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
         */
        [_gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}


-(BOOL) prefersStatusBarHidden
{
    return YES;
}


@end
