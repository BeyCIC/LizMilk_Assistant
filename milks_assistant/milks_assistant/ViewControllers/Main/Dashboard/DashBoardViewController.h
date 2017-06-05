//
//  DashBoardViewController.h
//  MoveDemo
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/8/15.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DashBoardModel.h"
#import "LMBaseViewController.h"


@interface DashBoardViewController : LMBaseViewController
// 指标model的数组
@property (nonatomic , strong) NSMutableArray * DashModelArray;

@end
