//
//  IKAsyncViewControllersTests.m
//  IKAsyncViewControllersTests
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KIF/KIF.h>
#import <Expecta/Expecta.h>
#import "ArrayViewController.h"
#import "UINavigationController+IKAsyncViewController.h"

@interface IKAsyncViewControllersTests : KIFTestCase
@end

@implementation IKAsyncViewControllersTests
-(void)testRoot {
    __block NSArray *result = nil;
    
    UINavigationController *nav = [UINavigationController new];
    ArrayViewController *first = [ArrayViewController initWithArray:@[]];
    nav.root(^{ return first; }, NO)
    .finally(^(NSArray *output) {
        result = output;
    });
    
    [first addToArray:@"test"];
    expect(result).will.equal(@[@"test"]);
}
-(void)testPush {
    __block NSArray *result = nil;
    
    UINavigationController *nav = [UINavigationController new];
    ArrayViewController *first = [ArrayViewController initWithArray:@[]];
    nav.push(^{ return first; }, NO)
    .finally(^(NSArray *output) {
        result = output;
    });
    
    [first addToArray:@"test"];
    expect(result).will.equal(@[@"test"]);
}

-(void)testThen {
    __block NSArray *result = nil;
    UINavigationController *nav = [UINavigationController new];
    ArrayViewController *first = [ArrayViewController initWithArray:@[]];
    __block ArrayViewController *second = nil;
    
    nav.push(^{ return first; }, NO)
    .then(^(NSArray *output) {
        second = [ArrayViewController initWithArray:output];
        return second;
    }, NO)
    .finally(^(NSArray *output) {
        result = output;
    });
    
    [first addToArray:@"first"];
    [tester waitForTimeInterval:1.0];
    [second addToArray:@"second"];
    
    expect(result).will.equal(@[@"first", @"second"]);
}
-(void)testThenIf {
    __block NSArray *result = nil;
    UINavigationController *nav = [UINavigationController new];
    ArrayViewController *first = [ArrayViewController initWithArray:@[]];
    __block ArrayViewController *second = nil;
    
    nav.push(^{ return first; }, NO)
    .thenIf(NO, ^(NSArray *output) {
        second = [ArrayViewController initWithArray:output];
        return second;
    }, NO)
    .finally(^(NSArray *output) {
        result = output;
    });
    
    [first addToArray:@"first"];
    [tester waitForTimeInterval:1.0];
    [second addToArray:@"second"];
    
    expect(result).will.equal(@[@"first"]);
}

-(void)testThenIf_YES_NO_YES {
    __block NSArray *result = nil;
    UINavigationController *nav = [UINavigationController new];
    ArrayViewController *first = [ArrayViewController initWithArray:@[]];
    __block ArrayViewController *second = nil;
    __block ArrayViewController *third = nil;
    __block ArrayViewController *fourth = nil;
    
    
    nav.push(^{ return first; }, NO)
    .thenIf(YES, ^(NSArray *output) {
        second = [ArrayViewController initWithArray:output];
        return second;
    }, NO)
    .thenIf(NO, ^(NSArray *output) {
        third = [ArrayViewController initWithArray:output];
        return third;
    }, NO)
    .thenIf(YES, ^(NSArray *output) {
        fourth = [ArrayViewController initWithArray:output];
        return fourth;
    }, NO)
    .finally(^(NSArray *output) {
        result = output;
    });
    
    [first addToArray:@"first"];
    [tester waitForTimeInterval:0.5];
    [second addToArray:@"second"];
    [tester waitForTimeInterval:0.5];
    [third addToArray:@"third"];
    [tester waitForTimeInterval:0.5];
    [fourth addToArray:@"fourth"];
    
    expect(result).will.equal(@[@"first", @"second", @"fourth"]);
}
@end
