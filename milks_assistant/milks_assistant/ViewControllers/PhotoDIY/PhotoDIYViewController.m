//
//  PhotoDIYViewController.m
//  milks_assistant
//  爱你一生一世，刘磊璐
//  Create by Jason Huang on 17/4/22.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "PhotoDIYViewController.h"
#import "LWContentView.h"
#import "Categorys.h"
#import "LWImageZoomView.h"
#import "LMMaskViewController.h"
#import "HYScratchCardView.h"
#import "UPWMUserInterfaceManager.h"

#define kBitsPerComponent (8)
#define kBitsPerPixel (32)
#define kPixelChannelCount (4)

@interface PhotoDIYViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIAlertController *actionSheet;
    HYScratchCardView *scatchView;
    UIImage *selectImage;
    UIButton *_deleteBtn;
}

@end

@implementation PhotoDIYViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _contentView = [[LWContentView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64)];
    _toolBar = [[LWToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40 - 64, SCREEN_WIDTH, 44)];
    [self.view addSubview:_contentView];
    
    selectImage = [UIImage imageNamed:@"panda"];
    if (scatchView) {
        [scatchView removeFromSuperview];
    }
    CGFloat height = selectImage.size.height*SCREEN_WIDTH/selectImage.size.width;
    if (height < (SCREEN_HEIGHT - 44 - 64)) {
        scatchView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(0, ((SCREEN_HEIGHT - 44 - 64)-height)/2.0, SCREEN_WIDTH, selectImage.size.height*SCREEN_WIDTH/selectImage.size.width)];
    } else
    {
        scatchView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, selectImage.size.height*SCREEN_WIDTH/selectImage.size.width)];
    }
    
    UIImage * image = selectImage;
    //顶图
    scatchView.surfaceImage = image;
    //低图
    scatchView.image = [self transToMosaicImage:image blockLevel:10];
    scatchView.hidden = YES;
    [_contentView addSubview:scatchView];
//    _toolBar.backgroundColor  = [UIColor redColor];
    [self.view addSubview:_toolBar];
    
    [_toolBar.photosBtn addTarget:self action:@selector(selPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.filtersBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.cropBtn addTarget:self action:@selector(cropAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.drawBtn addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView loadDefaultImage];
    

    
    
    UIButton *rightSaveBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 60, 40)];
    [rightSaveBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightSaveBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [rightSaveBtn setTitleColor:RGBCOLOR(59, 196, 250) forState:UIControlStateNormal];
//    [rightSaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightSaveBtn addTarget:self action:@selector(savaContentImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:rightSaveBtn];
    
    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 30, 30, 30)];
    [_deleteBtn setImage:[UIImage imageNamed:@"draw_clear"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(resetMaskImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_deleteBtn];
    _deleteBtn.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetMaskImage) name:@"resetMaskImage" object:nil];
    // Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)savaContentImage:(UIButton*)sender {
    if (!scatchView.isHidden) {
        
//            self.imageLayer.contents = (id)image.CGImage;
//            self.imageLayer.contents = (id)image.CGImage;
//        UIImage *image = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)((id)scatchView.shapeLayer.contents)];
        UIImage *image = [scatchView getDrawImage];
        ALAssetsLibrary *assetsLibrary=[[ALAssetsLibrary alloc]init];
        [assetsLibrary writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
                [[UPWMUserInterfaceManager sharedManager] showAlertWithTitle:nil message:@"保存失败" cancelButtonTitle:@"确定" otherButtonTitle:nil completeBlock:^(UPXAlertView *alertView, NSInteger buttonIndex) {
                    if(buttonIndex==[UPXAlertView cancelButtonIndex]) {
                        
                    }
                    else {
                        
                    }
                }];
            }else{
                [[UPWMUserInterfaceManager sharedManager] showAlertWithTitle:nil message:@"保存成功" cancelButtonTitle:@"确定" otherButtonTitle:nil completeBlock:^(UPXAlertView *alertView, NSInteger buttonIndex) {
                    if(buttonIndex==[UPXAlertView cancelButtonIndex]) {
                        
                    }
                    else {
                        
                    }
                }];
            }
        }];
        
        
    
    } else {
        [self.contentView saveImage];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //绘图板添加默认图片
//
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.view rotationToInterfaceOrientation:toInterfaceOrientation];
}


- (IBAction)selPhotoAction:(id)sender {
    actionSheet  = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.allowsEditing = NO;
        
        UIAlertAction *libActon = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagepicker animated:YES completion:nil];
        }];
        
        UIAlertAction *takeActon = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagepicker animated:YES completion:nil];
        }];
        UIAlertAction *cancelActon = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [actionSheet addAction:libActon];
        [actionSheet addAction:takeActon];
        [actionSheet addAction:cancelActon];
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    } else{
        [self showAlertWithTitle:@"提示" msg:@"请设置访问权限" ok:@"确定" cancel:nil];
    }

