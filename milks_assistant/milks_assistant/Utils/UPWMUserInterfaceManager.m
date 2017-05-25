//
//  UPWMUserInterfaceManager.m
//  wallet_merchant
//
//  Create by renjie on 2017/1/6.
//  Copyright © 2017年 任杰. All rights reserved.
//

#import "UPWMUserInterfaceManager.h"
/* 定义一般Toast宽高 */
#define kCommonToastSize CGSizeMake(120, 30)

@interface UPWMUserInterfaceManager ()
{
  NSMutableArray* _toastArray;//toast
  NSMutableArray* _waitingViewArray;//waitingView
  UIView* _loadingView;
  UPWLoadingView* _loadingView2;
  
  CGFloat _screenWidth;
  CGFloat _screenHeight;
}
@end

@implementation UPWMUserInterfaceManager

+ (UPWMUserInterfaceManager*)sharedManager
{
  static UPWMUserInterfaceManager* userInterfaceManager = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{
    userInterfaceManager = [[self alloc] init];
  });
  
  return userInterfaceManager;
}

- (id)init
{
  self = [super init];
  if (self) {
    _toastArray = [[NSMutableArray alloc] initWithCapacity:5];
    _waitingViewArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    _screenWidth = kScreenWidth;
    _screenHeight = kScreenHeight;
  }
  return self;
}


#pragma mark -
#pragma mark AlertView, Toast, Loading 相关函数


- (void)showWaitingView:(NSString*)title
{
  NSLog(@"showWaitingView : %@", title);
  if (title) {
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    CGRect rt = window.bounds;
    UPXWaitingView *waitView = [[UPXWaitingView alloc] initWithFrame:rt];
    waitView.title = title;
    [_waitingViewArray addObject:waitView];
    [waitView show];
  }
}


- (void)hideWaitingView
{
  NSLog(@"hideWaitingView");
  [_waitingViewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj hide];
  }];
  [_waitingViewArray removeAllObjects];
}


- (void)showLoadingView2
{
  NSLog(@"showLoadingView2");
  [self dismissLoading2];
  CGFloat loadingWidth = UPFloat(50);
  CGFloat loadingHeight = UPFloat(50);
  if (!_loadingView2) {
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    _loadingView2 = [[UPWLoadingView alloc] initWithFrame:CGRectMake((_screenWidth-loadingWidth)/2, (_screenHeight-loadingHeight)/2, loadingWidth, loadingHeight)];
    [window addSubview:_loadingView2];
  }
  [_loadingView2 startAnimation];
}

- (void)showLoadingView2WithCenter:(CGPoint)pt
{
  NSLog(@"showLoadingView2WithCenter %@",NSStringFromCGPoint(pt));
  [self dismissLoading2];
  CGFloat loadingWidth = UPFloat(50);
  CGFloat loadingHeight = UPFloat(50);
  if (!_loadingView2) {
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    _loadingView2 = [[UPWLoadingView alloc] initWithFrame:CGRectMake(pt.x-loadingWidth/2, pt.y-loadingHeight/2, loadingWidth, loadingHeight)];
    [window addSubview:_loadingView2];
  }
  [_loadingView2 startAnimation];
}

- (void)dismissLoading2
{
  NSLog(@"dismissLoading2");
  if (_loadingView2) {
    [_loadingView2 stopAnimation];
    [_loadingView2 removeFromSuperview];
    _loadingView2 = nil;
  }
}

- (void)showLoadingWithMessage:(NSString*)message
{
  NSLog(@"showLoadingWithMessage:%@",message);
  
  [self dismissLoading];
  
  CGFloat offset = 5;
  CGFloat aivWidth = 30;
  CGFloat aivHeight = 30;
  
  CGFloat loadingViewWidth = 210;
  CGSize messageSize = [message sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake((loadingViewWidth-aivWidth-offset), MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
  CGFloat loadingViewHeight = messageSize.height;
  
  UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
  _loadingView = [[UIView alloc] initWithFrame:CGRectMake((_screenWidth-loadingViewWidth)/2, (_screenHeight-loadingViewHeight)/2, loadingViewWidth, loadingViewHeight)];
  _loadingView.backgroundColor = [UIColor clearColor];
  [window addSubview:_loadingView];
  
  UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
  [aiv setFrame:CGRectMake((loadingViewWidth-(aivWidth+messageSize.width+offset))/2, (loadingViewHeight-aivHeight)/2, aivWidth, aivHeight)];
  [_loadingView addSubview:aiv];
  [aiv startAnimating];
  
  CGFloat x = aiv.frame.origin.x + aivWidth + offset;
  UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, loadingViewWidth-x, loadingViewHeight)];
  label.text = message;
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor grayColor];
  label.font = [UIFont systemFontOfSize:14];
  [_loadingView addSubview:label];
}

