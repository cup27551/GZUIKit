//
//  UIView+GZ.m
//  GZUIKit
//
//  Created by GZDGuanZi on 2021/1/5.
//

#import "UIView+GZ.h"

@implementation UIView (GZ)


#pragma mark - =====================Origin=====================
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)newOrigin {
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX {
    self.frame = CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY {
    self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
}

#pragma mark - =====================Size=====================
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)newSize {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newSize.width, newSize.height);
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}

#pragma mark - =====================Point=====================
- (CGFloat)frameMaxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setFrameMaxX:(CGFloat)newFrameMaxX {
    self.frame = CGRectMake(newFrameMaxX - self.frameWidth, self.originY, self.frameWidth, self.frameHeight);
}

- (CGFloat)frameMaxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setFrameMaxY:(CGFloat)newFrameMaxY {
    self.frame = CGRectMake(self.originX, newFrameMaxY - self.frameHeight, self.frameWidth, self.frameHeight);
}

- (CGFloat)frameMidX {
    return CGRectGetMidX(self.frame);
}

- (void)setFrameMidX:(CGFloat)newFrameMidX {
    self.frame = CGRectMake(newFrameMidX-self.frameWidth*0.5, self.originY, self.frameWidth, self.frameHeight);
}

- (CGFloat)frameMidY {
    return CGRectGetMidY(self.frame);
}

- (void)setFrameMidY:(CGFloat)newFrameMidY {
    self.frame = CGRectMake(self.originX, newFrameMidY-self.frameHeight*0.5, self.frameWidth, self.frameHeight);
}

- (CGFloat)frameMinX {
    return CGRectGetMinX(self.frame);
}

- (void)setFrameMinX:(CGFloat)newFrameMinX {
    self.frame = CGRectMake(newFrameMinX, self.frameMinY, self.frameWidth, self.frameHeight);
}

- (CGFloat)frameMinY {
    return CGRectGetMinY(self.frame);
}

- (void)setFrameMinY:(CGFloat)newFrameMinY {
    self.frame = CGRectMake(self.frameMinX, newFrameMinY, self.frameWidth, self.frameHeight);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)newCenterX {
    CGPoint center = self.center;
    center.x = newCenterX;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)newCenterY {
    CGPoint center = self.center;
    center.y = newCenterY;
    self.center = center;
}

@end
