//
//  ImagesViewController.m
//  线程
//
//  Created by 孙硕磊 on 7/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ImagesViewController.h"

@interface ImagesViewController ()
{
    NSArray * _imagesViews;
    NSOperationQueue * _operationQueue;
}
@end

@implementation ImagesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"图片墙";
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    _operationQueue=[[NSOperationQueue alloc] init];
    
    [self setupImages];
    [self setupButton];
    
    
}

-(void) setupImages
{
    CGFloat buttonH=30;
    int  colNum=4;
    int  rowNum=6;
    CGFloat w=self.view.frame.size.width/colNum;
    CGFloat h=(self.view.frame.size.height-64-buttonH)/rowNum;
    NSMutableArray * arr=[[NSMutableArray alloc] initWithCapacity:colNum*rowNum];
    for (int i=0; i<rowNum; i++)
    {
        for (int j=0; j<colNum; j++)
        {
            UIImageView * imageView=[[UIImageView alloc] init];
            imageView.frame=CGRectMake(j*w, i*h, w, h);
            int index=arc4random_uniform(17)+1;
            NSString * imageName=nil;
            if (index<10)
            {
                imageName=[NSString stringWithFormat:@"NatGeo0%d",index];
            }
            else
            {
                imageName=[NSString stringWithFormat:@"NatGeo%d",index];
            }
           // imageView.image=[UIImage imageNamed:imageName];
            [self.view addSubview:imageView];
            [arr addObject:imageView];
        }
    }
    _imagesViews=[arr copy];
}

-(void) setupButton
{
    UIButton * button=[[UIButton alloc] init];
    button.frame=CGRectMake(100,self.view.frame.size.height-64-30, 100, 30);
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"刷新" forState:UIControlStateNormal];
    //[button addTarget:self action:@selector(freshImages) forControlEvents:UIControlEventTouchDown];
    //[button addTarget:self action:@selector(operationFreshImages) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(gcd) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

-(void) freshImages
{
    for (UIImageView * imageView in _imagesViews)
    {
        //NSThread,很难管理线程的生命周期
        //创建新的线程，并立即执行
        //[NSThread detachNewThreadSelector:@selector(freshImage:) toTarget:self withObject:imageView];
        
        //创建新的线程，但并不会立即执行，需要调用start方法
        NSThread * thread=[[NSThread alloc] initWithTarget:self selector:@selector(freshImage:) object:imageView];
        [thread start];
    }
}

-(void) freshImage:(UIImageView *) imageView;
{
    @autoreleasepool
    {
        int index=arc4random_uniform(17)+1;
        NSString * imageName=nil;
        if (index<10)
        {
            imageName=[NSString stringWithFormat:@"NatGeo0%d",index];
        }
        else
        {
            imageName=[NSString stringWithFormat:@"NatGeo%d",index];
        }
        //在主线程更新UI
        //imageView.image=[UIImage imageNamed:imageName];
        [imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageNamed:imageName] waitUntilDone:YES];
    }
}

#pragma mark - NSOperation

-(void) operationFreshImages
{
    //操作队列可以控制线程的并发数量,操作队列也可以设置操作间的依赖关系，而控制操作的执行顺序，但要避免循环依赖
    //[_operationQueue setMaxConcurrentOperationCount:4];
    for (UIImageView  * imageView  in _imagesViews)
    {
        /*
        NSOperation * op=[[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationFreshImage:) object:imageView];
         //[op start]方法，将会使该op在主线程队列上运行，并不会开启新的线程，需要配合操作队列使用
        [_operationQueue addOperation:op];
         */
        NSOperation * op=[NSBlockOperation blockOperationWithBlock:^{
            [self blockOperationFreshImage:imageView];
        }];
        //将操作添加到操作队列，就会开启新的线程
        [_operationQueue addOperation:op];
    }
}

-(void) operationFreshImage:(UIImageView *) imageView
{
    @autoreleasepool
    {
        int index=arc4random_uniform(17)+1;
        NSString * imageName=nil;
        if (index<10)
        {
            imageName=[NSString stringWithFormat:@"NatGeo0%d",index];
        }
        else
        {
            imageName=[NSString stringWithFormat:@"NatGeo%d",index];
        }
        //在主线程更新UI
        //imageView.image=[UIImage imageNamed:imageName];
        //[imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageNamed:imageName] waitUntilDone:YES];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            imageView.image=[UIImage imageNamed:imageName];
        }];
    }
}

-(void) blockOperationFreshImage:(UIImageView *) imageView
{
    @autoreleasepool
    {
        int index=arc4random_uniform(17)+1;
        NSString * imageName=nil;
        if (index<10)
        {
            imageName=[NSString stringWithFormat:@"NatGeo0%d",index];
        }
        else
        {
            imageName=[NSString stringWithFormat:@"NatGeo%d",index];
        }
        //在主线程更新UI
        //imageView.image=[UIImage imageNamed:imageName];
        //[imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageNamed:imageName] waitUntilDone:YES];
        //若NSOperation实例为NSBlockOperation，需要在主队列中更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            imageView.image=[UIImage imageNamed:imageName];
        }];
    }
}

#pragma mark -GCD

-(void) gcd
{
    /*
       1.全局队列，所有任务是并发(异步)执行的；
       2.主队列，主线程队列，串行执行
       3.串行队列需要创建，而不行get,dispatch_queue_t queue=dispatch_queue_create("sq", DISPATCH_QUEUE_SERIAL);
     */
    
    //1. 获取全局队列,所有任务是并发执行的
    dispatch_queue_t queue=dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    //2. 在全局队列上，异步执行
    for (UIImageView * imageView in _imagesViews)
    {
        dispatch_async(queue, ^{
            NSLog(@"%@",[NSThread currentThread]);
            int index=arc4random_uniform(17)+1;
            NSString * imageName=nil;
            if (index<10)
            {
                imageName=[NSString stringWithFormat:@"NatGeo0%d",index];
            }
            else
            {
                imageName=[NSString stringWithFormat:@"NatGeo%d",index];
            }
            //3. 在主队列中更新UI
            dispatch_sync(dispatch_get_main_queue(), ^{
                 NSLog(@"%@",[NSThread currentThread]);
                imageView.image=[UIImage imageNamed:imageName];
            });
            
        });
    }
}



@end
