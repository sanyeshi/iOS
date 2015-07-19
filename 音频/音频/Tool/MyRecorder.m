//
//  MyRecorder.m
//  01.声音播放
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MyRecorder.h"

@interface MyRecorder()
{
    AVAudioRecorder         *_recorder;     // 录音机
    AVAudioPlayer           *_player;       // 录音播放器
    
    NSURL                   *_recorderURL;  // 音频文件URL
}

@end

@implementation MyRecorder
single_implementation(MyRecorder)

#pragma mark - 私有方法
#pragma mark 录音设置
- (NSDictionary *)recorderSettings
{
    NSMutableDictionary *setting = [[NSMutableDictionary alloc] init];
    
    // 音频格式
    [setting setValue:[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    // 音频采样率
    [setting setValue:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    // 音频通道数
    [setting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    // 线性音频的位深度
    [setting setValue:[NSNumber numberWithInt:8]forKey:AVLinearPCMBitDepthKey];
    
    return setting;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        // 1. 设置音频会话，允许录音
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        // 激活分类
        [session setActive:YES error:nil];
        
        // 2. 实例化录音机
        // 1) 保存录音文件的url
        NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [docs[0] stringByAppendingPathComponent:@"recorder.caf"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        // 2) 录音文件设置的字典（设置音频的属性，例如音轨数量，音频格式等）
        NSError *error = nil;
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:[self recorderSettings] error:&error];
        
        _recorderURL = url;
        
        if (error) {
            NSLog(@"实例化录音机失败 - %@", error.localizedDescription);
        }
    }
    
    return self;
}

#pragma mark - 成员方法
#pragma mark 是否正在录音
- (BOOL)isRecording
{
    return [_recorder isRecording];
}

#pragma mark 开始录音
- (void)startRecording
{
    // 特殊情况处理
    // 1. 如果当前正在录音
    if ([_recorder isRecording]) {
        return;
    }
    // 2. 如果当前正在播放录音
    if ([_player isPlaying]) {
        [_player stop];
    }
    
    [_recorder record];
}

#pragma mark 停止录音
- (void)stopRecording
{
    if ([_recorder isRecording]) {
        [_recorder stop];
    }
}

#pragma mark 开始播放
- (void)startPlaying
{
    // 1) 实例化播放器
    _player = [SoundTool audioPlayerWithURL:_recorderURL];
    [_player setNumberOfLoops:0];
    [_player prepareToPlay];
    
    [_player play];
}

#pragma mark 停止播放
- (void)stopPlaying
{
    if ([_player isPlaying]) {
        [_player stop];
    }
}

@end
