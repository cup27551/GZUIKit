//
//  GZLayoutManager.h
//  GZUIKit
//
//  Created by GZDGuanZi on 2021/1/5.
//

#ifndef GZLayoutManager_h
#define GZLayoutManager_h

#import "UIView+GZ.h"

static const CGFloat gz_reference_width = 375.f;
static const CGFloat gz_reference_height = 667.f;

#define GZ_INLINE static inline

// Macro define supporting

#define GZ_SCREEM_BOUNDS            [UIScreen mainScreen].bounds
#define GZ_SCREEN_SIZE              [UIScreen mainScreen].bounds.size
#define GZ_SCREEN_WIDTH             GZ_SCREEN_SIZE.width
#define GZ_SCREEN_HEIGHT            GZ_SCREEN_SIZE.height

#define GZ_SCREEN_WIDTH_RATIO       (GZ_SCREEN_WIDTH / gz_reference_width)
#define GZ_SCREEN_HEIGHT_RATIO      (GZ_SCREEN_HEIGHT / gz_reference_height)


// Use these following inline functions to layout your views to adapt multiple screens
GZ_INLINE CGFloat GZ_HorizontalFlexible(CGFloat value) {
    return value * GZ_SCREEN_WIDTH_RATIO;
}

GZ_INLINE CGFloat GZ_VerticalFlexible(CGFloat value) {
    return value * GZ_SCREEN_HEIGHT_RATIO;
}

GZ_INLINE CGPoint GZ_FlexiblePoint(CGPoint point) {
    
    CGFloat x = GZ_HorizontalFlexible(point.x);
    CGFloat y = GZ_VerticalFlexible(point.y);
    return CGPointMake(x, y);
}

GZ_INLINE CGRect GZ_FrameMake(CGSize size, CGPoint center) {
    
    CGFloat x = center.x - size.width/2;
    CGFloat y = center.y - size.height/2;
    
    return CGRectMake(x, y, size.width, size.height);
}

GZ_INLINE CGPoint GZ_CenterFromFrame(CGRect frame) {
    CGFloat x = frame.origin.x + frame.size.width/2;
    CGFloat y = frame.origin.y + frame.size.height/2;
    
    return CGPointMake(x, y);
}

GZ_INLINE CGSize GZ_FlexibleSize(CGSize size) {
    CGFloat width = GZ_HorizontalFlexible(size.width);
    CGFloat heigth = GZ_VerticalFlexible(size.height);
    return CGSizeMake(width, heigth);
}

GZ_INLINE CGRect GZ_FlexibleFrame(CGRect frame) {
    
    CGPoint center = GZ_CenterFromFrame(frame);
    CGPoint flexibleCenter = GZ_FlexiblePoint(center);
    
    CGSize size = frame.size;
    CGSize flexibleSize = GZ_FlexibleSize(size);
    
    CGRect flexibleFrame = GZ_FrameMake(flexibleSize, flexibleCenter);
    
    return flexibleFrame;
    
}

GZ_INLINE CGRect GZ_FlexibleFrameMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    
    return GZ_FlexibleFrame(CGRectMake(x, y, width, height));
}


#endif /* GZLayoutManager_h */
