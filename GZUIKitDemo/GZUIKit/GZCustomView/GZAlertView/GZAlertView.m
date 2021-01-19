//
//  GZAlertView.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/11.
//

#import "GZAlertView.h"
#import "GZLayoutManager.h"
#import "GZConfigUtils.h"
#import "UIView+GZFunction.h"
#import "GZDefine.h"

@interface GZAlertView ()


@property (nonatomic, copy) GZIndexHandler doAction;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIView *buttonContentView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *cancelButton;

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


+ (void)sheetAlertViewWithTitles:(NSArray *)titles cancelTitle:(NSString *)cancelTitle fromView:(UIView *)fromView action:(GZIndexHandler)action {
    GZAlertView *view = [[GZAlertView alloc] initWithFrame:GZ_SCREEM_BOUNDS];
    view.titleArr = titles;
    view.doAction = action;
    if (cancelTitle.length) {
        [view.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    }
    [view _setupSheetStyle];
    
    //show
    [fromView addSubview:view];
    [UIView animateWithDuration:0.25 animations:^{
        view.contentView.originY = view.frameHeight - view.contentView.frameHeight;
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - Method
- (void)_setupSheetStyle {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    _contentView = ({
        CGFloat height = (self.titleArr.count+1)*GZ_HorizontalFlexible(50) + GZ_HorizontalFlexible(15) + GZ_BOTTOM_DEFAULT_HEIGHT + GZ_HorizontalFlexible(14);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(GZ_HorizontalFlexible(15), self.frameHeight, self.frameWidth - GZ_HorizontalFlexible(30), height)];
        view.backgroundColor = [UIColor clearColor];
        view;
    });
    [self addSubview:_contentView];
    
    _buttonContentView = ({
        CGFloat height = (self.titleArr.count)*GZ_HorizontalFlexible(50);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frameWidth, height)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.cornerRadius = GZ_HorizontalFlexible(6);
        view.layer.masksToBounds = YES;
        view;
    });
    [self.contentView addSubview:_buttonContentView];
    
    self.cancelButton.originY = self.buttonContentView.frameMaxY + GZ_HorizontalFlexible(15);
    [self.contentView addSubview:self.cancelButton];
    
    for (int i = 0; i<self.titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i*(GZ_HorizontalFlexible(50) + 1), self.contentView.frameWidth, GZ_HorizontalFlexible(50));
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:GZColor(51, 51, 51, 1) forState:UIControlStateNormal];
        button.titleLabel.font = GZ_FONT_YAHEI(GZ_HorizontalFlexible(16));
        button.tag = TAG_NUMBER + i;
        [button addTarget:self action:@selector(sheetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonContentView addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, button.frameMaxY, button.frameWidth, 1)];
        line.backgroundColor = GZColor(235, 235, 235, 1);
        [self.buttonContentView addSubview:line];
        if (i == self.titleArr.count - 1) {
            line.hidden = YES;
        }
    }
}

#pragma mark - Aciton
- (void)sheetButtonAction:(UIButton *)sender {
    if (self.doAction) {
        self.doAction(sender.tag - TAG_NUMBER);
    }
    [self cancelButtonAction:self.cancelButton];
}

- (void)cancelButtonAction:(UIButton *)sender {
    GZWEAKSELF;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.contentView.originY = weakSelf.frameHeight;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

#pragma mark - Getter
- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, self.frameWidth - GZ_HorizontalFlexible(30), GZ_HorizontalFlexible(50));
            button.layer.cornerRadius = GZ_HorizontalFlexible(6);
            button.layer.masksToBounds = YES;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:GZColor(51, 51, 51, 1) forState:UIControlStateNormal];
            button.titleLabel.font = GZ_FONT_YAHEI(GZ_HorizontalFlexible(16));
            [button addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cancelButton;
}


@end
