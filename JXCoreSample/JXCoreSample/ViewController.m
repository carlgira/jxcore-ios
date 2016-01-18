//
//  ViewController.m
//  JXCoreSample
//
//  Created by Carlos Giraldo on 17/1/16.
//  Copyright © 2016 Carlos Giraldo. All rights reserved.
//

#import "ViewController.h"
#import "CDVJXcore.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_stopServerButton setEnabled:false];
    
    _jxcore =  [[CDVJXcore alloc] init];
    _jxcore.viewController = self;
    [_jxcore pluginInitialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateLabel:(NSString*) texto{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //load your data here.
        dispatch_async(dispatch_get_main_queue(), ^{
                _serverStatusLabel.text = texto;
        });
    });

}



- (IBAction)startServerAction:(id)sender {
    [_startServerButton setEnabled:false];
    [_stopServerButton setEnabled:true];
    
    [JXcore callEventCallback:@"JXCoreModule_startServer" withJSON:@"{ }"];
}

- (IBAction)stopServerAction:(id)sender {
    [_stopServerButton setEnabled:false];
    [_startServerButton setEnabled:true];
    
    [JXcore callEventCallback:@"JXCoreModule_stopServer" withJSON:@"{ }"];
}
@end
