//
//  Util.m
//  wallet_international
//
//  Created by JasonHuang on 16/9/6.
//  Copyright © 2016年 任杰. All rights reserved.
//

#import "Util.h"

@implementation Util

/**
 *弹到指定的controller
 */
+ (void)popToViewController:(UINavigationController*)mUINavigationController clazz:(Class)clazz animated:(BOOL)animated
{
    for (UIViewController *temp in mUINavigationController.viewControllers) {
        if ([temp isKindOfClass:clazz]) {
            [mUINavigationController popToViewController:temp animated:YES];
            break;
        }
    }
}

+ (void)popToLastedViewController:(UINavigationController*)mUINavigationController clazz:(Class)clazz animated:(BOOL)animated
{
    UIViewController *viewController = nil;
    for (UIViewController *temp in mUINavigationController.viewControllers) {
        if ([temp isKindOfClass:clazz]) {
            viewController = temp;
        }
    }
    [mUINavigationController popToViewController:viewController animated:YES];
}

/**
 *是否已经包含该controller
 */
+ (BOOL)isAlreadPushdViewController:(UINavigationController*)mUINavigationController clazz:(Class)clazz {
    for (UIViewController *temp in mUINavigationController.viewControllers) {
        if ([temp isKindOfClass:clazz]) {
            return YES;
        }
    }
    return NO;
}


//add by huang
+ (BOOL)isStrEmpty:(NSString *)str {
    
    if (nil == str || [str isEqual:[NSNull null]]) {
        return YES;
    } else if (![str isKindOfClass:[NSString class]]) {
        return NO;
    } else if ( 0 == str.length) {
        return YES;
    }
    return NO;
}

//判断字符串是否为空
+ (BOOL)isNotStrEmpty:(NSString *)str {
    
    return ![Util isStrEmpty:str];
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (int)calculateDaysFromDate:(NSDate*)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromDate;
    fromDate = [NSDate date];
    NSDate *toDate;
    toDate = [NSDate date];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:date];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return (int)dayComponents.day;
}


+ (NSString*)formatter:(NSString*) formattter FromeDate:(NSDate*)date {
    NSString *returnValue=[NSString string];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formattter];
    returnValue = [dateFormatter stringFromDate:date];
    return returnValue;
}

+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width {
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}


+ (NSString*)ZhConvertToPinying:(NSString*)value{
    
    if (!value) {
        return @"";
    }
    
    NSMutableString *ms = [[NSMutableString alloc] initWithString:value];
    if ([value length]) {
        
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            NSLog(@"pinyin: %@", ms);
            //            return ms;
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            NSLog(@"pinyin: %@", ms);
            [ms setString:[ms stringByReplacingOccurrencesOfString:@" " withString:@""]];
            //            return ms;
        }
    }
    return ms;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//UIView 转 UIImage
+ (UIImage*)convertViewToImage:(UIView*)view{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)notRounding:(float)price afterPoint:(int)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (NSString *)dealWithLargeNumber:(NSNumber*)number {
    if (number.integerValue > 0 && number.integerValue < 1000) {
        return number.stringValue;
    } else if (number.integerValue >= 1000 ) {
        
        return[NSString stringWithFormat:@"%.0ld千",number.integerValue /1000];
    }
    //    } else if (number.integerValue >= 10000) {
    //
    //        return[NSString stringWithFormat:@"%.0ldm",number.integerValue /10000];
    //    }
    return number.stringValue;
}

+ (NSString *)dealWithDouble:(double)doubleValue {
    double d2 = doubleValue;
    NSString *d2Str = [NSString stringWithFormat:@"%lf", d2];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:d2Str];
    NSString *strD2 = [num1 stringValue];
    return strD2;
}

+(NSString*)doubleToformat:(double)value{
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
    [numFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    [numFormat setPositiveFormat:@"###,##0.00;"];
    NSNumber *num = [NSNumber numberWithDouble:value];
    return [numFormat stringFromNumber:num];
}

+ (BOOL )valiMobile:(NSString *)mobile{
    if (mobile.length < 11) {
        return NO;
    } else {
        // 移动号段正则表达式
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        //联通号段正则表达式
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        //电信号段正则表达式
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

//新的验证手机号, 只判断首个数字是否是1
+(BOOL)isValideMobile:(NSString*)mobile{
    NSString *regex = @"^(1[0-9])\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:mobile];
}

//获取当前系统语言
+ (NSString*)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog( @"%@" , currentLanguage);
    return currentLanguage;
}

+ (NSInteger)readNSUserDefaultsInt:(NSString*)key
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    return [userDefaultes integerForKey:key];
}

+ (void)saveNSUserDefaults:(NSString*)key value:(NSInteger)value
{
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
    [userDefaults synchronize];
}

+ (NSString*)calculateDateWith:(NSDate*)date {
    
    if (date) {
        // 1.获得年月日
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        BOOL isToday = NO;
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @" HH:mm";
            isToday = YES;
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:date];
        
        return time;
        
    } else {
        return @"";
    }
}

+ (NSString *)bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)(kSecClassGenericPassword), kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

@end
