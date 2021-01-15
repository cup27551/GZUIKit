//
//  UIColor+GZ.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GZ)

///十六进制颜色转换，带不带#都可以
+ (UIColor *)colorWithHexString: (NSString *)color;
///十六进制颜色转换，带不带#都可以
+ (UIColor *)colorWithHexString:(NSString *) hexColor alpha:(CGFloat)alpha;

///创建纯色图片
+ (UIImage *)createColorImg:(NSString *)hexColor;
///创建纯色图片
+ (UIImage *)createColorImg:(NSString *)hexColor alpha:(CGFloat)alpha;

//返回两个颜色渐变的中间值
+ (UIColor *)colorInTwo:(NSString *)firstColor secondColor:(NSString *)secondColor  percent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
