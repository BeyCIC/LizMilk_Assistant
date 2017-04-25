//
//  LWContentView.h
//  PhotoDIY
//
//  Created by luowei on 16/7/4.
//  Copyright © 2016年 wodedata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import "PDPhotoLibPicker.h"
#import "LWDataManager.h"

@class LWFilterCollectionView;
@class LWPhotoCollectionView;
@class MBProgressHUD;
@class LWImageCropView;
@class LWDrawView;
@class LWImageZoomView;
@class LWFilterImageView;
@class LWPhotosBar;
@class LWFilterBar;

@interface LWContentView : UIView<PDPhotoPickerProtocol>

@property(nonatomic,strong)  LWImageZoomView *zoomView;
@property(nonatomic,strong)  LWFilterImageView *filterView;
@property(nonatomic,strong)  LWImageCropView *cropView;
@property(nonatomic,strong)  LWDrawView *drawView;

@property(nonatomic,strong)  LWFilterBar *filterBar;
@property(nonatomic,strong)  LWFilterCollectionView *filterCollectionView;

@property(nonatomic,strong)  LWPhotosBar *photosBar;
@property(nonatomic,strong)  LWPhotoCollectionView *photoCollectionView;


@property(nonatomic,strong)  NSLayoutConstraint *filterVPaddingZero;
@property(nonatomic,strong)  NSLayoutConstraint *filterVPaddingPhotosBar;
@property(nonatomic,strong)  NSLayoutConstraint *filterVPaddingFiltersBar;


@property(nonatomic, strong) MBProgressHUD *hud;

@property(nonatomic) enum DIYMode currentMode;

@property(nonatomic, strong) NSArray *imageURLs;

//加载默认图片
- (void)loadDefaultImage;

- (void)reloadImage:(UIImage *)image;

//加载照片
- (void)showPhotos;

//加载滤镜
-(void)showFilters;

- (void)saveImage;

- (void)recovery;

- (void)showOrHideCropView;

- (void)cropImageOk;

- (void)cancelCropImage;

- (void)showDrawView;
@end


@interface LWPhotosBar:UIView

@property(nonatomic,strong)  UIButton *flipBtn;
@property(nonatomic,strong)  UIButton *recovationBtn;
@property(nonatomic,strong)  UIButton *leftRotateBtn;
@property(nonatomic,strong)  UIButton *rightRotateBtn;

@end

@interface LWFilterBar:UIView

@property(nonatomic,strong) UIView *topLine;

@property(nonatomic,strong) UISlider *slider;

@end
