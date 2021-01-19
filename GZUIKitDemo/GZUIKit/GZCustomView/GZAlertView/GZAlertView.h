//
//  GZAlertView.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/11.
//

#import <UIKit/UIKit.h>
#import "GZAlertApiConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^GZIndexHandler)(NSInteger index);


@interface GZAlertView : UIView

+ (void)showNormalAlertView:(NSString *)text;
+ (void)showNormalAlertView:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)showNormalAlertView:(NSString *)text handler:(void (^__strong)(void))handler;
+ (void)showNormalAlertView:(NSString *)text delay:(NSTimeInterval)delay handler:(void (^__strong)(void))handler;

+ (void)sheetAlertViewWithTitles:(NSArray *)titles cancelTitle:(NSString *)cancelTitle fromView:(UIView *)fromView  action:(GZIndexHandler)action;

@end

NS_ASSUME_NONNULL_END
