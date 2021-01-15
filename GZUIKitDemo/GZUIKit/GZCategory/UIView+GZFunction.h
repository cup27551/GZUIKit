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

///给圆角View添加阴影，注意在addSubview之后使用否则无效
- (void)addShadowToViewWithOpacity:(float)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor;


@end

NS_ASSUME_NONNULL_END
