//
//  SoundTool.h
//  音频播放与录制
//
//  Created by 刘凡 on 13-12-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/**
 *  声音播放工具使用说明
 *
 *  1.  准备工作
 *
 *      1) 将所有音效文件保存在一个bundle中，例如sound.bundle；
 *      2) 将背景音乐文件直接放在MainBound中
 *
 *  2.  使用方法
 *
 *      1)  [[SoundTool sharedSoundTool] prepareSoundToolWithSoundBundleName:@"sound.bundle" backMusicName:@"game_music.mp3"];
 *
 *      加载sound.bundle中的所有音效文件，并循环播放指定的背景音乐
 *
 *      2)  [[SoundTool sharedSoundTool] playSoundWithName:@"bullet.mp3"];
 *
 *      使用sound.bundle中的文件名播放音效
 *
 *      3)  [[SoundTool sharedSoundTool] playAlertSoundWithName:@"bullet.mp3"];
 *
 *      使用sound.bundle中的文件名播放音效并振动
 *
 *      4)  设置背景播放
 *          (1) 添加成员变量
 *              UIBackgroundTaskIdentifier  _bgTaskId;      // 后台播放任务Id
 *          (2) 在应用程序启动时，设置后台播放任务代号
 *              _bgTaskId = [SoundTool backgroundPlayerID:_bgTaskId];
 *          (3) 在Info.plist中增加后台播放支持
 *              Required background modes -> App plays audio or streams audio/video using AirPlay
 *
 *  3.  应用中的设置
 *
 *          setEnableSoundPlay  可以打开或关闭音效的播放设置
 *          setEnableMusicPlay  可以打开或关闭背景音乐的播放设置
 *
 *      说明：音效和背景音乐播放的设置保存在系统偏好之中
 *
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface SoundTool : NSObject
single_interface(SoundTool)

/**
 *  允许播放音效属性，如果设置为NO，全局不播放音效
 *
 *  从系统偏好中获取播放音效设置，如果系统偏好中不存在，则默认播放音效
 */
@property (assign, nonatomic) BOOL  enableSoundPlay;
/**
 *  允许播放音乐属性，如果设置为NO，全局不播放音乐
 *
 *  从系统偏好中获取播放音乐设置，如果系统偏好中不存在，则默认播放音乐
 */
@property (assign, nonatomic) BOOL  enableMusicPlay;

#pragma mark - 对象方法
/**
 *  使用声音包名称和背景音乐名称准备SoundTool
 *
 *  @param soundBundleName soundBundle名称
 *  @param backMusicName   背景音乐文件名
 */
- (void)prepareSoundToolWithSoundBundleName:(NSString *)soundBundleName backMusicName:(NSString *)backMusicName;

#pragma mark - 音效文件相关方法
/**
 *  声音字典中包含的音频文件数量
 *
 *  @return 音频文件数量
 */
- (NSInteger)numberOfSounds;
/**
 *  返回字典中的所有音效文件名
 *
 *  @return 音效文件名数组
 */
- (NSArray *)namesOfSounds;

/**
 *  使用文件名播放音效
 *
 *  @param name 要播放音效的声音文件名
 */
- (void)playSoundWithName:(NSString *)name;
/**
 *  使用文件名播放警告音效
 *
 *  @param name 要播放音效的声音文件名
 */
- (void)playAlertSoundWithName:(NSString *)name;

/**
 *  播放背景音乐
 */
- (void)playBackMusic;
/**
 *  暂停背景音乐
 */
- (void)pauseBackMusic;
/**
 *  停止背景音乐
 */
- (void)stopBackMusic;

#pragma mark - AVAudioPlayer相关类方法
/**
 *  使用指定的URL加载音乐播放器
 *
 *  @param url 音乐文件URL
 *
 *  @return 音乐播放器
 */
+ (AVAudioPlayer *)audioPlayerWithURL:(NSURL *)url;
/**
 *  使用指定的文件名从MainBundle中加载音乐播放器
 *
 *  @param fileName 音乐文件名
 *
 *  @return 音乐播放器
 */
+ (AVAudioPlayer *)audioPlayerWithName:(NSString *)fileName;
/**
 *  使用指定的文件名从bundleName中加载音乐播放器
 *
 *  @param bundleName 存放音乐文件的bundleName
 *  @param fileName   音乐文件名
 *
 *  @return 音乐播放器
 */
+ (AVAudioPlayer *)audioPlayerFromBundle:(NSString *)bundleName fileName:(NSString *)fileName;


/**
 *  设置后台音乐播放任务ID
 *
 *  @param backTaskId 初始后台播放标示
 *
 *  @return 后台任务标示
 */
+ (UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId;

@end
