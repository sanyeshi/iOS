//
//  SoundTool.m
//  音频播放与录制
//
//  Created by 刘凡 on 13-12-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SoundTool.h"
#import <AudioToolbox/AudioToolbox.h>

// 支持声音文件的扩展名数组
#define kValidSoundExtensions       @[@"mp3", @"caf", @"aiff", @"wav", @"m4a"]
// 禁止播放音效键值，如果系统偏好中不存在该键值，返回NO
#define kSoundToolDisablePlaySound  @"soundToolDisablePlaySoundKey"
// 禁止播放声音键值，如果系统偏好中不存在该键值，返回NO
#define kSoundToolDisablePlayMusic  @"soundToolDisablePlayMusicKey"

@interface SoundTool()
{
    NSDictionary    *_soundsDict;           // 音效字典
    AVAudioPlayer   *_backMusicPlayer;      // 背景音乐播放器
}

/**
 *  获取指定名称对应的Bundle
 *
 *  @param name Bundle名称
 *
 *  @return 指定名称对应的Bundle，如果不存在返回mainBundle
 */
+ (NSBundle *)bundleWithName:(NSString *)name;

/**
 *  从soundBundle中加载指定文件名的声音
 *
 *  @param name        声音文件名
 *  @param soundBundle 音效包
 *
 *  @return SystemSoundID
 */
- (SystemSoundID)loadSoundIdWithName:(NSString *)name fromBundle:(NSBundle *)soundBundle;

/**
 *  从soundBundle中加载音效文件，如果没有指定Bundle，则从MainBundle中加载
 *
 *  @param bundleName soundBundle名称
 */
- (void)loadSoundsFromBundleName:(NSString *)bundleName;

/**
 *  使用指定的文件名从MainBundle中加载背景音乐，并准备播放
 *
 *  @param musicName 背景音乐文件名
 */
- (void)loadBackMusicPlayerWithName:(NSString *)musicName;

@end

@implementation SoundTool
single_implementation(SoundTool)

#pragma mark - 私有方法
#pragma mark 获取指定名称对应的Bundle
+ (NSBundle *)bundleWithName:(NSString *)name
{
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:name];

    // 判断指定的bundle是否存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:nil] ) {
        return [NSBundle bundleWithPath:path];
    }

    return [NSBundle mainBundle];
}

#pragma mark 从_soundBundle中加载指定文件名的声音
- (SystemSoundID)loadSoundIdWithName:(NSString *)name fromBundle:(NSBundle *)soundBundle;
{
    SystemSoundID soundID;

    NSString *path = [soundBundle pathForResource:name ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];

    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);

    return soundID;
}

#pragma mark 从soundBundle中加载音效文件
- (void)loadSoundsFromBundleName:(NSString *)bundleName
{
    // 1. 获取声音包
    NSBundle *soundBundle = [SoundTool bundleWithName:bundleName];

    // 2. 从声音包中加载所有文件
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:soundBundle.bundlePath error:nil];

    // 3. 遍历包中的文件，并生成数据字典
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];

    for (NSString *fileName in files) {
        // 1) 取出文件扩展名
        NSString *extName = [fileName pathExtension];

        // 2) 判断扩展名是否包含在允许的声音文件中
        if ([kValidSoundExtensions containsObject:extName]) {
            // 3) 加载声音文件并添加至字典
            SystemSoundID soundID = [self loadSoundIdWithName:fileName fromBundle:soundBundle];

            [dictM setObject:@(soundID) forKey:fileName];
        }
    }
    
    // 记录声音数组
    _soundsDict = dictM;
}

#pragma mark 使用指定的文件名从MainBundle中加载背景音乐，并准备播放
- (void)loadBackMusicPlayerWithName:(NSString *)musicName
{
    _backMusicPlayer = [SoundTool audioPlayerWithName:musicName];

    // 设置循环播放
    [_backMusicPlayer setNumberOfLoops:-1];

    // 缓冲音乐
    [_backMusicPlayer prepareToPlay];
}

#pragma mark - 属性
#pragma mark 设置播放声音属性
- (void)setEnableSoundPlay:(BOOL)enableSoundPlay
{
    [[NSUserDefaults standardUserDefaults] setBool:!enableSoundPlay forKey:kSoundToolDisablePlaySound];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 播放音效属性
- (BOOL)enableSoundPlay
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:kSoundToolDisablePlaySound];
}

