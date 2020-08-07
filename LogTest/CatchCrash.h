//
//  CatchCrash.h
//  LogTest
//
//  Created by tpv tpv on 17/12/6.
//  Copyright © 2017年 xumxum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchCrash : NSObject

void uncaughtExceptionHandler(NSException *exception);

@end
