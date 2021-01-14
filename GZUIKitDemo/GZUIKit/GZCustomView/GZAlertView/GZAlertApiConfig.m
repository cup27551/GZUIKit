//
//  GZAlertApiConfig.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/14.
//

#import "GZAlertApiConfig.h"

@interface GZAlertApiConfig ()

@end

@implementation GZAlertApiConfig

+ (instancetype)shardInstance {
    static GZAlertApiConfig *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[GZAlertApiConfig alloc]init];
    
    });
    return _shared;
}


#pragma mark - Getter
- (UIFont *)alertLabelFont {
    if (_alertLabelFont == nil) {
        _alertLabelFont = GZ_FONT_YAHEI(GZ_HorizontalFlexible(13));
    }
    return _alertLabelFont;
}

- (UIColor *)alertLabelColor {
    if (_alertLabelColor == nil) {
        _alertLabelColor = self.isDarkStyle ? GZColor(71, 71, 71, 1) : [UIColor whiteColor];
    }
    return _alertLabelColor;
}

- (UIColor *)alertLabelBGColor {
    if (_alertLabelBGColor == nil) {
        _alertLabelBGColor = self.isDarkStyle ? [UIColor colorWithWhite:1 alpha:0.7] : [UIColor colorWithWhite:0 alpha:0.7];
    }
    return _alertLabelBGColor;
}

@end
