//
//  UPToast.m
//  UPClientV3
//
//  Created by TZ_JSKFZX_CAOQ on 13-5-28.
//
//

#import "UPXToast.h"

enum ToastDurationTag {
    kToastDurationLong = 10000,
    kToastDurationShort = 1000,
    kToastDurationNormal = 3000
}ToastDuration;

/* Toast文字颜色 */
#define kColorToastText 0xffffff
/* Toast背景颜色 */
#define kColorToastViewBg [UIColor colorWithWhite:0.0 alpha:0.8]


#define kToastOffsetY 180
#define kAnimationDuration 0.15
#define kPopScale 0.5

/* Toast带图片的最小宽度 */
#define kImageTosatMinWidth 100

@interface UPXToastViewWindowOverlay : UIWindow
@end

static UPXToastSettings *sharedSettings = nil;


@interface UPXToast()

//- (UPXToast *)settings;

@property (nonatomic, strong) UIWindow *hostWindow;
@property (nonatomic, strong) UPXToastViewWindowOverlay *overlay;

@end

@implementation UPXToast

//- (void)dealloc
//{
//    UP_RELEASE(_text);
//    [self hideOverlay];
//    // overlay 和 hostWindow 必须放在 hideOverLay动画结束后才能释放
//    [super dealloc];
//}

- (id)initWithText:(NSString *) text
{
	self = [super init];
	if (self){
		_text = [text copy];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        self.hostWindow = window;
	}
	return self;
}

- (void)show
{
	UPXToastSettings *theSettings = _settings;
	if (!theSettings) {
		theSettings = [UPXToastSettings getSharedSettings];
	}
	
	UIFont *font = [UIFont systemFontOfSize: roundf(UPFloat(14))];
    CGSize textSize = [_text sizeWithFont:font constrainedToSize:CGSizeMake(UPFloat(210), MAXFLOAT)];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
	label.backgroundColor = [UIColor clearColor];
    label.textColor = UP_COL_RGB(kColorToastText);
	label.font = font;
	label.text = _text;
	label.numberOfLines = 0;
	
    UIImage* image = theSettings.image;
    UIImageView* imageView = nil;
    int imageHeight = 0;
    int imageWidth = 0;
    if (image) {
        imageHeight = image.size.height;
        imageWidth = image.size.width;
        imageView = [[UIImageView alloc] initWithImage:image];
    }
    
    //计算宽度
    int width = theSettings.size.width;
    if (textSize.width + UPFloat(20) > width) {
        width = textSize.width + UPFloat(20);
    }
    
    if (imageWidth > width) {
        width = imageWidth + UPFloat(20);
    }
    
    //图片最小宽度要比文字更小
    if (image) {
        if (textSize.width < (UPFloat(kImageTosatMinWidth) - UPFloat(20))) {
            width = UPFloat(kImageTosatMinWidth);
        }
    }
    
    //计算高度
    //如果有image则加image的padding
    CGFloat imagePadding  = UPFloat(8.0);
    int totalImageHeight = 0;
    if (imageHeight > 0) {
        totalImageHeight = imageHeight + imagePadding;
    }
    int height = theSettings.size.height;
    if (textSize.height + totalImageHeight + UPFloat(17)  > height) {
        height = textSize.height + totalImageHeight + UPFloat(17);
    }
    
    if (imageView) {
        imageView.frame = CGRectMake((width - imageWidth)/2, 10, imageWidth, imageHeight);
    }
    
	UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];

    v.frame = CGRectMake(0,0,width,height);
    if (imageView) {
        label.frame = CGRectMake((width - label.frame.size.width)/2, imagePadding + totalImageHeight, label.frame.size.width, label.frame.size.height);
    }
    else{
    	label.center = CGPointMake(v.frame.size.width / 2, v.frame.size.height / 2);
    }
    [v addSubview:imageView];
	[v addSubview:label];
	
    v.backgroundColor = kColorToastViewBg;
  	v.layer.cornerRadius = 5;
    
    //UIAlertOverlayWindow
    [self initOverlay];
	__block UIWindow *window = self.overlay;
    
	CGRect windowRect = window.frame;
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (UIInterfaceOrientationIsLandscape(orientation))
	{
		CGFloat width = windowRect.size.width;
		windowRect.size.width  = windowRect.size.height;
		windowRect.size.height = width;
	}
    
	CGPoint point;
	
	if (theSettings.gravity == kToastGravityTop) {
		point = CGPointMake(windowRect.size.width / 2, UPFloat(45));
	}else if (theSettings.gravity == kToastGravityBottom) {
		point = CGPointMake(windowRect.size.width / 2, windowRect.size.height - UPFloat(45));
	}else if (theSettings.gravity == kToastGravityCenter) {
//        point = CGPointMake(windowRect.size.width/2, kToastOffsetY + height/2);
		point = CGPointMake(windowRect.size.width/2, windowRect.size.height/2);
	}else{
		point = theSettings.postition;
	}
	
	point = CGPointMake(point.x + _offsetLeft, point.y + _offsetTop);
	v.center = point;
	
	NSTimer *timer1 = [NSTimer timerWithTimeInterval:((float)theSettings.duration)/1000
                                              target:self selector:@selector(hideToast:)
                                            userInfo:nil repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];
	[window addSubview:v];
    
    __block UPXToast *weakSelf = self;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        window.alpha = 1.0;
        weakSelf->_view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // stub
    }];
    
    [window makeKeyAndVisible];
    
    [self.hostWindow makeKeyWindow];
    self.hostWindow = nil;

