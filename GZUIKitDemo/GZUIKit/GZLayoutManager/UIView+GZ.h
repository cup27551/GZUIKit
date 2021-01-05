//
//  UIView+GZ.h
//  GZUIKit
//
//  Created by GZDGuanZi on 2021/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GZ)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;

@property (nonatomic, assign) CGFloat frameMaxX;
@property (nonatomic, assign) CGFloat frameMaxY;
@property (nonatomic, assign) CGFloat frameMinX;
@property (nonatomic, assign) CGFloat frameMinY;
@property (nonatomic, assign) CGFloat frameMidX;
@property (nonatomic, assign) CGFloat frameMidY;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end

NS_ASSUME_NONNULL_END
