//
//  UPXAlertView.m
//  UPClientV3
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 13-5-28.
//
//

#import "UPXAlertView.h"

#define  kFontAlertViewTitleSize        18
#define  kFontAlertViewMessageSize      14

enum UPXAlertViewButtonType {
    kButtonLeft = UIRectCornerBottomLeft,
    kButtonCenter = UIRectCornerAllCorners,
    kButtonRight = UIRectCornerBottomRight,
    kButtonAlone = UIRectCornerBottomLeft |UIRectCornerBottomRight
    };
@interface UPXAlertViewWindowOverlay : UIWindow
@property (nonatomic, strong) UPXAlertView *alertView;
@property (nonatomic, assign) CGRect keyboardRect;
@end
@interface UPXAlertViewButton : UIButton
@property (retain, nonatomic) UIColor*  buttonBackgroundColor;
@property (retain, nonatomic) UIColor* buttonhighlightColor;
@property (assign, nonatomic) enum UPXAlertViewButtonType type;
@end

@interface UPXAlertView ()

@property (nonatomic, strong) UPXAlertViewWindowOverlay *overlay;
@property (nonatomic, strong) UIWindow *hostWindow;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *subtitleFont;
@property (nonatomic, assign) NSInteger specialIndex;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end


#define kCancelButtonTag 9999
#define kAnimationDuration 0.15
#define kPopScale 0.5
#define kTagNotDismiss             0x00006543



#define kColorButtonCancel              0xffffff
#define kColorButtonCancelHighlight     0xe5e5e5
#define kColorButtonSpecial             0xffffff
#define kColorButtonSpecialHighlight    0xe5e5e5
#define kColorButton                    0xffffff
#define kColorButtonHighlight           0xe5e5e5
    
/* 警告框背景颜色 */
#define kColorAlertViewBackground 0xffffff
/* 警告框Title文字颜色 */
#define kColorAlertViewTitleText 0x333333
/* 警告框Title分割线颜色 */
//#define kColorAlertViewTitleLine 0x3e98ea
/* 警告框Message文字颜色 */
#define kColorAlertViewMessageText 0x333333
/* 警告框button文字颜色 */
#define kColorAlertViewButtonText 0x158cfb
/* 警告框button不可点击的文字颜色 */
#define kColorAlertViewButtonDisableText 0x999999
/* 相对设备屏幕水平边距, 左右相等  UI设计45/2 取22 */
#define kHorizenInset 25.0
/* 中心点相对设备屏幕高度百分比  380/960*/
#define kVerticalCenterScale 0.4
/* 按钮高度 */
#define kButtonHeight UPFloat(40.0)
/* 上边距 */
#define kTopMargin 15.0
/* 竖直方向边距 */
#define kVerticalPadding 0.0
/* 竖直最小值 */
#define kVerticalContentMinHeight 25.0
/* 最小高度 上边距+最小值+padding+按钮*/
#define kContentMinHeight (kTopMargin+kVerticalContentMinHeight+kVerticalPadding+kButtonHeight)



/* SubTitlte(如有)于title的边距 */
#define kSubTitlePadding 12.0
/* custom view于title的边距 */
#define kCustomViewPadding 8.0
/* Title的水平缩进 */
#define kTitleIndent 15.0
/* Title分割线于Title的距离 */
//#define kTitleLinePadding 8.0


@implementation UPXAlertView {
@private
    struct {
        CGRect titleRect;
        CGRect titlelineRect;
        CGRect subtitleRect;
        CGRect buttonRect;
        CGRect customViewRect;
    } layout;
}

@synthesize customView = _customView;
@synthesize title  = _title;
@synthesize subtitle = _subtitle;
@synthesize overlay = _overlay;
@synthesize hostWindow =  _hostWindow;
@synthesize contentView = _contentView;
@synthesize buttons = _buttons;
@synthesize titleFont = _titleFont;
@synthesize subtitleFont = _subtitleFont;
@synthesize specialIndex = _specialIndex;


//点击取消按钮
+ (NSInteger)cancelButtonIndex
{
    return kCancelButtonTag;
}

//对话框点击不会消失
+ (NSInteger)neverDismissTag
{
    return kTagNotDismiss;
}



