//
//  RunLoopSource.h
//  Runloop
//
//  Created by 孙硕磊 on 7/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunLoopSource : NSObject
{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray   * commands;         //命令缓冲区
}
-(void) addToCurrentRunLoop;
-(void) invalidate;

//handler method
-(void) sourceFired;
//client interface for registering commands to process
-(void) addCommand:(NSInteger) command withData:(id) data;
-(void) fireAllCommandsOnRunLoop:(CFRunLoopRef) runLoopRef;
@end


//These are the CFRunLoopSourceRef callback functions
void RunLoopSourceScheduleRoutine(void * info,CFRunLoopRef rl,CFStringRef mode);
void RunLoopSourcePerformRoutine(void * info);
void RunLoopSourceCancelRoutine(void * info,CFRunLoopRef rl,CFStringRef mode);
