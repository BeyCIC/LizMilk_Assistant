//
//  LWContentView.m
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/7/4.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import "LWContentView.h"
#import "Categorys.h"
#import "LWFilterCollectionView.h"
#import "LWPhotoCollectionView.h"
#import "MBProgressHUD.h"
#import "LWImageCropView.h"
#import "LWFilterImageView.h"
#import "LWDataManager.h"
#import "LWImageZoomView.h"
#import "LWDrawView.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UPWMUserInterfaceManager.h"
#import "HYScratchCardView.h"

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

@implementation LWContentView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _zoomView = [[LWImageZoomView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _filterView = [[LWFilterImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _cropView = [[LWImageCropView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _drawView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _photosBar = [[LWPhotosBar alloc] initWithFrame:CGRectMake(0, frame.size.height - 144, frame.size.width, 144)];
        _filterBar = [[LWFilterBar alloc] initWithFrame:CGRectMake(0, frame.size.height - 70, frame.size.width, 150)];
        _drawView.hidden  = YES;
        UIImage * image = [UIImage imageNamed:@"panda"];
        //顶图
        _drawView.surfaceImage = image;
        //低图
        _drawView.image = [self transToMosaicImage:image blockLevel:10];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(1, 1);
        //该方法也可以设置itemSize
        layout.itemSize =CGSizeMake(110, 150);

        
        _filterCollectionView = [[LWFilterCollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 120) collectionViewLayout:layout];
        [_filterCollectionView registerClass:[LWFilterCollectionCell class] forCellWithReuseIdentifier:@"LWFilterCollectionCell"];
        [_filterCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];

        [_filterBar addSubview:_filterCollectionView];
        [self addSubview:_zoomView];
        [self addSubview:_filterView];
        [self addSubview:_cropView];
        [self addSubview:_drawView];
        [self addSubview:_photosBar];
        [self addSubview:_filterBar];
        
        self.backgroundColor = [UIColor blackColor];
        self.currentMode = ImageMode;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor blackColor];
    self.currentMode = ImageMode;
}

- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    [super rotationToInterfaceOrientation:orientation];

    [self hiddenHandBoard];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    //隐藏HandBoard
    [self hiddenHandBoard];
}

//初次启动,加载默认图片
- (void)loadDefaultImage {
    UIImage *inputImage = [UIImage imageNamed:@"panda"];
    [self loadPhoto:inputImage];
}

#pragma mark - PDPhotoPickerProtocol 实现

- (void)collectPhotoFailed {

}

- (void)loadPhoto:(UIImage *)image {
    if (!image) {
        return;
    }
    LWDataManager *dm = [LWDataManager sharedInstance];
    dm.originImage = image;
    self.currentMode = FilterMode;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadImage:image];
    });
    
}

- (void)allURLPicked:(NSArray *)imageURLs{
    self.imageURLs = imageURLs;
}


#pragma mark - 其他方法

- (void)showErrorHud {
    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = NSLocalizedString(@"Error", nil);
}


//隐藏HandBoard
- (void)hiddenHandBoard {
    if (!self.filterBar.hidden) {
        self.filterBar.hidden = !self.filterBar.hidden;
    }
    if (!self.photosBar.hidden) {
        self.photosBar.hidden = !self.photosBar.hidden;
    }
    NSComparisonResult result = [[UIDevice currentDevice].systemVersion compare:@"8.0"];
    if (result == NSOrderedSame || result == NSOrderedDescending) {
        [self removeConstraint:self.filterVPaddingFiltersBar];
        [self removeConstraint:self.filterVPaddingPhotosBar];
        [self addConstraint:self.filterVPaddingZero];
        [self setNeedsUpdateConstraints];
    }
}

//加载照片选择器
- (void)showPhotos {
    //处理handBoard
    if (!self.filterBar.hidden) {
        self.filterBar.hidden = !self.filterBar.hidden;
    }

    self.photosBar.hidden = !self.photosBar.hidden;
    if (!self.photosBar.hidden) {
        NSComparisonResult result = [[UIDevice currentDevice].systemVersion compare:@"8.0"];
        if (result == NSOrderedSame || result == NSOrderedDescending) {
            [self removeConstraint:self.filterVPaddingZero];
            [self removeConstraint:self.filterVPaddingFiltersBar];
            [self addConstraint:self.filterVPaddingPhotosBar];
            [self setNeedsUpdateConstraints];
        }

        [self.photoCollectionView reloadPhotos];

    } else {
        NSComparisonResult result = [[UIDevice currentDevice].systemVersion compare:@"8.0"];
        if (result == NSOrderedSame || result == NSOrderedDescending) {
            [self removeConstraint:self.filterVPaddingFiltersBar];
            [self removeConstraint:self.filterVPaddingPhotosBar];
            [self addConstraint:self.filterVPaddingZero];
            [self setNeedsUpdateConstraints];
        }
    }

    LWDataManager *dm = [LWDataManager sharedInstance];
    self.currentMode = ImageMode;
    [self reloadImage:dm.currentImage];

}


