//
//  RunLoopSource.m
//  Runloop
//
//  Created by 孙硕磊 on 7/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "RunLoopSource.h"
#import "AppDelegate.h"
#import "RunLoopContext.h"


/*
    当source添加到runloop时，调用此回调方法
 */
void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource * source = (__bridge RunLoopSource *)info;
    AppDelegate   * del = [UIApplication sharedApplication].delegate;
    RunLoopContext* context =[[RunLoopContext alloc] initWithSource:source andRunLoopRef:rl];
    [del performSelectorOnMainThread:@selector(registerSource:) withObject:context
                       waitUntilDone:NO];
}


/*
    当输入源被告知(signal source)时，调用该例程；
 */
void RunLoopSourcePerformRoutine (void *info)
{
    RunLoopSource* source = (__bridge RunLoopSource*)info;
    [source sourceFired];
}


/*
   当source从runloop移除时，调用此方法
 */
void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef rl, CFStringRef mode)
{
    RunLoopSource* source = (__bridge RunLoopSource*)info;
    AppDelegate* del = [UIApplication sharedApplication].delegate;
    RunLoopContext* context =[[RunLoopContext alloc] initWithSource:source andRunLoopRef:rl];
    [del performSelectorOnMainThread:@selector(removeSource:) withObject:context
                       waitUntilDone:YES];
}


@implementation RunLoopSource

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //setup the context
        CFRunLoopSourceContext context={0,(__bridge void *)(self),NULL,NULL,NULL,NULL,NULL,
                                        &RunLoopSourceScheduleRoutine,
                                        &RunLoopSourceCancelRoutine,
                                        &RunLoopSourcePerformRoutine
                                       };
        runLoopSource=CFRunLoopSourceCreate(NULL, 0, &context);
        commands=[NSMutableArray array];
    }
    return self;
}

-(void) addToCurrentRunLoop
{
    CFRunLoopRef runLoopRef=CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoopRef, runLoopSource, kCFRunLoopDefaultMode);
}

/*
   输入源是一类事件处理机制，它是线程间事件异步通讯机制
 */
/*
   客户端(其他线程)发送数据到输入源，分两步发送
   1）首先发送信号给输入源；
   2）然后唤醒输入源的runloop
 */
-(void) fireAllCommandsOnRunLoop:(CFRunLoopRef)runLoopRef
{
    //wake up the run loop
    //手动调用此方法的时候，将会触发RunLoopSourceContext的performCallback
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runLoopRef);
}


-(void) sourceFired
{
    NSLog(@"source fired.....");
    
}

-(void) invalidate
{
    NSLog(@"invalidate.....");
}

-(void) addCommand:(NSInteger)command withData:(id)data
{
    NSLog(@"addCommand.....");
}
@end
