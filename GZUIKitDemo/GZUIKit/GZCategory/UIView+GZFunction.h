//
//  UIView+GZFunction.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GZFunction)

- (BOOL)containsSubView:(UIView *)subView;
- (BOOL)containsSubViewOfClassType:(Class)aClass;
- (void)viewHideDelay:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
