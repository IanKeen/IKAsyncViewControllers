//
//  IKAsyncViewControllerOutput
//
//  Created by Ian Keen on 5/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "IKAsyncViewControllerOutput.h"
#import <IKResults/AsyncResult.h>

@interface IKAsyncViewControllerOutput ()
@property (nonatomic, strong) AsyncResult *result;
@property (nonatomic, weak) UIViewController *viewController;
@end

@implementation IKAsyncViewControllerOutput
-(instancetype)init {
    if (!(self = [super init])) { return nil; }
    self.result = [AsyncResult asyncResult];
    return self;
}
-(void)output:(id)output {
    [self.result fulfill:[Result success:output]];
}
-(IKAsyncViewControllerOutput *(^)(asyncViewControllerOutputBlock, BOOL))then {
    __weak typeof(self) weakSelf = self;
    return ^IKAsyncViewControllerOutput *(asyncViewControllerOutputBlock function, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        return strongSelf.thenIf(YES, function, animated);
    };
}
-(IKAsyncViewControllerOutput *(^)(BOOL, asyncViewControllerOutputBlock, BOOL))thenIf {
    __weak typeof(self) weakSelf = self;
    return ^IKAsyncViewControllerOutput *(BOOL predicate, asyncViewControllerOutputBlock function, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        IKAsyncViewControllerOutput *new = [IKAsyncViewControllerOutput new];
        strongSelf.result.success(^(id output) {
            if (predicate) {
                UIViewController<IKAsyncViewController> *instance = function(output);
                [instance useOutput:new];
                new.viewController = instance;
                [strongSelf.viewController.navigationController pushViewController:instance animated:animated];
                
            } else {
                new.viewController = self.viewController;
                [new output:output];
            }
        });
        return new;
    };
}
-(void (^)(asyncViewControllerFinallyBlock))finally {
    __weak typeof(self) weakSelf = self;
    return ^void(asyncViewControllerFinallyBlock function) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.result.success(^(id output) {
            function(output);
        });
    };
}
@end
