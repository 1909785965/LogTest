//
//  ExceptionHandler.h
//  Philips TV Remote App
//
//  Created by Suraj Thomas K on 06/08/13.
//  Copyright (c) 2013 TPVision India Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ExceptionHandler : NSObject


/**
 * This method registers the exception and signal handlers for the app.
 * Will return without executing the code, if the app is AppStore build
 */
+ (void) registerForExceptionAndSignalHandling;

@end
