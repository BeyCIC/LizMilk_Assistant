//
//  UIColor+NSString.h
//  Categories
//
//  Created by yu on 15/12/27.
//  Copyright © 2015年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NSString)

//以#开头的字符串（不区分大小写）,如：#ffFFff, 若需要alpha，则传#abcdef255, 不传默认为1
+ (UIColor *)colorWithString:(NSString *)name;

@end