//加载滤镜
- (void)showFilters {

    //处理handBoard
    if (!self.photosBar.hidden) {
        self.photosBar.hidden = !self.photosBar.hidden;
    }

    self.filterBar.hidden = !self.filterBar.hidden;
    if (!self.filterBar.hidden) {
        NSComparisonResult result = [[UIDevice currentDevice].systemVersion compare:@"8.0"];
        if (result == NSOrderedSame || result == NSOrderedDescending) {
            [self removeConstraint:self.filterVPaddingZero];
            [self removeConstraint:self.filterVPaddingPhotosBar];
            [self addConstraint:self.filterVPaddingFiltersBar];
            [self setNeedsUpdateConstraints];
        }

        [self.filterCollectionView reloadFilters];
        self.currentMode = FilterMode;
    } else {
        NSComparisonResult result = [[UIDevice currentDevice].systemVersion compare:@"8.0"];
        if (result == NSOrderedSame || result == NSOrderedDescending) {
            [self removeConstraint:self.filterVPaddingFiltersBar];
            [self removeConstraint:self.filterVPaddingPhotosBar];
            [self addConstraint:self.filterVPaddingZero];
            [self setNeedsUpdateConstraints];
        }
        self.currentMode = ImageMode;
    }

    LWDataManager *dm = [LWDataManager sharedInstance];
    [self reloadImage:dm.currentImage];
}


//显示涂鸦视图
- (void)showDrawView {
    //处理handBoard(隐藏)
    if (!self.photosBar.hidden) {
        self.photosBar.hidden = !self.photosBar.hidden;
    }
    //处理handBoard(隐藏)
    if (!self.filterBar.hidden) {
        self.filterBar.hidden = !self.filterBar.hidden;
    }

    self.currentMode = DrawMode;

    LWDataManager *dm = [LWDataManager sharedInstance];
    [self reloadImage:dm.currentImage];
    _drawView.hidden = YES;
    if (_drawView) {
            [_drawView removeFromSuperview];
    }
}

#pragma mark -

- (void)reloadImage:(UIImage *)image {

    LWDataManager *dm = [LWDataManager sharedInstance];
    dm.currentImage = image;

    switch (self.currentMode) {
        case FilterMode: {
            self.zoomView.hidden = YES;
            self.filterView.hidden = NO;
            self.cropView.hidden = YES;
            self.drawView.hidden = YES;
            [self.filterView loadImage2GPUImagePicture:image];
            break;
        }
        case CropMode: {
            self.zoomView.hidden = YES;
            self.filterView.hidden = YES;
            self.cropView.hidden = NO;
            self.drawView.hidden = YES;
            [self.cropView setImage:image];
            break;
        }
        case DrawMode: {
            self.zoomView.hidden = YES;
            self.filterView.hidden = YES;
            self.cropView.hidden = YES;
            self.drawView.hidden = NO;
            [self.drawView setImage:image];
            break;
        }
        case ImageMode:
        default: {
            self.zoomView.hidden = NO;
            self.filterView.hidden = YES;
            self.cropView.hidden = YES;
            self.drawView.hidden = YES;
            self.zoomView.image = image;
            [self setNeedsUpdateConstraints];
            break;
        }
    }
}


- (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char *bitmapData = CGBitmapContextGetData (context);
    
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1)*width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }
    
    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              kBitsPerComponent,
                                              kBitsPerPixel,
                                              width*kPixelChannelCount ,
                                              colorSpace,
                                              kCGBitmapByteOrderDefault,
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       kBitsPerComponent,
                                                       width*kPixelChannelCount,
                                                       colorSpace,
                                                       kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage ;
    
}



- (void)saveImage {
    LWDataManager *dm = [LWDataManager sharedInstance];

    [self.filterView.filter forceProcessingAtSize:dm.currentImage.size];
//    self.hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self.filterView.sourcePicture processImageUpToFilter:self.filterView.filter
                                      withCompletionHandler:^(UIImage *processedImage) {
                                          if (!processedImage) {
                                              [self saveImageToPhotos:dm.currentImage];
                                          } else {
                                              [self saveImageToPhotos:processedImage];
                                              
                                          }
                                      }];
//    [self.hud hideAnimated:YES afterDelay:2.0];
    
}

