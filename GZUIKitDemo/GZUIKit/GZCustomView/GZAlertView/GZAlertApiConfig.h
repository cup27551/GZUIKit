//
//  GZAlertApiConfig.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/14.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface GZAlertApiConfig : NSObject

///APP如果是深色背景置为YES，默认NO
@property (nonatomic, assign) BOOL isDarkStyle;

///提示置中，默认为NO在屏幕下方，但如果提示过长永远都会在中间
@property (nonatomic, assign) BOOL isCenter;

///文字大小（注意和isDarkStyle使用冲突）
@property (nonatomic, strong) UIFont *alertLabelFont;

///文字颜色（注意和isDarkStyle使用冲突）
@property (nonatomic, strong) UIColor *alertLabelColor;

///文字背景颜色（注意和isDarkStyle使用冲突）
@property (nonatomic, strong) UIColor *alertLabelBGColor;


+ (instancetype)shardInstance;

@end

NS_ASSUME_NONNULL_END
