//
//  AppDelegate.m
//  IKAsyncViewControllers
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "AppDelegate.h"
#import "UINavigationController+IKAsyncViewController.h"
#import "VCColor.h"

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation AppDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.navController = [UINavigationController new];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
    self.navController
    .push(^{ return [VCColor new]; }, NO)
    .then(^(UIColor *output) { return [VCColor vcWithBGColor:output]; }, YES)
    .then(^(UIColor *output) { return [VCColor vcWithBGColor:output]; }, YES)
    .then(^(UIColor *output) { return [VCColor vcWithBGColor:output]; }, YES);
}
@end
