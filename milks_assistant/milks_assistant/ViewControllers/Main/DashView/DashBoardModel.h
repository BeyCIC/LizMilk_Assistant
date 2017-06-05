//
//  DashBoardModel.h
//  MoveDemo
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/8/1.
//  Copyright © 2016年 JasonHuang. All rights reserved.
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
