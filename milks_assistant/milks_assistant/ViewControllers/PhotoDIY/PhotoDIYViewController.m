//
//  PhotoDIYViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/22.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "PhotoDIYViewController.h"
#import "LWContentView.h"
#import "Categorys.h"
#import "LWImageZoomView.h"

@interface PhotoDIYViewController ()

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _contentView = [[LWContentView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64)];
    _toolBar = [[LWToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44 - 64, SCREEN_WIDTH, 44)];
    [self.view addSubview:_contentView];
//    _toolBar.backgroundColor  = [UIColor redColor];
    [self.view addSubview:_toolBar];
    
    [_toolBar.photosBtn addTarget:self action:@selector(selPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.filtersBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.cropBtn addTarget:self action:@selector(cropAction:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar.drawBtn addTarget:self action:@selector(drawAction:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //绘图板添加默认图片
    [self.contentView loadDefaultImage];
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
    [self.contentView showPhotos];
}

- (IBAction)filterAction:(id)sender {
    [self.contentView showFilters];
}

- (IBAction)cropAction:(id)sender {
    [self.contentView showOrHideCropView];
}

- (IBAction)drawAction:(id)sender {
    [self.contentView showDrawView];
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

