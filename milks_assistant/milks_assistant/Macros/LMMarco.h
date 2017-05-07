//
//  UPWMarco.h
//  wallet
//
//  Created by TZ_JSKFZX_CAOQ on 14-9-22.
//  Copyright (c) 2014年 China Unionpay Co.,Ltd. All rights reserved.
//
#import <Availability.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UPWSizeUtil.h"

//iOS7以上的系统
#define UP_iOSgt7 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0)

#define UP_iOS_7 (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0 && NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0)

#define UP_IPAD (!(UP_IPHONE4||UP_IPHONE5||UP_IPHONE6||UP_IPHONE6_PLUS))


#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height

#define IS_IPHONE_4             ([UIScreen mainScreen].bounds.size.height == 480)
#define IS_IPHONE_5             ([UIScreen mainScreen].bounds.size.height == 568)
#define IS_IPHONE_6             ([UIScreen mainScreen].bounds.size.width == 375)
#define IS_IPHONE_6PLUS         ([UIScreen mainScreen].bounds.size.width == 414)

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

// 判断string是否为00, 00表示JSON数据正常；
#define UP_RESPOK(X) ([X intValue] == kNetRespOkValue)


// 判断如果string为 nil 更改string 为 @""
#define UP_NIL_STR(X)   X = X? X : @""


#define UP_FILEEXIST(X) [[NSFileManager defaultManager] fileExistsAtPath:X]

#define UP_App ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define UP_App_KeyWindow [[UIApplication sharedApplication] keyWindow]

//正则表达式
#define UP_REGEXP(X,REG)  [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", REG] evaluateWithObject:X]


//打开URL
#define UP_CANOPENURL(appScheme) ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]])
#define UP_OPENURL(appScheme) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]])

//是否Retina屏幕

//屏幕size
#define UP_IPHONESIZE [[UIScreen mainScreen]bounds].size

#define kScreenWidth             ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight             ([UIScreen mainScreen].bounds.size.height)

#define UP_NC [NSNotificationCenter defaultCenter]

#define UP_CGSizeScale(size, scale) CGSizeMake(size.width * scale, size.height * scale)

#define UP_OBJATIDX(ARRAY,INDEX) (ARRAY&&(INDEX>=0)&&(INDEX<[ARRAY count]))?ARRAY[INDEX]:nil

#define DEVICE_IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define UPHEIGHT (IOS7)?64:44

/**判断是否是ios7系统*/
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f
/**判断是否是ios8系统*/
#define IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.f
/**判断是否是ios9系统*/
#define IOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.f

#define PNArc4randomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
// 判断1X1的前后都不是1X1的情况
#define TiaojianOne  ((!(modelqian.size_x == 1 && modelqian.size_y == 1)) && (!(modelhou.size_x == 1 && modelhou.size_y == 1)))
// 判断1X1前面是1X1 后面不是1X1 并且前面的1X1数量的不是偶数的情况
#define TiaojianTwo ((modelqian.size_x == 1 && modelqian.size_y == 1)&&(!(modelhou.size_x == 1 && modelhou.size_y == 1)) && ((i + 1) % 2 != 0))
// 判断第一个指标是1x1 后面不是1X1的情况
#define TiaojianThree ((xiabiao == 0)&& !(modelhou.size_x == 1 && modelhou.size_y == 1))

#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)




// 系统控件默认高度
#define StatusBarHeight        (20.f)
#define TopBarHeight           (44.f)
#define NavgationHeight        (StatusBarHeight+TopBarHeight)
#define BottomBarHeight        (49.f)
#define CellDefaultHeight      (44.f)
#define EnglishKeyboardHeight  (216.f)
#define ChineseKeyboardHeight  (252.f)


// 页面不含状态栏、导航栏、tabbar的View的高
#define KViewHeight (Main_Screen_Height-NavgationHeight-BottomBarHeight)

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//APP默认背景色
#define DEFAULT_BGCOLOR RGBCOLOR(238.0,238.0,238.0)
//moreButtonColor
#define MoreButtonColor RGBCOLOR(66.0,165.0,254.0)
//导航栏颜色
#define NavigationColor RGBCOLOR(38.0,38.0,39.0)
//bashboardView边距
#define KBianJu 6
// 以iphone6为基本屏幕，当前尺寸与6屏幕宽的比例
#define  KWidth6scale ([UIScreen mainScreen].bounds.size.width/375)
// 以iphone6为基本屏幕，当前尺寸与6屏幕高的比例
#define  KHeight6scale ([UIScreen mainScreen].bounds.size.height/667)


#define DB_NAME                      @"Lizzielu.sqlite"

#define dbVersion                    @"dbVersion"

#define dbVersionNew                 6

#define TABLE_NAME_DIARY            @"Lizziediary"
#define TABLE_NAME_BOARD        @"DashBoard"
