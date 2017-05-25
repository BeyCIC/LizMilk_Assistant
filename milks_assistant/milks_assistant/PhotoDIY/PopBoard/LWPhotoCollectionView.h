//
//  LWPhotoCollectionView.h
//  PhotoDIY
//
//  Create by luowei on 16/7/5.
//  Copyright © 2016年 wodedata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDPhotoLibPicker.h"

@interface LWPhotoCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PDPhotoPickerProtocol>

@property(nonatomic,strong) IBOutlet UIView *topLine;
@property(nonatomic,strong) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property(nonatomic,strong) IBOutlet UIView *msgView;

@property(nonatomic,strong) IBOutlet NSLayoutConstraint *photoCollectionHeight;

@property(nonatomic, strong) PDPhotoLibPicker *photoPicker;

@property(nonatomic, strong) ALAssetsLibrary *library;

- (void)reloadPhotos;
@end


@interface LWPhotoCollectionCell : UICollectionViewCell

@property(nonatomic, strong) IBOutlet UIImageView *imageView;
@property(nonatomic,strong) IBOutlet UIImageView *selectIcon;

@property(nonatomic, strong) NSURL *url;
@end