//    _view = [v retain];
    _view = v;
	[v addTarget:self action:@selector(hideToastButtonPressed:) forControlEvents:UIControlEventTouchDown];
}

- (void)hideToastButtonPressed:(UIButton *)button
{
    [self hideOverlay];
}

- (void)hideToast:(NSTimer*)theTimer
{
    [theTimer invalidate];
//	[UIView beginAnimations:nil context:NULL];
//	_view.alpha = 0;
    [self hideOverlay];
//	[UIView commitAnimations];
    
//	NSTimer *timer = [NSTimer timerWithTimeInterval:500
//                                              target:self selector:@selector(hideToast:)
//                                            userInfo:nil repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)removeToast
{
//	[_view removeFromSuperview];
    [self hideOverlay];
}


+ (UPXToast *)makeText:(NSString *) _text
{
	UPXToast *toast = [[UPXToast alloc] initWithText:_text];
	return toast;
}


- (UPXToast *)setDuration:(NSInteger ) duration
{
	[self theSettings].duration = duration;
	return self;
}

- (UPXToast *)setGravity:(ToastGravity) gravity
              offsetLeft:(NSInteger) left
               offsetTop:(NSInteger) top
{
	[self theSettings].gravity = gravity;
	_offsetLeft = left;
	_offsetTop = top;
	return self;
}

- (UPXToast *)setGravity:(ToastGravity) gravity
{
	[self theSettings].gravity = gravity;
	return self;
}

- (UPXToast *)setPostion:(CGPoint) _position
{
	[self theSettings].postition = CGPointMake(_position.x, _position.y);
	return self;
}

- (UPXToast *)setSize:(CGSize) size
{
	[self theSettings].size = CGSizeMake(size.width, size.height);
	return  self;
}


- (UPXToast*)setImage:(UIImage*)image
{
    [self theSettings].image = image;
    return self;
}

- (UPXToastSettings *)theSettings
{
	if (!_settings) {
		_settings = [UPXToastSettings getSharedSettings];
	}
	return _settings;
}

- (void)initOverlay
{
    
    UPXToastViewWindowOverlay *overlay = self.overlay;
    BOOL show = (overlay == nil);
    
    // Create overlay
    if (show) {
        overlay = [[UPXToastViewWindowOverlay alloc] init];
        overlay.opaque = NO;
        overlay.windowLevel = UIWindowLevelStatusBar+3;
        overlay.frame = self.hostWindow.bounds;
        overlay.alpha = 0.0;
        overlay.backgroundColor = [UIColor clearColor];
        self.overlay = overlay;
//        [overlay release];
    }
}

- (void)hideOverlay
{
    UPXToastViewWindowOverlay *overlay = self.overlay;
    
    // Nothing to hide if it is not key window
    if (overlay == nil) {
        return;
    }
    __block UPXToast *weakSelf = self;
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        weakSelf.overlay.alpha = 0.0;
        weakSelf->_view.transform = CGAffineTransformMakeScale(kPopScale, kPopScale);
    } completion:^(BOOL finished) {
        weakSelf.overlay.hidden = YES;
        weakSelf->_view.transform = CGAffineTransformIdentity;
        [weakSelf->_view removeFromSuperview];
//        [weakSelf->_view release];
        weakSelf->_view = nil;
        
//        [weakSelf.hostWindow makeKeyWindow];
        // overlay 和 hostWindow 必须放在 hideOverLay动画结束后才能释放
//        UP_RELEASE(_overlay);
//        UP_RELEASE(_hostWindow);
    }];
}


@end


@implementation UPXToastSettings
@synthesize duration = _duration;
@synthesize gravity = _gravity;
@synthesize postition = _postition;
@synthesize size = _size ;
@synthesize image = _image;

//- (void)dealloc
//{
//    [_image release];
//    [super dealloc];
//}
+ (UPXToastSettings *)getSharedSettings
{
	if (!sharedSettings) {
        sharedSettings = [UPXToastSettings new];
		sharedSettings.gravity = kToastGravityCenter;
		sharedSettings.duration = kToastDurationNormal;
	}
	return sharedSettings;
}

- (id)copyWithZone:(NSZone *)zone
{
	UPXToastSettings *copy = [UPXToastSettings new];
	copy.gravity = self.gravity;
	copy.duration = self.duration;
	copy.postition = self.postition;
	copy.size      = self.size ;
    copy.image    = self.image;
	return copy;
}


@end


@implementation UPXToastViewWindowOverlay

//- (void)dealloc
//{
//    [super dealloc];
//}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

@end
