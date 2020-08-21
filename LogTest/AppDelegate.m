//
//  AppDelegate.m
//  LogTest
//
//  Created by tpv tpv on 17/12/6.
//  Copyright © 2017年 xumxum. All rights reserved.
//

#import "AppDelegate.h"
#import "MyLogFormatter.h"
#import "CatchCrash.h"




@interface AppDelegate ()

@end

@implementation AppDelegate

//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //for CocoaLumberJack
    //开始时，你需要下面两行代码：
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //这将在你的日志框架中添加两个“logger”。也就是说你的日志语句将被发送到Console.app和Xcode控制 台（就像标准的NSLog）
    [[DDTTYLogger sharedInstance] setLogFormatter:[[MyLogFormatter alloc] init]];
    setenv("XcodeColors", "YES", 0);
    //开启DDLog 颜色
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    //    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    NSString * applicationDocumentsDirectory = [[[[NSFileManager defaultManager]
                                                  URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] path];
    DDLogFileManagerDefault *documentsFileManager = [[DDLogFileManagerDefault alloc]
                                                     initWithLogsDirectory:applicationDocumentsDirectory];
    DDFileLogger *fileLogger = [[DDFileLogger alloc]
                                initWithLogFileManager:documentsFileManager];
    //这个框架的好处之一就是它的灵活性，如果你还想要你的日志语句写入到一个文件中，你可以添加和配置一个file logger:
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    
    [DDLog addLogger:fileLogger];
    [fileLogger setLogFormatter:[[MyLogFormatter alloc] init]];
    //上面的代码告诉应用程序要在系统上保持一周的日志文件。
    //如果不设置rollingFrequency和maximumNumberOfLogFiles，
    //则默认每天1个Log文件、存5天、单个文件最大1M、总计最大20M，否则自动清理最前面的记录。

    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    return YES;
}










- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
