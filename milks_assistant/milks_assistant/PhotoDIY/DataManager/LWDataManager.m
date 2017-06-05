//
//  LWDataManager.m
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/7/5.
//  Copyright (c) 2016 JasonHuang. All rights reserved.
//

#import "LWDataManager.h"
#import "GPUImageFilter.h"

@implementation LWDataManager

+ (LWDataManager *)sharedInstance {
    static LWDataManager *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[LWDataManager alloc] init];
    }
    return sharedInstance;
}

-(NSDictionary *)filters{
    GPUImageOutput *contrast = [GPUImageContrastFilter new];
    [((GPUImageContrastFilter *)contrast) setContrast:2.0];

    GPUImageOutput *levels = [GPUImageLevelsFilter new];
    [(GPUImageLevelsFilter *)levels setRedMin:0.2 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    [(GPUImageLevelsFilter *)levels setGreenMin:0.2 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
    [(GPUImageLevelsFilter *)levels setBlueMin:0.2 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];

    GPUImageOutput *rgb = [GPUImageRGBFilter new];
    [((GPUImageRGBFilter *)rgb) setGreen:1.25];

    GPUImageOutput *hue = [GPUImageHueFilter new];

    GPUImageOutput *whiteBalance = [GPUImageWhiteBalanceFilter new];
    [(GPUImageWhiteBalanceFilter *)whiteBalance setTemperature:2500.0];

    GPUImageOutput *sharpen = [GPUImageSharpenFilter new];
    [(GPUImageSharpenFilter *)sharpen setSharpness:4.0];

    GPUImageOutput *gamma = [GPUImageGammaFilter new];
    [(GPUImageGammaFilter *)gamma setGamma:1.5];

    GPUImageOutput *toneCurve = [GPUImageToneCurveFilter new];
    [(GPUImageToneCurveFilter *) toneCurve setBlueControlPoints:@[
            [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)],
            [NSValue valueWithCGPoint:CGPointMake(0.5, 0.75)],
            [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)]]];

    GPUImageOutput *sepiaTone = [GPUImageSepiaFilter new];

    GPUImageOutput *colorInvert = [GPUImageColorInvertFilter new];
    GPUImageOutput *grayScale = [GPUImageGrayscaleFilter new];
    GPUImageOutput *sobelEdge = [GPUImageSobelEdgeDetectionFilter new];

    GPUImageOutput *sketch = [GPUImageSketchFilter new];
    GPUImageOutput *emboss = [GPUImageEmbossFilter new];
    GPUImageOutput *vignette = [GPUImageVignetteFilter new];

    GPUImageOutput *gaussianBlur = [GPUImageGaussianBlurFilter new];
    [(GPUImageGaussianBlurFilter *)gaussianBlur setBlurRadiusInPixels:10.0];

    GPUImageOutput *gaussianSelectiveBlur = [GPUImageGaussianSelectiveBlurFilter new];

    GPUImageOutput *boxBlur = [GPUImageBoxBlurFilter new];
    [(GPUImageBoxBlurFilter *)boxBlur setBlurRadiusInPixels:20];

    GPUImageOutput *motionBlur = [GPUImageMotionBlurFilter new];
    [(GPUImageMotionBlurFilter *)motionBlur setBlurAngle:90];

    GPUImageOutput *zoomBlur = [GPUImageZoomBlurFilter new];

    return @{NSLocalizedString(@"contrast",nil):contrast,NSLocalizedString(@"levels",nil):levels,
            NSLocalizedString(@"rgb",nil):rgb,NSLocalizedString(@"hue",nil):hue,
            NSLocalizedString(@"whiteBalance",nil):whiteBalance,NSLocalizedString(@"sharpen",nil):sharpen,
            NSLocalizedString(@"gamma",nil):gamma,NSLocalizedString(@"toneCurve",nil):toneCurve,
            NSLocalizedString(@"sepiaTone",nil):sepiaTone,NSLocalizedString(@"colorInvert",nil):colorInvert,
            NSLocalizedString(@"grayScale",nil):grayScale,NSLocalizedString(@"sobelEdge",nil):sobelEdge,
            NSLocalizedString(@"sketch",nil):sketch,NSLocalizedString(@"emboss",nil):emboss,
            NSLocalizedString(@"vignette",nil):vignette,NSLocalizedString(@"gaussianBlur",nil):gaussianBlur,
            NSLocalizedString(@"gaussianSelectiveBlur",nil):gaussianSelectiveBlur,NSLocalizedString(@"boxBlur",nil):boxBlur,
            NSLocalizedString(@"motionBlur",nil):motionBlur,NSLocalizedString(@"zoomBlur",nil):zoomBlur};
}

-(NSDictionary *)filterImageName{
    return @{NSLocalizedString(@"对比度调节",nil):@"对比度调节",NSLocalizedString(@"色阶调节",nil):@"色阶调节",
            NSLocalizedString(@"RGB调节",nil):@"RGB调节",NSLocalizedString(@"HUE调节",nil):@"HUE调节",
            NSLocalizedString(@"白平衡",nil):@"白平衡",NSLocalizedString(@"锐化",nil):@"锐化",
            NSLocalizedString(@"Gamma",nil):@"Gamma",NSLocalizedString(@"色调美化",nil):@"色调美化",
            NSLocalizedString(@"褐色调",nil):@"褐色调",NSLocalizedString(@"反转",nil):@"反转",
            NSLocalizedString(@"灰度",nil):@"灰度",NSLocalizedString(@"边缘勾勒",nil):@"边缘勾勒",
            NSLocalizedString(@"素描",nil):@"素描",NSLocalizedString(@"浮雕",nil):@"浮雕",
            NSLocalizedString(@"晕映",nil):@"晕映",NSLocalizedString(@"高斯模糊",nil):@"高斯模糊",
            NSLocalizedString(@"虚化背影",nil):@"虚化背影",NSLocalizedString(@"盒状模糊",nil):@"盒状模糊",
            NSLocalizedString(@"运动模糊",nil):@"运动模糊",NSLocalizedString(@"变焦模糊",nil):@"变焦模糊"};
}



@end
