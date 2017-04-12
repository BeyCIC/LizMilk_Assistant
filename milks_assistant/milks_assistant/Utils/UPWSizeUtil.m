//
//  UPWSizeUtil.m
//  wallet
//
//  Created by qcao on 14/12/6.
//  Copyright (c) 2014年 China Unionpay Co.,Ltd. All rights reserved.
//

#import "UPWSizeUtil.h"


CGFloat scale()
{
    static CGFloat scale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = kScreenWidth/320.0f;
    });
    return scale;
}

@implementation UPWSizeUtil

+ (CGFloat)sizeFloat:(CGFloat)f
{
    return f * scale();
}

+ (CGSize)sizeSize:(CGSize)sz
{
   return CGSizeMake(sz.width * scale(), sz.height * scale());
}

+ (CGRect)sizeRect:(CGRect)rt
{
    return CGRectMake(rt.origin.x * scale(), rt.origin.y * scale(), rt.size.width * scale(), rt.size.height * scale());
}



@end
