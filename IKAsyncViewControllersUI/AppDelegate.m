//
//  AppDelegate.m
//  IKAsyncViewControllers
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UINavigationController+IKAsyncViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationController *navController = [UINavigationController new];
    navController
    .root(^{ return [ViewController new]; })
    .then(^(id output){ return [ViewController new]; })
    .thenIf(NO, ^(id output){ return [ViewController new]; })
    .finally(^(id value) {
        //..
    });
    
    return YES;
}
@end