- (id)initWithWindow:(UIWindow *)hostWindow
{
    self = [super initWithFrame:[self defaultAlertViewFrame]];
    if (self) {
        self.specialIndex = -1;
        self.titleFont = [UIFont systemFontOfSize:kFontAlertViewTitleSize];
        self.subtitleFont = [UIFont systemFontOfSize:kFontAlertViewMessageSize];
        self.hostWindow = hostWindow;
        self.alertWindowLevel = UIWindowLevelStatusBar + 1;
        self.opaque = NO;
        self.alpha = 1.0;
        self.buttons = [NSMutableArray array];
        
//        self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
//        self.layer.shadowOpacity = 0.75;
        // Register for keyboard notifications
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [nc addObserver:self selector:@selector(removeSelf) name:@"removeAlertView" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    UP_RELEASE(_title);
//    UP_RELEASE(_customView);
//    UP_RELEASE(_subtitle);
//    UP_RELEASE(_buttons);
//    
//    UP_RELEASE(_overlay);
//    UP_RELEASE(_hostWindow);
//    UP_RELEASE(_contentView);
//    UP_RELEASE(_titleFont);
//    UP_RELEASE(_subtitleFont);
//    [super dealloc];
}

- (void)removeSelf
{
    [self hideAnimated:YES];
}

- (void)adjustToKeyboardBounds:(CGRect)bounds
{
    _overlay.keyboardRect = bounds;

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat height = CGRectGetHeight(screenBounds) - CGRectGetHeight(bounds);
    
    CGRect frame = self.frame;
    frame.origin.y = (height - CGRectGetHeight(self.bounds)) / 2.0;
    
    if (CGRectGetMinY(frame) < 0) {
        NSLog(@"warning: AlertView is clipped, origin negative (%f)", CGRectGetMinY(frame));
    }
    
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        // stub
    }];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    NSValue *value = [[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [value CGRectValue];
    
    [self adjustToKeyboardBounds:frame];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    [self adjustToKeyboardBounds:CGRectZero];
}

- (CGRect)defaultAlertViewFrame
{
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    CGRect insetFrame = CGRectInset(appFrame, kHorizenInset, 0.0);
    insetFrame.size.height = kContentMinHeight;
    CGFloat cy = appFrame.size.height * kVerticalCenterScale;
    cy -= kContentMinHeight/2;
    insetFrame.origin.y = (int)cy;
    insetFrame = CGRectIntegral(insetFrame);
    return insetFrame;
}

- (void)layoutComponents
{
    [self setNeedsDisplay];
    
    // Compute frames of components
    CGRect layoutFrame = self.bounds;
    CGFloat layoutWidth = CGRectGetWidth(layoutFrame);
    
    // Title frame
    CGFloat titleHeight = 0;
    CGFloat titleWidth = layoutWidth - 2*kTitleIndent;
    CGFloat offsetY = CGRectGetMinY(layoutFrame);
    if (self.title.length > 0) {
        //创建titleLabel
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = self.titleFont;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UP_COL_RGB(kColorAlertViewMessageText);
        _titleLabel.text = self.title;
        _titleLabel.numberOfLines = 0;
        
        titleHeight = [self.title sizeWithFont:self.titleFont
                             constrainedToSize:CGSizeMake(layoutWidth, MAXFLOAT)
                                 lineBreakMode:NSLineBreakByWordWrapping].height;
        offsetY += kTopMargin;
    }
    layout.titleRect = CGRectIntegral(CGRectMake(CGRectGetMinX(layoutFrame) + kTitleIndent, offsetY, titleWidth, titleHeight));
    
    
    //Title Line
    /*
    CGFloat titleLineHeight = 0;
    CGFloat titleLineWidth = CGRectGetWidth(layoutFrame);
    offsetY = CGRectGetMaxY(layout.titleRect);
    if (self.title.length > 0) {
        titleLineHeight = 2;
        offsetY += kTitleLinePadding;
    }
    
    layout.titlelineRect = CGRectIntegral(CGRectMake(CGRectGetMinX(layoutFrame), offsetY, titleLineWidth, titleLineHeight));
     */
    // Subtitle frame
    CGFloat subtitleHeight = 0;
    CGFloat subtitleWidth = CGRectGetWidth(layoutFrame) - 2*kTitleIndent;
    offsetY = CGRectGetMaxY(layout.titleRect);
    if (offsetY == 0) {
        offsetY += kTopMargin;
    }
    
    if (self.subtitle.length > 0) {
        //创建_subTitleLabel
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.font = self.subtitleFont;
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.textColor = UP_COL_RGB(kColorAlertViewTitleText);
        _subTitleLabel.text = self.subtitle;
        _subTitleLabel.numberOfLines = 0;
        
        subtitleHeight = [self.subtitle sizeWithFont:self.subtitleFont
                                   constrainedToSize:CGSizeMake(layoutWidth, MAXFLOAT)
                                       lineBreakMode:NSLineBreakByWordWrapping].height + 30;
        if (self.titleDirectionMode == UITitleDirectionVertical) {

        } else {
            if (subtitleHeight < kVerticalContentMinHeight) {
                subtitleHeight = kVerticalContentMinHeight;
            }
            subtitleHeight = UPFloat(subtitleHeight);
        }

        
        
      //  offsetY += kSubTitlePadding;
    }
    layout.subtitleRect = CGRectIntegral(CGRectMake(CGRectGetMinX(layoutFrame) + kTitleIndent, offsetY, subtitleWidth, subtitleHeight));
    
    //custom view
    CGFloat customViewHeight = 0;
    CGFloat customViewWidth = 0;
    CGFloat customViewLeft = 0;
    offsetY = CGRectGetMaxY(layout.subtitleRect);
    if (self.customView) {
        customViewHeight = CGRectGetHeight(self.customView.frame);
        customViewWidth = CGRectGetWidth(self.customView.frame);
        customViewLeft = (CGRectGetWidth(layoutFrame) - customViewWidth) / 2.0;
        offsetY += kCustomViewPadding;
    }
    layout.customViewRect = CGRectIntegral(CGRectMake(customViewLeft, offsetY, customViewWidth, customViewHeight));

    // Buttons frame (note that views are in the content view coordinate system)
    CGFloat buttonsHeight = 0;
    offsetY = CGRectGetMaxY(layout.customViewRect);
    if (self.buttons.count > 0) {
        buttonsHeight = kButtonHeight;
        if (self.title.length > 0 || self.subtitle.length > 0) {
            offsetY += kVerticalPadding;
        }
    }
    if (self.titleDirectionMode == UITitleDirectionVertical) {
        buttonsHeight *= self.buttons.count ;
    }
    layout.buttonRect = CGRectIntegral(CGRectMake(CGRectGetMinX(layoutFrame), offsetY, layoutWidth, buttonsHeight));
    
    // Adjust layout frame
    //根据实际内容调整大小
    layoutFrame.size.height = CGRectGetMaxY(layout.buttonRect);
    
    // Create new content view
    UIView *newContentView = [[UIView alloc] initWithFrame:layoutFrame];
    newContentView.backgroundColor = UP_COL_RGB(kColorAlertViewBackground);
    newContentView.layer.cornerRadius = 5;
    newContentView.contentMode = UIViewContentModeRedraw;
    
    if (self.showXButton) {
        //左上角加X
        UIButton *XButton = [UIButton buttonWithType:UIButtonTypeCustom];
        XButton.frame = CGRectMake(0, 5, 44, 44);
        [XButton setBackgroundColor:[UIColor clearColor]];
        [XButton setBackgroundImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        [XButton addTarget:self action:@selector(hideAnimated:) forControlEvents:UIControlEventTouchUpInside];
        [newContentView addSubview:XButton];
    }
    
    //titeLabel
    self.titleLabel.frame = layout.titleRect;
    [newContentView addSubview:self.titleLabel];
    
    //subTitleLabel
    self.subTitleLabel.frame = layout.subtitleRect;
    [newContentView addSubview:self.subTitleLabel];
    
    // Layout custom view
    self.customView.frame = layout.customViewRect;
    [newContentView addSubview:self.customView];
    
    // Layout buttons
    NSUInteger count = self.buttons.count;
    CGFloat buttonWidth = (int)(layoutWidth/count);
    offsetY = CGRectGetMinY(layout.buttonRect);
    int offsetX = 0;
    if (self.titleDirectionMode == UITitleDirectionVertical) {
        for (int i = 0; i<count; i++) {
            buttonWidth = layoutWidth ;
            UPXAlertViewButton* bt = [self.buttons objectAtIndex:i];
            bt.type = kButtonAlone ;
            CGRect buttonFrame = CGRectIntegral(CGRectMake(offsetX, offsetY , buttonWidth, kButtonHeight));
            bt.frame = buttonFrame;
            bt.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            bt.buttonBackgroundColor = UP_COL_RGB(kColorButtonCancel);
            bt.buttonhighlightColor = UP_COL_RGB(kColorButtonCancelHighlight);
            bt.titleLabel.font = [UIFont systemFontOfSize:16];
            offsetY += kButtonHeight;
            [newContentView addSubview:bt];
            
        }
        
    } else {

    for (int i = 0; i < count; ++i) {
        UPXAlertViewButton* bt = [self.buttons objectAtIndex:i];
        if (count == 1) {
            bt.type = kButtonAlone;
        }
        else{
            if (i == 0) {
                bt.type = kButtonLeft;
            }
            else if (i == (count -1)){
                bt.type = kButtonRight;
            }
            else{
                bt.type = kButtonCenter;
            }
        }
        CGRect buttonFrame = CGRectIntegral(CGRectMake(offsetX, offsetY, buttonWidth, kButtonHeight));
        bt.frame = buttonFrame;
        bt.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        
        if (bt.tag == kCancelButtonTag) {
            bt.buttonBackgroundColor = UP_COL_RGB(kColorButtonCancel);
            bt.buttonhighlightColor = UP_COL_RGB(kColorButtonCancelHighlight);
            bt.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        else if(self.specialIndex == i){
            bt.buttonBackgroundColor = UP_COL_RGB(kColorButtonSpecial);
            bt.buttonhighlightColor = UP_COL_RGB(kColorButtonSpecialHighlight);
            bt.titleLabel.font = [UIFont systemFontOfSize:16];

        }
        else{
            bt.buttonBackgroundColor = UP_COL_RGB(kColorButton);
            bt.buttonhighlightColor = UP_COL_RGB(kColorButtonHighlight);
            bt.titleLabel.font = [UIFont boldSystemFontOfSize:16];

        }
    
        [newContentView addSubview:bt];
        offsetX += buttonWidth;
    }
    }

    __block typeof(self) weakSelf = self;
    // Fade content views
    CGFloat animationDuration = kAnimationDuration;
    if (self.contentView.superview != nil) {
        [UIView transitionFromView:self.contentView
                            toView:newContentView
                          duration:animationDuration
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        completion:^(BOOL finished) {
                            weakSelf.contentView = newContentView;
                        }];
    } else {
        self.contentView = newContentView;
        [self addSubview:newContentView];
        
        // Don't animate frame adjust if there was no content before
        animationDuration = 0;
    }
//    [newContentView release];
    
    // Adjust frame size
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
        CGRect alertFrame = layoutFrame;
        alertFrame.origin.x = (int)((CGRectGetWidth(weakSelf.hostWindow.bounds) - CGRectGetWidth(alertFrame)) / 2.0);
        alertFrame.origin.y = (int)((CGRectGetHeight(weakSelf.hostWindow.bounds) - CGRectGetHeight(alertFrame)) / 2.0);
        
        weakSelf.frame = CGRectIntegral(alertFrame);
    } completion:^(BOOL finished) {
        [weakSelf setNeedsDisplay];
    }];
     
}

- (void)resetLayout
{
    self.tag = 0;
    self.title = nil;
    self.subtitle = nil;
    self.customView = nil;
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    [self removeAllControls];
}

- (void)removeAllControls
{
    [self removeAllButtons];
}

- (void)removeAllButtons
{
    [self.buttons removeAllObjects];
    self.specialIndex = -1;
}

- (void)buttonClicked:(UIButton*)sender
{
    self.overlay.alertView = nil;
    if (self.tag != kTagNotDismiss) {
        [self hideAnimated:YES];
    }
    if (self.block) {
        self.block(self,sender.tag);
    }
}

- (void)addOtherButtons:(NSArray*)buttonTitles specialIndex:(NSInteger)index
{
    for (int i = 0 ; i < [buttonTitles count]; ++i) {
        NSString* title = [buttonTitles objectAtIndex:i];
        BOOL special = NO;
        if (index == i) {
            special = YES;
        }
        [self addButtonWithTitle:title special:special tag:i];
    }
 }


- (void)addButtonCancel:(NSString *)title
{
    [self addButtonWithTitle:title special:NO tag:kCancelButtonTag];
}


- (void)addButtonWithTitle:(NSString *)title special:(BOOL)flag tag:(NSInteger)tag
{
    UPXAlertViewButton *button = [UPXAlertViewButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UP_COL_RGB(kColorAlertViewButtonText) forState:UIControlStateNormal];
    [button setTitleColor:UP_COL_RGB(kColorAlertViewButtonDisableText) forState:UIControlStateDisabled];

    //修改默认样式的button
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    if (flag) {
        self.specialIndex = self.buttons.count;
    }
    [self.buttons addObject:button];
}


- (void)showOrUpdateAnimatedInternal:(BOOL)flag
{
    UPXAlertViewWindowOverlay *overlay = self.overlay;
    BOOL show = (overlay == nil);
    
    // Create overlay
    if (show) {
        overlay = [[UPXAlertViewWindowOverlay alloc] init];
        overlay.opaque = NO;
        overlay.windowLevel = self.alertWindowLevel;
        overlay.alertView = self;
        overlay.frame = self.hostWindow.bounds;
        overlay.alpha = 0.0;
        overlay.backgroundColor = [UIColor clearColor];
        self.overlay = overlay;
//        [overlay release];
    }
    
    // Layout components
    [self layoutComponents];
    
    if (show) {
        // Scale down ourselves for pop animation
        self.transform = CGAffineTransformMakeScale(kPopScale, kPopScale);
        
        // Animate
        NSTimeInterval animationDuration = (flag ? kAnimationDuration : 0.0);
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            overlay.alpha = 1.0;
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // stub
        }];
        
        [overlay addSubview:self];
        [overlay makeKeyAndVisible];
    }
}

