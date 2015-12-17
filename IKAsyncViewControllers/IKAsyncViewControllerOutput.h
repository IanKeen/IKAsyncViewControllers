//
//  IKAsyncViewControllerOutput
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKAsyncViewController.h"

typedef UIViewController<IKAsyncViewController> * (^asyncViewControllerOutputBlock)(id output);
typedef void(^asyncViewControllerFinallyBlock)(id output);
typedef void(^asyncViewControllerFailedBlock)(NSError *error);

/**
 *  Represents the future output of a UIViewController
 */
@interface IKAsyncViewControllerOutput : NSObject
/**
 *  Allows a UIViewController to signal its completion and parse its output forward
 *
 *  @param output The result/output from the view controller
 */
-(void)output:(id)output;

/**
 *  Allows a UIViewController to signal failure and stop the chain
 *
 *  @param error NSError that caused the failure
 */
-(void)fail:(NSError *)error;

/**
 *  Block that is called to parse the output of one UIViewController to the next
 */
@property (nonatomic, strong, readonly) IKAsyncViewControllerOutput * (^then)(asyncViewControllerOutputBlock function, BOOL animated);

/**
 *  Block that is called to parse the output of one UIViewController to the next if `predicate` returns YES
 */
@property (nonatomic, strong, readonly) IKAsyncViewControllerOutput * (^thenIf)(BOOL predicate, asyncViewControllerOutputBlock function, BOOL animated);

/**
 *  Block called at the end of a chain to provide the final value
 */
@property (nonatomic, strong, readonly) void (^finally)(asyncViewControllerFinallyBlock);

/**
 *  Block called if something should fail
 */
@property (nonatomic, copy) asyncViewControllerFailedBlock failed;
@end
