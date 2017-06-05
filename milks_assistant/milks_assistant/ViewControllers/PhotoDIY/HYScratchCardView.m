//
//  HYScratchCardView.m
//  Test
//  爱你一生一世，刘磊璐
//  Created by JasonHuang on 14-5-25.
//  Copyright (c) 2017年 JasonHuang. All rights reserved.
//

#import "HYScratchCardView.h"

@interface HYScratchCardView () {
    
    UIButton *_deleteBtn;
    UIImage *oldImg;
}

@property (nonatomic, assign) CGMutablePathRef path;


@end

@implementation HYScratchCardView

- (void)dealloc
{
    if (self.path) {
        CGPathRelease(self.path);
    }
}

- (UIImage*)getDrawImage {
    UIGraphicsBeginImageContext([self bounds].size);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    [UIImagePNGRepresentation(image) writeToFile:@"test.png"
//                                      atomically:YES];
    UIGraphicsEndImageContext();
    return image;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加imageview（surfaceImageView）到self上
        self.surfaceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, frame.size.width, frame.size.height)];
        [self addSubview:self.surfaceImageView];
        //添加layer（imageLayer）到self上
        self.imageLayer = [CALayer layer];
        self.imageLayer.frame = CGRectMake(0, 20, frame.size.width, frame.size.height);
        [self.layer addSublayer:self.imageLayer];
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.frame = CGRectMake(0, 20, frame.size.width, frame.size.height);
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.lineJoin = kCALineJoinRound;
        self.shapeLayer.lineWidth = 50.f;
        self.shapeLayer.strokeColor = [UIColor blueColor].CGColor;
        self.shapeLayer.fillColor = nil;//此处设置颜色有异常效果，可以自己试试
        
        [self.layer addSublayer:self.shapeLayer];
        self.imageLayer.mask = self.shapeLayer;
        
        self.path = CGPathCreateMutable();
    }
    return self;
}

- (void)clearDrawBoard {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetMaskImage" object:nil];
//    CGPathRelease(self.path);
//    self.imageLayer.contents = (id)oldImg.CGImage;
//    self.surfaceImageView.image = oldImg;
    
//    self.imageLayer = [CALayer layer];
//    self.imageLayer.frame = self.bounds;
//    [self.layer addSublayer:self.imageLayer];
    
//    self.shapeLayer = [CAShapeLayer layer];
//    self.shapeLayer.frame = self.bounds;
//    self.shapeLayer.lineCap = kCALineCapRound;
//    self.shapeLayer.lineJoin = kCALineJoinRound;
//    self.shapeLayer.lineWidth = 50.f;
//    self.shapeLayer.strokeColor = [UIColor blueColor].CGColor;
//    self.shapeLayer.fillColor = nil;//此处设置颜色有异常效果，可以自己试试
    
//    [self.layer addSublayer:self.shapeLayer];
//    self.imageLayer.mask = self.shapeLayer;
    
//    self.path = CGPathCreateMutable();
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPathMoveToPoint(self.path, NULL, point.x, point.y);
    CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
    self.shapeLayer.path = path;
    CGPathRelease(path);

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
    CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
    self.shapeLayer.path = path;
    CGPathRelease(path);
 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
  
}


- (void)setImage:(UIImage *)image
{
    //底图
    _image = image;
    self.imageLayer.contents = (id)image.CGImage;
}

- (void)setSurfaceImage:(UIImage *)surfaceImage
{
    //顶图
    _surfaceImage = surfaceImage;
    self.surfaceImageView.image = surfaceImage;
}



@end