- (void)showOrUpdateAnimated:(BOOL)flag
{
    SEL selector = @selector(showOrUpdateAnimatedInternal:);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:selector object:nil];
    [self performSelector:selector withObject:[NSNumber numberWithBool:flag] afterDelay:0];
}

- (void)hideAnimated:(BOOL)flag
{
    [self.hostWindow makeKeyWindow];
    self.hostWindow = nil;

    UPXAlertViewWindowOverlay *overlay = self.overlay;
    
    // Nothing to hide if it is not key window
    if (overlay == nil) {
        return;
    }
   
    NSTimeInterval animationDuration = (flag ? kAnimationDuration : 0.0);
    [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        overlay.alpha = 0.0;
        self.transform = CGAffineTransformMakeScale(kPopScale, kPopScale);
    } completion:^(BOOL finished) {
        overlay.hidden = YES;
        self.transform = CGAffineTransformIdentity;
        [self removeFromSuperview];
        self.overlay = nil;
    }];
}

- (void)hideAnimated:(BOOL)flag afterDelay:(NSTimeInterval)delay
{
    SEL selector = @selector(hideAnimated:);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:selector object:nil];
    [self performSelector:selector withObject:[NSNumber numberWithBool:flag] afterDelay:delay];
}

- (void)drawBackgroundInRect:(CGRect)rect
{
    // General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set alpha
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 1.0);
    
    // Color Declarations
    UIColor *color = UP_COL_RGB(kColorAlertViewBackground);
    CGFloat cornerRadius = 8.0;
    // Rounded Rectangle Drawing
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    CGContextSaveGState(context);    
    [color setFill];
    [roundedRectanglePath fill];
    CGContextRestoreGState(context);
    // Set clip path
    [roundedRectanglePath addClip];
        
    // Cleanup
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
     
}

