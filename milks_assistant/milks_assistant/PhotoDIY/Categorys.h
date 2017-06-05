//
//  Categorys.h
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/7/4.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Categorys : NSObject

@end


@interface UIView(Recursive)

-(id)superViewWithClass:(Class)clazz;

- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation;

-(void)didLayoutSubviews;

@end

@interface UIImage(ext)

- (UIImage *)imageWithOverlayColor:(UIColor *)color;

@end

@interface NSArray (Reverse)

- (NSArray *)reversedArray;

@end

@interface NSMutableArray (Reverse)

- (void)reverse;

@end

