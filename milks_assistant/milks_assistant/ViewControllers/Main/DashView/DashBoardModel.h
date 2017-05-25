//
//  DashBoardModel.h
//  MoveDemo
//
//  Create by lulu on 16/8/1.
//  Copyright © 2016年 lulu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface DashBoardModel : JSONModel

@property (nonatomic,copy) NSString * Did;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * color;
@property (nonatomic,copy) NSString *size_x;

@property (nonatomic,copy) NSString  *size_y;

@end
