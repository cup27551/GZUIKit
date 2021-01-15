//
//  GZAlertView.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/11.
//

#import <UIKit/UIKit.h>
#import "GZAlertApiConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZAlertView : UIView

+ (void)showNormalAlertView:(NSString *)text;
+ (void)showNormalAlertView:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)showNormalAlertView:(NSString *)text handler:(void (^__strong)(void))handler;
+ (void)showNormalAlertView:(NSString *)text delay:(NSTimeInterval)delay handler:(void (^__strong)(void))handler;

@end

NS_ASSUME_NONNULL_END
