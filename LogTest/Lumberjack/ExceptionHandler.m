//
//  ExceptionHandler.m
//  Philips TV Remote App
//
//  Created by Suraj Thomas K on 06/08/13.
//  Copyright (c) 2013 TPVision India Pvt Ltd. All rights reserved.
//

#import "ExceptionHandler.h"
#include <sys/signal.h>
#include <execinfo.h>

@interface ExceptionHandler ()

/**
 * Method which gets invoked on encountering an exception and logs the stack trace.
 */
void exceptionHandler(NSException *exception);

/**
 * Method which gets invoked on encountering a signal and logs the stack trace.
 */
void signalHandler(int sig);
@end

@implementation ExceptionHandler

void exceptionHandler(NSException *exception)
{
    AppLogE(@"*********************Exception Caught*********************");
    AppLogE(@"Name -> %@\nReason -> %@\nUserInfo -> %@", exception.name, exception.reason, exception.userInfo);
    AppLogE(@"----------------------------------------------------------");
    AppLogE(@"Call Stack Symbols (Stack Trace) --> -->\n%@", [exception callStackSymbols]);
    AppLogE(@"**********************************************************");
}

void signalHandler(int sig)
{
    void* callstack[128] = {NULL,};
    int frames = backtrace(callstack, sizeof(callstack)/sizeof(callstack[0]));
    char** strs = backtrace_symbols(callstack, frames);
	
    AppLogE(@"*********************Signal Error*********************");
    AppLogE(@"Build Version : %@", [[NSBundle mainBundle]objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]);
    AppLogE(@"Signal Type : %d || Backtrace Symbols Count --> %d\n", sig, frames);
    for (int i = 0; i < frames; ++i) {
        AppLogE(@"%s\n", strs[i]);
    }
	free(strs);
	strs = NULL;
    AppLogE(@"******************************************************");
}

+ (void) registerForExceptionAndSignalHandling
{
#ifdef APP_STORE
	return;
#endif
    
    struct sigaction signalAction;
    memset(&signalAction, 0, sizeof(signalAction));
    signalAction.sa_handler = &signalHandler;
    signalAction.sa_flags = SA_USERSPACE_MASK;
    
    // sigaction(SIGHUP, &signalAction, NULL);				/* hangup */
	// sigaction(SIGINT, &signalAction, NULL);				/* interrupt */
    sigaction(SIGQUIT, &signalAction, NULL);				/* quit */
    sigaction(SIGILL, &signalAction, NULL);					/* illegal instruction (not reset when caught) */
    sigaction(SIGTRAP, &signalAction, NULL);				/* trace trap (not reset when caught) */
    sigaction(SIGABRT, &signalAction, NULL);				/* abort() */
#if  (defined(_POSIX_C_SOURCE) && !defined(_DARWIN_C_SOURCE))
	// sigaction(SIGPOLL, &signalAction, NULL);				/* pollable event ([XSR] generated, not supported) */
#else	/* (!_POSIX_C_SOURCE || _DARWIN_C_SOURCE) */
	// sigaction(SIGIOT, &signalAction, NULL);				/* compatibility */
    sigaction(SIGEMT, &signalAction, NULL);					/* EMT instruction */
#endif	/* (!_POSIX_C_SOURCE || _DARWIN_C_SOURCE) */
    sigaction(SIGFPE, &signalAction, NULL);					/* floating point exception */
	// sigaction(SIGKILL, &signalAction, NULL);				/* kill (cannot be caught or ignored) */
    sigaction(SIGBUS, &signalAction, NULL);					/* bus error */
    sigaction(SIGSEGV, &signalAction, NULL);				/* segmentation violation */
    sigaction(SIGSYS, &signalAction, NULL);					/* bad argument to system call */
	// sigaction(SIGPIPE, &signalAction, NULL);				/* write on a pipe with no one to read it */
    sigaction(SIGALRM, &signalAction, NULL);				/* alarm clock */
	// sigaction(SIGTERM, &signalAction, NULL);				/* software termination signal from kill */
	// sigaction(SIGURG, &signalAction, NULL);				/* urgent condition on IO channel */
	// sigaction(SIGSTOP, &signalAction, NULL);				/* sendable stop signal not from tty */
	// sigaction(SIGTSTP, &signalAction, NULL);				/* stop signal from tty */
	// sigaction(SIGCONT, &signalAction, NULL);				/* continue a stopped process */
	// sigaction(SIGCHLD, &signalAction, NULL);				/* to parent on child stop or exit */
	// sigaction(SIGTTIN, &signalAction, NULL);				/* to readers pgrp upon background tty read */
	// sigaction(SIGTTOU, &signalAction, NULL);				/* like TTIN for output if (tp->t_local&LTOSTOP) */
	//#if  (!defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE))
	// sigaction(SIGIO, &signalAction, NULL);				/* input/output possible signal */
	//#endif
    sigaction(SIGXCPU, &signalAction, NULL);				/* exceeded CPU time limit */
    sigaction(SIGXFSZ, &signalAction, NULL);				/* exceeded file size limit */
	// sigaction(SIGVTALRM, &signalAction, NULL);			/* virtual time alarm */
	// sigaction(SIGPROF, &signalAction, NULL);				/* profiling time alarm */
	//#if  (!defined(_POSIX_C_SOURCE) || defined(_DARWIN_C_SOURCE))
	// sigaction(SIGWINCH, &signalAction, NULL);				/* window size changes */
	// sigaction(SIGINFO, &signalAction, NULL);				/* information request */
	//#endif
	sigaction(SIGUSR1, &signalAction, NULL);				/* user defined signal 1 */
	// sigaction(SIGUSR2, &signalAction, NULL);				/* user defined signal 2 */
    
    NSSetUncaughtExceptionHandler(&exceptionHandler);
}

@end
