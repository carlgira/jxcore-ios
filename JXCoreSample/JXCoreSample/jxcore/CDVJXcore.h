// See the LICENSE file

#import <UIKit/UIKit.h>
#import <JXCoreIos/JXcore.h>

@class ViewController;

@interface CDVJXcore : NSObject 
{}

@property ViewController* viewController;

+ (CDVJXcore*) activeInstance;

- (void)Evaluate;

- (void)onPause;

- (void)onResume;

- (void)pluginInitialize;



@end
