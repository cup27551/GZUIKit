//
//  GZPhoneImageManager.h
//  CatPaw
//
//  Created by quark on 2020/7/21.
//  Copyright © 2020 BZDGuanZi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GZPhotoImageManager : NSObject

@property (nonatomic, copy) GZNormalHandler imageBlock;
@property (nonatomic, copy) GZMoreValueHandler videoBlock;

- (void)showImageActionFromController:(UIViewController *)controller;

- (void)publishVideoActionFromController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
