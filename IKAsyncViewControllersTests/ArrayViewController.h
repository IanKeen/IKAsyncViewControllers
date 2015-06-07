//
//  ArrayViewController.h
//  IKAsyncViewControllers
//
//  Created by Ian Keen on 6/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKAsyncViewController.h"

@interface ArrayViewController : UIViewController <IKAsyncViewController>
+(instancetype)initWithArray:(NSArray *)array;
-(void)addToArray:(id)item;
@end
