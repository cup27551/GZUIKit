//
//  NSDate+GZ.h
//  GZUIKitDemo
//
//  Created by quark on 2021/1/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (GZ)

///比较两个日期大小 结束时间大于开始时间 == YES
+ (BOOL)compareDate:(NSDate *)star withDate:(NSDate *)end;

///毫秒换算成时分秒
+ (NSString *)returnTimeStrWithMillisecond:(NSInteger)millisecond;

///秒换算成时分秒
+ (NSString *)returnTimeStrWithSecond:(NSInteger)second;

///获取当前时间戳(以秒为单位)
+ (NSString *)getNowTimeTimestampBySecond;

///获取当前时间戳 （以毫秒为单位）
+ (NSString *)getNowTimeTimestampByMillisecond;

/// 将秒数转换成小时（非常规）
+ (NSString *)hourFormSecond:(NSInteger)second;

@end

NS_ASSUME_NONNULL_END
