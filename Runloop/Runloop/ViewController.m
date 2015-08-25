//
//  ViewController.m
//  Runloop
//
//  Created by 孙硕磊 on 7/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self observeRunloop];
}


-(void) observeRunloop
{
    @autoreleasepool
    {
        //1.获取当前线程的run loop
        NSRunLoop * runLoop=[NSRunLoop currentRunLoop];
        //2.设置runloop观察者的运行环境
        CFRunLoopObserverContext context={0,(__bridge void *)(self),NULL,NULL,NULL};
        //3.创建runloop观察者
        /*
          3.1>allocator:分配该observer对象的内存
          3.2>activities:设置该observer关注的事件
          3.3>repeats:是否重复执行
          3.4>order:优先级
          3.5>callout:回调函数
          3.6>context:运行环境
         */

        CFRunLoopObserverRef observer=CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0,&observerHandle, &context);
        if(observer)
        {
            CFRunLoopRef runLoopRef=[runLoop getCFRunLoop];
            //将观察者加入到run loop中
            CFRunLoopAddObserver(runLoopRef, observer, kCFRunLoopDefaultMode);
        }
        //Creates and Returns a new NSTimer object and schedules it on the current run loop in the default mode
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
    }
}


void observerHandle(CFRunLoopObserverRef observer,CFRunLoopActivity activity,void *info)
{
    switch (activity)
    {
        case kCFRunLoopEntry:
             NSLog(@"run loop entry");
             break;
        
        case kCFRunLoopBeforeTimers:
            NSLog(@"run loop before timers");
            break;
            
        case kCFRunLoopBeforeSources:
            NSLog(@"run loop before sources");
            break;
            
        case kCFRunLoopBeforeWaiting:
            NSLog(@"run loop before waiting");
            break;
            
        case kCFRunLoopAfterWaiting:
            NSLog(@"run loop after waiting");
            break;
            
        case kCFRunLoopExit:
            NSLog(@"run loop exit");
            break;
            
        case kCFRunLoopAllActivities:
            break;
            
        default:
            break;
    }
}

-(void) doFireTimer:(NSTimer *) timer
{
    NSLog(@"timer......");
}

@end











































