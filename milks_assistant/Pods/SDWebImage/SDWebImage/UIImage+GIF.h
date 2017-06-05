//
//  UIImage+GIF.h
//  LBGIFImage
//
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 06.01.12.
//  Copyright (c) 2012 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;

- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
