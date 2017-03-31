//
//  UPWMarco.h
//  wallet
//
//  Created by TZ_JSKFZX_CAOQ on 14-9-22.
//  Copyright (c) 2014年 China Unionpay Co.,Ltd. All rights reserved.
//


//iOS7以上的系统
#define UP_iOSgt7 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0)

#define UP_iOS_7 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0 && NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0)

#define UP_IPAD (!(UP_IPHONE4||UP_IPHONE5||UP_IPHONE6||UP_IPHONE6_PLUS))

//iPhone4分辨率
#define UP_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhone5分辨率
#define UP_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhone6分辨率
#define UP_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhone6 plus分辨率 标准模式分辨率为1242x2208，放大模式分辨率为1125x2001
#define UP_IPHONE6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)||CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)


//配置文件相关
#define UP_STR(X) [UPWAppUtil localizedStringWithKey:X]

#define UP_LOCALURL(X) [UPWAppUtil localWebUrlWithKey:X]

#define UP_ARRAY(X) (NSArray*)[UPWAppUtil localizedArrayWithKey:X]

//从UI提示语配置文件中取得版本
#define UP_VERCONFIG UP_STR(@"LocalPlist_Version")

//UIColor 相关

// 设计师定义常用颜色值
#define UP_BLACK        0x171717
#define UP_DARK_GREY    0x333333
#define UP_GREY         0x666666
#define UP_LIGHT_GREY   0x999999
#define UP_RED          0xff3b3b
#define UP_DARK_RED     0xce310d
#define UP_BLUE         0x158cfb
#define UP_BLUE_GREEN   0x34b3af
#define UP_GREEN        0x13a308
#define UP_ORANGE       0xE09E1C
#define UP_BLACK_MASK   0x000000E6
#define UP_PAGE_GREY    0xefeff4

#define UPFloat(f) [UPWSizeUtil sizeFloat:f]

#define UPSize(sz) [UPWSizeUtil sizeSize:sz]

#define UPRect(rt) [UPWSizeUtil sizeRect:rt]

#define UP_COL_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// R, G, B, Alpha
#define UP_COL_RGBA(rgbaValue) [UIColor colorWithRed:((float)((rgbaValue & 0xFF000000) >> 24))/255.0 green:((float)((rgbaValue & 0xFF0000) >> 16))/255.0 blue:((float)((rgbaValue & 0xFF00) >> 8))/255.0 alpha:((float)(rgbaValue & 0xFF))/255.0]

#define UP_COL_INT_RGB(r,g,b) [UIColor colorWithRed:((float)r)/255.0 green:((float)g)/255.0 blue:((float)b)/255.0 alpha:1.0]

#define UP_COL_STR(X)  [UPWAppUtil colorWithHexString:X]

#define UP_COL_STR_ALPHA_1(X)  [UPWAppUtil colorWithString:X]

// 判断string是否为00, 00表示JSON数据正常；
#define UP_RESPOK(X) ([X intValue] == kNetRespOkValue)

#define UP_SHDAT    [UPWGlobalData sharedData]

#define UP_GETIMG(X) [UPWAppUtil getImage:X]

#define UP_IOS_VERSION [UPWAppUtil deviceOS]

// 判断string是否为空 nil 或者 @"" 或者 @""；
#define UP_IS_NIL(X)  [UPWAppUtil isEmpty:X]

// 判断如果string为 nil 更改string 为 @""
#define UP_NIL_STR(X)   X = X? X : @""

#define UP_URL(X)  [UPWAppUtil urlWithString:X]

#define UP_FILEEXIST(X) [[NSFileManager defaultManager] fileExistsAtPath:X]

#define UP_App ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define UP_App_KeyWindow [[UIApplication sharedApplication] keyWindow]

//正则表达式
#define UP_REGEXP(X,REG)  [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REG] evaluateWithObject:X]


//打开URL
#define UP_CANOPENURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define UP_OPENURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])

//是否Retina屏幕
#define UP_ISRETINA [UPWAppUtil isRetina]

//屏幕size
#define UP_IPHONESIZE [[UIScreen mainScreen]bounds].size

#define kScreenWidth             ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight             ([UIScreen mainScreen].bounds.size.height)

#define UP_NC [NSNotificationCenter defaultCenter]

#define UP_CGSizeScale(size, scale) CGSizeMake(size.width * scale, size.height * scale)

#define UP_OBJATIDX(ARRAY,INDEX) (ARRAY&&(INDEX>=0)&&(INDEX<[ARRAY count]))?ARRAY[INDEX]:nil

#define DEVICE_IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

