//
//  PhotoDIYViewController.h
//  milks_assistant
//
//  Created by Jason Huang on 17/4/22.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMBaseViewController.h"

@class LWContentView;
@class LWToolBar;


@interface PhotoDIYViewController : LMBaseViewController
@property (strong, nonatomic)  LWContentView *contentView;
@property (strong, nonatomic)  LWToolBar *toolBar;
@end


@interface LWToolBar:UIView

@property(nonatomic,strong)UIButton *photosBtn;
@property(nonatomic,strong)UIButton *filtersBtn;
@property(nonatomic,strong)UIButton *cropBtn;
@property(nonatomic,strong)UIButton *drawBtn;
@end
