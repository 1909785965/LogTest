//
//  CatchCrash.m
//  LogTest
//
//  Created by tpv tpv on 17/12/6.
//  Copyright © 2017年 xumxum. All rights reserved.
//

#import "CatchCrash.h"
#import "LogTestPrefix.pch"


@implementation CatchCrash

//在AppDelegate中注册后，程序崩溃时会执行的方法
 void uncaughtExceptionHandler(NSException *exception)
{
        //获取系统当前时间，（注：用[NSDate date]直接获取的是格林尼治时间，有时差）
        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *crashTime = [formatter stringFromDate:[NSDate date]];
        //异常的堆栈信息
        NSArray *stackArray = [exception callStackSymbols];
    AppLogE(@"异常的堆栈信息:%@",stackArray);

        //出现异常的原因
        NSString *reason = [exception reason];
    AppLogE(@"异常的原因:%@",reason);
        //异常名称
        NSString *name = [exception name];
    AppLogE(@"异常名称:%@",name);
    
        //拼接错误信息
        NSString *exceptionInfo = [NSString stringWithFormat:@"crashTime: %@ Exception reason: %@\nException name: %@\nException stack:%@", crashTime, name, reason, stackArray];
    
        //把错误信息保存到本地文件，设置errorLogPath路径下
        //并且经试验，此方法写入本地文件有效。
        NSString *errorLogPath = [NSString stringWithFormat:@"%@/Documents/errorrrr.log", NSHomeDirectory()];
       NSLog(@"日志路径===%@",errorLogPath);
        NSError *error = nil;
        BOOL isSuccess = [exceptionInfo writeToFile:errorLogPath atomically:YES encoding:NSUTF8StringEncoding error:nil];//写到本地
        if (!isSuccess) {
            DLog(@"将crash信息保存到本地失败: %@", error.userInfo);
        }
}



@end
