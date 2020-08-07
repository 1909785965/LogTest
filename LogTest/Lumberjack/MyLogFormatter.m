//
//  MyLogFormatter.m
//  jeevesApp
//
//  Created by mingyang.wu on 17/5/19.
//  Copyright © 2017年 TPVision India Pvt Ltd. All rights reserved.
//

#import "MyLogFormatter.h"

@implementation MyLogFormatter

- (id)init {
    if((self = [super init])) {
        threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
        [threadUnsafeDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
    }
    return self;
}


- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"E |"; break;
        case DDLogFlagWarning  : logLevel = @"W |"; break;
        case DDLogFlagInfo     : logLevel = @"I |"; break;
        case DDLogFlagDebug    : logLevel = @"D |"; break;
        default                : logLevel = @"V |"; break;
    }
    
    NSString *dateAndTime = [threadUnsafeDateFormatter stringFromDate:(logMessage->_timestamp)];
    NSString *logMsg = logMessage->_message;
    NSString *logFileNmae = logMessage -> _fileName;
    NSString *logFuncation = logMessage -> _function;
    unsigned long lineNum = logMessage -> _line;
    
    return [NSString stringWithFormat:@"[%@] %@ %@ :%li %@ %@ ",dateAndTime, logFileNmae, logFuncation,lineNum, logLevel,logMsg];
    
}


@end
