//
//  IKAsyncViewController
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IKAsyncViewControllerOutput;

/**
 *  Protocol a UIViewController must conform to to support the asynchronous flow
 */
@protocol IKAsyncViewController <NSObject>
/**
 *  Method called to parse a IKAsyncViewControllerOutput instance to the UIViewController
 *  Once the UIViewController has completed its function it should parse its output to the
 *  IKAsyncViewControllerOutput instance.
 *
 *  @param output IKAsyncViewControllerOutput the UIViewController can use to signal completion
 */
-(void)useOutput:(IKAsyncViewControllerOutput *)output;
@end
