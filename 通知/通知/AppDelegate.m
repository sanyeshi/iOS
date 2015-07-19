//
//  AppDelegate.m
//  通知
//
//  Created by 孙硕磊 on 7/16/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*
 提示:通知和应用是分别处理的，应用程序调度了通知后，即使被关闭，仍然能够在指定的调度时间被触发。
 1.通常在使用本地通知时，是在应用程序退出到后台时被调度的，在后台往往会做一些调度的服务，如
   1>未接来电；
   2>新闻类应用，在后台检测最新的数据。有新数据时，通知用户，用户进入应用程序时，直接显示通知的内容
 2.如果要实现，用户进入应用程序时，直接显示通知内容，需要借助于userInfo数据字典
 3.要获取接收到的消息，可以在application:didFinishLaunchWithOptions:方法中实现
 4.应用程序退出后台后，会在内存中驻留一段时间，时间过后，系统会自动清理应用程序，被清理之后，再次运行，才会调用
   application:didFinishLaunchWithOptions:方法
 
 fireDate;            //触发时间
 timeZone;
 repeatInterval;      // 0 means don't repeat
 repeatCalendar;
 alertBody;           // defaults to nil. pass a string or localized string key to show an alert
 soundName;           // name of resource in app's bundle to play or UILocalNotificationDefaultSoundName
 applicationIconBadgeNumber;  // 0 means no change. defaults to 0
 userInfo;            //
 
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
     */
    // Override point for customization after application launch.
    //截获本地通知，用户通过通知的横幅点击进入系统，可以在字典中获取本地通知
    UILocalNotification * notification=[launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification)
    {
        NSLog(@"获取本地通知");
    }
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController=[[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void) loadNotification
{
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    UILocalNotification * localNotification=[[UILocalNotification alloc] init];
    //5秒后触发通知
    localNotification.fireDate=[NSDate dateWithTimeIntervalSinceNow:5.0f];
    localNotification.alertBody=@"通知";
    localNotification.soundName=UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber=1;
    
    //通知需要UIApplication统一调度
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

//进入前台，清除图标数字，注意应用程序图标通知要慎用，尽量减少使用，用户体验不会太好
-(void)applicationWillResignActive:(UIApplication *)application
{
 
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //通知一般是程序进入后台
    [self loadNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
