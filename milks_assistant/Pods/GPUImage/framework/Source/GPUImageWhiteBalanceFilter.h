#import "GPUImageFilter.h"
/**
 //  爱你一生一世 刘磊璐
 * Create by JasonHuang
 * Allows adjustment of color temperature in terms of what an image was effectively shot in. This means higher Kelvin values will warm the image, while lower values will cool it. 
 
 */
@interface GPUImageWhiteBalanceFilter : GPUImageFilter
{
    GLint temperatureUniform, tintUniform;
}
//choose color temperature, in degrees Kelvin
@property(readwrite, nonatomic) CGFloat temperature;

//adjust tint to compensate
@property(readwrite, nonatomic) CGFloat tint;

@end
