//
//  UINavigationController+IKAsyncViewController
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "UINavigationController+IKAsyncViewController.h"
#import <objc/runtime.h>

static void * kViewControllerOutput = "_kViewControllerOutput";

@interface IKAsyncViewControllerOutput (Private)
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation UINavigationController (AsyncViewController)
-(IKAsyncViewControllerOutput *(^)(asyncViewControllerBlock, BOOL))push {
    __weak typeof(self) weakSelf = self;
    return ^IKAsyncViewControllerOutput *(asyncViewControllerBlock function, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        IKAsyncViewControllerOutput *output = [strongSelf create:function actionBlock:^(UIViewController *instance) {
            [strongSelf pushViewController:instance animated:animated];
        }];
        return output;
    };
}
-(IKAsyncViewControllerOutput *(^)(asyncViewControllerBlock, BOOL))root {
    __weak typeof(self) weakSelf = self;
    return ^IKAsyncViewControllerOutput *(asyncViewControllerBlock function, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        IKAsyncViewControllerOutput *output = [strongSelf create:function actionBlock:^(UIViewController *instance) {
            [strongSelf setViewControllers:@[instance] animated:animated];
        }];
        return output;
    };
}
-(IKAsyncViewControllerOutput *)currentOutput {
    if ([self.viewControllers.lastObject conformsToProtocol:@protocol(IKAsyncViewController)]) {
        return objc_getAssociatedObject(self.viewControllers.lastObject, kViewControllerOutput);
    }
    return nil;
}

#pragma mark - Private
-(IKAsyncViewControllerOutput *)create:(asyncViewControllerBlock)create actionBlock:(void(^)(UIViewController *instance))action {
    IKAsyncViewControllerOutput *output = [IKAsyncViewControllerOutput new];
    UIViewController<IKAsyncViewController> *instance = create();
    [instance useOutput:output];
    output.viewController = instance;
    objc_setAssociatedObject(instance, kViewControllerOutput, output, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    action(instance);
    return output;
}
@end
