//
//  UINavigationController+IKAsyncViewController
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKAsyncViewControllerOutput.h"
#import "IKAsyncViewController.h"

typedef UIViewController<IKAsyncViewController> * (^asyncViewControllerBlock)();

/**
 *  UINavigationController category used to begin a chain of IKAsyncViewControllers
 */
@interface UINavigationController (IKAsyncViewController)
/**
 *  Block to provide the first IKAsyncViewController in a chain
 */
@property (nonatomic, readonly) IKAsyncViewControllerOutput * (^root)(asyncViewControllerBlock block, BOOL animated);

/**
 *  Block to push a IKAsyncViewController onto the stack
 */
@property (nonatomic, readonly) IKAsyncViewControllerOutput * (^push)(asyncViewControllerBlock block, BOOL animated);

/**
 *  Returns the current `IKAsyncViewControllerOutput` 'pointer'
 */
@property (nonatomic, readonly) IKAsyncViewControllerOutput *currentOutput;
@end
