//
//  NSString+GZ.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define GZ_MOBILE_REG   @"[1]\\d{10}$"//只判断数字位数，第一位为1
#define GZ_PASSWORD_REG @"^(?![^a-zA-Z]+$)(?!\\D+$).{8,16}$" //6-20位字母+数字
#define GZ_EMAIL_REG    @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"//邮箱

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GZ)

///判断字符串是否匹配某个正则
- (BOOL)isMatchingRegularString:(NSString *)regularString;

///是否有中文
- (BOOL)isHaveChinese;

///是否有空格
- (BOOL)isHaveBlank;

///是否符合GZ对密码的规则设定
- (BOOL)isGZCorrectSecret;

///是否符合GZ对手机号的判断，只判断数字位数，第一位为1
- (BOOL)isGZMobileValid;

///计算字符串尺寸
- (CGSize)caculateStringSizeWithLineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width;

/// 去掉所有空格回车
- (NSString *)removeAllSpaceAndNewline;

///生成定长随机字符串
+ (NSString *)randomStringWithLength:(NSInteger)length;

///将bytes转为字符串
+ (NSString *)stringFromDigest:(unsigned char *)digest length:(NSInteger)leng;

///数组转json
+ (NSString *)toJsonStrWithArray:(NSArray *)arr;

/// 字典转json
+ (NSString *)toJsonStrWithDictionary:(NSDictionary *)dic;

///对象转json
+ (NSString *)toJsonStrWithObject:(id)object;

///去掉空格，null等
+ (NSString *)nullToString:(id)data;

///正确的url格式
+ (NSString *)correctUrlStyleWithData:(id)data;

///是否为空
+ (BOOL)isTextEmpty:(NSString*)str;


@end

NS_ASSUME_NONNULL_END