- (void)saveImageToPhotos:(UIImage*)image {
    ALAssetsLibrary *assetsLibrary=[[ALAssetsLibrary alloc]init];
    [assetsLibrary writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
//        [self.hud hideAnimated:YES];
        if (error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[UPWMUserInterfaceManager sharedManager] showAlertWithTitle:nil message:@"Save failed" cancelButtonTitle:@"Sure" otherButtonTitle:nil completeBlock:^(UPXAlertView *alertView, NSInteger buttonIndex) {
                    if(buttonIndex==[UPXAlertView cancelButtonIndex]) {
                        
                    }
                    else {
                        
                    }
                }];
            });
            
        }else{
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[UPWMUserInterfaceManager sharedManager] showAlertWithTitle:nil message:@"Save Successfully" cancelButtonTitle:@"Sure" otherButtonTitle:nil completeBlock:^(UPXAlertView *alertView, NSInteger buttonIndex) {
                    if(buttonIndex==[UPXAlertView cancelButtonIndex]) {
                        
                    }
                    else {
                        
                    }
                }];
            });
        }
    }];
}

- (void)recovery {
    LWDataManager *dm = [LWDataManager sharedInstance];
    [self reloadImage:dm.originImage];

    if (self.filterBar) {
        NSArray *selectedItems = self.filterCollectionView.indexPathsForSelectedItems;
        for (NSIndexPath *path in selectedItems) {
            LWFilterCollectionCell *cell = (LWFilterCollectionCell *) [self.filterCollectionView cellForItemAtIndexPath:path];
            [self.filterCollectionView deselectItemAtIndexPath:path animated:NO];
            cell.selected = NO;
            cell.selectIcon.hidden = YES;
        }
        self.filterCollectionView.selectedIndexPath = nil;
        [self.filterCollectionView reloadItemsAtIndexPaths:selectedItems];
    }
}


- (void)showOrHideCropView {
    [self hiddenHandBoard];
    LWDataManager *dm = [LWDataManager sharedInstance];

    self.cropView.hidden = !self.cropView.hidden;
    self.currentMode = self.cropView.hidden ? ImageMode : CropMode;
    [self reloadImage:dm.currentImage];
}

- (void)cropImageOk {
    LWDataManager *dm = [LWDataManager sharedInstance];
    if (dm.currentImage) {
        CGRect CropRect = self.cropView.cropAreaInImage;
        CGImageRef imageRef = CGImageCreateWithImageInRect([self.cropView.imageView.image CGImage], CropRect);
        UIImage *croppedImg = [UIImage imageWithCGImage:imageRef];

        self.currentMode = ImageMode;
        [self reloadImage:croppedImg];

        CGImageRelease(imageRef);
    } else {
        [self showErrorHud];
    }
}

- (void)cancelCropImage {
    LWDataManager *dm = [LWDataManager sharedInstance];
    self.currentMode = ImageMode;
    [self reloadImage:dm.currentImage];
}



@end


@implementation LWPhotosBar

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //这个功能暂时不需要;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    UIImage *flipImg = [UIImage imageNamed:@"flip"];
    UIImage *recovationImg = [UIImage imageNamed:@"revocation"];
    UIImage *leftRotateImg = [UIImage imageNamed:@"undoButton"];
    UIImage *rightRotateImg = [UIImage imageNamed:@"redoButton"];

    [self.flipBtn setImage:[flipImg imageWithOverlayColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.flipBtn setImage:[flipImg imageWithOverlayColor:[UIColor colorWithRed:0.07 green:0.42 blue:0.84 alpha:1]] forState:UIControlStateHighlighted];
    [self.recovationBtn setImage:[recovationImg imageWithOverlayColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.recovationBtn setImage:[recovationImg imageWithOverlayColor:[UIColor colorWithRed:0.07 green:0.42 blue:0.84 alpha:1]] forState:UIControlStateHighlighted];
    [self.leftRotateBtn setImage:[leftRotateImg imageWithOverlayColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.leftRotateBtn setImage:[leftRotateImg imageWithOverlayColor:[UIColor colorWithRed:0.07 green:0.42 blue:0.84 alpha:1]] forState:UIControlStateHighlighted];
    [self.rightRotateBtn setImage:[rightRotateImg imageWithOverlayColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.rightRotateBtn setImage:[rightRotateImg imageWithOverlayColor:[UIColor colorWithRed:0.07 green:0.42 blue:0.84 alpha:1]] forState:UIControlStateHighlighted];

}


@end


@implementation LWFilterBar

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(23, 0, frame.size.width-46, 31)];
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0.5)];
        _topLine.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:_slider];
        [self addSubview:_topLine];
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.slider setThumbImage:[UIImage imageNamed:@"slider_circel"] forState:UIControlStateNormal];
    [self.slider setThumbImage:[UIImage imageNamed:@"slider_circel_highlight"] forState:UIControlStateHighlighted];
}


@end
