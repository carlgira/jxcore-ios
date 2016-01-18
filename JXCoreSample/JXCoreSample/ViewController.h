//
//  ViewController.h
//  JXCoreSample
//
//  Created by Carlos Giraldo on 17/1/16.
//  Copyright © 2016 Carlos Giraldo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDVJXcore;

@interface ViewController : UIViewController

@property CDVJXcore* jxcore;

- (void) updateLabel:(NSString*) text;

@property (weak, nonatomic) IBOutlet UILabel *serverStatusLabel;


@property (weak, nonatomic) IBOutlet UIButton *startServerButton;

@property (weak, nonatomic) IBOutlet UIButton *stopServerButton;

- (IBAction)startServerAction:(id)sender;


- (IBAction)stopServerAction:(id)sender;



@end