//    [self.contentView showPhotos];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *selImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (!selImage) {
        return;
    }
    selectImage = selImage;
    [self.contentView loadPhoto:selImage];
    [self maskLoadImage:selImage];
}

- (IBAction)filterAction:(id)sender {
     scatchView.hidden = YES;
    _deleteBtn.hidden = YES;
    [self.contentView showFilters];
}

- (IBAction)cropAction:(id)sender {
    scatchView.hidden = YES;
    _deleteBtn.hidden = YES;
    [self.contentView showOrHideCropView];
}

- (IBAction)drawAction:(id)sender {

//    LMMaskViewController *maskCtl = [[LMMaskViewController alloc] init];
//    [self.navigationController pushViewController:maskCtl animated:YES];
//    [self.contentView showDrawView];
//    [self maskLoadImage];
    [_contentView showDrawView];
    scatchView.hidden = NO;
    _deleteBtn.hidden = NO;
}


- (void)resetMaskImage {
    [_contentView showDrawView];
    if (scatchView) {
        [scatchView removeFromSuperview];
    }
    
    CGFloat height = selectImage.size.height*SCREEN_WIDTH/selectImage.size.width;
    if (height < (SCREEN_HEIGHT - 44 - 64)) {
        scatchView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(0, ((SCREEN_HEIGHT - 44 - 64)-height)/2.0, SCREEN_WIDTH, selectImage.size.height*SCREEN_WIDTH/selectImage.size.width)];
    } else
    {
        scatchView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, selectImage.size.height*SCREEN_WIDTH/selectImage.size.width)];
    }
    UIImage * image = selectImage;
    //顶图
    scatchView.surfaceImage = image;
    //低图
    scatchView.image = [self transToMosaicImage:image blockLevel:10];
    scatchView.hidden = NO;
    [_contentView addSubview:scatchView];
}

- (void)maskLoadImage:(UIImage*)image {

    
    if (scatchView) {
        [scatchView removeFromSuperview];
    }
    scatchView = nil;
    CGFloat height = selectImage.size.height*SCREEN_WIDTH/selectImage.size.width;
    if (height < (SCREEN_HEIGHT - 44 - 64)) {
        scatchView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(0, ((SCREEN_HEIGHT - 44 - 64)-height)/2.0, SCREEN_WIDTH, selectImage.size.height*SCREEN_WIDTH/selectImage.size.width)];
    } else
    {
        scatchView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, selectImage.size.height*SCREEN_WIDTH/selectImage.size.width)];
    }
    UIImage * image1 = selectImage;
    //顶图
    scatchView.surfaceImage = image1;
    //低图
    scatchView.image = [self transToMosaicImage:image1 blockLevel:10];
    scatchView.hidden = NO;
    [_contentView addSubview:scatchView];
    [_contentView showDrawView];
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


- (IBAction)saveAction:(id)sender {
    [self.contentView saveImage];
}

- (IBAction)recovery:(id)sender{
    [self.contentView recovery];
}

- (IBAction)rotateRight:(id)sender {
    [self.contentView.zoomView rotateRight];
}

- (IBAction)rotateLeft:(id)sender {
    [self.contentView.zoomView rotateLeft];
}

- (IBAction)flipHorizonal:(id)sender {
    [self.contentView.zoomView flipHorizonal];
}

- (IBAction)share:(id)sender {
}

- (IBAction)cropOkAction:(id)sender {
    [self.contentView cropImageOk];
}

- (IBAction)cropCancelAction:(id)sender {
    [self.contentView cancelCropImage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


@implementation LWToolBar{
    CALayer *_topLine;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat pwidth = (frame.size.width - 35*4 - 30)/3.0+35;
        _photosBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, (frame.size.height-35)/2.0, 35, 35)];
        [_photosBtn setImage:[UIImage imageNamed:@"albumButton"] forState:UIControlStateNormal];
        [_photosBtn setImage:[UIImage imageNamed:@"albumButton"] forState:UIControlStateSelected];
        _filtersBtn = [[UIButton alloc] initWithFrame:CGRectMake(15+pwidth, (frame.size.height-35)/2.0, 35, 35)];
        [_filtersBtn setImage:[UIImage imageNamed:@"filter"] forState:UIControlStateNormal];
        _cropBtn = [[UIButton alloc] initWithFrame:CGRectMake(15+pwidth*2, (frame.size.height-35)/2.0, 35, 35)];
        [_cropBtn setImage:[UIImage imageNamed:@"cropButton"] forState:UIControlStateNormal];
        _drawBtn = [[UIButton alloc] initWithFrame:CGRectMake(15+pwidth*3, (frame.size.height-35)/2.0, 35, 35)];
        [_drawBtn setBackgroundImage:[UIImage imageNamed:@"doodleButton"] forState:UIControlStateNormal];
        [self addSubview:_photosBtn];
        [self addSubview:_filtersBtn];
        [self addSubview:_cropBtn];
        [self addSubview:_drawBtn];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end

