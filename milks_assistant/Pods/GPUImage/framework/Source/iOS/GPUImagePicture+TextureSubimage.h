//
//  GPUImagePicture+TextureSubimage.h
//  GPUImage
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 2014-05-28.
//  Copyright (c) 2014 JasonHuang All rights reserved.
//

#import "GPUImagePicture.h"

@interface GPUImagePicture (TextureSubimage)

- (void)replaceTextureWithSubimage:(UIImage*)subimage;
- (void)replaceTextureWithSubCGImage:(CGImageRef)subimageSource;

- (void)replaceTextureWithSubimage:(UIImage*)subimage inRect:(CGRect)subRect;
- (void)replaceTextureWithSubCGImage:(CGImageRef)subimageSource inRect:(CGRect)subRect;

@end
