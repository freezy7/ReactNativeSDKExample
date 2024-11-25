//
//  ViewController.m
//  ReactNativeSDKExample
//
//  Created by nikki on 2024/9/7.
//

#import "ViewController.h"
#import <React/RCTRootView.h>

@interface ViewController () {
    NSURL *_mainBundleURL;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"Caches目录: %@", cachesDirectory);
    NSString *rnDirectoryPath = [cachesDirectory stringByAppendingPathComponent:@"rn"];
    // 创建文件管理对象
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // 检查 rn 文件夹是否已存在
    if (![fileManager fileExistsAtPath:rnDirectoryPath]) {
        // 创建 rn 文件夹
        NSError *error = nil;
        BOOL success = [fileManager createDirectoryAtPath:rnDirectoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (success) {
            NSLog(@"成功创建 rn 文件夹: %@", rnDirectoryPath);
        } else {
            NSLog(@"创建 rn 文件夹失败: %@", error.localizedDescription);
        }
    } else {
        NSLog(@"rn 文件夹已存在: %@", rnDirectoryPath);
    }
    
    // 资源文件需要和main.jsbundle在同一级目录，否则就无法进行展示
    NSString *sourceBundlePath = [[NSBundle mainBundle] pathForResource:@"jsbundle" ofType:@"bundle"];
    NSString *targetBundlePath = [rnDirectoryPath stringByAppendingPathComponent:@"jsbundle.bundle"];
    
    // 4. 复制 bundle 文件到目标路径
    NSError *copyError = nil;
    if (![fileManager fileExistsAtPath:targetBundlePath]) {
        BOOL success = [fileManager copyItemAtPath:sourceBundlePath toPath:targetBundlePath error:&copyError];
        if (success) {
            NSLog(@"成功复制 bundle 到目标路径: %@", targetBundlePath);
        } else {
            NSLog(@"复制 bundle 失败: %@", copyError.localizedDescription);
        }
    } else {
        NSLog(@"目标路径已存在 bundle 文件: %@", targetBundlePath);
    }
    
    NSString *targetJSBundlePath = [rnDirectoryPath stringByAppendingPathComponent:@"jsbundle.bundle/main.jsbundle"];
    _mainBundleURL = [NSURL fileURLWithPath:targetJSBundlePath];
}

- (IBAction)click:(id)sender {
    NSURL *jsCodeLocation = _mainBundleURL;
    UIView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"AwesomeProject"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)click2:(id)sender {
    NSURL *jsCodeLocation = _mainBundleURL;
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
