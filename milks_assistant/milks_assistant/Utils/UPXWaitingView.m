//
//  UPXWaitingView.m
//  UPClientV3
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 13-6-13.
//
//

#import "UPXWaitingView.h"

#define kWaitingViewOffsetY 160
#define kWaitingViewWidth 100
#define kWaitingViewHeight 74
#define kWaitingViewLeftMargin 10
/* 菊花距离最上边的垂直距离 */
#define kWaitingViewTopMargin 16
/* 菊花距离文字的垂直距离 */
#define kWaitingViewButtonMargin 15
#define kWaitingViewRowMargin 10
#define kWaitingViewActivityHeight 20
#define kWaitingViewTextColor 0xffffff

#define kAnimationDuration 0.15
//#define kStatusBarHeight                  20
/* 背景颜色 */
#define kWaitingViewBg [UIColor colorWithWhite:0.0 alpha:0.8]


@interface UPXWaitingViewWindowOverlay : UIWindow
@property (nonatomic, strong) UPXWaitingView *waitingView;
@end
@implementation UPXWaitingViewWindowOverlay @end


@interface UPXWaitingView()

@property (nonatomic, strong) UIWindow *hostWindow;
@property (nonatomic, strong) UPXWaitingViewWindowOverlay *overlay;

@end



@implementation UPXWaitingView

@synthesize dimBackground;
@synthesize title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        self.hostWindow = window;
        
        //大背景 50%透明 黑色背景
//        _bgView =  [[UIView alloc] initWithFrame:frame];
//        _bgView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
//        [self addSubview:_bgView];
        
        //小背景 纯白色圆角矩形
        float x = (frame.size.width - UPFloat(kWaitingViewWidth))/2;
//        float y = kWaitingViewOffsetY;
        float y = (frame.size.height - UPFloat(kWaitingViewHeight))/2;;
//        if (UP_iOSgt7)
//        {
//            //在ios7上增加偏移量
//            y += kStatusBarHeight;
//        }
        CGRect rect = CGRectIntegral(CGRectMake(x, y, UPFloat(kWaitingViewWidth), UPFloat(kWaitingViewHeight)));
        _dialogView = [[UIView alloc] initWithFrame:rect];
        _dialogView.backgroundColor = kWaitingViewBg;
        _dialogView.layer.cornerRadius = 5.0f;
//        [self addSubview:_dialogView];

        //菊花
        //        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        UIImage* loading = [UIImage imageNamed:@"icon_activity"];
        int cx = (_dialogView.frame.size.width -  loading.size.width)/2;
        int cy = UPFloat(kWaitingViewTopMargin);
        _activityView = [[UPWRotateAnimationView alloc] initWithFrame:CGRectMake(cx, cy, loading.size.width, loading.size.height)];
        _activityView.image = loading;
        [_dialogView addSubview:_activityView];

        //文字
        int width = UPFloat(kWaitingViewWidth) - 2 * UPFloat(kWaitingViewLeftMargin);
        int height = UPFloat(kWaitingViewHeight - kWaitingViewTopMargin - kWaitingViewButtonMargin - kWaitingViewActivityHeight);
        cy = UPFloat(kWaitingViewTopMargin) + _activityView.frame.size.height + UPFloat(kWaitingViewRowMargin);
        CGRect labelRt = CGRectIntegral(CGRectMake(UPFloat(kWaitingViewLeftMargin), cy, width, height));
        _titleLabel = [[UILabel alloc] initWithFrame:labelRt];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = UP_COL_RGB(kWaitingViewTextColor);
        _titleLabel.font = [UIFont systemFontOfSize:round(UPFloat(14))];
        [_dialogView addSubview:_titleLabel];

    }
    return self;
}


- (void)dealloc
{
    [self hideOverlay];

}

- (void)show
{
    
    _titleLabel.text = self.title;
//    [_activityView startAnimating];
    [_activityView startRotating];
    [self initOverlay];
    __block UIWindow *overlayWindow = self.overlay;
    [overlayWindow addSubview:_dialogView];
    __block UPXWaitingView *weakSelf = self;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        overlayWindow.alpha = 1.0;
        weakSelf->_dialogView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        // stub
    }];
    [overlayWindow makeKeyAndVisible];
}
- (void)hide
{
    _titleLabel.text = nil;
    self.title = nil;
    [_activityView stopRotating];
//    [_activityView stopAnimating];
    [self hideOverlay];
}


- (void)initOverlay
{
    UPXWaitingViewWindowOverlay *overlay = self.overlay;
    BOOL show = (overlay == nil);
    
    // Create overlay
    if (show) {
        overlay = [[UPXWaitingViewWindowOverlay alloc] init];
        overlay.opaque = NO;
        overlay.windowLevel = UIWindowLevelStatusBar+4;
        overlay.waitingView = self;
        overlay.frame = self.hostWindow.bounds;
        overlay.alpha = 0.0;
        overlay.backgroundColor = [UIColor clearColor];
        self.overlay = overlay;
//        [overlay release];
    }
}

- (void)hideOverlay
{
    UPXWaitingViewWindowOverlay *overlay = self.overlay;
    [self.hostWindow makeKeyWindow];
    self.hostWindow = nil;
    // Nothing to hide if it is not key window
    if (overlay == nil) {
        return;
    }
    __block UPXWaitingView *weakSelf = self;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        weakSelf.overlay.alpha = 0.0;
    } completion:^(BOOL finished) {
            weakSelf.overlay.hidden = YES;
            [weakSelf->_dialogView removeFromSuperview];
//            [weakSelf->_dialogView release];
            weakSelf->_dialogView = nil;
            weakSelf.overlay = nil;
    }];
}


@end