- (void)drawTitleInRect:(CGRect)rect isSubtitle:(BOOL)isSubtitle
{
    NSString *title = (isSubtitle ? self.subtitle : self.title);
    NSTextAlignment alignment = NSTextAlignmentCenter;
    if (title.length > 0) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        UIFont *font = (isSubtitle ? self.subtitleFont : self.titleFont);
        UIColor *color = (isSubtitle ? UP_COL_RGB(kColorAlertViewMessageText) : UP_COL_RGB(kColorAlertViewTitleText));
        [color set];
        //可能rect比较大,垂直输出
        CGSize size = [title sizeWithFont:font constrainedToSize:CGSizeMake(CGRectGetWidth(rect), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        int y = (rect.size.height - size.height)/2;
        CGRect textRect = CGRectMake(rect.origin.x,rect.origin.y + y, rect.size.width, size.height);
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = alignment;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingMiddle;
        NSDictionary *attribute = @{NSFontAttributeName:font ,NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:color};
        [title drawInRect:CGRectIntegral(textRect) withAttributes:attribute];
        CGContextRestoreGState(ctx);
    }
}

/*
- (void)drawTitleLineInRect:(CGRect)rect
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [UP_COL_RGB(kColorAlertViewTitleLine) setFill];
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
}*/

- (void)drawDimmedBackgroundInRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor* bgColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    CGContextFillRect(context, rect);
     
    /*
    // General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Color Declarations
    UIColor *greyInner = [UIColor colorWithWhite:0.0 alpha:0.70];
    UIColor *greyOuter = [UIColor colorWithWhite:0.0 alpha:0.2];
    
    // Gradient Declarations
    NSArray* gradientColors = @[(id)greyOuter.CGColor,
                               (id)greyInner.CGColor];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)gradientColors, gradientLocations);
    
    // Rectangle Drawing
    CGPoint mid = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:rect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawRadialGradient(context,
                                gradient,
                                mid, 10,
                                mid, CGRectGetMidY(rect),
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextRestoreGState(context);
    
    // Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    */
}


