//
//  LWFilterImageView.h
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/7/27.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import "LWDataManager.h"

@interface LWFilterImageView : GPUImageView

@property(nonatomic,strong) GPUImageOutput<GPUImageInput> *filter;
@property(nonatomic,strong) GPUImagePicture *sourcePicture;

@property(nonatomic) enum FilterType filterType;

- (void)reloadGPUImagePicture;

//load 照片到 GPUImagePicture
- (void)loadImage2GPUImagePicture:(UIImage *)image;

- (void)renderWithFilter:(GPUImageOutput<GPUImageInput> *)output;

- (void)renderWithFilterKey:(NSString *)key;

@end