#pragma mark 设置播放音乐属性
- (void)setEnableMusicPlay:(BOOL)enableMusicPlay
{
    if (enableMusicPlay) {
        [self playBackMusic];
    } else {
        [self pauseBackMusic];
    }

    [[NSUserDefaults standardUserDefaults] setBool:!enableMusicPlay forKey:kSoundToolDisablePlayMusic];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 播放音乐属性
- (BOOL)enableMusicPlay
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:kSoundToolDisablePlayMusic];
}

#pragma mark - 对象方法
#pragma mark 使用声音包名称和背景音乐名称准备SoundTool
- (void)prepareSoundToolWithSoundBundleName:(NSString *)soundBundleName backMusicName:(NSString *)backMusicName
{
    // 从soundBundle中全部音效文件
    [self loadSoundsFromBundleName:soundBundleName];

    // 加载背景音乐并准备播放
    [self loadBackMusicPlayerWithName:backMusicName];

    // 根据系统偏好中的设置，决定是否播放背景音乐
    if ([self enableMusicPlay]) {
        [self playBackMusic];
    }
}

#pragma mark - 音效处理成员方法
#pragma mark 声音字典中的数量
- (NSInteger)numberOfSounds
{
    return [_soundsDict count];
}

#pragma mark 返回字典中的所有音效文件名
- (NSArray *)namesOfSounds
{
    return [_soundsDict allKeys];
}

#pragma mark 使用文件名播放音效
- (void)playSoundWithName:(NSString *)name
{
    if (![self enableSoundPlay]) return;

    // 从字典中取出SystemSoundID
    SystemSoundID soundID = [_soundsDict[name] unsignedIntegerValue];

    // 判断文件是否存在
    NSAssert(soundID > 0, @"%@ %ld - 音效文件不存在！", name, soundID);

    // 播放音效
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark 使用文件名播放警告音效
- (void)playAlertSoundWithName:(NSString *)name
{
    if (![self enableSoundPlay]) return;

    // 从字典中取出SystemSoundID
    SystemSoundID soundID = [_soundsDict[name] unsignedIntegerValue];

    // 判断文件是否存在
    NSAssert(soundID > 0, @"%@ %ld - 音效文件不存在！", name, soundID);

    // 播放音效
    AudioServicesPlayAlertSound(soundID);
}

#pragma mark 播放背景音乐
- (void)playBackMusic
{
    if (!_backMusicPlayer.isPlaying) {
        [_backMusicPlayer play];
    }
}

#pragma mark 暂停背景音乐
- (void)pauseBackMusic
{
    if (_backMusicPlayer.isPlaying) {
        [_backMusicPlayer pause];
    }
}

#pragma mark 停止背景音乐
- (void)stopBackMusic
{
    if (_backMusicPlayer.isPlaying) {
        [_backMusicPlayer stop];
    }
}

#pragma mark - AVAudioPlayer相关方法
#pragma mark 使用指定的URL加载音频播放器
+ (AVAudioPlayer *)audioPlayerWithURL:(NSURL *)url
{
    NSError *error = nil;

    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

    if (error) {
        NSLog(@"加载音乐播放器失败 - %@", error.localizedDescription);

        return nil;
    }

    return player;
}

#pragma mark 使用指定的文件名从MainBundle中加载音频播放器
+ (AVAudioPlayer *)audioPlayerWithName:(NSString *)fileName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];

    if (url) {
        return [SoundTool audioPlayerWithURL:url];
    }

    return nil;
}

#pragma mark 使用指定的文件名从bundleName中加载音乐播放器
+ (AVAudioPlayer *)audioPlayerFromBundle:(NSString *)bundleName fileName:(NSString *)fileName
{
    NSBundle *bundle = [SoundTool bundleWithName:bundleName];
    NSURL *url = [bundle URLForResource:fileName withExtension:nil];
    
    if (url) {
        return [SoundTool audioPlayerWithURL:url];
    }
    
    return nil;
}

#pragma mark 设置后台音乐播放任务ID

+ (UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
    // 1. 设置并激活音频会话类别
    AVAudioSession *session = [AVAudioSession sharedInstance];

    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];

    // 2. 允许应用程序接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    // 3. 设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;

    newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if (newTaskId != UIBackgroundTaskInvalid && backTaskId != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }

    return newTaskId;
}

@end
