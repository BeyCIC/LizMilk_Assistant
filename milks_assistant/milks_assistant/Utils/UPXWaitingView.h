//
//  UPXLoadingView.h
//  UPClientV3
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 13-6-13.
//
//

#import <UIKit/UIKit.h>
#import "UPWRotateAnimationView.h"

@interface UPXWaitingView : UIView
{
    UPWRotateAnimationView* _activityView;
//    UIActivityIndicatorView* _activityView;
    UILabel*            _titleLabel;
    UIView*             _dialogView;
//    UIView*             _bgView;
}

@property (nonatomic, assign) BOOL dimBackground;
@property (nonatomic, copy) NSString* title;

- (void)show;
- (void)hide;

@end
