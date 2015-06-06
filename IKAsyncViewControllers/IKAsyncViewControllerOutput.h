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

/**
 *  Represents the future output of a UIViewController
 */
@interface IKAsyncViewControllerOutput : NSObject
/**
 *  Allows a UIViewController to signal its completion and parse its output forward
 *
 *  @param output <#output description#>
 */
-(void)output:(id)output;

/**
 *  Block that is called to parse the output of one UIViewController to the next
 */
@property (nonatomic, strong, readonly) IKAsyncViewControllerOutput * (^then)(asyncViewControllerOutputBlock function);

/**
 *  Block that is called to parse the output of one UIViewController to the next if `predicate` returns YES
 */
@property (nonatomic, strong, readonly) IKAsyncViewControllerOutput * (^thenIf)(BOOL predicate, asyncViewControllerOutputBlock function);

/**
 *  Block called at the end of a chain to provide the final value
 */
@property (nonatomic, strong, readonly) void (^finally)(asyncViewControllerFinallyBlock);
@end
