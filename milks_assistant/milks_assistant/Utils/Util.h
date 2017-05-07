//
//  Util.h
//  wallet_international
//
//  Created by JasonHuang on 16/9/6.
//  Copyright © 2016年 任杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject


/**
 *弹到指定的controller
 */
+ (void)popToViewController:(UINavigationController*)mUINavigationController clazz:(Class)clazz animated:(BOOL)animated;

+ (void)popToLastedViewController:(UINavigationController*)mUINavigationController clazz:(Class)clazz animated:(BOOL)animated;
/**
 *是否已经包含该controller
 */
+ (BOOL)isAlreadPushdViewController:(UINavigationController*)mUINavigationController clazz:(Class)clazz;

//判断字符串是否为空
+ (BOOL)isStrEmpty:(NSString *)str ;

+ (BOOL)isNotStrEmpty:(NSString *)str ;

+ (BOOL)isPureInt:(NSString*)string;

+ (int)calculateDaysFromDate:(NSDate*)date ;

+ (NSString*)formatter:(NSString*) formattter FromeDate:(NSDate*)date ;

+ (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;

+ (NSString*)ZhConvertToPinying:(NSString*)value;

+ (NSDate *)dateFromString:(NSString *)dateString;

+ (UIImage*)convertViewToImage:(UIView*)view;

+ (NSString *)notRounding:(float)price afterPoint:(int)position;

+ (NSString *)dealWithLargeNumber:(NSNumber*)number;

+ (NSString *)dealWithDouble:(double)doubleValue ;

+(NSString*)doubleToformat:(double)value;

+ (BOOL )valiMobile:(NSString *)mobile;

+(BOOL)isValideMobile:(NSString*)mobile;

+ (NSString*)getCurrentLanguage;

+ (NSInteger)readNSUserDefaultsInt:(NSString*)key;

+ (void)saveNSUserDefaults:(NSString*)key value:(NSInteger)value;

+ (NSString*)calculateDateWith:(NSDate*)date;

@end
