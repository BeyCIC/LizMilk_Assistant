//
//  LWDrawView.m
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/7/27.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import "LWDrawView.h"
#import "LWScratchView.h"
#import "LWScrawlView.h"
#import "LWDrawBar.h"

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

@implementation LWDrawView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _mosaicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_mosaicImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_mosaicImageView setBackgroundColor:[UIColor clearColor]];
        _mosaicImageView.opaque = YES;
//        _mosaicImageView.clearsContextBeforeDrawing = YES;
//        _mosaicImageView.autoresizesSubviews = YES;
//        [_mosaicImageView setContentStretch:CGRectMake(0, 0, 1, 1)];
        _mosaicImageView.semanticContentAttribute = UISemanticContentAttributeUnspecified;
        
        _scratchView = [[LWScratchView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _scratchView.userInteractionEnabled = YES;
//        _scratchView.opaque = YES;
//        _scratchView.clearsContextBeforeDrawing = YES;
//        _scratchView.autoresizesSubviews = YES;
//        [_scratchView setContentStretch:CGRectMake(0, 0, 1, 1)];
        _scratchView.contentMode = UIViewContentModeScaleToFill;
        _scrawlView = [[LWScrawlView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrawlView.userInteractionEnabled = YES;
        _scrawlView.userInteractionEnabled = YES;
        _scrawlView.opaque = YES;
//        _scrawlView.clearsContextBeforeDrawing = YES;
//        _scrawlView.autoresizesSubviews = YES;
//        [_scrawlView setContentStretch:CGRectMake(0, 0, 1, 1)];
        _scrawlView.contentMode = UIViewContentModeScaleToFill;
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 50, 70, 40, 40)];
//        _deleteBtn.backgroundColor = [UIColor redColor];
        [_deleteBtn setImage:[UIImage imageNamed:@"draw_clear"] forState:UIControlStateNormal];
        
        _mosaicBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 50, 125, 40, 40)];
//        _mosaicBtn.backgroundColor = [UIColor blueColor];
        
        [_mosaicBtn addTarget:self action:@selector(openOrCloseMosaic:) forControlEvents:UIControlEventTouchUpInside];
        [_mosaicBtn setImage:[UIImage imageNamed:@"macaic"] forState:UIControlStateNormal];
        [_mosaicBtn setImage:[UIImage imageNamed:@"macaic_selected"] forState:UIControlStateSelected];
        _mosaicBtn.userInteractionEnabled = YES;
        _drawBar = [[LWDrawBar alloc] initWithFrame:CGRectMake(0, frame.size.height - 140, frame.size.width, 140)];
        
        [self addSubview:_mosaicImageView];
        [self addSubview:_scratchView];
        [self addSubview:_scrawlView];
        [self addSubview:_deleteBtn];
        [self addSubview:_mosaicBtn];
        [self addSubview:_drawBar];
        
        
    }
    return self;
}

//开启关闭马赛克按钮
- (void)openOrCloseMosaic:(UIButton *)mosaicButton{
//    mosaicButton.selected = YES;
    if (!mosaicButton.selected) { //close
        //改变层级关系,并隐藏画笔视图
        self.scrawlView.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.drawBar.hidden = YES;
        [self bringSubviewToFront:self.scratchView];
        [self bringSubviewToFront:self.drawBar];
        [self bringSubviewToFront:self.mosaicBtn];
        self.mosaicBtn.selected = YES;
        [self.scratchView setNeedsDisplay];

    }else{ //open
        //改变层级关系,并隐藏画笔视图
        self.scrawlView.hidden = NO;
        self.deleteBtn.hidden = NO;
        self.drawBar.hidden = NO;
        [self bringSubviewToFront:self.scrawlView];
        [self bringSubviewToFront:self.deleteBtn];
        [self bringSubviewToFront:self.drawBar];
        [self bringSubviewToFront:self.mosaicBtn];
        self.mosaicBtn.selected = NO;
        [self.scrawlView setNeedsDisplay];
    }
}

- (void)setImage:(UIImage *)image {

    CGFloat wRatio = image.size.width/[UIScreen mainScreen].bounds.size.width ;

    //设置马赛克图片
    self.mosaicImageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *renderImg = [LWDrawView transToMosaicImage:image blockLevel:image.size.width/ 50];
    self.mosaicImageView.image = renderImg;

    //把底图绘制到scratchView上
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:self.scratchView.bounds];
    tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    tempImageView.image = image;
    [self.scratchView setSizeBrush:50.0];   //涂抹大小
    [self.scratchView setHideView:tempImageView];

    //改变层级关系,并隐藏画笔视图
    self.scrawlView.hidden = NO;
    self.deleteBtn.hidden = NO;
    self.drawBar.hidden = NO;
    [self bringSubviewToFront:self.scrawlView];
    [self bringSubviewToFront:self.deleteBtn];
    [self bringSubviewToFront:self.drawBar];
    [self bringSubviewToFront:self.mosaicBtn];
    self.mosaicBtn.selected = NO;
    [self.scratchView setNeedsDisplay]; //刷新显示
}


//转换成马赛克,level代表一个点转为多少level*level的正方形
+ (UIImage *)transToMosaicImage:(UIImage *)orginImage blockLevel:(NSUInteger)level {
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate(nil,width,height,
            kBitsPerComponent,        //每个颜色值8bit
            width * kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
            colorSpace,
            kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData(context);

    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index, preIndex;
    for (NSUInteger i = 0; i < height - 1; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount * index, kPixelChannelCount);
                } else {
                    memcpy(bitmapData + kPixelChannelCount * index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i - 1) * width + j;
                memcpy(bitmapData + kPixelChannelCount * index, bitmapData + kPixelChannelCount * preIndex, kPixelChannelCount);
            }
        }
    }

    NSInteger dataLength = width * height * kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
            kBitsPerComponent,
            kBitsPerPixel,
            width * kPixelChannelCount,
            colorSpace,
            kCGImageAlphaPremultipliedLast,
            provider,
            NULL, NO,
            kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
            width,
            height,
            kBitsPerComponent,
            width * kPixelChannelCount,
            colorSpace,
            kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if (resultImageRef) {
        CFRelease(resultImageRef);
    }
    if (mosaicImageRef) {
        CFRelease(mosaicImageRef);
    }
    if (colorSpace) {
        CGColorSpaceRelease(colorSpace);
    }
    if (provider) {
        CGDataProviderRelease(provider);
    }
    if (context) {
        CGContextRelease(context);
    }
    if (outputContext) {
        CGContextRelease(outputContext);
    }
    return resultImage;

}


@end
