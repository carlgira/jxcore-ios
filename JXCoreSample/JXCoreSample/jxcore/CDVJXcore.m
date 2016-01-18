// See the LICENSE file

#include <sys/types.h>
#include <sys/sysctl.h>
#include <stdio.h>


// ugly but takes care of XCODE 6 i386 compile bug
size_t fwrite$UNIX2003(const void *a, size_t b, size_t c, FILE *d) {
  return fwrite(a, b, c, d);
}
char *strerror$UNIX2003(int errnum) { return strerror(errnum); }
time_t mktime$UNIX2003(struct tm *a) { return mktime(a); }
//double strtod$UNIX2003(const char *a, char **b) { return strtod(a, b); }
void fputs$UNIX2003(const char *restrict c, FILE *restrict f) { fputs(c, f); }

#include <JXCoreIos/jx.h>

#import "CDVJXcore.h"
#import <JXCoreIos/JXcoreExtension.h>
#import <JXCoreIos/JXMobile.h>
#import "ViewController.h"

static CDVJXcore *activeDevice = nil;

@implementation CDVJXcore

+ (CDVJXcore*) activeInstance {
  return activeDevice;
}

- (void)pluginInitialize {
  if (activeDevice != nil) {
    activeDevice = self;
    return;
  }
    
  NSLog(@"JXcore Cordova plugin initializing");
  
  [JXcore useSubThreading];
  [JXcore startEngine:@"jxcore_module" withCallback:callback namedAs:@"  _callback_  "];

  activeDevice = self;
  
  Class extensionClass = NSClassFromString(@"JXcoreExtension");
  if (extensionClass != nil) {
    id extension = [[extensionClass alloc] init];
    [extension defineMethods];
  }

    [JXMobile defineMethods];
    [self registerFunctions];
}

static void callback(NSArray *arr, NSString *_callbackId) {
    if (arr.count != 4) {
        NSLog(@"JXcore-Cordova: Unexpected callback received");
        return;
    }
    
    if (![[arr objectAtIndex:2] isKindOfClass:[NSString class]]) {
        NSLog(@"JXcore-Cordova: Unexpected callback received. Third parameter must "
              "be a String");
        return;
    }
    
    if (activeDevice == nil) {
        NSLog(@"There is no active instance for JXcore plugin");
        return;
    }
}

- (void)onPause {
  [JXcore Evaluate:@"process.emit('pause');"];
}
 
- (void)onResume {
  [JXcore Evaluate:@"process.emit('resume');"];
}


-(void) registerFunctions{
    
    [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
        [_viewController updateLabel:@"Sever Started (Callback from JS!!)"];
    } withName:@"serverStarted"];
    
    [JXcore addNativeBlock:^(NSArray *params, NSString *callbackId) {
        [_viewController updateLabel:@"Sever Stopped (Callback from JS!!)"];
    } withName:@"serverStopped"];
}


@end
