//
//  RootViewController.m
//  线程
//
//  Created by 孙硕磊 on 7/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "RootViewController.h"
#import "ImagesViewController.h"
#import "TicketViewController.h"

#import "Person.h"



@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"线程";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"图片墙" style:UIBarButtonItemStylePlain target:self action:@selector(images)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"卖票" style:UIBarButtonItemStylePlain target:self action:@selector(tickets)];
    //初始化控件
    UIButton * bigTaskButton=[[UIButton alloc] init];
    bigTaskButton.frame=CGRectMake(100, 100, 100, 30);
    bigTaskButton.backgroundColor=[UIColor redColor];
    [bigTaskButton setTitle:@"大任务" forState:UIControlStateNormal];
    [bigTaskButton addTarget:self action:@selector(bigTask) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bigTaskButton];
    
    
    UIButton * smallTaskButton=[[UIButton alloc] init];
    smallTaskButton.frame=CGRectMake(100, 200, 100, 30);
    smallTaskButton.backgroundColor=[UIColor redColor];
    [smallTaskButton setTitle:@"小任务" forState:UIControlStateNormal];
    [smallTaskButton addTarget:self action:@selector(smallTask) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:smallTaskButton];
    
    NSLog(@"主线程:%@",[NSThread currentThread]);
    
    NSMutableArray * arr=[NSMutableArray array];
    
    NSObject * obj=[[NSObject alloc] init];
    [obj isEqual:nil];
    [obj hash];
    
    NSMutableSet * set=[[NSMutableSet alloc] init];
    
    Person * person=[[Person alloc] init];
    [set addObject:person];
    
}


-(void) tickets
{
    TicketViewController * tickets=[[TicketViewController alloc] init];
    [self.navigationController pushViewController:tickets animated:YES];
}


-(void) images
{
    ImagesViewController * images=[[ImagesViewController alloc] init];
    [self.navigationController pushViewController:images animated:YES];
}

-(void) bigTaskOperation
{
    /*每个线程都维护它自己的NSAutoreleasePool的栈对象。Cocoa希望在每个当前线程的栈里面有一个可用的自动释放池。
     如果一个自动释放池不可用，对象将不会给释放，从而造成内存泄露。
     Application Kit的主线程会自动创建并消耗一个自动释放池，但是其他辅助线程必须手工创建,否则将造成内存泄露。
     */
    @autoreleasepool
    {
        for (int i=0; i<1000;i++ )
        {
            [NSThread sleepForTimeInterval:0.1f];
            NSLog(@"%@",[NSString stringWithFormat:@"大任务+%d",i]);
        }
        NSLog(@"%@",[NSThread currentThread]);
    }
}

-(void) bigTask
{
    //[NSThread currentThread] 将会获得当前正在执行的线程
    //更新界面需要在主线程中完成,[self performSelectorOnMainThread: withObject:nil waitUntilDone:YES];
    NSLog(@"%@",[NSThread currentThread]);
    //[self bigTaskOperation];
    //performSelectorInBackground 将会新开启一个线程，并立即执行
    [self performSelectorInBackground:@selector(bigTaskOperation) withObject:nil];
}



-(void) smallTaskOperation
{
    @autoreleasepool
    {
        NSString * str=nil;
        for (int i=0; i<3000; i++)
        {
            str=[NSString stringWithFormat:@"小任务+%d",i];
        }
        NSLog(@"%@",str);
        NSLog(@"%@",[NSThread currentThread]);
    }
}
-(void) smallTask
{
   // [self smallTaskOperation];
    [self performSelectorInBackground:@selector(smallTaskOperation) withObject:nil];
}


@end
