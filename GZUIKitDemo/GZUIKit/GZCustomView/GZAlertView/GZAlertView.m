//
//  GZAlertView.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/11.
//

#import "GZAlertView.h"
#import "GZLayoutManager.h"
#import "GZConfigUtils.h"
#import "GZDefine.h"
#import "UIView+GZFunction.h"

@interface GZAlertView ()

@property (nonatomic, assign) BOOL isShow;

@end

@implementation GZAlertView

+ (void)showNormalAlertView:(NSString *)text delay:(NSTimeInterval)delay {
    dispatch_async(dispatch_get_main_queue(), ^{
        GZAlertView *bgView = [[GZAlertView alloc] initWithFrame:GZ_SCREEM_BOUNDS];
        bgView.userInteractionEnabled = NO;

        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, GZ_SCREEN_WIDTH - GZ_HorizontalFlexible(80), 0)];
        textLabel.text = text;
        textLabel.textColor = [GZAlertApiConfig shardInstance].alertLabelColor;
        textLabel.font = [GZAlertApiConfig shardInstance].alertLabelFont;
        textLabel.backgroundColor = [GZAlertApiConfig shardInstance].alertLabelBGColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.layer.cornerRadius = GZ_HorizontalFlexible(5);
        textLabel.layer.masksToBounds = YES;
        textLabel.numberOfLines = 0;
        [textLabel sizeToFit];
        
        textLabel.centerX = GZ_SCREEN_WIDTH * 0.5;
        textLabel.frameWidth = textLabel.frameWidth + GZ_HorizontalFlexible(10);
        if (textLabel.frameWidth > (GZ_SCREEN_WIDTH - GZ_HorizontalFlexible(80))) {
            textLabel.frameWidth = GZ_SCREEN_WIDTH - GZ_HorizontalFlexible(80);
        }
        textLabel.frameHeight = textLabel.frameHeight + GZ_HorizontalFlexible(10);
        if (textLabel.frameHeight > (GZ_SCREEN_HEIGHT - GZ_HorizontalFlexible(20))) {
            textLabel.frameHeight = GZ_SCREEN_HEIGHT - GZ_HorizontalFlexible(20);
        }
        //判断在屏幕的位置
        if ([GZAlertApiConfig shardInstance].isCenter) {
            textLabel.centerY = GZ_SCREEN_HEIGHT * 0.5;
        }else {
            if (textLabel.frameHeight > GZ_HorizontalFlexible(80)) {
                textLabel.centerY = GZ_SCREEN_HEIGHT * 0.5;
            }else {
                textLabel.originY = GZ_SCREEN_HEIGHT - GZ_HorizontalFlexible(120);
            }
        }
        
        //防止多个label叠加
        for (UIView *view in [[GZConfigUtils keyController].view subviews]) {
            if ([view isKindOfClass:[GZAlertView class]]) {
                [view removeFromSuperview];
            }
        }
        
        [bgView addSubview:textLabel];
        
        
        [[GZConfigUtils keyController].view addSubview:bgView];
        
        [bgView viewHideDelay:delay];
    });
}

+ (void)showNormalAlertView:(NSString *)text {
    [GZAlertView showNormalAlertView:text delay:1.5];
}

+ (void)showNormalAlertView:(NSString *)text handler:(nonnull void (^)(void))handler {
    [GZAlertView showNormalAlertView:text delay:1.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        handler();
    });
}

+ (void)showNormalAlertView:(NSString *)text delay:(NSTimeInterval)delay handler:(nonnull void (^)(void))handler {
    [GZAlertView showNormalAlertView:text delay:delay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        handler();
    });
}


@end
