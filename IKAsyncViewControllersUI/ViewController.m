//
//  ViewController.m
//  IKAsyncViewControllers
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "ViewController.h"
#import "IKAsyncViewControllerOutput.h"

@interface ViewController ()
@property (nonatomic, strong) IKAsyncViewControllerOutput *output;
@end

@implementation ViewController
-(void)useOutput:(IKAsyncViewControllerOutput *)output {
    self.output = output;
}

-(IBAction)actionTriggered:(id)sender {
    [self.output output:@(YES)];
}
@end
