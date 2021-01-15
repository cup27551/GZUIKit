//
//  NSDate+GZ.m
//  GZUIKitDemo
//
//  Created by quark on 2021/1/15.
//

#import "NSDate+GZ.h"

@implementation NSDate (GZ)

+ (BOOL)compareDate:(NSDate *)star withDate:(NSDate *)end{
    NSComparisonResult result = [star compare: end];
    if (result==NSOrderedSame) {
        //相等
        return NO;
    }else if (result == NSOrderedAscending) {
       //结束时间大于开始时间
        return YES;
    }else if (result == NSOrderedDescending) {
        //结束时间小于开始时间
        return NO;
    }
    return NO;
}

+ (NSString *)returnTimeStrWithMillisecond:(NSInteger)millisecond {
    return [NSDate returnTimeStrWithSecond:millisecond/1000];
}

+ (NSString *)returnTimeStrWithSecond:(NSInteger)second {
    NSInteger h = second/3600;
    NSInteger m = (second%3600)/60;
    NSInteger s = second%60;
    NSString *format_time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",h,m,s];
    return format_time;
}

+ (NSString *)getNowTimeTimestampBySecond {
    double currentTime =  [[NSDate date] timeIntervalSince1970];
    NSString *strTime = [NSString stringWithFormat:@"%.0f",currentTime];
    return strTime;
}


+ (NSString *)getNowTimeTimestampByMillisecond {
    double currentTime =  [[NSDate date] timeIntervalSince1970]*1000;
    NSString *strTime = [NSString stringWithFormat:@"%.0f",currentTime];
    return strTime;
}

+ (NSString *)hourFormSecond:(NSInteger)second {
    if (second == 0) {
        return  @"0";
    }
    NSInteger sec = second % (60*60);
    NSInteger hour = second / (60*60);
    if (hour == 0) {
        CGFloat secFloat = sec/(60*60.0);
        if (secFloat < 0.1) {
            secFloat = 0.1;
        }
        return  [NSString stringWithFormat:@"%.1f",secFloat];
    }
    else{
        CGFloat secFloat = sec/(60*60.0);
        return  [NSString stringWithFormat:@"%.1f",hour + secFloat];

    }
    
}

@end
