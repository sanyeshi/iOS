//
//  MyRecorder.h
//  01.声音播放
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "SoundTool.h"

@interface MyRecorder : NSObject
single_interface(MyRecorder)

#pragma mark 是否正在录音
- (BOOL)isRecording;

#pragma mark 开始录音
- (void)startRecording;

#pragma mark 停止录音
- (void)stopRecording;

#pragma mark 开始播放
- (void)startPlaying;

#pragma mark 停止播放
- (void)stopPlaying;

@end
