# IKAsyncViewControllers

A simple little DSL for chaing `UIViewControllers` together to obtain a final/single value

## Why?
Whenever possible I always try and create my `UIViewControllers` to be just as modular as any other non-visual component. They should be able to be inserted into a 'flow' of `UIViewControllers` to get back some result at the end. In other words my UIViewControllers usually are dumb, they might take some input and have some output but they don't know about anything outside their function.

## Example
Imagine we are creating a small contacts app, the 'flow' of that app might be something like:
* Show a list of contacts
* Once the user selects someone, we show a list of that contacts phone numbers
* Once the user selects a phone number we dial it.

Using `IKAsyncViewController`s that logic can be abstract and written as
```objectivec
-(void)callContact:(UINavigationController *)navController animate:(BOOL)animate {
    navController
    .push(^{ 
    	return [ContactListViewController new]; 
    }, animate)
    .then(^(User *user){ 
    	return [PhoneNumberViewController newWithUser:user]; 
    }, animate)
    .finally(^(NSString *phoneNumber) {
	    NSString *phoneNumberString = [NSString stringWithFormat:@"tel://%@", phoneNumber];
        NSURL *url = [NSURL URLWithString:phoneNumberString];
        [[UIApplication sharedApplication] openURL:url];
    });
    return YES;
}
```

## Usage
### UIViewController
Setting up a UIViewController to support this flow is simple

`.h`
```objectivec
#import <IKAsyncViewControllers/IKAsyncViewController.h>

@interface ViewController : UIViewController <IKAsyncViewController>
@end
```
`.m`
```objectivec
#import "IKAsyncViewControllerOutput.h"

@interface ViewController ()
@property (nonatomic, strong) IKAsyncViewControllerOutput *output;
@end

@implementation ViewController
-(void)useOutput:(IKAsyncViewControllerOutput *)output {
    self.output = output;
}

-(IBAction)actionTriggered:(id)sender {
    [self.output output:<output_value>];
}
@end
```

## Beginning the chain
Starting a chain of `IKAsyncViewController`s is easy using the `UINavigationController` category methods. Given a method to create the first view controller you want to show
```objectivec
-(UIViewController<IKAsyncViewController> *)firstViewController { ... }
```
You can make it the root view controller using the `root` block
```objectivec
-(void)startChain:(UINavigationController *)navController animate:(BOOL)animate {
	navController.root(^{ return [self firstViewController]; }, animate);
}
```
Or you can just push it onto an existing stack with the `push` block
```objectivec
-(void)startChain:(UINavigationController *)navController animate:(BOOL)animate {
	navController.push(^{ return [self firstViewController]; }, animate);
}
```

## Continuing the chain
Parsing a value from one `IKAsyncViewController` to the next is also simple.
Given methods to create an `IKAsyncViewController` that take some input and produce some output
```objectivec
-(UIViewController<IKAsyncViewController> *)anotherViewController:(id)input { ... }
-(UIViewController<IKAsyncViewController> *)andAnotherViewController:(id)input { ... }
```
You using the `then` block
```objectivec
-(void)startChain:(UINavigationController *)navController animate:(BOOL)animate {
	navController.root(^{ return [self firstViewController]; }, animate)
    .then(^(id output) { return [self anotherViewController:output]; }, animate)
    .then(^(id output) { return [self andAnotherViewController:output]; }, animate);
}
```
Or using the `thenIf` block to conditionally show an `IKAsyncViewController`. If the predicate is `NO` the `IKAsyncViewController` will be skipped in the chain
```objectivec
-(void)startChain:(UINavigationController *)navController {
	navController.root(^{ return [self firstViewController]; })
    .thenIf([self shouldShowAnother], ^(id output) { return [self anotherViewController:output]; }, animate)
    .then(^(id output) { return [self andAnotherViewController:output]; }, animate);
}
-(BOOL)shouldShowAnother { ... }
```

## Completing a chain
Eventually the idea is to get some final value from a chain of `IKAsyncViewController`s this is achieved with the `finally` block
```objectivec
-(void)startChain:(UINavigationController *)navController {
	navController.root(^{ return [self firstViewController]; })
    .thenIf([self shouldShowAnother], ^(id output) { return [self anotherViewController:output]; }, animate)
    .then(^(id output) { return [self andAnotherViewController:output]; }, animate)
    .finally(^(id finalValue) {
    	//.. do something with finalValue
    });
}
-(BOOL)shouldShowAnother { ... }
```

# What IKAsyncViewControllers is..
`IKAsyncViewControllers` is a nice, simple DSL that can help you think about making your UIViewControllers more modular. It is a great tool you can use when you have a clearly defined set of UIViewControllers that you can chain together to get some output.

# What IKAsyncViewControllers is not..
`IKAsyncViewControllers` is *not* a replacement for storyboards and while it can be used for complex/multi branch navigation that doesn't necessarily make it the right tool for the job. Have a good think about wether `IKAsyncViewControllers` is right for your app.


# Installation
Install via cocoapods by adding the following to your Podfile
```
pod "IKAsyncViewControllers", "~>1.0"
```
or manually by adding the source files from the `IKEvents` subfolder to your project

# The rest..
Pull Requests are welcome!

If you use this in a project I would love to hear about it!..


### Contact
I'm usually hanging out on [iOS Developers](http://ios-developers.io/). You should check them out!
