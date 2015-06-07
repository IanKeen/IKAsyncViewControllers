//
//  VCColor.m
//  IKAsyncViewControllers
//
//  Created by Ian Keen on 6/06/2015.
//  Copyright (c) 2015 IanKeen. All rights reserved.
//

#import "VCColor.h"
#import "IKAsyncViewControllerOutput.h"

@interface VCColor ()
@property (nonatomic, strong) UIColor *inputColor;
@property (nonatomic, strong) IKAsyncViewControllerOutput *output;
@end

@implementation VCColor
+(instancetype)vcWithBGColor:(UIColor *)color {
    VCColor *instance = [VCColor new];
    instance.inputColor = color;
    return instance;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.inputColor = self.inputColor ?: [UIColor redColor];
    self.view.backgroundColor = self.inputColor;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIColor *outputColor = ([self.inputColor isEqual:[UIColor redColor]] ? [UIColor blueColor] : [UIColor redColor]);
        [self.output output:outputColor];
    });
}
-(void)useOutput:(IKAsyncViewControllerOutput *)output {
    self.output = output;
}
@end
