//
//  DashBoardViewController.h
//  MoveDemo
//
//  Create by lulu on 16/8/15.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DashBoardModel.h"
#import "LMBaseViewController.h"


@interface DashBoardViewController : LMBaseViewController
// 指标model的数组
@property (nonatomic , strong) NSMutableArray * DashModelArray;

@end
