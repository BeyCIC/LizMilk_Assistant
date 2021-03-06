//
//  LWImageCropView.h
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/7/7.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

CGRect SquareCGRectAtCenter(CGFloat centerX, CGFloat centerY, CGFloat size);

typedef struct {
    CGPoint dragStart;
    CGPoint topLeftCenter;
    CGPoint bottomLeftCenter;
    CGPoint bottomRightCenter;
    CGPoint topRightCenter;
    CGPoint cropAreaCenter;
} DragPoint;

// Used when working with multiple dragPoints
typedef struct {
    DragPoint mainPoint;
    DragPoint optionalPoint;
    NSUInteger lastCount;
} MultiDragPoint;


#pragma mark - ControlPointView

@interface ControlPointView : UIView {
    CGFloat red, green, blue, alpha;
}

@property (nonatomic, retain) UIColor* color;

@end

#pragma mark -  ShadeView

@interface ShadeView : UIView {
    CGFloat cropBorderRed, cropBorderGreen, cropBorderBlue, cropBorderAlpha;
    CGRect cropArea;
    CGFloat shadeAlpha;
}

@property (nonatomic, retain) UIColor* cropBorderColor;
@property (nonatomic) CGRect cropArea;
@property (nonatomic) CGFloat shadeAlpha;
@property (nonatomic, strong) UIImageView *blurredImageView;

@property(nonatomic, strong) CALayer *maskLayer;
@end


#pragma mark -  LWImageCropView

@interface LWImageCropView : UIView<UIGestureRecognizerDelegate> {
    CGRect imageFrame;

    CGFloat controlPointSize;
    ControlPointView* topLeftPoint;
    ControlPointView* bottomLeftPoint;
    ControlPointView* bottomRightPoint;
    ControlPointView* topRightPoint;
    NSArray *PointsArray;
    UIColor* controlColor;

    DragPoint dragPoint;
    MultiDragPoint multiDragPoint;

    UIView* dragViewOne;
    UIView* dragViewTwo;
}

@property (nonatomic) CGFloat controlPointSize;
@property (nonatomic) CGRect cropAreaInView;
@property (nonatomic) CGRect cropAreaInImage;
@property (nonatomic, assign) CGFloat imageScale;
@property (nonatomic) CGFloat maskAlpha;
@property (nonatomic, retain) UIColor* controlColor;
@property (nonatomic, strong) ShadeView* shadeView;
@property (nonatomic) BOOL blurred;

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIView *cropAreaView;


@property(nonatomic, strong)  UIButton *cropOk;
@property(nonatomic, strong)  UIButton *cropCancel;

- (void)setImage:(UIImage*)image;

@end

@interface UIImage (fixOrientation)

- (UIImage *)fixOrientation;

@end
