//
//  ViewController.m
//  ReactNativeSDKExample
//
//  Created by nikki on 2024/9/7.
//

#import "ViewController.h"
#import <React/RCTRootView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)click:(id)sender {
    NSString *bundleUrl = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"jsbundle"];
//
    NSURL *jsCodeLocation = [NSURL URLWithString:bundleUrl];
//    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    NSDictionary *mockData = @{
        @"scores": @[
            @{@"name": @"Alex", @"value": @"42"},
            @{@"name": @"Joel", @"value": @"10"}
        ]
    };
    
    UIView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNHighScores"
                                                 initialProperties:mockData
                                                     launchOptions:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
