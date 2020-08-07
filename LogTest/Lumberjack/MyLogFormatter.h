//
//  MyLogFormatter.h
//  jeevesApp
//
//  Created by mingyang.wu on 17/5/19.
//  Copyright © 2017年 TPVision India Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyLogFormatter : NSObject<DDLogFormatter>
{
    int loggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}
@end
