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

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentView = [[LWContentView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64)];
    _toolBar = [[LWToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44 - 64, SCREEN_WIDTH, 44)];
    [self.view addSubview:_contentView];
    _toolBar.backgroundColor  = [UIColor redColor];
    [self.view addSubview:_toolBar];
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
        
        UIStackView *stackView = [[UIStackView alloc] initWithFrame:frame];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.spacing = 20;
        stackView.alignment = UIStackViewAlignmentFill;
        UIButton *photos = [[UIButton alloc] init];
        photos.backgroundColor = [UIColor grayColor];
        UIButton *filters = [[UIButton alloc] init];
        filters.backgroundColor = [UIColor purpleColor];
        UIButton *crop = [[UIButton alloc] init];
        crop.backgroundColor = [UIColor blueColor];
        UIButton *draw = [[UIButton alloc] init];
        draw.backgroundColor = [UIColor redColor];
        
        [stackView addArrangedSubview:photos];
        [stackView addArrangedSubview:filters];
        [stackView addArrangedSubview:crop];
        [stackView addArrangedSubview:draw];
        [self addSubview:stackView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end

