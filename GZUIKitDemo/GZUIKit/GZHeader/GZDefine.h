//
//  GZDefine.h
//  GZUIKit
//
//  Created by quark on 2021/1/5.
//

#ifndef GZDefine_h
#define GZDefine_h

#import "GZLayoutManager.h"

typedef void(^GZHandler)(void);
typedef void(^GZNormalHandler)(id value);
typedef void(^GZMoreValueHandler)(id value1,id value2);
typedef void(^GZBoolValueHandler)(BOOL success,id value);

//MARK: Common
#define APP_Name                    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_Version                 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//MARK: Color
#define GZColor(r, g, b, a)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define GZRandomColor               GZColor(arc4random()%256,arc4random()%256,arc4random()%256,1);
#define GZColorFromHex(s)           [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

//MARK: Path
#define GZ_PATH_DOCUMENT            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//MARK: Other
#define TAG_NUMBER                  1000
#define TAG_NUMBERs                 10000
#define GZWEAKSELF                  typeof(self) __weak weakSelf = self;
#define DEFAULT_DURATION            0.25//默认动画时长
#define ARC4RANDOM_MAX              0x100000000

#define NUM                         @"0123456789"
#define ALPHA                       @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM                    @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define IS_iPhoneX (\
{\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);}\
)

//MARK: Height
#define GZ_STATUS_BAR               [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top
#define GZ_NAV_HEIGHT               GZ_STATUS_BAR + 44
#define GZ_TOP_HEIGHT               (IS_iPhoneX ? 44.f : 20.f)
#define GZ_BOTTOM_HEIGHT            (IS_iPhoneX ? 34.f : 0.f)
#define GZ_BOTTOM_DEFAULT_HEIGHT    (IS_iPhoneX ? 20.f : 0.f)

//MARK: Fonts
#define GZ_FONT_YAHEI(x)        [UIFont systemFontOfSize:x weight:UIFontWeightRegular]
#define GZ_FONT_YAHEI_LIGHT(x)  [UIFont systemFontOfSize:x weight:UIFontWeightLight]
#define GZ_FONT_YAHEI_BOLD(x)   [UIFont systemFontOfSize:x weight:UIFontWeightBold]

//MARK: AlertMessg
#define GZ_ERROR_ALAERT                @"❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌❌"
#define GZ_SUCCESS_ALAERT              @"✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️✌️"


#endif /* GZDefine_h */
