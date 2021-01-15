//
//  NSString+GZ.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/15.
//

#import "NSString+GZ.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (GZ)

- (BOOL)isMatchingRegularString:(NSString *)regularString {
    NSPredicate *regextestPredicate= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularString];
    return [regextestPredicate evaluateWithObject:self];
}

- (BOOL)isHaveChinese {
    for(int i=0; i< [self length];i++)
    {
        int a = [self characterAtIndex:i];
        if( a > 0x4E00 && a < 0x9FFF)
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isHaveBlank {
    return [self containsString:@" "];
}

- (BOOL)isGZCorrectSecret {
    // 创建谓词对象并设定条件表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",GZ_PASSWORD_REG];
    // 字符串判断，然后BOOL值
    BOOL result = [predicate evaluateWithObject:self];
    return result;
}

- (BOOL)isGZMobileValid {
    return [self isMatchingRegularString:GZ_MOBILE_REG];
}

- (CGSize)caculateStringSizeWithLineSpacing:(CGFloat)lineSpacing font:(UIFont *)font width:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

- (NSString *)removeAllSpaceAndNewline {
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

+ (NSString *)randomStringWithLength:(NSInteger)length {
    length = length/2;
    unsigned char digest[length];
    CCRNGStatus status = CCRandomGenerateBytes(digest, length);
    NSString *s = nil;
    if (status == kCCSuccess) {
        s = [NSString stringFromDigest:digest length:length];
    } else {
        s = @"ErrorMsgErrorMsgErrorMsgErrorMsg";
    }
    NSLog(@"randomLength---:%@",s);
    return s;
}

+ (NSString *)stringFromDigest:(unsigned char *)digest length:(NSInteger)leng {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < leng; i++) {
        [string appendFormat:@"%02x",digest[i]];
    }
    NSLog(@"final stringFrom:%@",string);
    return string;
}

+ (NSString *)toJsonStrWithArray:(NSArray *)arr {
    if ([arr isKindOfClass:[NSString class]]) {
        return (NSString *)arr;
    }
    NSError *parseError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (parseError) {
        jsonStr = @"";
    }
    return jsonStr;
}

+ (NSString *)toJsonStrWithDictionary:(NSDictionary *)dic {
    if ([dic isKindOfClass:[NSString class]]) {
        return (NSString *)dic;
    }
    NSError *parseError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (parseError) {
        jsonStr = @"";
    }
    return jsonStr;
}

+ (NSString *)toJsonStrWithObject:(id)object {
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    }else if ([object isKindOfClass: [NSArray class]]) {
        return [NSString toJsonStrWithArray:object];
    }else {
        return [NSString toJsonStrWithDictionary:object];
    }
}

+ (NSString *)nullToString:(id)data {
    NSString *str;
    if (data == [NSNull null] || data == nil || data == Nil || [data isKindOfClass:[NSNull class]]) {
        str = @"";
    }else{
        str = [NSString stringWithFormat:@"%@",data];
    }
    return str;
}

+ (NSString *)correctUrlStyleWithData:(id)data {
    NSString *str = [NSString nullToString:data];
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return str;
}

+ (BOOL)isTextEmpty:(NSString *)str {
    if (str == nil || (id)str == [NSNull null]) {
        return YES;
    }else{
        if (![str respondsToSelector:@selector(length)]) {
            return YES;
        }
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([str length]) {
            return NO;
        }
    }
    return YES;
}




@end
