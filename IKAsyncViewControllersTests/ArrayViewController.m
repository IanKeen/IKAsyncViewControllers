//
//  ArrayViewController.m
//  IKAsyncViewControllers
//
//  Created by Ian Keen on 6/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "ArrayViewController.h"
#import "IKAsyncViewControllerOutput.h"

@interface ArrayViewController ()
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) IKAsyncViewControllerOutput *output;
@end

@implementation ArrayViewController
+(instancetype)initWithArray:(NSArray *)array {
    ArrayViewController *instance = [ArrayViewController new];
    instance.array = array;
    return instance;
}
-(void)useOutput:(IKAsyncViewControllerOutput *)output {
    self.output = output;
}
-(void)addToArray:(id)item {
    [self.output output:[self.array arrayByAddingObject:item]];
}
@end