- (void)drawRect:(CGRect)rect
{
//    [self drawBackgroundInRect:rect];
//    [self drawTitleInRect:layout.titleRect isSubtitle:NO];
//    [self drawTitleLineInRect:layout.titlelineRect];
//    [self drawTitleInRect:layout.subtitleRect isSubtitle:YES];
}


@end

@implementation UPXAlertViewWindowOverlay
@synthesize alertView = _alertVIew;

- (void)drawRect:(CGRect)rect
{
    [self.alertView drawDimmedBackgroundInRect:rect];
}

- (void)dealloc
{
//    UP_RELEASE(_alertVIew);
//    [super dealloc];
}

//当customView可编辑得时候点击空白区域隐藏键盘
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    CGRect rect = [self convertRect:_alertVIew.frame fromView:self];
    BOOL flag = CGRectContainsPoint(rect, point);
    if (view && !flag) {
        //修正iOS5上的操作系统的bug, 在切换到后台回到前台后, 键盘会触发hitTest回调
        //http://stackoverflow.com/questions/8072984/hittest-fires-when-uikeyboard-is-tapped
        if (!CGRectContainsPoint(self.keyboardRect, point)) {
            [_alertVIew endEditing:YES];
        }
    }
	return view;
}

@end


@implementation UPXAlertViewButton

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"highlighted"];
//    UP_RELEASE(_buttonBackgroundColor);
//    UP_RELEASE(_buttonhighlightColor);
//    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:NULL];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set alpha
    CGContextSaveGState(context);
    CGContextSetAlpha(context, 1.0);
    
    CGContextSaveGState(context);

    // Color Declarations
    UIColor *color = self.highlighted ? self.buttonhighlightColor : self.buttonBackgroundColor;
    CGSize cornerRadius = {6.0,6.0};
    [color setFill];

    //Background 
    if(self.type == kButtonCenter) {
        CGContextFillRect(context, rect);
    }
    else{
        // Rounded Rectangle Drawing
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:(UIRectCorner)self.type cornerRadii:cornerRadius];
        [path fill];
    }
    CGContextRestoreGState(context);
    // Cleanup
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(context);
    
    int offsetY = CGRectGetMinY(rect);
    int offsetX = CGRectGetMinX(rect);
    int width = CGRectGetWidth(rect);
    int hight = CGRectGetHeight(rect);

    //top border
    UIImage* border = [[UIImage imageNamed:@"alert_bt_border"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.5, 0, 0, 0)];
    CGRect borderRect = CGRectMake(offsetX,offsetY,width ,1);
    [border drawInRect:borderRect];

    //vertical line
    if (self.type == kButtonCenter || self.type == kButtonRight) {
        UIImage* line = [[UIImage imageNamed:(@"alert_bt_line")] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0.5, 0, 0)];
        //从第二个开始
        CGRect lineRect = CGRectMake(offsetX, offsetY+1, 1, hight -1);
        [line drawInRect:lineRect];
    }
}

@end



