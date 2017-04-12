//
//  DashCollectionViewFlowLayout.h
//  MoveDemo
//
//  Created by lulu on 16/8/15.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashBoardModel.h"

@interface DashCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *attributes;

@property (nonatomic , strong)NSMutableArray * DashModelArray;

@property (nonatomic , strong)UIView * viewDash;

@property (nonatomic , strong)NSMutableArray * viewDashArray;

@property (nonatomic , strong)NSMutableArray * tempAtt;

@end