- (void)dismissLoading
{
  NSLog(@"dismissLoading");
  if (_loadingView) {
    [_loadingView removeFromSuperview];
    _loadingView = nil;
  }
}

- (void)hideFlashInfo
{
  [_toastArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj removeToast];
  }];
  [_toastArray removeAllObjects];
}

- (void)showFlashInfo:(NSString*)info
{
  [self showFlashInfo:info withDismissBlock:nil];
}

- (void)showFlashInfo:(NSString*)info withDismissBlock:(dispatch_block_t)dismissBlock
{
  NSLog(@"showFlashInfo:%@",info);
  
  [self hideFlashInfo];
  if (info) {
    CGSize size = UPSize(kCommonToastSize);
    UPXToast* toast = [[[[[UPXToast makeText:info]
                          setGravity:kToastGravityCenter]
                         setDuration:3000]
                        setSize:size] setImage:nil];
    [toast show];
    [_toastArray addObject:toast];
    
    // 执行dismissBlock
    [self executeDismissBlock:dismissBlock withToast:toast];
  }
}

- (void)showFlashInfo:(NSString*)info withTime:(NSInteger)time
{
  [self showFlashInfo:info time:time withDismissBlock:nil];
}

//新增，添加时间参数
- (void)showFlashInfo:(NSString*)info time:(NSInteger)time withDismissBlock:(dispatch_block_t)dismissBlock
{
  NSLog(@"showFlashInfo:%@",info);
  
  [self hideFlashInfo];
  if (info) {
    CGSize size = UPSize(kCommonToastSize);
    UPXToast* toast = [[[[[UPXToast makeText:info]
                          setGravity:kToastGravityCenter]
                         setDuration:time]
                        setSize:size] setImage:nil];
    [toast show];
    [_toastArray addObject:toast];
    
    // 执行dismissBlock
    [self executeDismissBlock:dismissBlock withToast:toast];
  }
}


- (void)executeDismissBlock:(dispatch_block_t)dismissBlock withToast:(UPXToast *)toast
{
  if(dismissBlock) {
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, toast.theSettings.duration);
    dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
      dismissBlock();
    });
  }
}

- (void)showFlashInfo:(NSString*)info withImage:(UIImage*)image
{
  [self showFlashInfo:info withImage:image withDismissBlock:nil];
}

- (void)showFlashInfo:(NSString*)info withImage:(UIImage*)image withDismissBlock:(dispatch_block_t)dismissBlock
{
  NSLog(@"showFlashInfo:%@ withImage %@",info, image);
  [self hideFlashInfo];
  if (info || image) {
    CGSize size = UPSize(kCommonToastSize);
    UPXToast* toast = [[[[[UPXToast makeText:info]
                          setGravity:kToastGravityCenter]
                         setDuration:3000]
                        setSize:size] setImage:image];
    [toast show];
    [_toastArray addObject:toast];
    
    [self executeDismissBlock:dismissBlock withToast:toast];
  }
}

- (UPXAlertView*)showAlertWithTitle:(NSString*)title message:(NSString*)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle completeBlock:(UPXAlertViewBlock)block
{
  NSArray* otherTitles = nil;
  if (otherButtonTitle) {
    otherTitles = @[otherButtonTitle];
  }
  return [self showAlertViewWithTitle:title message:message customView:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherTitles special:-1 tag:-1 completeBlock:block];
}


- (UPXAlertView*)showAlertViewWithTitle:(NSString*)title
                                message:(NSString*)message
                             customView:(UIView*)view
                      cancelButtonTitle:(NSString*)cancelTitle
                      otherButtonTitles:(NSArray*)otherButtonTitles
                                special:(NSInteger)specialIndex
                                    tag:(NSInteger)tag
                          completeBlock:(UPXAlertViewBlock)block

{
  NSLog(@"showAlertViewWithTitle:%@\nmessage:%@\ncustomView:%@\nbuttons:%@\nspecialIndex:%ld\ntag:%ld",title,message,view,otherButtonTitles,(long)specialIndex,(long)tag);
  
  if (!title && !message && !view) {
    NSLog(@"showAlertView arg error!");
    return nil;
  }
  
  UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
  UPXAlertView* alertView = [[UPXAlertView alloc] initWithWindow:window];
  [alertView resetLayout];
  alertView.title = title;
  alertView.subtitle = message;
  alertView.customView = view;
  alertView.block = block;
  if (cancelTitle) {
    [alertView addButtonCancel:cancelTitle];
  }
  if ([otherButtonTitles count] > 0) {
    [alertView addOtherButtons:otherButtonTitles specialIndex:specialIndex];
  }
  [alertView showOrUpdateAnimated:YES];
  alertView.tag = tag;
  return alertView;
}


- (void)dismissAll
{
  NSLog(@" \n\n dismiss %@ ",NSStringFromClass([self class]));
  [self hideWaitingView];
  [self dismissLoading];
  [self hideFlashInfo];
}



@end
