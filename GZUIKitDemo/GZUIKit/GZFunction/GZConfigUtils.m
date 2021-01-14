//
//  GZConfigUtils.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/11.
//

#import "GZConfigUtils.h"

@implementation GZConfigUtils

+ (UIViewController *)keyController {
    UIViewController *keyController;
    if (@available(iOS 13.0, *)) {
        keyController = [[[UIApplication sharedApplication].windows firstObject] rootViewController];
    } else {
        keyController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    }
    
    UIViewController *currentVC = [GZConfigUtils getCurrentVCFrom:keyController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}


@end
