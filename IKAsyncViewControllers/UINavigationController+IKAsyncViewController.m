//
//  UINavigationController+IKAsyncViewController
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "UINavigationController+IKAsyncViewController.h"

@interface IKAsyncViewControllerOutput (Private)
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation UINavigationController (AsyncViewController)
-(IKAsyncViewControllerOutput *(^)(asyncViewControllerBlock))push {
    __weak typeof(self) weakSelf = self;
    return ^IKAsyncViewControllerOutput *(asyncViewControllerBlock function) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        IKAsyncViewControllerOutput *output = [strongSelf create:function actionBlock:^(UIViewController *instance) {
            [strongSelf pushViewController:instance animated:YES];
        }];
        return output;
    };
}
-(IKAsyncViewControllerOutput *(^)(asyncViewControllerBlock))root {
    __weak typeof(self) weakSelf = self;
    return ^IKAsyncViewControllerOutput *(asyncViewControllerBlock function) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        IKAsyncViewControllerOutput *output = [strongSelf create:function actionBlock:^(UIViewController *instance) {
            [strongSelf setViewControllers:@[instance] animated:NO];
        }];
        return output;
    };
}

#pragma mark - Private
-(IKAsyncViewControllerOutput *)create:(asyncViewControllerBlock)create actionBlock:(void(^)(UIViewController *instance))action {
    IKAsyncViewControllerOutput *output = [IKAsyncViewControllerOutput new];
    UIViewController<IKAsyncViewController> *instance = create();
    [instance useOutput:output];
    output.viewController = instance;
    action(instance);
    return output;
}
@end
