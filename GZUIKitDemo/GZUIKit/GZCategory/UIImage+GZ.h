//
//  UIImage+GZ.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (GZ)

/** 生成二维码*/
+ (UIImage *)createQRCodeImageWithText:(NSString *)text size:(CGSize)size;

/** 截图*/
+ (UIImage *)snapshot:(UIView *)view;

/** 返回虚线图片*/
+ (UIImage *)gettingDottedLineWithImageView:(UIImageView *)imageView color:(UIColor *)color;




@end

NS_ASSUME_NONNULL_END
