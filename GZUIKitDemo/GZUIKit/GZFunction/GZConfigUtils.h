//
//  GZConfigUtils.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GZConfigUtils : NSObject

+ (UIViewController *)keyController;
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC;


@end

NS_ASSUME_NONNULL_END
