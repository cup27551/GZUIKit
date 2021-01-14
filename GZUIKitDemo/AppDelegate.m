//
//  AppDelegate.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/5.
//

#import "AppDelegate.h"
#import "GZAlertView.h"
#import "GZLayoutManager.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *windows = [[UIWindow alloc] initWithFrame:GZ_SCREEM_BOUNDS];
    windows.backgroundColor = [UIColor whiteColor];
    self.window = windows;

    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
